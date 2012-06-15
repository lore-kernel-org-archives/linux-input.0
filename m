From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] Input: tsl2771: ambient light and proximity driver
Date: Fri, 15 Jun 2012 20:36:10 +0530
Message-ID: <CAKdam55TyeY6bshsgZDVnK5kjpyMi-YLSoTJ-8eZzwVHyAEwZA@mail.gmail.com>
References: <1338892302-2477-1-git-send-email-sourav.poddar@ti.com>
	<CADTbHxo3f6ugYr3Wi5N5_WbRRXn_FMUmegn3HBQz_wS7mNfp6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADTbHxo3f6ugYr3Wi5N5_WbRRXn_FMUmegn3HBQz_wS7mNfp6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Jangra <jangra.pankaj9@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, dtor@mail.ru, DMurphy@ti.com, linux-kernel@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Randy Dunlap <rdunlap@xenotime.net>, Samuel Ortiz <sameo@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Alan Cox <alan@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Anirudh Ghayal <aghayal@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Hi Pankaj,


On Fri, Jun 8, 2012 at 11:08 AM, Pankaj Jangra <jangra.pankaj9@gmail.co=
m> wrote:
> Hi Sourav,
>
> Had a quick look of patch. Few comments......
>
> On Tue, Jun 5, 2012 at 4:01 PM, Sourav Poddar <sourav.poddar@ti.com> =
wrote:
>>
>> From: Dan Murphy <DMurphy@ti.com>
>>
>> Add tsl2771 ambient light and proximity driver.
>>
>> Tested on 3.4-rc6 custom kernel having omap5
>> evm device tree support.
>>
>> Will post the device tree data once the dts files for omap5
>> will be available in mainline.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Randy Dunlap <rdunlap@xenotime.net>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>
>> Cc: Anirudh Ghayal <aghayal@codeaurora.org>
>> Signed-off-by: Dan Murphy <DMurphy@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> [Sourav Poddar: - Adapted to device tree]
>> ---
>> =A0.../devicetree/bindings/input/tsl2771.txt =A0 =A0 =A0 =A0 =A0| =A0=
 86 ++
>> =A0drivers/input/misc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 10 +
>> =A0drivers/input/misc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A01 +
>> =A0drivers/input/misc/tsl2771.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0973
>> ++++++++++++++++++++
>> =A0include/linux/i2c/tsl2771.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 71 ++
>> =A05 files changed, 1141 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/input/tsl277=
1.txt
>> =A0create mode 100644 drivers/input/misc/tsl2771.c
>> =A0create mode 100644 include/linux/i2c/tsl2771.h
>>
>> diff --git a/Documentation/devicetree/bindings/input/tsl2771.txt
>> b/Documentation/devicetree/bindings/input/tsl2771.txt
>> new file mode 100644
>> index 0000000..f298475
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/tsl2771.txt
>> @@ -0,0 +1,86 @@
>> +* TAOS's ambient light and proximity Controller device tree binding=
s
>> +
>> +The TSL2771 family of devices, an i2c based device, provides both a=
mbient
>> +light sensing (ALS) and proximity detection (when coupled with an
>> external IR LED).
>> +The ALS approximates human eye response to light intensity under a
>> variety
>> +of lighting conditions and through a variety of attenuation materia=
ls.
>> +The proximity detection feature allows a large dynamic range of ope=
ration
>> +for use in short distance detection behind dark glass such as in a =
cell
>> phone.
>> +
>> +Required SoC Specific Properties:
>> +- compatible: should be one of the following
>> +- "tsl2771,alps": For controllers compatible with
>> + =A0 =A0 =A0 taos tsl2771 controller.
>> +
>> +Required Board Specific Properties:
>> +- tsl2771,gpio : gpio used to signal an interrupt
>> +- tsl2771,irq_flags : Flags used to configure the irq type
>> + =A0 =A0 =A0 (Edge triggered/Level Triggerred)
>> +- tsl2771,def_enable : Used to power the device on/off, enable
>> + =A0 =A0 =A0 functions and interrupts.
>> +- tsl2771,als_adc_time : Ambient light internal integration time of=
 the
>> + =A0 =A0 =A0 ALS clear and IR channel ADCs.
>> +- tsl2771,prox_adc_time : Controls the integration time of the prox=
imity
>> + =A0 =A0 =A0 ADC
>> +- tsl2771,wait_time : Wait time required between state transition.
>> +- tsl2771,als_low_thresh_low_byte :
>> +- tsl2771,als_low_thresh_high_byte :
>> + =A0 =A0 =A0 Value to be used as a low trigger points for the compa=
rison
>> function
>> + =A0 =A0 =A0 for interrupt generation for ambient light sensor.
>> +- tsl2771,als_high_thresh_low_byte :
>> +- tsl2771,als_high_thresh_high_byte :
>> + =A0 =A0 =A0 Value to be used as a high trigger points for the comp=
arison
>> function
>> + =A0 =A0 =A0 for interrupt generation for ambient light sensor.
>> +- tsl2771,prox_low_thresh_low_byte :
>> +- tsl2771,prox_low_thresh_high_byte :
>> + =A0 =A0 =A0 Value to be used as a low trigger points for the compa=
rison
>> function
>> + =A0 =A0 =A0 for interrupt generation for proximity sensor.
>> +- tsl2771,prox_high_thresh_low_byte :
>> +- tsl2771,prox_high_thresh_high_byte :
>> + =A0 =A0 =A0 Value to be used as a high trigger points for the comp=
arison
>> function
>> + =A0 =A0 =A0 for interrupt generationi for proximity sensor.
>> +
>> +- tsl2771,interrupt_persistence : Controls the filtering interrupt
>> capabilities
>> + =A0 =A0 =A0 of the device.
>> +- tsl2771,config : Sets the wait long time
>> +- tsl2771,prox_pulse_count : Sets the number of proximity pulses th=
at
>> will be transmitted.
>> +- tsl2771,gain_control : Control functions such as gain settings an=
d
>> diode selection.
>> +- tsl2771,glass_attn :
>> +- tsl2771,device_factor :
>> + =A0 =A0 =A0 Properties depending on which the calculation of
>> + =A0 =A0 =A0 "counts per linux(cpl)" depends.
>> +- tsl2771,prox_enable_flag : signifies that proximity sensor is to =
be
>> enabled
>> +- tsl2771,als_enable_flag : Signifies that ambient light sensor is =
to be
>> enabled.
>> +
>> +Example:
>> +
>> +&i2c2 {
>> + =A0 =A0 =A0 clock-frequency =3D <400000>;
>> +
>> + =A0 =A0 =A0 tsl2771@39 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "tsl2771,alps";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x39>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,gpio =3D <149>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,irq_flags =3D <0x0000200a>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,def_enable =3D <0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,als_adc_time =3D <0xdb>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_adc_time =3D <0xff>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,wait_time =3D <0x00>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,als_low_thresh_low_byte =3D <0=
x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,als_low_thresh_high_byte =3D <=
0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,als_high_thresh_low_byte =3D <=
0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,als_high_thresh_high_byte =3D =
<0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_low_thresh_low_byte =3D <=
0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_low_thresh_high_byte =3D =
<0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_high_thresh_low_byte =3D =
<0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_high_thresh_high_byte =3D=
 <0x0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,interrupt_persistence =3D <0xf=
6>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,config =3D <0x00>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_pulse_count =3D <0x03>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,gain_control =3D <0xe0>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,glass_attn =3D <0x01>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,device_factor =3D <0x34>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,prox_enable_flag;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771,als_enable_flag;
>> + =A0 =A0 =A0 };
>> +};
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 7faf4a7..cc85b22 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -177,6 +177,16 @@ config INPUT_MPU3050
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here=
: the
>> =A0 =A0 =A0 =A0 =A0module will be called mpu3050.
>>
>> +config INPUT_TSL2771
>> + =A0 =A0 =A0 tristate "TSL2771 ALS/Proximity Sensor Driver"
>> + =A0 =A0 =A0 depends on I2C && SYSFS
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Say Y here if you want to use TSL2771 ALS/Proximit=
y Sensor
>> Driver
>> + =A0 =A0 =A0 =A0 through I2C interface.
>> +
>> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here:=
 the
>> + =A0 =A0 =A0 =A0 module will be called tsl2771.
>> +
>> =A0config INPUT_APANEL
>> =A0 =A0 =A0 =A0tristate "Fujitsu Lifebook Application Panel buttons"
>> =A0 =A0 =A0 =A0depends on X86 && I2C && LEDS_CLASS
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefi=
le
>> index f55cdf4..2f72aaf 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_INPUT_MAX8997_HAPTIC) =A0 =A0+=3D
>> max8997_haptic.o
>> =A0obj-$(CONFIG_INPUT_MC13783_PWRBUTTON) =A0+=3D mc13783-pwrbutton.o
>> =A0obj-$(CONFIG_INPUT_MMA8450) =A0 =A0 =A0 =A0 =A0 =A0+=3D mma8450.o
>> =A0obj-$(CONFIG_INPUT_MPU3050) =A0 =A0 =A0 =A0 =A0 =A0+=3D mpu3050.o
>> +obj-$(CONFIG_INPUT_TSL2771) =A0 =A0 =A0 =A0 =A0 =A0 +=3D tsl2771.o
>> =A0obj-$(CONFIG_INPUT_PCAP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pcap_ke=
ys.o
>> =A0obj-$(CONFIG_INPUT_PCF50633_PMU) =A0 =A0 =A0 +=3D pcf50633-input.=
o
>> =A0obj-$(CONFIG_INPUT_PCF8574) =A0 =A0 =A0 =A0 =A0 =A0+=3D pcf8574_k=
eypad.o
>> diff --git a/drivers/input/misc/tsl2771.c b/drivers/input/misc/tsl27=
71.c
>> new file mode 100644
>> index 0000000..ec96493
>> --- /dev/null
>> +++ b/drivers/input/misc/tsl2771.c
>> @@ -0,0 +1,973 @@
>> +/**
>> + * tsl2771.c - ALS and Proximity sensor driver
>> + *
>> + * Copyright (C) 2011 Texas Instruments
>> + * Author: Dan Murphy <DMurphy@ti.com>
>> + *
>> + * This file is subject to the terms and conditions of the GNU Gene=
ral
>> + * Public License. See the file "COPYING" in the main directory of =
this
>> + * archive for more details.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A00211=
1-1307
>> =A0USA
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/input.h>
>> +#include <linux/pm.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/i2c.h>
>> +#include <linux/i2c/tsl2771.h>
>> +#include <linux/gpio.h>
>> +
>> +#define TSL2771_DEBUG 1
>> +
>> +#define TSL2771_ALLOWED_R_BYTES =A0 =A0 =A0 =A025
>> +#define TSL2771_ALLOWED_W_BYTES =A0 =A0 =A0 =A02
>> +#define TSL2771_MAX_RW_RETRIES 5
>> +#define TSL2771_I2C_RETRY_DELAY 10
>> +
>> +#define TSL2771_I2C_WRITE =A0 =A0 =A00x80
>> +#define TSL2771_I2C_READ =A0 =A0 =A0 0xa0
>> +
>> +#define TSL2771_PROX_INT_CLR =A0 0x65
>> +#define TSL2771_ALS_INT_CLR =A0 =A00x66
>> +#define TSL2771_ALL_INT_CLR =A0 =A00x67
>> +
>> +/* TSL2771 Read only registers */
>> +#define TSL2771_REV =A0 =A00x11
>> +#define TSL2771_ID =A0 =A0 0x12
>> +#define TSL2771_STATUS 0x13
>> +#define TSL2771_CDATAL 0x14
>> +#define TSL2771_CDATAH 0x15
>> +#define TSL2771_IRDATAL =A0 =A0 =A0 =A00x16
>> +#define TSL2771_IRDATAH =A0 =A0 =A0 =A00x17
>> +#define TSL2771_PDATAL 0x18
>> +#define TSL2771_PDATAH 0x19
>> +
>> +/* Enable register mask */
>> +#define TSL2771_PWR_ON =A0 =A0 =A0 =A0 (1 << 0)
>> +#define TSL2771_ADC_EN =A0 =A0 =A0 =A0 (1 << 1)
>> +#define TSL2771_PROX_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
>> +#define TSL2771_WAIT_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 3)
>> +#define TSL2771_ALS_INT_EN =A0 =A0 (1 << 4)
>> +#define TSL2771_PROX_INT_EN =A0 =A0(1 << 5)
>> +
>> +#define TSL2771_ALS_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
>> +#define TSL2771_PROX_INT =A0 =A0 =A0 (1 << 5)
>> +
>> +#define TSL2771_ALS_EN_FLAG =A0 =A00x01
>> +#define TSL2771_PROX_EN_FLAG =A0 0x02
>> +
>> +struct tsl2771_data {
>> + =A0 =A0 =A0 struct i2c_client *client;
>> + =A0 =A0 =A0 struct input_dev *prox_input_dev;
>> + =A0 =A0 =A0 struct input_dev *als_input_dev;
>> + =A0 =A0 =A0 struct mutex enable_mutex;
>> +
>> + =A0 =A0 =A0 int lux;
>> + =A0 =A0 =A0 int prox_distance;
>> + =A0 =A0 =A0 int power_state;
>> + =A0 =A0 =A0 int power_context;
>> + =A0 =A0 =A0 int als_gain;
>> + =A0 =A0 =A0 int glass_attn;
>> + =A0 =A0 =A0 int device_factor;
>> + =A0 =A0 =A0 int irq_flags;
>> + =A0 =A0 =A0 int flags;
>> + =A0 =A0 =A0 int gpio;
>> +
>> + =A0 =A0 =A0 uint32_t def_enable;
>> + =A0 =A0 =A0 uint32_t als_adc_time;
>> + =A0 =A0 =A0 uint32_t prox_adc_time;
>> + =A0 =A0 =A0 uint32_t wait_time;
>> + =A0 =A0 =A0 uint32_t als_ltlb;
>> + =A0 =A0 =A0 uint32_t als_lthb;
>> + =A0 =A0 =A0 uint32_t als_htlb;
>> + =A0 =A0 =A0 uint32_t als_hthb;
>> + =A0 =A0 =A0 uint32_t prox_ltlb;
>> + =A0 =A0 =A0 uint32_t prox_lthb;
>> + =A0 =A0 =A0 uint32_t prox_htlb;
>> + =A0 =A0 =A0 uint32_t prox_hthb;
>> + =A0 =A0 =A0 uint32_t interrupt_persistence;
>> + =A0 =A0 =A0 uint32_t config;
>> + =A0 =A0 =A0 uint32_t prox_pulse_count;
>> + =A0 =A0 =A0 uint32_t gain_control;
>> +};
>> +
>> +static int als_gain_table[4] =3D {
>> + =A0 =A0 =A0 1, 8, 16, 120
>> +};
>> +
>> +static uint32_t als_prox_debug;
>> +module_param_named(tsl2771_debug, als_prox_debug, uint, 0664);
>> +
>> +#ifdef TSL2771_DEBUG
>> +struct tsl2771_reg {
>> + =A0 =A0 =A0 const char *name;
>> + =A0 =A0 =A0 uint8_t reg;
>> + =A0 =A0 =A0 int writeable;
>> +} tsl2771_regs[] =3D {
>> + =A0 =A0 =A0 { "REV", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TSL2771_REV, 0=
 },
>> + =A0 =A0 =A0 { "CHIP_ID", =A0 =A0 =A0 =A0 =A0 =A0TSL2771_ID, 0 },
>> + =A0 =A0 =A0 { "STATUS", =A0 =A0 =A0 =A0 =A0 =A0 TSL2771_STATUS, 0 =
},
>> + =A0 =A0 =A0 { "ADC_LOW", =A0 =A0 =A0 =A0 =A0 =A0TSL2771_CDATAL, 0 =
},
>> + =A0 =A0 =A0 { "ADC_HI", =A0 =A0 =A0 =A0 =A0 =A0 TSL2771_CDATAH, 0 =
},
>> + =A0 =A0 =A0 { "IR_LOW_DATA", =A0 =A0 =A0 =A0TSL2771_IRDATAL, 0 },
>> + =A0 =A0 =A0 { "IR_HI_DATA", =A0 =A0 =A0 =A0 TSL2771_IRDATAH, 0 },
>> + =A0 =A0 =A0 { "P_LOW_DATA", =A0 =A0 =A0 =A0 TSL2771_PDATAL, 0 },
>> + =A0 =A0 =A0 { "P_HI_DATA", =A0 =A0 =A0 =A0 =A0TSL2771_PDATAH, 0 },
>> + =A0 =A0 =A0 { "ENABLE", =A0 =A0 =A0 =A0 =A0 =A0 TSL2771_ENABLE, 1 =
},
>> + =A0 =A0 =A0 { "A_ADC_TIME", =A0 =A0 =A0 =A0 TSL2771_ATIME, 1 },
>> + =A0 =A0 =A0 { "P_ADC_TIME", =A0 =A0 =A0 =A0 TSL2771_PTIME, 1 },
>> + =A0 =A0 =A0 { "WAIT_TIME", =A0 =A0 =A0 =A0 =A0TSL2771_WTIME, 1 },
>> + =A0 =A0 =A0 { "A_LOW_TH_LOW", =A0 =A0 =A0 TSL2771_AILTL, 1 },
>> + =A0 =A0 =A0 { "A_LOW_TH_HI", =A0 =A0 =A0 =A0TSL2771_AILTH, 1 },
>> + =A0 =A0 =A0 { "A_HI_TH_LOW", =A0 =A0 =A0 =A0TSL2771_AIHTL, 1 },
>> + =A0 =A0 =A0 { "A_HI_TH_HI", =A0 =A0 =A0 =A0 TSL2771_AIHTH, 1 },
>> + =A0 =A0 =A0 { "P_LOW_TH_LOW", =A0 =A0 =A0 TSL2771_PILTL, 1 },
>> + =A0 =A0 =A0 { "P_LOW_TH_HI", =A0 =A0 =A0 =A0TSL2771_PILTH, 1 },
>> + =A0 =A0 =A0 { "P_HI_TH_LOW", =A0 =A0 =A0 =A0TSL2771_PIHTL, 1 },
>> + =A0 =A0 =A0 { "P_HI_TH_HI", TSL2771_PIHTH, 1 },
>> + =A0 =A0 =A0 { "INT_PERSIT", =A0 =A0 =A0 =A0 TSL2771_PERS, 1 },
>> + =A0 =A0 =A0 { "PROX_PULSE_CNT", =A0 =A0 TSL2771_PPCOUNT, 1 },
>> + =A0 =A0 =A0 { "CONTROL", =A0 =A0 =A0 =A0 =A0 =A0TSL2771_CONTROL, 1=
 },
>> +};
>> +#endif
>> +
>> +static int tsl2771_write_reg(struct tsl2771_data *data, u8 reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u8 val, int len)
>> +{
>> + =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 int tries =3D 0;
>> + =A0 =A0 =A0 u8 buf[TSL2771_ALLOWED_W_BYTES];
>> +
>> + =A0 =A0 =A0 struct i2c_msg msgs[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.addr =3D data->client->addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D data->client->flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.len =3D len + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 buf[0] =3D (TSL2771_I2C_WRITE | reg);
>> + =A0 =A0 =A0 buf[1] =3D val;
>> +
>> + =A0 =A0 =A0 msgs->buf =3D buf;
>> +
>> + =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_transfer(data->client->ada=
pter, msgs, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err !=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep_interruptible(T=
SL2771_I2C_RETRY_DELAY);
>> + =A0 =A0 =A0 } while ((err !=3D 1) && (++tries < TSL2771_MAX_RW_RET=
RIES));
>> +
>> + =A0 =A0 =A0 if (err !=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev, "write tra=
nsfer error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> +static int tsl2771_read_reg(struct tsl2771_data *data, u8 reg, u8 *=
buf,
>> int len)
>> +{
>> + =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 int tries =3D 0;
>> + =A0 =A0 =A0 u8 reg_buf[TSL2771_ALLOWED_R_BYTES];
>> +
>> + =A0 =A0 =A0 struct i2c_msg msgs[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.addr =3D data->client->addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D data->client->flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.len =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.addr =3D data->client->addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D (data->client->flags | I=
2C_M_RD),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.len =3D len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.buf =3D buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 };
>> + =A0 =A0 =A0 reg_buf[0] =3D (TSL2771_I2C_READ | reg);
>> + =A0 =A0 =A0 msgs->buf =3D reg_buf;
>> +
>> + =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_transfer(data->client->ada=
pter, msgs, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err !=3D 2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep_interruptible(T=
SL2771_I2C_RETRY_DELAY);
>> + =A0 =A0 =A0 } while ((err !=3D 2) && (++tries < TSL2771_MAX_RW_RET=
RIES));
>> +
>> + =A0 =A0 =A0 if (err !=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev, "read tran=
sfer error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> +static int tsl2771_init_device(struct tsl2771_data *data)
>> +{
>> + =A0 =A0 =A0 int error =3D 0;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_CONFIG, data=
->config, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_ENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->def_enable, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_ATIME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_adc_time, 1)=
;
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PTIME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_adc_time, 1=
);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_WTIME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->wait_time, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_AILTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_ltlb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_AILTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_lthb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_AIHTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_htlb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_AIHTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_hthb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PILTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_ltlb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PILTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_lthb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PIHTL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_htlb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PIHTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_hthb, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PERS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->interrupt_persis=
tence, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_PPCOUNT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_pulse_count=
, 1);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_write_reg(data, TSL2771_CONTROL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->gain_control, 1)=
;
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_error;
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +init_error:
>> + =A0 =A0 =A0 pr_err("%s:Failed initializing the device\n", __func__=
);
>> + =A0 =A0 =A0 return -1;
>> +
>> +}
>> +
>> +static int tsl2771_read_prox(struct tsl2771_data *data)
>> +{
>> + =A0 =A0 =A0 u8 data_buffer[4];
>> + =A0 =A0 =A0 int prox_data =3D 0;
>> + =A0 =A0 =A0 tsl2771_read_reg(data, TSL2771_PDATAL, data_buffer, 2)=
;
>> +
>> + =A0 =A0 =A0 prox_data =3D (data_buffer[1] << 8);
>> + =A0 =A0 =A0 prox_data |=3D data_buffer[0];
>> +
>> + =A0 =A0 =A0 if (als_prox_debug & 0x2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:Prox Data 0x%X\n", __func_=
_, prox_data);
>> +
>> + =A0 =A0 =A0 data->prox_distance =3D prox_data;
>> +
>> + =A0 =A0 =A0 return prox_data;
>> +}
>> +
>> +static int tsl2771_read_als(struct tsl2771_data *data)
>> +{
>> + =A0 =A0 =A0 int cdata_data =3D 0;
>> + =A0 =A0 =A0 int irdata_data =3D 0;
>> + =A0 =A0 =A0 int ratio =3D 0;
>> + =A0 =A0 =A0 int iac =3D 0;
>> + =A0 =A0 =A0 int cpl =3D 0;
>> + =A0 =A0 =A0 int integration_time =3D 0;
>> + =A0 =A0 =A0 u8 data_buffer[4];
>> +
>> + =A0 =A0 =A0 tsl2771_read_reg(data, TSL2771_CDATAL, data_buffer, 4)=
;
>> +
>> + =A0 =A0 =A0 cdata_data =3D (data_buffer[1] << 8);
>> + =A0 =A0 =A0 cdata_data |=3D data_buffer[0];
>> + =A0 =A0 =A0 irdata_data =3D (data_buffer[3] << 8);
>> + =A0 =A0 =A0 irdata_data |=3D data_buffer[2];
>> + =A0 =A0 =A0 if (als_prox_debug & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: IR Data 0x%X CData 0x%X\n=
", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irdata=
_data, cdata_data);
>> + =A0 =A0 =A0 if (!cdata_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:cdata is NULL\n", __func__)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->lux =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ratio =3D (irdata_data * 100) / cdata_data;
>> + =A0 =A0 =A0 if (als_prox_debug & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: Ratio is %i\n", __func__,=
 ratio);
>> +
>> + =A0 =A0 =A0 if ((ratio >=3D 0) && (ratio <=3D 30))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iac =3D ((1000 * cdata_data) - (1846 *=
 irdata_data));
>> + =A0 =A0 =A0 else if ((ratio >=3D 30) && (ratio <=3D 38))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iac =3D ((1268 * cdata_data) - (2740 *=
 irdata_data));
>> + =A0 =A0 =A0 else if ((ratio >=3D 38) && (ratio <=3D 45))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iac =3D ((749 * cdata_data) - (1374 * =
irdata_data));
>> + =A0 =A0 =A0 else if ((ratio >=3D 45) && (ratio <=3D 54))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iac =3D ((477 * cdata_data) - (769 * i=
rdata_data));
>> +
>> + =A0 =A0 =A0 if (als_prox_debug & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: IAC %i\n", __func__, iac)=
;
>> +
>> + =A0 =A0 =A0 integration_time =3D (272 * (256 - data->als_adc_time)=
);
>> + =A0 =A0 =A0 data->als_gain =3D als_gain_table[data->gain_control &=
 0x3];
>> + =A0 =A0 =A0 if (data->glass_attn && data->device_factor)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpl =3D ((integration_time * data->als=
_gain) /
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (data->glass_attn * da=
ta->device_factor));
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device factor or glass att=
enuation is NULL\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> +
>> + =A0 =A0 =A0 if (als_prox_debug & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: CPL %i\n", __func__, cpl)=
;
>> +
>> + =A0 =A0 =A0 if (cpl)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->lux =3D iac / cpl;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Count per lux is zero\n", =
__func__);
>> +
>> + =A0 =A0 =A0 if (als_prox_debug & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:Current lux is %i\n", __fu=
nc__, data->lux);
>> +
>> +out:
>> + =A0 =A0 =A0 return data->lux;
>> +}
>> +static int tsl2771_als_enable(struct tsl2771_data *data, int val)
>> +{
>> + =A0 =A0 =A0 u8 enable_buf[2];
>> + =A0 =A0 =A0 u8 write_buf;
>> +
>> + =A0 =A0 =A0 tsl2771_read_reg(data, TSL2771_ENABLE, enable_buf, 1);
>> + =A0 =A0 =A0 if (val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_buf =3D (TSL2771_ALS_INT_EN | TS=
L2771_ADC_EN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TSL277=
1_PWR_ON | enable_buf[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->power_state |=3D TSL2771_ALS_EN_=
=46LAG;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_buf =3D (~TSL2771_ALS_INT_EN & ~=
TSL2771_ADC_EN &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable=
_buf[0]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(data->power_state & ~TSL2771_PRO=
X_EN_FLAG))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_buf &=3D ~TSL277=
1_PWR_ON;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->power_state &=3D ~TSL2771_ALS_EN=
_FLAG;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return tsl2771_write_reg(data, TSL2771_ENABLE, write_b=
uf, 1);
>> +
>> +}
>> +
>> +static int tsl2771_prox_enable(struct tsl2771_data *data, int val)
>> +{
>> + =A0 =A0 =A0 u8 enable_buf[2];
>> + =A0 =A0 =A0 u8 write_buf;
>> +
>> + =A0 =A0 =A0 tsl2771_read_reg(data, TSL2771_ENABLE, enable_buf, 1);
>> + =A0 =A0 =A0 if (val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_buf =3D (TSL2771_PROX_INT_EN | T=
SL2771_PROX_EN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TSL277=
1_PWR_ON | enable_buf[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->power_state |=3D TSL2771_PROX_EN=
_FLAG;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_buf =3D (~TSL2771_PROX_INT_EN & =
~TSL2771_PROX_EN &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable=
_buf[0]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(data->power_state & ~TSL2771_ALS=
_EN_FLAG))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_buf &=3D ~TSL277=
1_PWR_ON;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->power_state &=3D ~TSL2771_PROX_E=
N_FLAG;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return tsl2771_write_reg(data, TSL2771_ENABLE, write_b=
uf, 1);
>> +
>> +}
>> +
>> +static void tsl2771_report_prox_input(struct tsl2771_data *data)
>> +{
>> + =A0 =A0 =A0 input_report_abs(data->prox_input_dev, ABS_DISTANCE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->=
prox_distance);
>> + =A0 =A0 =A0 input_sync(data->prox_input_dev);
>> +}
>> +
>> +static void tsl2771_report_als_input(struct tsl2771_data *data)
>> +{
>> + =A0 =A0 =A0 input_event(data->als_input_dev, EV_LED, LED_MISC, dat=
a->lux);
>> + =A0 =A0 =A0 input_sync(data->als_input_dev);
>> +}
>> +
>> +static irqreturn_t tsl2771_work_queue(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D dev_id;
>> + =A0 =A0 =A0 int err =3D 0;
>> + =A0 =A0 =A0 u8 enable_buf[2];
>> +
>> + =A0 =A0 =A0 mutex_lock(&data->enable_mutex);
>> + =A0 =A0 =A0 tsl2771_read_reg(data, TSL2771_STATUS, enable_buf, 1);
>> + =A0 =A0 =A0 if (enable_buf[0] & TSL2771_ALS_INT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D tsl2771_read_als(data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Not going =
to report ALS\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto prox_check;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_report_als_input(data);
>> + =A0 =A0 =A0 }
>> +
>> +prox_check:
>> + =A0 =A0 =A0 if (enable_buf[0] & TSL2771_PROX_INT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D tsl2771_read_prox(data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Not going =
to report prox\n",
>> __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_report_prox_input(data);
>> + =A0 =A0 =A0 }
>> +
>> +done:
>> + =A0 =A0 =A0 tsl2771_write_reg(data, TSL2771_ALL_INT_CLR, 0, 0);
>> + =A0 =A0 =A0 mutex_unlock(&data->enable_mutex);
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static ssize_t tsl2771_show_attr_enable(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0char *buf)
>> +{
>> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D i2c_get_clientdata(clien=
t);
>> +
>> + =A0 =A0 =A0 return sprintf(buf, "%d\n", (data->power_state & 0x3))=
;
>> +}
>> +
>> +static ssize_t tsl2771_store_attr_prox_enable(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const char *buf, size_t count)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> + =A0 =A0 =A0 unsigned long val;
>> + =A0 =A0 =A0 int error =3D 0;
>> +
>> + =A0 =A0 =A0 error =3D kstrtoul(buf, 0, &val);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>> +
>> + =A0 =A0 =A0 if (!(data->flags & TSL2771_USE_PROX)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: PROX is not supported by k=
ernel\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&data->enable_mutex);
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_prox_enable(data, val);
>> + =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Failed to turn prox %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, (val ? "on" =
: "off"));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_read_prox(data);
>> + =A0 =A0 =A0 tsl2771_report_prox_input(data);
>> +error:
>> + =A0 =A0 =A0 mutex_unlock(&data->enable_mutex);
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t tsl2771_store_attr_als_enable(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const char *buf, size_t count)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> + =A0 =A0 =A0 unsigned long val;
>> + =A0 =A0 =A0 int error =3D 0;
>> +
>> + =A0 =A0 =A0 error =3D kstrtoul(buf, 0, &val);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>> +
>> + =A0 =A0 =A0 if (!(data->flags & TSL2771_USE_ALS)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: ALS is not supported by ke=
rnel\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 mutex_lock(&data->enable_mutex);
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_als_enable(data, val);
>> + =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Failed to turn prox %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, (val ? "on" =
: "off"));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 error =3D tsl2771_read_als(data);
>> + =A0 =A0 =A0 tsl2771_report_als_input(data);
>> +error:
>> + =A0 =A0 =A0 mutex_unlock(&data->enable_mutex);
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +static ssize_t tsl2771_show_attr_delay(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0char *buf)
>> +{
>> + =A0 =A0 =A0 return sprintf(buf, "%d\n", 1);
>> +}
>> +
>> +static ssize_t tsl2771_store_attr_delay(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const char *buf, size_t count)
>> +{
>> + =A0 =A0 =A0 unsigned long interval;
>> + =A0 =A0 =A0 int error =3D 0;
>> +
>> + =A0 =A0 =A0 error =3D kstrtoul(buf, 0, &interval);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>> +
>> + =A0 =A0 =A0 return count;
>> +}
>> +
>> +#ifdef TSL2771_DEBUG
>> +static ssize_t tsl2771_registers_show(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dev=
ice_attribute *attr, char *buf)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> + =A0 =A0 =A0 unsigned i, n, reg_count;
>> + =A0 =A0 =A0 u8 read_buf[2];
>> +
>> + =A0 =A0 =A0 reg_count =3D sizeof(tsl2771_regs) / sizeof(tsl2771_re=
gs[0]);
>> + =A0 =A0 =A0 for (i =3D 0, n =3D 0; i < reg_count; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_read_reg(data, tsl2771_regs[i]=
=2Ereg, read_buf, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n +=3D scnprintf(buf + n, PAGE_SIZE - =
n,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%-20s =
=3D 0x%02X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tsl2771=
_regs[i].name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read_bu=
f[0]);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return n;
>> +}
>> +
>> +static ssize_t tsl2771_registers_store(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
device_attribute *attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const c=
har *buf, size_t count)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> + =A0 =A0 =A0 unsigned i, reg_count, value;
>> + =A0 =A0 =A0 int error =3D 0;
>> + =A0 =A0 =A0 char name[30];
>> +
>> + =A0 =A0 =A0 if (count >=3D 30) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:input too long\n", __func__=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (sscanf(buf, "%s %x", name, &value) !=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:unable to parse input\n", _=
_func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 reg_count =3D sizeof(tsl2771_regs) / sizeof(tsl2771_re=
gs[0]);
>> + =A0 =A0 =A0 for (i =3D 0; i < reg_count; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(name, tsl2771_regs[i].name=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tsl2771_regs[i].wr=
iteable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =
=3D tsl2771_write_reg(data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_regs[i].reg,
>> value, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (er=
ror) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pr_err("%s:Failed to write %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__, name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err=
("%s:Register %s is not
>> writeable\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__, name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return -1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pr_err("%s:no such register %s\n", __func__, name);
>> + =A0 =A0 =A0 return -1;
>> +}
>> +static ssize_t tsl2771_lux_show(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dev=
ice_attribute *attr, char *buf)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> +
>> + =A0 =A0 =A0 tsl2771_read_als(data);
>> + =A0 =A0 =A0 return sprintf(buf, "%d\n", data->lux);
>> +}
>> +static DEVICE_ATTR(registers, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_registers_show, tsl2771_regist=
ers_store);
>> +
>> +static DEVICE_ATTR(lux, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_lux_show, NULL);
>> +#endif
>> +static DEVICE_ATTR(als_enable, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_show_attr_enable, tsl2771_stor=
e_attr_als_enable);
>> +
>> +static DEVICE_ATTR(prox_enable, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_show_attr_enable, tsl2771_stor=
e_attr_prox_enable);
>> +
>> +static DEVICE_ATTR(delay, S_IWUSR | S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_show_attr_delay, tsl2771_store=
_attr_delay);
>> +
>> +static struct attribute *tsl2771_attrs[] =3D {
>> + =A0 =A0 =A0 &dev_attr_als_enable.attr,
>> + =A0 =A0 =A0 &dev_attr_prox_enable.attr,
>> + =A0 =A0 =A0 &dev_attr_delay.attr,
>> +#ifdef TSL2771_DEBUG
>> + =A0 =A0 =A0 &dev_attr_registers.attr,
>> + =A0 =A0 =A0 &dev_attr_lux.attr,
>> +#endif
>> + =A0 =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group tsl2771_attr_group =3D {
>> + =A0 =A0 =A0 .attrs =3D tsl2771_attrs,
>> +};
>> +
>> +static struct =A0tsl2771_data *tsl2771_parse_dt(struct i2c_client *=
client)
>> +{
>> + =A0 =A0 =A0 struct device_node *np =3D client->dev.of_node;
>> + =A0 =A0 =A0 struct =A0tsl2771_data *data =3D i2c_get_clientdata(cl=
ient);
>> +
>> + =A0 =A0 =A0 if (of_get_property(np, "tsl2771,als_enable_flag", NUL=
L))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->flags =3D TSL2771_USE_ALS;
>> +
>> + =A0 =A0 =A0 if (of_get_property(np, "tsl2771,prox_enable_flag", NU=
LL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->flags |=3D TSL2771_USE_PROX;
>> +
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,irq_flags", &data->i=
rq_flags);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,gpio", &data->gpio);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,def_enable", &data->=
def_enable);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,als_adc_time",
>> &data->als_adc_time);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,prox_adc_time",
>> &data->prox_adc_time);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,wait_time", &data->w=
ait_time);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,als_low_thresh_low_b=
yte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->als_ltlb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,als_low_thresh_high_=
byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->als_lthb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,als_high_thresh_low_=
byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->als_htlb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,als_high_thresh_high=
_byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->als_hthb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,prox_low_thresh_low_=
byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->prox_ltlb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,prox_low_thresh_high=
_byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->prox_lthb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,prox_high_thresh_low=
_byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->prox_htlb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,prox_high_thresh_hig=
h_byte",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->prox_hthb);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,interrupt_persistenc=
e",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->interrupt_persistence);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,config",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->config);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,prox_pulse_count",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->prox_pulse_count);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,gain_control",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->gain_control);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,glass_attn",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->glass_attn);
>> + =A0 =A0 =A0 of_property_read_u32(np, "tsl2771,device_factor",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &data->device_factor);
>> +
>> + =A0 =A0 =A0 return data;
>> +}
>> +
>> +static int __devinit tsl2771_driver_probe(struct i2c_client *client=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_id *id)
>> +{
>> + =A0 =A0 =A0 struct tsl2771_data *data;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC=
_I2C)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: need I2C_FUNC_I2C\n", __fu=
nc__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 data =3D devm_kzalloc(&client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct tsl2771_=
data), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 data->client =3D client;
>> + =A0 =A0 =A0 i2c_set_clientdata(client, data);
>> + =A0 =A0 =A0 mutex_init(&data->enable_mutex);
>> +
>> + =A0 =A0 =A0 data =3D tsl2771_parse_dt(client);
>> +
>> + =A0 =A0 =A0 if (data->flags & TSL2771_USE_PROX) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_input_dev =3D input_allocat=
e_device();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->prox_input_dev =3D=3D NULL) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Failed to a=
llocate proximity input
>> device\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto prox_input_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_input_dev->name =3D "tsl277=
1_prox";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_input_dev->id.bustype =3D B=
US_I2C;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->prox_input_dev->dev.parent =3D &=
data->client->dev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(data->prox_input_=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EV_ABS, ABS_DISTANCE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_drvdata(data->prox_input_dev=
, data);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(EV_ABS, data->prox_input_dev=
->evbit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(data->prox_input_=
dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ABS_DISTANCE, 0, 1, 0, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D input_register_device(data->pr=
ox_input_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Unable to r=
egister prox device\n",
>> __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto prox_register_fai=
l;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (data->flags & TSL2771_USE_ALS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_input_dev =3D input_allocate=
_device();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->als_input_dev =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Failed to a=
llocate als input device\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto als_input_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_input_dev->name =3D "tsl2771=
_als";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_input_dev->id.bustype =3D BU=
S_I2C;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->als_input_dev->dev.parent =3D &d=
ata->client->dev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(data->als_input_d=
ev, EV_MSC,
>> MSC_RAW);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(data->als_input_d=
ev, EV_LED,
>> LED_MISC);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_drvdata(data->als_input_dev,=
 data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D input_register_device(data->al=
s_input_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Unable to r=
egister als device\n",
>> __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto als_register_fail=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D gpio_request_one(data->gpio, GPIOF_IN, "sensor=
");
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev, "sensor: g=
pio request
>> failure\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (data->gpio) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_threaded_irq(gpio_to_i=
rq(data->gpio), NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tsl2771_work_queue,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data->irq_flags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data->client->name, data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client-=
>dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "reque=
st_threaded_irq failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto irq_request_fail;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No IRQ defined therefore f=
ailing\n",
>> __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto irq_request_fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D tsl2771_init_device(data);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:TSL2771 device init failed\=
n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto device_init_fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 data->power_state =3D 0;
>> +
>> + =A0 =A0 =A0 ret =3D sysfs_create_group(&client->dev.kobj, &tsl2771=
_attr_group);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:Cannot create sysfs group\n=
", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +sysfs_create_fail:
>> + =A0 =A0 =A0 kfree(data);
>
>
> Your error path does not seems correct. You are doing two time kfree =
for
> same data other below at=A0prox_input_error .
>
Yes, will fix.
>>
>> +device_init_fail:
>> + =A0 =A0 =A0 if (data->gpio)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(data->gpio), data=
);
>> +irq_request_fail:
>
>
> where is gpio_free() call in error path???
>
Missed it. Will correct it.
>>
>> +als_register_fail:
>> + =A0 =A0 =A0 if (data->flags & TSL2771_USE_ALS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(data->als_input_dev)=
;
>> +als_input_error:
>> +prox_register_fail:
>> + =A0 =A0 =A0 if (data->flags & TSL2771_USE_PROX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(data->prox_input_dev=
);
>> +prox_input_error:
>> + =A0 =A0 =A0 mutex_destroy(&data->enable_mutex);
>> + =A0 =A0 =A0 kfree(data);
>
>
> Already freed at sysfs_create_fail lable?
>
>>
>> +error:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit tsl2771_driver_remove(struct i2c_client *clien=
t)
>> +{
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D i2c_get_clientdata(clien=
t);
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &tsl2771_attr_gr=
oup);
>> +
>> + =A0 =A0 =A0 if (data->gpio)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(data->gpio), data=
);
>> +
>> + =A0 =A0 =A0 if (data->prox_input_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(data->prox_input_dev=
);
>> +
>> + =A0 =A0 =A0 if (data->als_input_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(data->als_input_dev)=
;
>> +
>> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
>> + =A0 =A0 =A0 mutex_destroy(&data->enable_mutex);
>> + =A0 =A0 =A0 kfree(data);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int tsl2771_driver_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> +
>> + =A0 =A0 =A0 data->power_context =3D data->power_state;
>> + =A0 =A0 =A0 if (data->power_state & 0x2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (als_prox_debug & 0x4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:Prox was e=
nabled into suspend\n",
>> __func__);
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_prox_enable(data, 0);
>
>
> Please put braces for else part too.
>
Ok
>> +
>> + =A0 =A0 =A0 tsl2771_als_enable(data, 0);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int tsl2771_driver_resume(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(de=
v);
>> + =A0 =A0 =A0 struct tsl2771_data *data =3D platform_get_drvdata(pde=
v);
>> +
>> + =A0 =A0 =A0 if (data->power_context & 0x2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (als_prox_debug & 0x4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:Prox was e=
nabled into suspend\n",
>> __func__);
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_prox_enable(data, 1);
>
>
> Please put braces for else part too.
>
Ok.
>> +
>> + =A0 =A0 =A0 if (data->power_context & 0x1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (als_prox_debug & 0x4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:ALS was en=
abled\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsl2771_als_enable(data, 1);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops tsl2771_pm_ops =3D {
>> + =A0 =A0 =A0 .suspend =3D tsl2771_driver_suspend,
>> + =A0 =A0 =A0 .resume =3D tsl2771_driver_resume,
>> +};
>> +#endif
>> +
>> +static const struct i2c_device_id tsl2771_idtable[] =3D {
>> + =A0 =A0 =A0 { TSL2771_NAME, 0 },
>> + =A0 =A0 =A0 { },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tsl2771_idtable);
>> +
>> +static const struct of_device_id tsl2771_dt_match[] =3D {
>> + =A0 =A0 =A0 { .compatible =3D "tsl2771,alps"},
>> + =A0 =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, tsl2771_dt_match);
>> +
>> +static struct i2c_driver tsl2771_driver =3D {
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D tsl2771_driver_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D tsl2771_driver_remove,
>> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D tsl2771_idtable,
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D TSL2771_NAME,
>> +#ifdef CONFIG_PM
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &tsl2771_pm_ops,
>> +#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(tsl27=
71_dt_match),
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +static int __init tsl2771_driver_init(void)
>> +{
>> + =A0 =A0 =A0 return i2c_add_driver(&tsl2771_driver);
>> +}
>> +
>> +static void __exit tsl2771_driver_exit(void)
>> +{
>> + =A0 =A0 =A0 i2c_del_driver(&tsl2771_driver);
>> +}
>> +
>> +module_init(tsl2771_driver_init);
>> +module_exit(tsl2771_driver_exit);
>> +
>> +MODULE_DESCRIPTION("TSL2771 ALS/Prox Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Dan Murphy <DMurphy@ti.com>");
>> diff --git a/include/linux/i2c/tsl2771.h b/include/linux/i2c/tsl2771=
=2Eh
>> new file mode 100644
>> index 0000000..79e4328
>> --- /dev/null
>> +++ b/include/linux/i2c/tsl2771.h
>> @@ -0,0 +1,71 @@
>> +/*
>> + * tsl2771.h
>> + * TSL2771 ALS and Proximity driver
>> + *
>> + * Copyright (C) 2011 Texas Instruments
>> + * Author: Dan Murphy <DMurphy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> it
>> + * under the terms of the GNU General Public License version 2 as
>> published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License
>> for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef _LINUX_TSL2771_I2C_H
>> +#define _LINUX_TSL2771_I2C_H
>> +
>> +#define TSL2771_NAME =A0 "tsl2771"
>> +
>> +/* TSL2771 Read/Write registers */
>> +#define TSL2771_ENABLE 0x00
>> +#define TSL2771_ATIME =A00x01
>> +#define TSL2771_PTIME =A00x02
>> +#define TSL2771_WTIME =A00x03
>> +#define TSL2771_AILTL =A00x04
>> +#define TSL2771_AILTH =A00x05
>> +#define TSL2771_AIHTL =A00x06
>> +#define TSL2771_AIHTH =A00x07
>> +#define TSL2771_PILTL =A00x08
>> +#define TSL2771_PILTH =A00x09
>> +#define TSL2771_PIHTL =A00x0a
>> +#define TSL2771_PIHTH =A00x0b
>> +#define TSL2771_PERS =A0 0x0c
>> +#define TSL2771_CONFIG 0x0d
>> +#define TSL2771_PPCOUNT =A0 =A0 =A0 =A00x0e
>> +#define TSL2771_CONTROL =A0 =A0 =A0 =A00x0f
>> +
>> +#define TSL2771_USE_ALS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +#define TSL2771_USE_PROX =A0 =A0 =A0 (1 << 1)
>> +
>> +struct tsl2771_platform_data {
>> + =A0 =A0 =A0 int irq_flags;
>> + =A0 =A0 =A0 int flags;
>> + =A0 =A0 =A0 =A0int glass_attn;
>> + =A0 =A0 =A0 =A0int device_factor;
>> +
>> + =A0 =A0 =A0 uint8_t def_enable;
>> + =A0 =A0 =A0 uint8_t als_adc_time;
>> + =A0 =A0 =A0 uint8_t prox_adc_time;
>> + =A0 =A0 =A0 uint8_t wait_time;
>> + =A0 =A0 =A0 uint8_t als_low_thresh_low_byte;
>> + =A0 =A0 =A0 uint8_t als_low_thresh_high_byte;
>> + =A0 =A0 =A0 uint8_t als_high_thresh_low_byte;
>> + =A0 =A0 =A0 uint8_t als_high_thresh_high_byte;
>> + =A0 =A0 =A0 uint8_t prox_low_thresh_low_byte;
>> + =A0 =A0 =A0 uint8_t prox_low_thresh_high_byte;
>> + =A0 =A0 =A0 uint8_t prox_high_thresh_low_byte;
>> + =A0 =A0 =A0 uint8_t prox_high_thresh_high_byte;
>> + =A0 =A0 =A0 uint8_t interrupt_persistence;
>> + =A0 =A0 =A0 uint8_t config;
>> + =A0 =A0 =A0 uint8_t prox_pulse_count;
>> + =A0 =A0 =A0 uint8_t gain_control;
>> +};
>> +
>> +#endif
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
~Sourav
