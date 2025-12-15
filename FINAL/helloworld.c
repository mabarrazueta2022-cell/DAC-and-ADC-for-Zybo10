/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "math.h"
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "DAC_Controller.h"
#include "xparameters.h"
#include "ADC_Controller.h"
#include "Medidas.h"

#define PI 3.141592653589793

#define DAC_BaseAddress XPAR_DAC_CONTROLLER_0_S00_AXI_BASEADDR
#define REG0 DAC_CONTROLLER_S00_AXI_SLV_REG0_OFFSET
#define REG1 DAC_CONTROLLER_S00_AXI_SLV_REG1_OFFSET
#define REG2 DAC_CONTROLLER_S00_AXI_SLV_REG2_OFFSET
#define REG3 DAC_CONTROLLER_S00_AXI_SLV_REG3_OFFSET
#define tam_RAM 16384 // 16k muestras

#define ADC_BaseAddress XPAR_ADC_CONTROLLER_0_ADC_AXI_BASEADDR
#define REG0_ADC ADC_CONTROLLER_ADC_AXI_SLV_REG0_OFFSET
#define REG1_ADC ADC_CONTROLLER_ADC_AXI_SLV_REG1_OFFSET
#define REG2_ADC ADC_CONTROLLER_ADC_AXI_SLV_REG2_OFFSET
#define REG3_ADC ADC_CONTROLLER_ADC_AXI_SLV_REG3_OFFSET

#define Medidas_BaseAddress XPAR_MEDIDAS_0_S00_AXI_MEDIDAS_BASEADDR
#define REG0_Medidas MEDIDAS_S00_AXI_Medidas_SLV_REG0_OFFSET
#define REG1_Medidas MEDIDAS_S00_AXI_Medidas_SLV_REG1_OFFSET
#define REG2_Medidas MEDIDAS_S00_AXI_Medidas_SLV_REG2_OFFSET
#define REG3_Medidas MEDIDAS_S00_AXI_Medidas_SLV_REG3_OFFSET

void generar_rampa(int tam, uint16_t* buffer);
void generar_seno(int tam, uint16_t* buffer);
void generar_cuadrada(int tam, uint16_t* buffer);

#define CICLOS_ADC 4
#define MUESTRAS_ADC (CICLOS_ADC * tam_RAM)


uint16_t tabla[tam_RAM];
uint16_t adc_buffer[MUESTRAS_ADC];


int main()
{
    init_platform();

    //xil_printf("--- Inicio del programa ---\r\n"); // Mensaje de debug inicial

    DAC_CONTROLLER_mWriteReg(DAC_BaseAddress, REG3, 1);
    DAC_CONTROLLER_mWriteReg(DAC_BaseAddress, REG0, 1); // Habilita escritura

    // ------ Selecciona aquí la forma de onda ------
   //generar_rampa(tam_RAM, tabla);
     //generar_seno(tam_RAM, tabla);   // Nota: Requiere librería math (-lm)
     generar_cuadrada(tam_RAM, tabla);
    // ----------------------------------------------

    // Escribir la tabla en la RAM del DAC
//        xil_printf("INICIO DE DATOS\r\n"); // Marcador de inicio
        for(int dir = 0; dir < tam_RAM; dir++)
        {
            DAC_CONTROLLER_mWriteReg(DAC_BaseAddress, REG2, dir);
            DAC_CONTROLLER_mWriteReg(DAC_BaseAddress, REG1, tabla[dir]);

            // Imprimir TODOS los datos en formato CSV (Direccion,Dato)
            //xil_printf("%d %04d\r\n", dir, tabla[dir]);
        }
//        xil_printf("FIN DE DATOS\r\n"); // Marcador de fin

    DAC_CONTROLLER_mWriteReg(DAC_BaseAddress, REG0, 0); // Deshabilita escritura

    while(1)
    {
    	//uint32_t REG0_ADC_value = ADC_CONTROLLER_mReadReg(ADC_BaseAddress, REG0_ADC);
    	//uint16_t adc_data = REG0_ADC_value & 0x0FFF;
    	//uint8_t adc_DRDY = ADC_CONTROLLER_mReadReg(ADC_BaseAddress, REG1_ADC);
    	//xil_printf("%d\n", adc_data);
    	//uint32_t valor_medio =  MEDIDAS_mReadReg(Medidas_BaseAddress, REG1_Medidas);
    	// Lectura del contador de pulsos (un número entero de ciclos de 200 MHz)
    	    uint32_t periodo_counts = MEDIDAS_mReadReg(Medidas_BaseAddress, REG0_Medidas);
    	    float periodo_segundos = (float)periodo_counts * 5.0e-9;
    	    // 3. Cálculo de la Frecuencia (en Hz)
    	    float frecuencia_hz = 1.0f / periodo_segundos;

    	    uint32_t suma_total = MEDIDAS_mReadReg(Medidas_BaseAddress, REG1_Medidas);
    	    uint32_t num_muestras = MEDIDAS_mReadReg(Medidas_BaseAddress, REG2_Medidas);
    	    float valor_medio = (float)suma_total / (float)num_muestras;
    	    float valor_medio_V = 3.3*valor_medio/4096;

    	    char print_valor_medio_V[64];
    	    char print_frecuencia_hz[64];

    	    sprintf(print_valor_medio_V,"%.3f",valor_medio_V);
    	    sprintf(print_frecuencia_hz,"%.3f",frecuencia_hz);

    	    xil_printf("Frecuencia = %s Hz y Valor medio: %s V\r\n", print_frecuencia_hz, print_valor_medio_V);
    	    usleep(2000000);
    }

    cleanup_platform();
    return 0;
}

void generar_rampa(int tam, uint16_t* buffer) {
    uint16_t value = 0;

    for(int i = 0; i < tam; i++) {
        if(i % 4 == 0 && i != 0)
            value++;

        if(value > 4095) value = 4095;   // límite DAC

        buffer[i] = value;
    }
}

void generar_seno(int tam, uint16_t* buffer) {
    float amplitude = 2047.0f;   // mitad del rango
    float offset    = 2047.0f;   // desplaza a valores positivos

    for(int i = 0; i < tam; i++) {
        float x = 2.0f * PI * ((float)i / (float)tam);
        float sample = offset + amplitude * sin(x);

        if(sample < 0) sample = 0;
        if(sample > 4095) sample = 4095;

        buffer[i] = (uint16_t)sample;
    }
}


void generar_cuadrada(int tam, uint16_t* buffer) {
    uint16_t high = 4095;
    uint16_t low  = 0;

    for(int i = 0; i < tam; i++) {        if(i < tam/2)
            buffer[i] = high;
        else
            buffer[i] = low;
    }
}


