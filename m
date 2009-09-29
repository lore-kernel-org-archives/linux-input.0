From: Christopher Friedt <chrisfriedt@gmail.com>
Subject: Re: keypad input method question
Date: Tue, 29 Sep 2009 20:43:46 +0200
Message-ID: <3ea34a000909291143h7ab144b8w4a6b16e22a64b718@mail.gmail.com>
References: <3ea34a000909250601n5127dd2bt6a84aab7a93c26ed@mail.gmail.com>
	 <20090928170240.GE21455@core.coreip.homeip.net>
	 <3ea34a000909281242h5b7702cbt8005b100f58bee9c@mail.gmail.com>
	 <20090929113024.6f006e25.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:4849 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZI2Sno (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2009 14:43:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so6245189and.1
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2009 11:43:47 -0700 (PDT)
In-Reply-To: <20090929113024.6f006e25.kristoffer.ericson@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a6b989a..e8b9f25 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -231,6 +231,24 @@ config KEYBOARD_LM8323
 	  To compile this driver as a module, choose M here: the
 	  module will be called lm8323.

+config STMPE2401
+	tristate "STMPE2401 keypad support"
+	depends on I2C
+	help
+	  Say Y or M here to have support for the ST Micro STMPE2401 GPIO
+	  expander. The STMPE2401 provides up to twenty-four extra GPIO lines;
+	  three of the lines can be reserved for programmable PWM channels,
+	  another three lines can function as a dedicated rotator input, and
+	  up to 20 lines can be used by the integrated matrix-keypad controller.
+	  The matrix keypad controller allows up 12 rows and 8 columns of key
+	  input. Each of the GPIO, PWM, and rotator subsystems have simultaneous
+	  interrupt generation capabilities to alert the host system via GPIO.
+	  The STMPE2401 also supports sleep and hibernate modes for low-power
+	  devices. Currently, only the keypad functionality is implimented.
+	
+	  To compile this driver as a module, choose M here: the module
+	  will be called stmpe2401.
+
 config KEYBOARD_LOCOMO
 	tristate "LoCoMo Keyboard Support"
 	depends on SHARP_LOCOMO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index b5b5eae..9f67adc 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
 obj-$(CONFIG_KEYBOARD_LM8323)		+= lm8323.o
+obj-$(CONFIG_STMPE2401)				+= stmpe2401.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
--- /dev/null
+++ b/drivers/input/keyboard/stmpe2401.c
@@ -0,0 +1,1121 @@
+/*
+ * stmpe2401.c: driver for the STMPE2401 GPIO port expander
+ *
+ * Copyright (C) 2009 Christopher Friedt, <chrisfriedt@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * Documentation for this device is available freely from ST Micro
+ *
+ * http://www.st.com/stonline/products/literature/ds/13018/stmpe2401.htm
+ * http://www.st.com/stonline/products/literature/ds/13018.pdf
+ * http://www.st.com/stonline/products/literature/an/12649.pdf
+ * http://www.st.com/stonline/products/literature/an/12648.pdf
+ * http://www.st.com/stonline/products/literature/an/12647.pdf
+ * http://www.st.com/stonline/products/literature/um/12788.pdf
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/irqnr.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/input.h>
+
+#include <linux/i2c/stmpe2401.h>
+
+/*--------------------------------------------------------------------------*/
+
+#define DRIVER_NAME	"stmpe2401"
+
+/*--------------------------------------------------------------------------*/
+
+static inline u8 sum_bits( u32 x, u8 y ) {
+	u8 s;
+	for( s=0, --y; y >= 0; s += ((x >> y) & 1) ? 1 : 0, y-- );
+	return s;
+}
+#define sum_u8(x) sum_bits( (u32)x, 8 )
+#define sum_u16(x) sum_bits( (u32)x, 16 )
+#define sum_u32(x) sum_bits( (u32)x, 32 )
+
+/*--------------------------------------------------------------------------*/
+
+struct reg_conf {
+	u8 syscon;         /* 0x02 */
+	u8 icr_msb;        /* 0x10 */
+	u8 icr_lsb;        /* 0x11 */
+	u8 ier_msb;        /* 0x12 */
+	u8 ier_lsb;        /* 0x13 */
+	u8 isr_msb;        /* 0x14 */
+	u8 isr_lsb;        /* 0x15 */
+	u8 iegpior_msb;    /* 0x16 */
+	u8 iegpior_csb;    /* 0x17 */
+	u8 iegpior_lsb;    /* 0x18 */
+	u8 isgpior_msb;    /* 0x19 */
+	u8 isgpior_csb;    /* 0x1a */
+	u8 isgpior_lsb;    /* 0x1b */
+	u8 pwmcs;          /* 0x30 */
+	u8 pwmic0;         /* 0x38 */
+	u8 pwmic1;         /* 0x39 */
+	u8 pwmic2;         /* 0x3a */
+	u8 kpc_col;        /* 0x60 */
+	u8 kpc_row_msb;    /* 0x61 */
+	u8 kpc_row_lsb;    /* 0x62 */
+	u8 kpc_ctrl_msb;   /* 0x63 */
+	u8 kpc_ctrl_lsb;   /* 0x64 */
+	u8 kpc_data_byte0; /* 0x68 */
+	u8 kpc_data_byte1; /* 0x69 */
+	u8 kpc_data_byte2; /* 0x6a */
+	u8 chip_id;        /* 0x80 */
+	u8 version_id;     /* 0x81 */
+	u8 gpsr_msb;       /* 0x83 */
+	u8 gpsr_csb;       /* 0x84 */
+	u8 gpsr_lsb;       /* 0x85 */
+	u8 gpcr_msb;       /* 0x86 */
+	u8 gpcr_csb;       /* 0x87 */
+	u8 gpcr_lsb;       /* 0x88 */
+	u8 gpdr_msb;       /* 0x89 */
+	u8 gpdr_csb;       /* 0x8a */
+	u8 gpdr_lsb;       /* 0x8b */
+	u8 gpedr_msb;      /* 0x8c */
+	u8 gpedr_csb;      /* 0x8d */
+	u8 gpedr_lsb;      /* 0x8e */
+	u8 gprer_msb;      /* 0x8f */
+	u8 gprer_csb;      /* 0x90 */
+	u8 gprer_lsb;      /* 0x91 */
+	u8 gpfer_msb;      /* 0x92 */
+	u8 gpfer_csb;      /* 0x93 */
+	u8 gpfer_lsb;      /* 0x94 */
+	u8 gppur_msb;      /* 0x95 */
+	u8 gppur_csb;      /* 0x96 */
+	u8 gppur_lsb;      /* 0x97 */
+	u8 gppdr_msb;      /* 0x98 */
+	u8 gppdr_csb;      /* 0x99 */
+	u8 gppdr_lsb;      /* 0x9a */
+	u8 gpafr_u_msb;    /* 0x9b */
+	u8 gpafr_u_csb;    /* 0x9c */
+	u8 gpafr_u_lsb;    /* 0x9d */
+	u8 gpafr_l_msb;    /* 0x9e */
+	u8 gpafr_l_csb;    /* 0x9f */
+	u8 gpafr_l_lsb;    /* 0xa0 */
+	u8 gpmr_msb;       /* 0xa2 */
+	u8 gpmr_csb;       /* 0xa3 */
+	u8 gpmr_lsb;       /* 0xa4 */
+};
+
+struct pwm;
+
+struct stmpe2401 {
+	struct i2c_client	*cl;
+
+	u32 				adapter_functionality;
+	u8					key_map_conf;
+	u8					kpd_read_once;
+
+	struct irq_chip		*irq_chip;
+	struct gpio_chip	*gio_chip;
+	struct input_dev	*kpd_input_dev;
+	struct input_dev	*rot_input_dev;
+	struct pwm			*pwm[3];
+
+	// stmpe2401, kpd, pwm, rot, gio
+	struct work_struct	work[5];
+
+	struct list_head	list;
+	struct mutex		lock;
+
+	// this is allocated for setup and then de-allocated
+	struct reg_conf		*conf;
+};
+
+/*--------------------------------------------------------------------------*/
+
+static struct stmpe2401 instances = {
+		.list = LIST_HEAD_INIT( instances.list ),
+};
+
+/*--------------------------------------------------------------------------*/
+
+// [MSB] kpd->callback.custom, kpd->callback.setkeycode,
+// kpd->keymap.keycode, kpd->keymap.keycodemax [LSB]
+#define MAP_USE_CB 			0x0f
+#define MAP_USE_KM_WITH_S 	0x07
+#define MAP_USE_KM 			0x03
+
+/*--------------------------------------------------------------------------*/
+
+/* usual argument order is client, command, length, (const) values */
+#define read_u8(x,y)		i2c_smbus_read_byte_data(x,y)
+#define write_u8(x,y,z)		i2c_smbus_write_byte_data(x,y,z)
+
+#define read_u16(x,y)		i2c_smbus_read_word_data(x,y)
+#define write_u16(x,y,z)	i2c_smbus_write_word_data(x,y,z)
+
+/*
+// TODO: need generic wrapper to handle various adapter functionality
+// until are more generic handler is available
+#define read_data(x,y,z)	i2c_smbus_read_block_data(x,y,z)
+#define write_data(w,x,y,z)	i2c_smbus_write_block_data(w,x,y,z)
+*/
+
+/*--------------------------------------------------------------------------*/
+
+static void read_and_print_all_registers( struct stmpe2401 *instance ) {
+	struct i2c_client *client = instance->cl;
+	u8 i,j;
+
+	for( i = 0; i < SZ_STMPE2401_REGMAP; i++ ) {
+		j = read_u8( client, regmap[i].reg );
+		printk( KERN_DEBUG DRIVER_NAME "-regmap[%.2d]: 0x%.2x : 0x%.2x : %s\n",
+				i, regmap[i].reg, j, regmap[i].name );
+	}
+
+}
+
+/*--------------------------------------------------------------------------*/
+
+static void kpd_work( struct stmpe2401 *instance ) {
+
+//	struct stmpe2401 *instance =
+//			container_of( work, struct stmpe2401, work[1] );
+
+	struct i2c_client *client = instance->cl;
+	struct stmpe2401_platform_data *pdata = client->dev.platform_data;
+	struct stmpe2401_kpd_data *kpd = pdata->kpd;
+	struct input_dev *input = instance->kpd_input_dev;
+	s32 keycode;
+
+	u8 i,j,k;
+	u8 kpc_data[3] = { 0 };
+	u8 have_key;
+
+	s32 error;
+
+	// an2423 states that the interrupt should be cleared _first_
+	kpc_data[0] = KPC_INT_ST | KPC_FIFO_INT_ST;
+	error = write_u8( client, ISR_lsb, kpc_data[0] );
+	if ( error ) {
+		printk( KERN_ERR DRIVER_NAME
+				": %s: failed to clear ISR (error %d)\n",
+				__FUNCTION__, error);
+	}
+
+	have_key = 1;
+	for( j = 0; j < KPC_FIFO_LEN && have_key; j++ ) {
+		for( i = 0; i < 3; i++ ) {
+			error = read_u8( client, KPC_data_byte(i) );
+			if ( error < 0 ) {
+				printk( KERN_ERR DRIVER_NAME
+						": %s: failed KPC_data_byte%d (error %d)\n",
+						__FUNCTION__, i, error);
+			} else {
+				kpc_data[i] = (u8) error;
+			}
+		}
+#define get_row(x) 		((x>>3) & 0xf)
+#define get_col(x) 		( x     & 0x7)
+#define get_press(x) 	( x   & 0x80 )
+#define get_dedkey(x,y)	((x>>y) & 0x80)
+		have_key = 0;
+		keycode = 0;
+		for( i = 0; i < 3; i++ ) {
+			if ( i < 2 ) {
+				if ( get_row( kpc_data[i] ) >= 0 &&
+						get_row( kpc_data[i] ) < 12 ) {
+/*
+					printk( KERN_DEBUG DRIVER_NAME ": key %d { %d %d } %s\n",
+							i, get_row( kpc_data[i] ), get_col( kpc_data[i] ),
+							get_press( kpc_data[i] ) ? "up" : "down" );
+*/
+					have_key = 1;
+					if ( instance->key_map_conf == MAP_USE_CB ) {
+						kpd->callback.custom( input, kpc_data[i] );
+					} else {
+						error = input->getkeycode( input,
+								kpc_data[i] & 0x7f, & keycode );
+						if ( error ) {
+							printk( KERN_ERR DRIVER_NAME
+							": failed to get keycode for key at "
+							"{ %d %d } (error %d)\n", get_row( kpc_data[i] ),
+							get_col( kpc_data[i] ), error );
+						} else {
+							if ( keycode )
+								input_report_key( input, keycode,
+										get_press( kpc_data[i] ) );
+						}
+					}
+				}
+			} else {
+				if ( pdata->kpd->ded_keys ) {
+					for( k = 0; k < 4; k++ ) {
+						if ( get_dedkey(kpd->ded_keys,k) ) {
+/*
+							printk( KERN_DEBUG DRIVER_NAME
+									": ded key %d %s\n",
+									k, get_dedkey(kpc_data[i],k) ?
+											"up" : "down" );
+*/
+							have_key = 1;
+							if ( instance->key_map_conf == MAP_USE_CB ) {
+								kpd->callback.custom( input, kpc_data[i] );
+							} else {
+								error = input->getkeycode( input,
+										kpc_data[i] << 8, & keycode );
+								if ( error ) {
+									printk( KERN_ERR DRIVER_NAME
+											": failed to get keycode for "
+											"ded key %d (error %d)\n",
+											k, error );
+								} else {
+									if ( keycode )
+										input_report_key( input, keycode,
+												get_press( kpc_data[i] ) );
+								}
+							}
+						}
+					}
+				}
+			}
+		}
+	}
+}
+static void pwm_work( struct work_struct *work ) {
+	struct stmpe2401 *instance =
+			container_of( work, struct stmpe2401, work[2] );
+	struct i2c_client *client = instance->cl;
+	mutex_lock( & instance->lock );
+	// TODO: write me
+	mutex_unlock( & instance->lock );
+}
+static void rot_work( struct work_struct *work ) {
+	struct stmpe2401 *instance =
+			container_of( work, struct stmpe2401, work[3] );
+	struct i2c_client *client = instance->cl;
+
+	mutex_lock( & instance->lock );
+	// TODO: write me
+	mutex_unlock( & instance->lock );
+}
+static void gio_work( struct work_struct *work ) {
+	struct stmpe2401 *instance =
+			container_of( work, struct stmpe2401, work[4] );
+	struct i2c_client *client = instance->cl;
+
+	mutex_lock( & instance->lock );
+	// TODO: write me
+	mutex_unlock( & instance->lock );
+}
+static void stmpe2401_work( struct work_struct *work ) {
+	struct stmpe2401 *instance =
+			container_of( work, struct stmpe2401, work[0] );
+	struct i2c_client *client = instance->cl;
+	struct stmpe2401_platform_data *pdata = client->dev.platform_data;
+
+	u8 i, clr;
+	u8 isr[2] = { 0 };
+	u8 conf_data[] = {
+			(pdata->kpd ? 1 : 0),
+			(pdata->pwm ? 1 : 0),
+			(pdata->rot ? 1 : 0),
+			(pdata->gio ? 1 : 0),
+	};
+	// 1 = isr_lsb, 0 = isr_msb
+	u8 mask[][2] = {
+			{ 1, KPC_INT_ST | KPC_FIFO_INT_ST	},
+			{ 1, PWM_CH_INT_ST(3) 				},
+			{ 1, ROT_INT_ST | ROT_BUF_INT_ST 	},
+			{ 0, GPIO_INT_ST 					},
+	};
+
+	mutex_lock( & instance->lock );
+
+	isr[0] = read_u8( client, ISR_msb );
+	isr[1] = read_u8( client, ISR_lsb );
+/*
+	if ( pdata->kpd && ! instance->kpd_read_once ) {
+		instance->kpd_read_once = 1;
+		isr[1] |= KPC_INT_ST | KPC_FIFO_INT_ST;
+	}
+*/
+
+	for( i = 0; i < 4; i++ ) {
+		if ( isr[ mask[i][0] ] & mask[i][1] ) {
+			if ( conf_data[i] ) {
+				//schedule_work( & instance->work[i] );
+				kpd_work( instance );
+			} else {
+				// anything that gets here is ERRONEOUS - BUG? WARN?
+			}
+		}
+	}
+
+	mutex_unlock( & instance->lock );
+}
+
+/*--------------------------------------------------------------------------*/
+
+static irqreturn_t stmpe2401_interrupt_handler( int irq, void *data ) {
+	struct list_head *pos;
+	struct stmpe2401 *instance = NULL;
+
+	if ( data ) {
+		list_for_each( pos, & instances.list ) {
+			instance = container_of( pos, struct stmpe2401, list );
+			if ( instance == data && instance->cl->irq == irq )
+				break;
+			else
+				instance = NULL;
+		}
+	}
+	if ( ! instance ) {
+		printk( KERN_DEBUG DRIVER_NAME
+				": no instance matching irq %d at address %p\n",
+				irq, data );
+		return IRQ_NONE;
+	}
+
+	schedule_work( & instance->work[0] );
+
+	return IRQ_HANDLED;
+}
+
+/*--------------------------------------------------------------------------*/
+
+/*
+	conf->gppur_lsb = 0xff;
+	conf->gpdr_msb = 0xff;
+	conf->gpdr_csb = 0xff;
+	conf->gpafr_u_msb = 0x55;
+	conf->gpafr_u_csb = 0x55;
+	conf->gpafr_u_lsb = 0x55;
+	conf->gpafr_l_msb = 0x55;
+	conf->gpafr_l_csb = 0x55;
+	conf->gpafr_l_lsb = 0x55;
+	conf->kpc_col = 0xff;
+	conf->kpc_row_msb = 0xcf;
+	conf->kpc_row_lsb = 0xff;
+	conf->kpc_ctrl_msb = 0x00;
+	conf->icr_lsb = 0x01;
+	conf->ier_lsb = 0x06;
+	conf->syscon = 0x0f;
+	conf->kpc_ctrl_lsb = 0x61;
+*/
+
+static int __init setup_kpd( struct stmpe2401 *instance ) {
+
+	struct stmpe2401_platform_data * pdata =
+			instance->cl->dev.platform_data;
+	struct stmpe2401_kpd_data *kpd = pdata->kpd;
+	struct input_dev *input;
+	struct reg_conf *conf = instance->conf;
+	u8 i,j;
+	int error;
+
+#define bmpx	kpd->bmp
+#define rows 	gio_to_row_bmp( bmpx )
+#define cols 	gio_to_col_bmp( bmpx )
+
+#define bmp_to_gpdr_msb(x)		((u8)( x >> 16))
+#define bmp_to_gpdr_csb(x)		((u8)( x >>  8))
+#define bmp_to_gpafr(x,y,z)     \
+	j = ( x >> z ) & 0xf;       \
+	for( i = 0; i < 4; i++ ) {  \
+		y |= (j >> i) & 1 ?     \
+				1 << 2*i : 0;   \
+	}
+
+	// be bit-friendly with all of the shared registers
+
+	conf->syscon 		|= KPC_CLK_EN | GPIO_CLK_EN;
+	conf->icr_lsb		|= GLOBAL_INT_EN;
+	conf->ier_lsb		|= KPC_INT_EN | KPC_FIFO_INT_EN;
+	conf->gpdr_msb		|= bmp_to_gpdr_msb( bmpx );
+	conf->gpdr_csb		|= bmp_to_gpdr_csb( bmpx );
+	conf->gpdr_lsb		&= ~cols;
+	conf->gppur_lsb		|= cols;
+
+	bmp_to_gpafr( bmpx, conf->gpafr_u_msb, 20 );
+	bmp_to_gpafr( bmpx, conf->gpafr_u_csb, 16 );
+	bmp_to_gpafr( bmpx, conf->gpafr_u_lsb, 12 );
+	bmp_to_gpafr( bmpx, conf->gpafr_l_msb,  8 );
+	bmp_to_gpafr( bmpx, conf->gpafr_l_csb,  4 );
+	bmp_to_gpafr( bmpx, conf->gpafr_l_lsb,  0 );
+
+
+#define rows_to_kpc_row_msb(x)	((u8)(( x >>  8) & 0xf ))
+#define rows_to_kpc_row_lsb(x)	((u8)(  x               ))
+
+	// no need to be bit-friendly for keypad-specific registers
+
+	conf->kpc_col		= cols;
+	conf->kpc_row_msb	= rows_to_kpc_row_msb(rows) | KPC_SCAN_PW;
+	conf->kpc_row_lsb	= rows_to_kpc_row_lsb(rows);
+	conf->kpc_ctrl_msb	= kpd->ded_keys & 0xf;
+	conf->kpc_ctrl_lsb	= KPC_DEBOUNCE_MS(kpd->debounce) | KPC_SCAN_ENABLE;
+
+	// next make an input_dev for the keypad
+
+	instance->kpd_input_dev = input_allocate_device();
+	if ( ! instance->kpd_input_dev ) {
+		error = -ENOMEM;
+		printk( KERN_ERR DRIVER_NAME
+				": unable to allocate keypad input device (error %d)\n",
+				error );
+		goto err_return;
+	}
+
+	input = instance->kpd_input_dev;
+	input->dev.parent = & instance->cl->dev;
+	input->phys = DRIVER_NAME;
+	input->name = DRIVER_NAME "-keypad";
+	input->id.bustype = BUS_I2C;
+	set_bit( EV_KEY, input->evbit );
+	set_bit( EV_REP, input->evbit );
+	set_bit( EV_MSC, input->evbit );
+	set_bit( MSC_SCAN, input->mscbit );
+	input->keycodesize = STMPE2401_KEYMAP_SCANCODESIZE;
+
+	switch( instance->key_map_conf ) {
+	case MAP_USE_CB:
+		input->setkeycode = kpd->callback.setkeycode;
+		for( i = 0; i < kpd->keymap.keycodemax; i++ )
+			set_bit( kpd->keymap.keycode[i], input->keybit );
+		break;
+	case MAP_USE_KM_WITH_S:
+		input->setkeycode = kpd->callback.setkeycode;
+	case MAP_USE_KM:
+		input->keycode = kpd->keymap.keycode;
+		input->keycodemax = kpd->keymap.keycodemax;
+		for( i = 0; i < kpd->keymap.keycodemax; i++ )
+			set_bit( i, input->keybit );
+		break;
+	default:
+		// this is a BUG ... validation is done beforehand, so code should
never get here.
+		printk( KERN_ERR DRIVER_NAME
+				": invalid keypad mapping configuration 0x%.2x\n",
+				instance->key_map_conf );
+		error = -EINVAL;
+		goto free_input;
+	}
+
+	error = input_register_device( input );
+	if ( error ) {
+		printk( KERN_ERR DRIVER_NAME ": failed to register keypad input
device (error %d)\n", error );
+		goto free_input;
+	}
+
+free_input:
+	input_free_device( input );
+err_return:
+	return 0;
+}
+static int __init setup_pwm( struct stmpe2401 *instance ) {
+	return -ENOSYS;
+}
+static int __init setup_rot( struct stmpe2401 *instance ) {
+	return -ENOSYS;
+}
+static int __init setup_gio( struct stmpe2401 *instance ) {
+	return -ENOSYS;
+}
+
+static void __init cleanup_kpd( struct stmpe2401 *instance ) {
+	struct input_dev *input = instance->kpd_input_dev;
+
+	printk( KERN_DEBUG DRIVER_NAME ": locking stmp2401 instance\n" );
+
+	if ( input ) {
+		printk( KERN_DEBUG DRIVER_NAME ": unregistering keypad input device\n" );
+		input_unregister_device( input );
+		//cancel_work_sync( & instance->work[1] );
+		instance->kpd_input_dev = NULL;
+	}
+}
+static void __init cleanup_pwm( struct stmpe2401 *instance ) {
+
+}
+static void __init cleanup_rot( struct stmpe2401 *instance ) {
+
+}
+static void __init cleanup_gio( struct stmpe2401 *instance ) {
+
+}
+
+/*--------------------------------------------------------------------------*/
+
+static void __init init_config( struct reg_conf *conf ) {
+	conf->syscon          = RESET_VAL(SYSCON);
+	conf->icr_msb         = RESET_VAL(ICR_msb);
+	conf->icr_lsb         = RESET_VAL(ICR_lsb);
+	conf->ier_msb         = RESET_VAL(IER_msb);
+	conf->ier_lsb         = RESET_VAL(IER_lsb);
+	conf->isr_msb         = RESET_VAL(ISR_msb);
+	conf->isr_lsb         = RESET_VAL(ISR_lsb);
+	conf->iegpior_msb     = RESET_VAL(IEGPIOR_msb);
+	conf->iegpior_csb     = RESET_VAL(IEGPIOR_csb);
+	conf->iegpior_lsb     = RESET_VAL(IEGPIOR_lsb);
+	conf->isgpior_msb     = RESET_VAL(ISGPIOR_msb);
+	conf->isgpior_csb     = RESET_VAL(ISGPIOR_csb);
+	conf->isgpior_lsb     = RESET_VAL(ISGPIOR_lsb);
+	conf->pwmcs           = RESET_VAL(PWMCS);
+	conf->pwmic0          = RESET_VAL(PWMIC0);
+	conf->pwmic1          = RESET_VAL(PWMIC1);
+	conf->pwmic2          = RESET_VAL(PWMIC2);
+	conf->kpc_col         = RESET_VAL(KPC_col);
+	conf->kpc_row_msb     = RESET_VAL(KPC_row_msb);
+	conf->kpc_row_lsb     = RESET_VAL(KPC_row_lsb);
+	conf->kpc_ctrl_msb    = RESET_VAL(KPC_ctrl_msb);
+	conf->kpc_ctrl_lsb    = RESET_VAL(KPC_ctrl_lsb);
+	conf->kpc_data_byte0  = RESET_VAL(KPC_data_byte0);
+	conf->kpc_data_byte1  = RESET_VAL(KPC_data_byte1);
+	conf->kpc_data_byte2  = RESET_VAL(KPC_data_byte2);
+	conf->chip_id         = RESET_VAL(CHIP_ID);
+	conf->version_id      = RESET_VAL(VERSION_ID);
+	conf->gpsr_msb        = RESET_VAL(GPSR_msb);
+	conf->gpsr_csb        = RESET_VAL(GPSR_csb);
+	conf->gpsr_lsb        = RESET_VAL(GPSR_lsb);
+	conf->gpcr_msb        = RESET_VAL(GPCR_msb);
+	conf->gpcr_csb        = RESET_VAL(GPCR_csb);
+	conf->gpcr_lsb        = RESET_VAL(GPCR_lsb);
+	conf->gpdr_msb        = RESET_VAL(GPDR_msb);
+	conf->gpdr_csb        = RESET_VAL(GPDR_csb);
+	conf->gpdr_lsb        = RESET_VAL(GPDR_lsb);
+	conf->gpedr_msb       = RESET_VAL(GPEDR_msb);
+	conf->gpedr_csb       = RESET_VAL(GPEDR_csb);
+	conf->gpedr_lsb       = RESET_VAL(GPEDR_lsb);
+	conf->gprer_msb       = RESET_VAL(GPRER_msb);
+	conf->gprer_csb       = RESET_VAL(GPRER_csb);
+	conf->gprer_lsb       = RESET_VAL(GPRER_lsb);
+	conf->gpfer_msb       = RESET_VAL(GPFER_msb);
+	conf->gpfer_csb       = RESET_VAL(GPFER_csb);
+	conf->gpfer_lsb       = RESET_VAL(GPFER_lsb);
+	conf->gppur_msb       = RESET_VAL(GPPUR_msb);
+	conf->gppur_csb       = RESET_VAL(GPPUR_csb);
+	conf->gppur_lsb       = RESET_VAL(GPPUR_lsb);
+	conf->gppdr_msb       = RESET_VAL(GPPDR_msb);
+	conf->gppdr_csb       = RESET_VAL(GPPDR_csb);
+	conf->gppdr_lsb       = RESET_VAL(GPPDR_lsb);
+	conf->gpafr_u_msb     = RESET_VAL(GPAFR_U_msb);
+	conf->gpafr_u_csb     = RESET_VAL(GPAFR_U_csb);
+	conf->gpafr_u_lsb     = RESET_VAL(GPAFR_U_lsb);
+	conf->gpafr_l_msb     = RESET_VAL(GPAFR_L_msb);
+	conf->gpafr_l_csb     = RESET_VAL(GPAFR_L_csb);
+	conf->gpafr_l_lsb     = RESET_VAL(GPAFR_L_lsb);
+	conf->gpmr_msb        = RESET_VAL(GPMR_msb);
+	conf->gpmr_csb        = RESET_VAL(GPMR_csb);
+	conf->gpmr_lsb        = RESET_VAL(GPMR_lsb);
+
+	// syscon should be 0 to begin with
+	conf->syscon = 0;
+	// all unused gpio should be output and set to zero
+	// to begin with
+	conf->gpdr_msb = 0xff;
+	conf->gpdr_csb = 0xff;
+	conf->gpdr_lsb = 0xff;
+}
+static int __init write_config( struct stmpe2401 *instance ) {
+	struct i2c_client *client = instance->cl;
+	struct reg_conf *conf = instance->conf;
+	int error = 0;
+
+#define WRITE_ORDER(x)                                         \
+	{ x->gppur_msb,    RESET_VAL_GPPUR_msb,    GPPUR_msb    }, \
+	{ x->gppur_csb,    RESET_VAL_GPPUR_csb,    GPPUR_csb    }, \
+	{ x->gppur_lsb,    RESET_VAL_GPPUR_lsb,    GPPUR_lsb    }, \
+	{ x->gppdr_msb,    RESET_VAL_GPPDR_msb,    GPPDR_msb    }, \
+	{ x->gppdr_csb,    RESET_VAL_GPPDR_csb,    GPPDR_csb    }, \
+	{ x->gppdr_lsb,    RESET_VAL_GPPDR_lsb,    GPPDR_lsb    }, \
+	{ x->gpdr_msb,     RESET_VAL_GPDR_msb,     GPDR_msb     }, \
+	{ x->gpdr_csb,     RESET_VAL_GPDR_csb,     GPDR_csb     }, \
+	{ x->gpdr_lsb,     RESET_VAL_GPDR_lsb,     GPDR_lsb     }, \
+	{ x->gpafr_u_msb,  RESET_VAL_GPAFR_U_msb,  GPAFR_U_msb  }, \
+	{ x->gpafr_u_csb,  RESET_VAL_GPAFR_U_csb,  GPAFR_U_csb  }, \
+	{ x->gpafr_u_lsb,  RESET_VAL_GPAFR_U_lsb,  GPAFR_U_lsb  }, \
+	{ x->gpafr_l_msb,  RESET_VAL_GPAFR_L_msb,  GPAFR_L_msb  }, \
+	{ x->gpafr_l_csb,  RESET_VAL_GPAFR_L_csb,  GPAFR_L_csb  }, \
+	{ x->gpafr_l_lsb,  RESET_VAL_GPAFR_L_lsb,  GPAFR_L_lsb  }, \
+	{ x->kpc_col,      RESET_VAL_KPC_col,      KPC_col      }, \
+	{ x->kpc_row_msb,  RESET_VAL_KPC_row_msb,  KPC_row_msb  }, \
+	{ x->kpc_row_lsb,  RESET_VAL_KPC_row_lsb,  KPC_row_lsb  }, \
+	{ x->kpc_ctrl_msb, RESET_VAL_KPC_ctrl_msb, KPC_ctrl_msb }, \
+	{ x->iegpior_msb,  RESET_VAL_IEGPIOR_msb,  IEGPIOR_msb  }, \
+	{ x->iegpior_csb,  RESET_VAL_IEGPIOR_csb,  IEGPIOR_csb  }, \
+	{ x->iegpior_lsb,  RESET_VAL_IEGPIOR_lsb,  IEGPIOR_lsb  }, \
+	{ x->isgpior_msb,  RESET_VAL_ISGPIOR_msb,  ISGPIOR_msb  }, \
+	{ x->isgpior_csb,  RESET_VAL_ISGPIOR_csb,  ISGPIOR_csb  }, \
+	{ x->isgpior_lsb,  RESET_VAL_ISGPIOR_lsb,  ISGPIOR_lsb  }, \
+	{ x->gpedr_msb,    RESET_VAL_GPEDR_msb,    GPEDR_msb    }, \
+	{ x->gpedr_csb,    RESET_VAL_GPEDR_csb,    GPEDR_csb    }, \
+	{ x->gpedr_lsb,    RESET_VAL_GPEDR_lsb,    GPEDR_lsb    }, \
+	{ x->gprer_msb,    RESET_VAL_GPRER_msb,    GPRER_msb    }, \
+	{ x->gprer_csb,    RESET_VAL_GPRER_csb,    GPRER_csb    }, \
+	{ x->gprer_lsb,    RESET_VAL_GPRER_lsb,    GPRER_lsb    }, \
+	{ x->gpfer_msb,    RESET_VAL_GPFER_msb,    GPFER_msb    }, \
+	{ x->gpfer_csb,    RESET_VAL_GPFER_csb,    GPFER_csb    }, \
+	{ x->gpfer_lsb,    RESET_VAL_GPFER_lsb,    GPFER_lsb    }, \
+	{ x->gpsr_msb,     RESET_VAL_GPSR_msb,     GPSR_msb     }, \
+	{ x->gpsr_csb,     RESET_VAL_GPSR_csb,     GPSR_csb     }, \
+	{ x->gpsr_lsb,     RESET_VAL_GPSR_lsb,     GPSR_lsb     }, \
+	{ x->gpcr_msb,     RESET_VAL_GPCR_msb,     GPCR_msb     }, \
+	{ x->gpcr_csb,     RESET_VAL_GPCR_csb,     GPCR_csb     }, \
+	{ x->gpcr_lsb,     RESET_VAL_GPCR_lsb,     GPCR_lsb     }, \
+	{ x->pwmcs,        RESET_VAL_PWMCS,        PWMCS        }, \
+	{ x->pwmic0,       RESET_VAL_PWMIC0,       PWMIC0       }, \
+	{ x->pwmic1,       RESET_VAL_PWMIC1,       PWMIC1       }, \
+	{ x->pwmic2,       RESET_VAL_PWMIC2,       PWMIC2       }, \
+	{ x->icr_lsb,      RESET_VAL_ICR_lsb,      ICR_lsb      }, \
+	{ x->ier_msb,      RESET_VAL_IER_msb,      IER_msb      }, \
+	{ x->ier_lsb,      RESET_VAL_IER_lsb,      IER_lsb      }, \
+	{ x->syscon,       RESET_VAL_SYSCON,       SYSCON       }, \
+	{ x->kpc_ctrl_lsb, RESET_VAL_KPC_ctrl_lsb, KPC_ctrl_lsb },
+
+	u8 set[60][3] = {  WRITE_ORDER(conf) };
+	u8 i;
+
+	for ( i = 0; i < 60; i++ )
+		if ( set[i][0] != set[i][1] ) {
+//			printk( KERN_DEBUG DRIVER_NAME ": writing 0x%.2x to 0x%.2x\n",
+//					set[i][0], set[i][2] );
+			error = write_u8( client, set[i][2], set[i][0] );
+			if ( error ) {
+				printk( KERN_DEBUG DRIVER_NAME
+						": failed to write 0x%.2x to 0x%.2x\n",
+						set[i][0], set[i][2] );
+				break;
+			}
+		}
+
+	return error;
+}
+
+static int __init configure_stmpe2401(
+		struct stmpe2401 *instance ) {
+
+	struct stmpe2401_platform_data *pdata = instance->cl->dev.platform_data;
+	u8 conf_data[] = {
+			(pdata->kpd ? 1 : 0),
+			(pdata->pwm ? 1 : 0),
+			(pdata->rot ? 1 : 0),
+			(pdata->gio ? 1 : 0),
+	};
+	int (*setup[])( struct stmpe2401 *instance )
+			= { & setup_kpd, & setup_pwm, & setup_rot, & setup_gio };
+	void (*cleanup[])( struct stmpe2401 *instance )
+		= { & cleanup_kpd, & cleanup_pwm, & cleanup_rot, & cleanup_gio };
+//	void (*work_fn[])( struct work_struct *work )
+//			= { & kpd_work, & pwm_work, & rot_work, & gio_work };
+
+	u8 i;
+	int error = 0;
+
+	INIT_WORK( & instance->work[0], stmpe2401_work );
+	mutex_init( & instance->lock );
+
+	instance->conf = kzalloc( sizeof( struct reg_conf) , GFP_KERNEL );
+	if ( ! instance->conf ) { error = -ENOMEM; goto err_return; }
+	init_config( instance->conf );
+
+	for( i = 0; i < 4; i++ ) {
+		if ( conf_data[i] ) {
+			//INIT_WORK( & instance->work[i+1], work_fn[i] );
+			error = setup[i]( instance );
+			if ( error ) goto free_stuff;
+		}
+	}
+
+	error = write_config( instance );
+	if ( error ) goto free_conf;
+
+	error = 0;
+
+	kfree( instance->conf );
+	return 0;
+free_stuff:
+	for(; i >= 0; i-- )
+		if ( conf_data[i] )
+			cleanup[i]( instance );
+free_conf:
+	kfree( instance->conf );
+err_return:
+	return error;
+}
+
+/*--------------------------------------------------------------------------*/
+
+static int __init read_ids( struct i2c_client *client ) {
+	u8 chip_id, version_id;
+	chip_id = read_u8( client, CHIP_ID );
+	version_id = read_u8( client, VERSION_ID );
+	if ( chip_id != RESET_VAL_CHIP_ID ||
+			version_id	!= RESET_VAL_VERSION_ID ) {
+		printk( KERN_ERR DRIVER_NAME ": stmpe2401 device not found\n" );
+		return -ENODEV;
+	}
+	printk( KERN_DEBUG DRIVER_NAME
+			": stmpe2401 found with CHIP_ID %x and VERSION_ID %x\n",
+			chip_id, version_id );
+
+	return 0;
+}
+static int __init pin_conflict( struct stmpe2401_platform_data * pdata ) {
+
+#define bmp_kpd pdata->kpd ? (u32)pdata->kpd->bmp : 0
+#define bmp_pwm pdata->pwm ? (u32)pdata->pwm->bmp : 0
+#define bmp_rot pdata->rot ? (u32)pdata->rot->bmp : 0
+#define bmp_gio pdata->gio ? (u32)pdata->gio->bmp : 0
+#define bmp(x) bmp_##x
+#define bmp_nc pdata->nc
+
+	u32 conflict = 0;
+	u32 bmp[5] = { bmp_nc, bmp(kpd), bmp(pwm), bmp(rot), bmp(gio) };
+	u8 i;
+
+	for ( i = 0; i < sizeof(bmp); i++ ) {
+		conflict &= bmp[i];
+		if ( conflict ) {
+			printk( KERN_ERR DRIVER_NAME
+					": pin assignment conflict 0x%x\n", conflict );
+			break;
+		}
+	}
+	return conflict;
+}
+
+static int __init validate_kpd( struct stmpe2401 *instance ) {
+
+	struct stmpe2401_platform_data *pdata = instance->cl->dev.platform_data;
+	struct stmpe2401_kpd_data *kpd = pdata->kpd;
+	int error;
+
+#define map_cb_c(x) \
+	( x->callback.custom ? 1 : 0)
+#define map_cb_s(x) \
+	( x->callback.setkeycode ? 1 : 0)
+#define map_km_kc(x) \
+	(x->keymap.keycode ? 1 : 0)
+#define map_km_kcm(x) \
+	((x->keymap.keycodemax > 0 && x->keymap.keycodemax < KEY_CNT) ? 1 : 0)
+#define map_bit(x,y) \
+	(x<<y)
+#define map_conf(x) \
+	(u8)( map_bit(   map_cb_c(x),3) | \
+		  map_bit(   map_cb_s(x),2) | \
+		  map_bit(  map_km_kc(x),1) | \
+		  map_bit( map_km_kcm(x),0)   )
+
+	instance->key_map_conf =  map_conf( kpd );
+	switch( instance->key_map_conf ) {
+	case MAP_USE_CB:
+	case MAP_USE_KM_WITH_S:
+	case MAP_USE_KM:
+		break;
+	default:
+		printk( KERN_ERR DRIVER_NAME
+				": invalid keymap configuration (0x%x)\n", instance->key_map_conf );
+		error = -EINVAL;
+		goto err_return;
+	}
+
+	return 0;
+
+err_return:
+	return error;
+}
+static int __init validate_pwm( struct stmpe2401 *instance ) {
+	return -ENOSYS;
+}
+static int __init validate_rot( struct stmpe2401 *instance ) {
+	return -ENOSYS;
+}
+static int __init validate_gio( struct stmpe2401 *instance ) {
+	return -ENOSYS;
+}
+static int __init validate_stmpe2401( struct stmpe2401 *instance ) {
+	struct stmpe2401_platform_data *pdata = instance->cl->dev.platform_data;
+	struct i2c_client *client = instance->cl;
+	int error;
+	u8 i;
+
+	int (*validate[])(struct stmpe2401 *instance) =
+		{ & validate_kpd, & validate_pwm, & validate_rot, & validate_gio };
+
+	u8 conf_data[] = {
+			(pdata->kpd ? 1 : 0), (pdata->pwm ? 1 : 0),
+			(pdata->rot ? 1 : 0), (pdata->gio ? 1 : 0) };
+
+	u8 has_conf_data = 0;
+	for( i = 0; i < 4; i++ ) {
+		has_conf_data |= conf_data[i];
+	}
+	if( ! has_conf_data ) {
+		printk( KERN_ERR DRIVER_NAME ": no configuration in platform data\n" );
+		error = -EINVAL;
+		goto err_return;
+	}
+
+	error = pin_conflict( pdata );
+	if ( error ) {
+		error = -EINVAL;
+		goto err_return;
+	}
+
+	error = read_ids( client );
+	if ( error ) goto err_return;
+
+	for( i = 0; i < 4; i++ ) {
+		if ( conf_data[i] ) {
+			error = validate[i]( instance );
+			if ( error ) goto err_return;
+		}
+	}
+
+	return 0;
+
+err_return:
+	return error;
+}
+/*--------------------------------------------------------------------------*/
+
+
+/*--------------------------------------------------------------------------*/
+
+static int __devinit
+stmpe2401_probe(
+		struct i2c_client *client, const struct i2c_device_id *id  ) {
+
+	struct stmpe2401_platform_data *pdata = client->dev.platform_data;
+	int error = -EINVAL;
+	struct stmpe2401 * instance;
+	int sw_reset = 0;
+
+	if ( ! ( client && client->dev.platform_data ) ) {
+		printk( KERN_ERR DRIVER_NAME ": no platform data\n");
+		error = -EINVAL;
+		goto err_return;
+	}
+
+	instance = kzalloc( sizeof( struct stmpe2401 ), GFP_KERNEL );
+	if ( ! instance ) {
+		printk( KERN_ERR DRIVER_NAME ": could not allocate stmpe2401 struct\n" );
+		error = -ENOMEM;
+		goto err_return;
+	}
+
+	INIT_LIST_HEAD( & instance->list );
+	list_add_tail( & instance->list, & instances.list );
+	instance->cl = client;
+
+	error = validate_stmpe2401( instance );
+	if ( error ) {
+		printk( KERN_ERR "failed to validate stmpe2401 (error %d)\n", error );
+		goto remove_from_list;
+	}
+
+	if ( pdata->getpower && pdata->setpower )
+		if ( ! pdata->getpower() )
+			pdata->setpower( 1 );
+		else
+			if ( pdata->reset )
+				pdata->reset();
+			else
+				sw_reset = 1;
+	else
+		sw_reset = 1;
+
+	if ( sw_reset ) {
+		printk( KERN_ERR DRIVER_NAME
+				": using soft-reset because hardware reset is unavailable.\n" );
+		error = write_u8( client, SYSCON, RESET );
+		if ( error ) {
+			printk( KERN_ERR DRIVER_NAME
+					": failed to send reset signal to stmpe2401 (error %d)\n", error );
+			goto free_instance;
+		}
+	}
+
+	// IRQF_DISABLED ?
+	error = request_irq( client->irq, stmpe2401_interrupt_handler,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING, DRIVER_NAME,
+			instance );
+	if ( error ) {
+		printk( KERN_ERR DRIVER_NAME
+				": unable to request irq %d (error %d)\n",
+				client->irq, error );
+		goto free_instance;
+	}
+
+	error = configure_stmpe2401( instance );
+	if ( error ) {
+		printk( KERN_ERR DRIVER_NAME
+				": failed to configure stmpe2401 (error %d)\n", error );
+		goto free_irq;
+	}
+
+	printk( KERN_INFO DRIVER_NAME ": added stmpe2401 with irq %d at i2c %d-%x\n",
+			client->irq, client->adapter->nr, client->addr );
+
+	return 0;
+
+free_irq:
+	free_irq( client->irq, instance );
+	write_u8( client, SYSCON, RESET );
+remove_from_list:
+	list_del( & instance->list );
+free_instance:
+	kfree( instance );
+err_return:
+	return error;
+}
+
+static int __devexit
+stmpe2401_remove( struct i2c_client *client ) {
+	struct stmpe2401 *instance = NULL;
+	struct stmpe2401_platform_data *pdata;
+	struct list_head *pos;
+	void (*cleanup[4])( struct stmpe2401 *instance );
+	int i = 0;
+
+	list_for_each( pos, & instances.list ) {
+		instance = container_of( pos, struct stmpe2401, list );
+		if ( instance->cl == client )
+			break;
+		instance = NULL;
+		i++;
+	}
+	if ( ! instance ) {
+		printk( KERN_DEBUG DRIVER_NAME ": cannot remove i2c_client %p: "
+				"not found in list!\n", client );
+		return -EINVAL;
+	}
+
+	pdata = instance->cl->dev.platform_data;
+
+	cleanup[0] = & cleanup_kpd;
+	cleanup[1] = & cleanup_pwm;
+	cleanup[2] = & cleanup_rot;
+	cleanup[3] = & cleanup_gio;
+/*
+	for( i = 3; i >=0; i-- ) {
+		cleanup[i]( instance );
+	}
+*/
+
+// from lm8323.c
+//	disable_irq_wake(client->irq);
+//	free_irq(client->irq, lm);
+//	cancel_work_sync(&lm->work);
+
+
+	free_irq( instance->cl->irq, instance );
+	write_u8( instance->cl, SYSCON, RESET );
+
+	list_del( & instance->list );
+	kfree( instance );
+
+	printk( KERN_INFO DRIVER_NAME ": removed stmpe2401 from i2c %d-%x\n",
+			client->adapter->nr, client->addr );
+
+	return 0;
+}
+
+/*--------------------------------------------------------------------------*/
+
+static const unsigned short normal_i2c[] =
+{ 0x42, 0x43, 0x44, 0x45, I2C_CLIENT_END };
+
+static const struct i2c_client_address_data stmpe2401_addr_data = {
+	.normal_i2c = normal_i2c,
+};
+
+static const struct i2c_device_id stmpe2401_ids[] = {
+		{ DRIVER_NAME, 0 },
+		{  }
+};
+
+/*--------------------------------------------------------------------------*/
+
+static struct i2c_driver stmpe2401_driver = {
+	.driver = {
+		.name		= DRIVER_NAME,
+		.owner		= THIS_MODULE,
+	},
+	.probe			= stmpe2401_probe,
+	.remove			= stmpe2401_remove,
+	.id_table		= stmpe2401_ids,
+	.address_data 	= & stmpe2401_addr_data,
+};
+
+/*--------------------------------------------------------------------------*/
+
+static int __init stmpe2401_init(void) {
+	return i2c_add_driver( &stmpe2401_driver );
+}
+
+static void __exit stmpe2401_exit(void) {
+	i2c_del_driver( &stmpe2401_driver );
+}
+
+/*--------------------------------------------------------------------------*/
+
+subsys_initcall( stmpe2401_init );
+module_exit( stmpe2401_exit );
+
+/*--------------------------------------------------------------------------*/
+
+MODULE_DEVICE_TABLE( i2c, stmpe2401_ids );
+MODULE_LICENSE( "GPL" );
+MODULE_DESCRIPTION( "stmpe2401 GPIO port expander from ST Micro" );
+MODULE_AUTHOR( "Christopher Friedt, <chrisfriedt@gmail.com>" );
+
+/*
+ * To Do List
+ * ==========
+ *
+ * =======
+ * General
+ * =======
+ * TODO: somehow seperate this into seperate modules, mfd style
+ *
+ * ====
+ * GPIO
+ * ====
+ * TODO: create a gpio_chip for the configured gpio lines
+ *
+ * =============
+ * Rotator Input
+ * =============
+ * TODO: impliment rotator handling, input device, etc
+ *
+ * ==============
+ * PWM Controller
+ * ==============
+ * TODO: Write command / IOCTL interface for PWM controller
+ *
+ * =======================
+ * Power Management Module
+ * =======================
+ * TODO: handle power management
+ *
+ */
diff --git a/include/linux/i2c/stmpe2401.h b/include/linux/i2c/stmpe2401.h
new file mode 100644
index 0000000..e8deec3
--- /dev/null
+++ b/include/linux/i2c/stmpe2401.h
@@ -0,0 +1,500 @@
+#ifndef __LINUX_I2C_STMPE2401_H
+#define __LINUX_I2C_STMPE2401_H
+
+#include <linux/input.h>
+
+/**
+ * struct stmpe2401_platform_data - data to set up stmpe2401 driver
+ * @gpio_base: number of the chip's first GPIO
+ * @setup: optional callback issued once the GPIOs are valid
+ * @teardown: optional callback issued before the GPIOs are invalidated
+ * @context: optional parameter passed to setup() and teardown()
+ *
+ * In addition to the I2C_BOARD_INFO() state appropriate to each chip,
+ * the i2c_board_info used with the stmpe2401 driver must provide its
+ * platform_data (pointer to one of these structures) with at least
+ * the gpio_base value initialized.
+ *
+ * The @setup callback may be used with the kind of board-specific glue
+ * which hands the (now-valid) GPIOs to other drivers, or which puts
+ * devices in their initial states using these GPIOs.
+ */
+
+#define MAX_GPIO 24
+#define MAX_ROWS 12
+#define MAX_COLS  8
+#define MAX_PWM   3
+
+#define KPC_FIFO_LEN 4
+
+#define BASE			0x00
+
+/* Identification Registers */
+#define CHIP_ID			(BASE + 0x80)
+#define VERSION_ID		(BASE + 0x81)
+/* IDR Read Values */
+#define RESET_VAL_CHIP_ID 		0x01
+#define RESET_VAL_VERSION_ID 	0x01
+
+/* System Control Register */
+#define SYSCON			(BASE + 0x02)
+/* SCR Write Values */
+#define ROT_CLK_EN		( 1 << 0 )
+#define KPC_CLK_EN		( 1 << 1 )
+#define PWM_CLK_EN		( 1 << 2 )
+#define GPIO_CLK_EN		( 1 << 3 )
+#define SLEEP			( 1 << 4 )
+#define DISABLE_32KHZ	( 1 << 5 )
+#define RESET			( 1 << 7 )
+#define SYSCON_SET(x)	( 1 << x )
+#define RESET_VAL_SYSCON		0x0f
+
+/* Interrupt Control Register */
+#define ICR_msb			(BASE + 0x10)
+#define ICR_lsb			(BASE + 0x11)
+/* ICR Write Values
+ * Note: edge-type output interrupts produce only a microscopic pulse
+ * It is suggested to use level-type output interrupts */
+#define GLOBAL_INT_EN	( 1 << 0 )
+#define EDGE_INT_OUT	( 1 << 1 )	// output edge interrupt signals
+#define LEVEL_INT_OUT	( 0 << 1 )	// output level interrupts signals
+#define RISING_EDGE_OUT	( 1 << 2 )	// output falling edge interrupt
+#define FALLING_EDGE_OUT (0 << 2 )	// output rising edge interrupt
+#define HIGH_LEVEL_OUT	( 1 << 2 )	// active-high level interrupt
+#define LOW_LEVEL_OUT	( 0 << 2 )	// active-low level interrupt
+#define ICR_SET(x)		( 1 << x )
+#define RESET_VAL_ICR_msb		0x00
+#define RESET_VAL_ICR_lsb		0x00
+
+/* Interrupt Enable Register */
+#define IER_msb			(BASE + 0x12)
+#define IER_lsb			(BASE + 0x13)
+/* ICR Write Values */
+#define WAKEUP_EN		( 1 << 0 )
+#define KPC_INT_EN		( 1 << 1 )
+#define KPC_FIFO_INT_EN	( 1 << 2 )	// enable fifo overflow interrupt
+#define ROT_INT_EN		( 1 << 3 )
+#define ROT_BUF_INT_EN	( 1 << 4 )	// enable buffer overflow interrupt
+#define PWM_CH0_INT_EN	( 1 << 5 )
+#define PWM_CH1_INT_EN	( 1 << 6 )
+#define PWM_CH2_INT_EN	( 1 << 7 )
+#define PWM_CH_INT_EN(x) (x << 5 )
+#define GPIO_INT_EN		( 1 << 8 )
+#define IER_SET(x)		( 1 << x )
+#define IER_CLEAR(x,y)	( x & ~(1 << y))
+#define RESET_VAL_IER_msb		0x00
+#define RESET_VAL_IER_lsb		0x00
+
+/* Interrupt Status Register */
+#define ISR_msb			(BASE + 0x14)
+#define ISR_lsb			(BASE + 0x15)
+/* ICR Write Values */
+#define WAKEUP_ST		( 1 << 0 )
+#define KPC_INT_ST		( 1 << 1 )
+#define KPC_FIFO_INT_ST	( 1 << 2 )
+#define ROT_INT_ST		( 1 << 3 )
+#define ROT_BUF_INT_ST	( 1 << 4 )
+#define PWM_CH0_INT_ST	( 1 << 5 )
+#define PWM_CH1_INT_ST	( 1 << 6 )
+#define PWM_CH2_INT_ST	( 1 << 7 )
+#define PWM_CH_INT_ST(x) (x << 5 )
+#define GPIO_INT_ST		( 1 << 0 )
+#define ISR_SET(x)		( 1 << x )
+#define ISR_CLEAR(x,y)	( ~x & (1 << y))
+#define RESET_VAL_ISR_msb		0x00
+#define RESET_VAL_ISR_lsb		0x00
+
+/* IER / ISR Read Values */
+#define WAKEUP			0
+#define KPC_INT			1
+#define KPC_FIFO_INT	2
+#define ROT_INT			3
+#define ROT_BUF_INT		4
+#define PWM_CH(x)		(5+x)		// valid for x values of 0-2
+#define GPIO_INT		8
+#define IER_GET(x,y)	((x >> y) & 0x1)
+#define ISR_GET(x,y)	IER_GET(x,y)
+
+/* Interrupt Enable GPIO Mask Register */
+#define IEGPIOR_msb		(BASE + 0x16)
+#define IEGPIOR_csb		(BASE + 0x17)
+#define IEGPIOR_lsb		(BASE + 0x18)
+#define RESET_VAL_IEGPIOR_msb	0x00
+#define RESET_VAL_IEGPIOR_csb	0x00
+#define RESET_VAL_IEGPIOR_lsb	0x00
+
+/* Interrupt Status GPIO Register */
+#define ISGPIOR_msb		(BASE + 0x19)
+#define ISGPIOR_csb		(BASE + 0x1A)
+#define ISGPIOR_lsb		(BASE + 0x1B)
+#define RESET_VAL_ISGPIOR_msb	0x00
+#define RESET_VAL_ISGPIOR_csb	0x00
+#define RESET_VAL_ISGPIOR_lsb	0x00
+
+/* GPIO Monitor Pin State Register */
+#define GPMR_msb		(BASE + 0xA2)
+#define GPMR_csb		(BASE + 0xA3)
+#define GPMR_lsb		(BASE + 0xA4)
+#define RESET_VAL_GPMR_msb	0x00
+#define RESET_VAL_GPMR_csb	0x00
+#define RESET_VAL_GPMR_lsb	0x00
+
+/* GPIO Set Pin State Register */
+#define GPSR_msb		(BASE + 0x83)
+#define GPSR_csb		(BASE + 0x84)
+#define GPSR_lsb		(BASE + 0x85)
+#define RESET_VAL_GPSR_msb	0x00
+#define RESET_VAL_GPSR_csb	0x00
+#define RESET_VAL_GPSR_lsb	0x00
+
+/* GPIO Clear Pin State Register */
+#define GPCR_msb		(BASE + 0x86)
+#define GPCR_csb		(BASE + 0x87)
+#define GPCR_lsb		(BASE + 0x88)
+#define RESET_VAL_GPCR_msb	0x00
+#define RESET_VAL_GPCR_csb	0x00
+#define RESET_VAL_GPCR_lsb	0x00
+
+/* GPIO Set Pin Direction Register */
+#define GPDR_msb		(BASE + 0x89)
+#define GPDR_csb		(BASE + 0x8A)
+#define GPDR_lsb		(BASE + 0x8B)
+#define RESET_VAL_GPDR_msb	0x00
+#define RESET_VAL_GPDR_csb	0x00
+#define RESET_VAL_GPDR_lsb	0x00
+
+/* GPIO Edge Detect Pin Status Register */
+#define GPEDR_msb		(BASE + 0x8C)
+#define GPEDR_csb		(BASE + 0x8D)
+#define GPEDR_lsb		(BASE + 0x8E)
+#define RESET_VAL_GPEDR_msb	0x00
+#define RESET_VAL_GPEDR_csb	0x00
+#define RESET_VAL_GPEDR_lsb	0x00
+
+/* GPIO Rising Edge Register */
+#define GPRER_msb		(BASE + 0x8F)
+#define GPRER_csb		(BASE + 0x90)
+#define GPRER_lsb		(BASE + 0x91)
+#define RESET_VAL_GPRER_msb	0x00
+#define RESET_VAL_GPRER_csb	0x00
+#define RESET_VAL_GPRER_lsb	0x00
+
+/* GPIO Falling Edge Register */
+#define GPFER_msb		(BASE + 0x92)
+#define GPFER_csb		(BASE + 0x93)
+#define GPFER_lsb		(BASE + 0x94)
+#define RESET_VAL_GPFER_msb	0x00
+#define RESET_VAL_GPFER_csb	0x00
+#define RESET_VAL_GPFER_lsb	0x00
+
+/* GPIO Pull-Up Register */
+#define GPPUR_msb		(BASE + 0x95)
+#define GPPUR_csb		(BASE + 0x96)
+#define GPPUR_lsb		(BASE + 0x97)
+#define RESET_VAL_GPPUR_msb	0x00
+#define RESET_VAL_GPPUR_csb	0x00
+#define RESET_VAL_GPPUR_lsb	0x00
+
+/* GPIO Pull-Down Register */
+#define GPPDR_msb		(BASE + 0x98)
+#define GPPDR_csb		(BASE + 0x99)
+#define GPPDR_lsb		(BASE + 0x9A)
+#define RESET_VAL_GPPDR_msb	0x00
+#define RESET_VAL_GPPDR_csb	0x00
+#define RESET_VAL_GPPDR_lsb	0x00
+
+/* GPIO Alternate-Function Register (Upper Bit) */
+#define GPAFR_U_msb		(BASE + 0x9B)
+#define GPAFR_U_csb		(BASE + 0x9C)
+#define GPAFR_U_lsb		(BASE + 0x9D)
+/* GPIO Alternate-Function Register (Lower Bit) */
+#define GPAFR_L_msb		(BASE + 0x9E)
+#define GPAFR_L_csb		(BASE + 0x9F)
+#define GPAFR_L_lsb		(BASE + 0xA0)
+/* GPAFR Write Values */
+#define KPD_AFR_PATTERN		((u8)0x01)
+#define PWM_AFR_PATTERN		((u8)0x00)
+#define ROT_AFR_PATTERN		((u8)0x01)
+#define GIO_AFR_PATTERN		((u8)0x00)
+#define RESET_VAL_GPAFR_L_msb	0x00
+#define RESET_VAL_GPAFR_L_csb	0x00
+#define RESET_VAL_GPAFR_L_lsb	0x00
+#define RESET_VAL_GPAFR_U_msb	0x00
+#define RESET_VAL_GPAFR_U_csb	0x00
+#define RESET_VAL_GPAFR_U_lsb	0x00
+
+#define GPIO_TO_BMP(x)		(1 << x)
+#define GPIO_PWM(x)			(21 + x)
+#define GPIO_ADDR0			15
+#define GPIO_ROT(x)			(18 + x)
+#define GPIO_KP_X(x)		x
+#define GPIO_KP_Y(x)		( (x < 7) ? (x+8) : (x+9) )
+
+/* PWM Control and Status Register */
+#define PWMCS			(BASE + 0x30)
+#define PWMIC0			(BASE + 0x38)
+#define PWMIC1			(BASE + 0x39)
+#define PWMIC2			(BASE + 0x3A)
+/* PWMCR Write Values */
+#define PWM_EN_CH(x)		(1 << x)	// channels 0-2
+#define RESET_VAL_PWMCS		0x00
+#define RESET_VAL_PWMIC0	0xee
+#define RESET_VAL_PWMIC1	0xb0
+#define RESET_VAL_PWMIC2	0xa3
+
+/* TODO: add PWM instruction mnemonics */
+
+/* Keypad Column Scan Register */
+#define KPC_col			(BASE + 0x60)
+/* KPC_col Write Values */
+#define COLUMN_ALL			(0xff << 0)
+#define COLUMN(x)			(1 << x)
+#define RESET_VAL_KPC_col	0x00
+/* Keypad Row Scan Registers (MSB) */
+#define KPC_row_msb		(BASE + 0x61)
+/* KPC_row_msb Write Values */
+#define KPC_SCAN_PW			(u8)(0x3 << 6) // this should _always_ be set
to this value
+#define ROW_MSB(x)			(0x1  << x)
+#define ROW_MSB_ALL			(0xf << 0)
+#define RESET_VAL_KPC_row_msb	0xc0
+/* Keypad Row Scan Registers (LSB) */
+#define KPC_row_lsb		(BASE + 0x62)
+#define ROW_LSB(x)			(0x1  << x)
+#define ROW_LSB_ALL			(0xff << 0)
+#define RESET_VAL_KPC_row_lsb	0x00
+
+/* Keypad Controller Register (MSB) */
+#define KPC_ctrl_msb	(BASE + 0x63)
+/* KPC_ctrl_msb Write values */
+#define KPC_SCAN_CYCLES(x)	(u8)(x << 4)	// 0-15 cycles
+#define KPC_DEDICATED(x)	(1 << x)	// up to 4 dedicated keys
+#define RESET_VAL_KPC_ctrl_msb 0x00
+/* Keypad Controller Register (LSB) */
+#define KPC_ctrl_lsb	(BASE + 0x64)
+/* KPC_ctrl_lsb Write values */
+#define KPC_DEBOUNCE_MS(x)	(x << 1)	// 0-128 ms
+#define KPC_SCAN_ENABLE		(1 << 0)
+#define RESET_VAL_KPC_ctrl_lsb 0x00
+
+/* KPC_data Register */
+#define KPC_data_byte0	(BASE + 0x68)
+#define KPC_data_byte1	(BASE + 0x69)
+#define KPC_data_byte2	(BASE + 0x6A)
+#define KPCD			(BASE + 0x68)
+#define KPC_data_byte(x) 	(KPCD + x)		// 0-2 data bytes
+
+#define RESET_VAL_KPC_data_byte0	0xf8
+#define RESET_VAL_KPC_data_byte1	0xf8
+#define RESET_VAL_KPC_data_byte2	0x0f
+
+
+#define RESET_VAL(x) RESET_VAL_##x
+
+/*--------------------------------------------------------------------------*/
+
+/*
+ * The stmpe2401 uses alternate functions for its 24 GPIO lines for 3 PWM
+ * output channels, the rotator input, and the (max 12 row x 8 col) keypad
+ * controller. Although it is still possible to have all of the components
+ * running and generating interrupts simultaneously, they obviously
+ * cannot the same GPIO lines.
+ *
+ * The stmpe2401 code uses bitmaps to encode alternate functionality for
+ * each of the GPIO lines. The LSB represents GPIO line 0, while bit 23
+ * represents GPIO line 23 on (little endian machines). Therefore,
+ * to specify an 4-row by 3-column keypad, one would use
+ *
+ * u32 bmp = row_to_gio(0xf) | col_to_gio(0x7);
+ *
+ * To retreive the row and column maps for a given GPIO bitmap, bmp, use
+ *
+ * u16 row = gio_to_row( bmp );
+ * u8  col = gio_to_col( bmp );
+ *
+ * The PWM and rotator bitmaps work accordingly.
+ */
+
+#define BMP_MASK_KPD 0x1f7fff
+#define BMP_MASK_PWM 0xe00000
+#define BMP_MASK_ROT 0x1c0000
+#define BMP_MASK_GIO 0xffffff
+
+#define row_to_gio_bmp(r) ((u32)((r & 0x7f)<<8)|((r & 0xf80)<<9))
+#define col_to_gio_bmp(c) ((u32)(c & 0xff))
+#define gio_to_row_bmp(g) ((u16)(((g>>9) & 0xf80)|((g>>8) & 0x7f)))
+#define gio_to_col_bmp(g) ((u8)(g & 0xff))
+#define pwm_to_gio_bmp(p) ((u32)((p & 0x7)<<21))
+#define gio_to_pwm_bmp(g) ((u8)((g>>21) & 0x7))
+#define rot_to_gio_bmp(r) ((u32)((r & 0x7)<<18))
+#define gio_to_rot_bmp(g) ((u8)((g>>18) & 0x7))
+
+/*--------------------------------------------------------------------------*/
+#define STMPE2401_KEYMAP_SCANCODESIZE 2
+
+/*
+ * See input.h
+ */
+struct stmpe2401_keymap {
+	unsigned int keycodemax;
+	unsigned int *keycode;
+};
+/*
+ * See input.h
+ */
+struct stmpe2401_keymap_callback {
+	void (*custom)(struct input_dev *dev, int scancode );
+	int (*setkeycode)(struct input_dev *dev, int scancode, int keycode);
+};
+/*
+ * @bmp        - a bitmap of GPIO to use for row outputs or column inputs
+ * @debounce   - the debounce time, in milliseconds, for each key-press
+ * @callback   - see the above definition
+ * @keymap     - see the above definition
+ *
+ * If @callback->custom is not defined, then @keymap->keycode is expected to
+ * be a dense array, with ordered entries from 0 up to @keymap->keycodemax.
+ * The entries in @keymap->keycode are all of the scancodes, extended to
+ * 32 bits. the dense matrix must have a 1-to-1 correspondence with the
+ * integer keycodes defined in input.h. The integer keycodes in input.h can
+ * be considered as the index of scancodes in @keymap->keycode The
+ * @callback->setkeycode method can optionally be defined for a customized
+ * key-remapping function, which is particularly useful if certain keys
+ * cannot be remapped.
+ *
+ * If @callback->custom is defined, then @callback->setkeycode must also
+ * be defined. Then @keymap->keycode is expected to be a sparse array, with
+ * exactly @keymap->keycodemax entries. In contrast to the @keymap method, the
+ * entries in the sparse array do not contain scancodes, but contain all of
+ * the possible keycodes used, out of those defined in input.h. The
+ * @callback->custom method is particularly useful when key-presses trigger
+ * more than one input event.
+ *
+ * Scancodes for the STMPE2401 keypad will always be 16 bits in length.
+ * The MSB represents dedicated keys (maskable by 0xf) and the LSB represents
+ * row (0x78) / column (0x7) data. The high bit (0x80) in each byte indicates
+ * if the key is up or down. Either the low byte or the high byte will be set
+ * in the @scancode parameter, but not both. Furthermore, only one dedicated
+ * key will be reported at once.
+ *
+ * The platform-specific @callback->custom function is expected to
+ * maintain its own state information. Therefore, if more than one stmpe2401
+ * device exists on the same host (unlikely), ensure that separate entry
+ * points for @callback->custom exist in order to distinguish context
+ * information.
+ *
+ */
+struct stmpe2401_kpd_data {
+	u32 bmp, ded_keys, start_irq, end_irq;
+	u8 debounce;
+	struct stmpe2401_keymap_callback callback;
+	struct stmpe2401_keymap keymap;
+};
+
+/*--------------------------------------------------------------------------*/
+
+struct stmpe2401_pwm_data {
+	u32 bmp, start_irq, end_irq;
+};
+
+/*--------------------------------------------------------------------------*/
+
+struct stmpe2401_rot_data {
+	u32 bmp, start_irq, end_irq;
+};
+
+/*--------------------------------------------------------------------------*/
+
+struct stmpe2401_gio_data {
+	u32 bmp, start_irq, end_irq;
+};
+
+/*--------------------------------------------------------------------------*/
+
+struct stmpe2401_platform_data {
+	int							nc;
+	struct stmpe2401_kpd_data	*kpd;
+	struct stmpe2401_gio_data	*gio;
+	struct stmpe2401_pwm_data	*pwm;
+	struct stmpe2401_rot_data	*rot;
+	int							(*getpower)(void);
+	void 						(*setpower)( int on );
+	void 						(*reset)( void );
+};
+
+
+/*--------------------------------------------------------------------------*/
+
+// delete this stuff once the
+
+struct name_reg_map {
+	char * name;
+	u8     reg;
+};
+
+
+#define NAME_REG_FORMAT(x,y) { .name = x, .reg = y }
+
+static const struct name_reg_map regmap[] = {
+		NAME_REG_FORMAT("CHIP_ID", 0x80),
+		NAME_REG_FORMAT("VERSION_ID", 0x81),
+		NAME_REG_FORMAT("SYSCON", 0x02),
+		NAME_REG_FORMAT("ICR_msb", 0x10),
+		NAME_REG_FORMAT("ICR_lsb", 0x11),
+		NAME_REG_FORMAT("IER_msb", 0x12),
+		NAME_REG_FORMAT("IER_lsb", 0x13),
+		NAME_REG_FORMAT("ISR_msb", 0x14),
+		NAME_REG_FORMAT("ISR_lsb", 0x15),
+		NAME_REG_FORMAT("IEGPIOR_msb", 0x16),
+		NAME_REG_FORMAT("IEGPIOR_csb", 0x17),
+		NAME_REG_FORMAT("IEGPIOR_lsb", 0x18),
+		NAME_REG_FORMAT("ISGPIOR_msb", 0x19),
+		NAME_REG_FORMAT("ISGPIOR_csb", 0x1A),
+		NAME_REG_FORMAT("ISGPIOR_lsb", 0x1B),
+		NAME_REG_FORMAT("GPMR_msb", 0xA2),
+		NAME_REG_FORMAT("GPMR_csb", 0xA3),
+		NAME_REG_FORMAT("GPMR_lsb", 0xA4),
+		NAME_REG_FORMAT("GPSR_msb", 0x83),
+		NAME_REG_FORMAT("GPSR_csb", 0x84),
+		NAME_REG_FORMAT("GPSR_lsb", 0x85),
+		NAME_REG_FORMAT("GPCR_msb", 0x86),
+		NAME_REG_FORMAT("GPCR_csb", 0x87),
+		NAME_REG_FORMAT("GPCR_lsb", 0x88),
+		NAME_REG_FORMAT("GPDR_msb", 0x89),
+		NAME_REG_FORMAT("GPDR_csb", 0x8A),
+		NAME_REG_FORMAT("GPDR_lsb", 0x8B),
+		NAME_REG_FORMAT("GPEDR_msb", 0x8C),
+		NAME_REG_FORMAT("GPEDR_csb", 0x8D),
+		NAME_REG_FORMAT("GPEDR_lsb", 0x8E),
+		NAME_REG_FORMAT("GPRER_msb", 0x8F),
+		NAME_REG_FORMAT("GPRER_csb", 0x90),
+		NAME_REG_FORMAT("GPRER_lsb", 0x91),
+		NAME_REG_FORMAT("GPFER_msb", 0x92),
+		NAME_REG_FORMAT("GPFER_csb", 0x93),
+		NAME_REG_FORMAT("GPFER_lsb", 0x94),
+		NAME_REG_FORMAT("GPPUR_msb", 0x95),
+		NAME_REG_FORMAT("GPPUR_csb", 0x96),
+		NAME_REG_FORMAT("GPPUR_lsb", 0x97),
+		NAME_REG_FORMAT("GPPDR_msb", 0x98),
+		NAME_REG_FORMAT("GPPDR_csb", 0x99),
+		NAME_REG_FORMAT("GPPDR_lsb", 0x9A),
+		NAME_REG_FORMAT("GPAFR_U_msb", 0x9B),
+		NAME_REG_FORMAT("GPAFR_U_csb", 0x9C),
+		NAME_REG_FORMAT("GPAFR_U_lsb", 0x9D),
+		NAME_REG_FORMAT("GPAFR_L_msb", 0x9E),
+		NAME_REG_FORMAT("GPAFR_L_csb", 0x9F),
+		NAME_REG_FORMAT("GPAFR_L_lsb", 0xA0),
+		NAME_REG_FORMAT("PWMCS", 0x30),
+		NAME_REG_FORMAT("PWMIC0", 0x38),
+		NAME_REG_FORMAT("PWMIC1", 0x39),
+		NAME_REG_FORMAT("PWMIC2", 0x3A),
+		NAME_REG_FORMAT("KPC_col", 0x60),
+		NAME_REG_FORMAT("KPC_row_msb", 0x61),
+		NAME_REG_FORMAT("KPC_row_lsb", 0x62),
+		NAME_REG_FORMAT("KPC_ctrl_msb", 0x63),
+		NAME_REG_FORMAT("KPC_ctrl_lsb", 0x64),
+		NAME_REG_FORMAT("KPC_data_byte0", 0x68),
+		NAME_REG_FORMAT("KPC_data_byte1", 0x69),
+		NAME_REG_FORMAT("KPC_data_byte2", 0x6A),
+};
+#define SZ_STMPE2401_REGMAP 60
+#endif /* __LINUX_I2C_STMPE2401_H */
