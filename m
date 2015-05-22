From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] touchscreen: stmpe-ts: enable module autoload
Date: Fri, 22 May 2015 07:34:43 +0200
Message-ID: <555EBFF3.1010602@gmail.com>
References: <555E4BF8.80401@web.de> <20150521230612.GA39517@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:32829 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbbEVFe6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 01:34:58 -0400
Received: by wgez8 with SMTP id z8so7176152wge.0
        for <linux-input@vger.kernel.org>; Thu, 21 May 2015 22:34:57 -0700 (PDT)
In-Reply-To: <20150521230612.GA39517@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Am 22.05.2015 um 01:06 schrieb Dmitry Torokhov:
> Hi Heiner,
> 
> On Thu, May 21, 2015 at 11:19:52PM +0200, Heiner Kallweit wrote:
>> Even with poper DT config the module didn't autoload.
>> That's fixed by this additional alias.
>>
>> Tested successfully with a STMPE610-based Adafruit PITFT Plus 3.5"
>> on RPI2 under Arch Linux ARM (kernel 3.18.13).
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/input/touchscreen/stmpe-ts.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
>> index e4c3125..1940e3c 100644
>> --- a/drivers/input/touchscreen/stmpe-ts.c
>> +++ b/drivers/input/touchscreen/stmpe-ts.c
>> @@ -393,4 +393,5 @@ module_platform_driver(stmpe_ts_driver);
>>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
>>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
>>  MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("spi:" STMPE_TS_NAME);
>>  MODULE_ALIAS("platform:" STMPE_TS_NAME);
> 
> Bit this is not an SPI driver, it is a platform driver for a MFD cell.
> Why does adding SPI alias help?
> 
> Thanks.
> 
The STMPE610 in my case is used on a small touchscreen for the Raspberry Pi
and touchscreen controller as well as display controller are connected via
SPI + a few GPIOs to the RPI.

The display controller is supported by the fbtft driver and the drivers
for the respective display controllers have similar aliases.
see e.g. drivers/staging/fbtft/fb_hx8353d.c

MODULE_ALIAS("spi:hx8353d");
MODULE_ALIAS("platform:hx8353d");

Kernel module stmpe_ts is autoloaded only when it's found at enumerating
the devices connected to SPI.

Below is the relevant part from the DT overlay.

Heiner


fragment@2 {
                target = <&spi0>;
                __overlay__ {
                        /* needed to avoid dtc warning */
                        #address-cells = <1>;
                        #size-cells = <0>;

                        pitft: pitft@0{
                                compatible = "himax,hx8357d";
                                reg = <0>;
                                pinctrl-names = "default";
                                pinctrl-0 = <&pitft_pins>;

                                spi-max-frequency = <32000000>;
                                rotate = <90>;
                                fps = <25>;
                                bgr;
                                buswidth = <8>;
                                dc-gpios = <&gpio 25 0>;
                                debug = <0>;
                        };

                        pitft_ts@1 {
                                #address-cells = <1>;
                                #size-cells = <0>;
                                compatible = "st,stmpe610";
                                reg = <1>;

                                spi-max-frequency = <500000>;
                                irq-gpio = <&gpio 24 0x2>; /* IRQF_TRIGGER_FALLING */
                                interrupts = <24 2>; /* high-to-low edge triggered */
                                interrupt-parent = <&gpio>;
                                interrupt-controller;

                                stmpe_touchscreen {
                                        compatible = "st,stmpe-ts";
                                        st,sample-time = <4>;
                                        st,mod-12b = <1>;
                                        st,ref-sel = <0>;
                                        st,adc-freq = <2>;
                                        st,ave-ctrl = <3>;
                                        st,touch-det-delay = <4>;
                                        st,settling = <2>;
                                        st,fraction-z = <7>;
                                        st,i-drive = <0>;
                                };

                                stmpe_gpio: stmpe_gpio {
                                        #gpio-cells = <2>;
                                        compatible = "st,stmpe-gpio";
                                        /*
                                         * only GPIO2 is wired/available
                                         * and it is wired to the backlight
                                         */
                                        st,norequest-mask = <0x7b>;
                                };
                        };
                };

