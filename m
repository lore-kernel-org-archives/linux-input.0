From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Tue, 3 Nov 2015 15:01:54 +0100
Message-ID: <CACRpkdbu8b=rNggjj7uL+E4DCD0A4xDSmhCa9K-SGWJS-dhoVw@mail.gmail.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
	<20150723171041.GA14941@mail.corp.redhat.com>
	<CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
	<5637E03B.5010804@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33807 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbbKCOBz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 09:01:55 -0500
Received: by obbza9 with SMTP id za9so12563169obb.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2015 06:01:54 -0800 (PST)
In-Reply-To: <5637E03B.5010804@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Nov 2, 2015 at 11:14 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> I have been continuing to work on the synaptics-rmi4 driver and was just
> trying to figure out what the next step should be. I recently uploaded my
> changes here https://github.com/aduggan/linux.

I just tested this patch set on the Ux500 with a TVK UI board.

I added this:

        i2c@80110000 {
            synaptics@4b {
                /* Synaptics RMI4 TM1217 touchscreen */
                compatible = "syna,rmi-i2c";
                #address-cells = <1>;
                #size-cells = <0>;
                reg = <0x4b>;
                pinctrl-names = "default";
                pinctrl-0 = <&synaptics_tvk_mode>;
                interrupt-parent = <&gpio2>;
                interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
                syna,sensor-name="TM1217";

                rmi-f01@1 {
                    reg = <0x1>;
                    syna,nosleep = <1>;
                };
                rmi-f11@11 {
                    reg = <0x11>;
                    syna,f11-flip-x = <1>;
                    syna,sensor-type = <1>;
                };
            };
        };

Bootlog:
[    2.143127] rmi_f01 sensor00.fn01: found RMI device, manufacturer:
Synaptics, product: TM1217
[    2.155242] input: Synaptics RMI4 Touch Sensor as
/devices/sensor00/input/input2
[    2.165466] rmi_i2c 3-004b: registered rmi i2c driver at 0x4b.

Doing cat /dev/input/event2 gives noise on screen, yay.

Some quick questions I see immediately:

- The DT examples in Documentation/devicetree/bindings/input/*
  omit
  #address-cells = <1>;
  #size-cells = <0>;
  for the I2C device children (i.e. the function nodes), it needs to look
  like my example above to work.

- All things boolean like syna,nosleep and syna,f11-flip-x
  should just be like:
  syna,nosleep;
  syna,f11-flip-x;
  in the device tree. Use of_property_read_bool() for these.

- syna,sensor-name = "FOO";
  Why?
  The bootlog clearly states that f01 can autodetect the sensor
  type. And f01 is always compiled in, right? So just cut this
  binding and handling, if the two don't match it's just
  super-confusing.

- /proc/interrupts say this:
 206:        114          0  nmk2-64-95  20 Edge      sensor00
 sensor00? Unhelpful. Why can't it say "TM1217", give take
 an instance number, with the detected sensor name?

But to me the code seems overall pretty mature. It just works.
I'll be happy to give a more detailed review if you post it.

Yours,
Linus Walleij
