From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <l.majewski@majess.pl>
Subject: [Regulator] Request for clarification - GPIO controlled regulator,
 USB VBUS,
Date: Tue, 3 Oct 2017 18:58:00 +0200
Message-ID: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-input@vger.kernel.org

Dear All,

Maybe somebody could shed some light to following issue:

On my setup I do have USB connected touchscreen powered from VBUS.

The VBUS power is controlled by a GPIO pin, which in turn is governed by 
regulator API:

	reg_usbh1_vbus: usb-h1-vbus {
		compatible = "regulator-fixed";
		gpio = <&gpio3 31 GPIO_ACTIVE_LOW>;
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_usbh1_vbus>;
		regulator-name = "usb_h1_vbus";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-settling-time-us = <100000>;
	};


This regulator is then passed to USB controller:

&usbh1 {
	vbus-supply = <&reg_usbh1_vbus>;

}

The regulator API starts VBUS -> USB host get info about the VBUS 
present and starts enumeration of the USB device.


I would like to ask if there is any recommended way to remove VBUS power 
and have a way to force from user space the touchscreen (re-)enumeration?

As fair as I know the Regulator API is RO on purpose, so I cannot toggle 
vbus from there.

I could use hacks presented here (the userspace-regulator API):
https://patchwork.ozlabs.org/patch/374912/
https://lkml.org/lkml/2014/7/30/357

but for some reason they did not find the way to the upstream. Also it 
seems like such approach is for testing, not for production system.


I could write a "dummy" regulator driver, which would export control API 
to /dev/sys/proc.
Something like:
http://elixir.free-electrons.com/linux/latest/source/drivers/usb/phy/phy-fsl-usb.c

(but with opposite way).

or ./drivers/input/misc/regulator-haptic.c


I've also tried the "usb" power control tricks;

echo "0" > /sys/bus/usb/devices/usb1/power/autosuspend_delay_ms
echo "auto" > /sys/bus/usb/devices/usb1/power/control

But without any effect (probably because of above dependencies).



Have I overlooked something? Maybe there is any other mainline code, 
which I could reuse?


My goal is to reuse as much as possible from ML and avoid developing any 
new code :-)

Thanks in advance,

-- 
Best regards.

Łukasz Majewski
