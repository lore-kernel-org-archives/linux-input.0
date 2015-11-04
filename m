From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Tue, 3 Nov 2015 16:38:55 -0800
Message-ID: <5639539F.2050406@synaptics.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150723171041.GA14941@mail.corp.redhat.com>
 <CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
 <5637E03B.5010804@synaptics.com>
 <CACRpkdbu8b=rNggjj7uL+E4DCD0A4xDSmhCa9K-SGWJS-dhoVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16137 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755004AbbKDAi4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 19:38:56 -0500
In-Reply-To: <CACRpkdbu8b=rNggjj7uL+E4DCD0A4xDSmhCa9K-SGWJS-dhoVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/03/2015 06:01 AM, Linus Walleij wrote:
> On Mon, Nov 2, 2015 at 11:14 PM, Andrew Duggan <aduggan@synaptics.com> wrote:
>
>> I have been continuing to work on the synaptics-rmi4 driver and was just
>> trying to figure out what the next step should be. I recently uploaded my
>> changes here https://github.com/aduggan/linux.
> I just tested this patch set on the Ux500 with a TVK UI board.
>
> I added this:
>
>          i2c@80110000 {
>              synaptics@4b {
>                  /* Synaptics RMI4 TM1217 touchscreen */
>                  compatible = "syna,rmi-i2c";
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  reg = <0x4b>;
>                  pinctrl-names = "default";
>                  pinctrl-0 = <&synaptics_tvk_mode>;
>                  interrupt-parent = <&gpio2>;
>                  interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
>                  syna,sensor-name="TM1217";
>
>                  rmi-f01@1 {
>                      reg = <0x1>;
>                      syna,nosleep = <1>;
>                  };
>                  rmi-f11@11 {
>                      reg = <0x11>;
>                      syna,f11-flip-x = <1>;
>                      syna,sensor-type = <1>;
>                  };
>              };
>          };
>
> Bootlog:
> [    2.143127] rmi_f01 sensor00.fn01: found RMI device, manufacturer:
> Synaptics, product: TM1217
> [    2.155242] input: Synaptics RMI4 Touch Sensor as
> /devices/sensor00/input/input2
> [    2.165466] rmi_i2c 3-004b: registered rmi i2c driver at 0x4b.
>
> Doing cat /dev/input/event2 gives noise on screen, yay.
>
> Some quick questions I see immediately:
>
> - The DT examples in Documentation/devicetree/bindings/input/*
>    omit
>    #address-cells = <1>;
>    #size-cells = <0>;
>    for the I2C device children (i.e. the function nodes), it needs to look
>    like my example above to work.

The devices which I have tested on haven't needed #address-cells or 
#size-cells. It looks like they are inheriting values defined at higher 
levels. I can add them to the example for completeness and update the 
documentation to say that they may be needed.

> - All things boolean like syna,nosleep and syna,f11-flip-x
>    should just be like:
>    syna,nosleep;
>    syna,f11-flip-x;
>    in the device tree. Use of_property_read_bool() for these.

That makes sense. I will switch them to booleans.

> - syna,sensor-name = "FOO";
>    Why?
>    The bootlog clearly states that f01 can autodetect the sensor
>    type. And f01 is always compiled in, right? So just cut this
>    binding and handling, if the two don't match it's just
>    super-confusing.

The sensor name in the platform data is used by some debug messages 
before F01 is loaded. But, I agree it can be confusing having multiple 
names for the device. Especially, when the sensor name is the same as 
the product id. I'll see if it makes sense to use another name like the 
transport device's name in the logs.

> - /proc/interrupts say this:
>   206:        114          0  nmk2-64-95  20 Edge      sensor00
>   sensor00? Unhelpful. Why can't it say "TM1217", give take
>   an instance number, with the detected sensor name?

Currently, rmi_dev's device name is also being set before F01 is loaded. 
I'll see if we can simply set it later when we have the product id from F01.

> But to me the code seems overall pretty mature. It just works.
> I'll be happy to give a more detailed review if you post it.

Great! I'll look into the issues you highlighted above and start posting 
patches soon. Thanks for reviewing!

Andrew

> Yours,
> Linus Walleij

