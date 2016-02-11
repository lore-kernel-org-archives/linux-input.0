From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v5 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Thu, 11 Feb 2016 13:37:28 -0800
Message-ID: <56BCFF18.90404@synaptics.com>
References: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
 <20160211100549.GB8577@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:21908 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbcBKVh2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2016 16:37:28 -0500
In-Reply-To: <20160211100549.GB8577@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

On 02/11/2016 02:05 AM, Benjamin Tissoires wrote:
> On Feb 10 2016 or thereabouts, Andrew Duggan wrote:
>> This is the v5 patch series which fixes the issues identified by kbuild
>> and coccinelle in the previous patch series. These include:
>>
>> - Using ARRAY_SIZE instead of a custom macro to calculate the size of the
>>    function handler array.
>> - Remove setting the .owner field for the driver in rmi_i2c and rmi_spi
>>    since the i2c-core and spi set that field.
>> - Fix if statment in rmi_f30 which was testing has_led twice instead of
>>    testing has_gpio.
>>
> Thanks Andrew for the (hopefully) last respin.
>
> For the rmi4 core/bus:
> Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> The HID part does not apply on top of Jiri's tree, so we might want to
> prevent Dmitri to pick this patch up for now (the 10/10).
>
> Regarding the SMBus part, I have pushed my rebase on top of your v5
> here:
> https://github.com/bentiss/linux/tree/synaptics-rmi4-smbus-v4.5-rc3%2B
>
> There is no trackpoint support (no PS/2 redirection) nor support for the
> embedded buttons. I think it would be good to already merge the current
> RMI4 bits so at least I2C and SPI could use it, and then figure out the
> remaining parts for HID and SMBus.

Yes, my hid-rmi patch b786ae8e269b (HID: rmi: Check that the device is a 
RMI device in suspend and resume callbacks) is in Jiri's tree, but not 
yet anywhere else. Including the HID patch in this patch series has 
probably unnecessarily complicated things since HID is a separate tree. 
It is self contained and I can resubmit HID support as a standalone 
patch once the core has been accepted.

But, I do think that HID support is ready to go and the changes need to 
get the patch to apply cleanly on top of b786ae8e269b are minimal.

Andrew

> Cheers,
> Benjamin
>
>> Thanks,
>> Andrew
>>
>> Andrew Duggan (10):
>>    Input: synaptics-rmi4: Add support for Synaptics RMI4 devices
>>    Input: synaptics-rmi4: Add I2C transport driver
>>    Input: synaptics-rmi4: Add device tree support for RMI4 I2C devices
>>    Input: synaptics-rmi4: Add support for 2D sensors and F11
>>    Input: synaptics-rmi4: Add device tree support for 2d sensors and F11
>>    Input: synaptics-rmi4: Add support for F12
>>    Input: synaptics-rmi4: Add support for F30
>>    Input: synaptics-rmi4: Add SPI transport driver
>>    Input: synaptics-rmi4: Add device tree support to the SPI transport
>>      driver
>>    HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
>>
>>   .../bindings/input/rmi4/rmi_2d_sensor.txt          |   56 +
>>   .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   39 +
>>   .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   53 +
>>   .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   57 +
>>   .../bindings/input/touchscreen/touchscreen.txt     |    2 +
>>   Documentation/devicetree/bindings/spi/spi-bus.txt  |    2 +
>>   .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>>   drivers/hid/Kconfig                                |    2 +-
>>   drivers/hid/hid-rmi.c                              |  891 ++-----------
>>   drivers/input/Kconfig                              |    2 +
>>   drivers/input/Makefile                             |    2 +
>>   drivers/input/rmi4/Kconfig                         |   63 +
>>   drivers/input/rmi4/Makefile                        |   13 +
>>   drivers/input/rmi4/rmi_2d_sensor.c                 |  329 +++++
>>   drivers/input/rmi4/rmi_2d_sensor.h                 |   87 ++
>>   drivers/input/rmi4/rmi_bus.c                       |  419 +++++++
>>   drivers/input/rmi4/rmi_bus.h                       |  182 +++
>>   drivers/input/rmi4/rmi_driver.c                    | 1055 ++++++++++++++++
>>   drivers/input/rmi4/rmi_driver.h                    |  105 ++
>>   drivers/input/rmi4/rmi_f01.c                       |  624 ++++++++++
>>   drivers/input/rmi4/rmi_f11.c                       | 1317 ++++++++++++++++++++
>>   drivers/input/rmi4/rmi_f12.c                       |  457 +++++++
>>   drivers/input/rmi4/rmi_f30.c                       |  407 ++++++
>>   drivers/input/rmi4/rmi_i2c.c                       |  397 ++++++
>>   drivers/input/rmi4/rmi_spi.c                       |  589 +++++++++
>>   include/linux/rmi.h                                |  359 ++++++
>>   include/uapi/linux/input.h                         |    1 +
>>   27 files changed, 6693 insertions(+), 818 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>>   create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
>>   create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
>>   create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
>>   create mode 100644 drivers/input/rmi4/Kconfig
>>   create mode 100644 drivers/input/rmi4/Makefile
>>   create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
>>   create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h
>>   create mode 100644 drivers/input/rmi4/rmi_bus.c
>>   create mode 100644 drivers/input/rmi4/rmi_bus.h
>>   create mode 100644 drivers/input/rmi4/rmi_driver.c
>>   create mode 100644 drivers/input/rmi4/rmi_driver.h
>>   create mode 100644 drivers/input/rmi4/rmi_f01.c
>>   create mode 100644 drivers/input/rmi4/rmi_f11.c
>>   create mode 100644 drivers/input/rmi4/rmi_f12.c
>>   create mode 100644 drivers/input/rmi4/rmi_f30.c
>>   create mode 100644 drivers/input/rmi4/rmi_i2c.c
>>   create mode 100644 drivers/input/rmi4/rmi_spi.c
>>   create mode 100644 include/linux/rmi.h
>>
>> -- 
>> 2.5.0
>>

