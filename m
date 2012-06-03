From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Wiimote joystick reports no axes
Date: Sun, 3 Jun 2012 21:16:05 +0200
Message-ID: <CAOxFTcwsVFpN0KcKSbCjCHJ0=0Q+CcSd0UxanWzue0pv5ZSoXA@mail.gmail.com>
References: <CAOxFTcySV3g2ieHqnC312RneiAj_CzY7Nba7bMpKkqgbvyt3mQ@mail.gmail.com>
 <CANq1E4R_Ciq4dLxmFzXB251u+jra-mioqkvBK6yQyGYKL8YvfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37303 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab2FCTQ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jun 2012 15:16:27 -0400
Received: by vcbf11 with SMTP id f11so2117788vcb.19
        for <linux-input@vger.kernel.org>; Sun, 03 Jun 2012 12:16:27 -0700 (PDT)
In-Reply-To: <CANq1E4R_Ciq4dLxmFzXB251u+jra-mioqkvBK6yQyGYKL8YvfA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Hello David,

On Sun, Jun 3, 2012 at 2:16 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> You cannot use the joystick device with the Wii Remote driver. The Wii
> Remote driver supports power management and this is only possible by
> splitting the input data across multiple input-devices. We also need
> multiple input devices because the Wii Remote reports more ABS data
> than we could send via a single device.

Thank you very much for the explanation. I didn't actually expect the
wiimote to be used as a joystick "out of the box", but when the new
joystick device appeared after pairing the wiimote with the computer,
I was surprised by it coming up as a "crippled" joystick (buttons, but
no axes).  Just for kicks, I tried replacing the axes reported in the
Accel device as X, Y, Z and that device also popped up as a joystick.

I understand the need for a split between the devices, and I
appreciate the power consumption motivations behind it, and I think
it's possible to expose the wiimote as a proper joystick while still
keeping the separation between the components. I'll discuss it
momentarily.

> Why do you want to fix this? The Wii Remote provides accelerometer
> data. Does the joystick interface really need accelerometer data?

The reason why I want to do this is that it would allow using the
wiimote with games that do not have direct support for it, through the
joystick interface. And of course the joystick driver can cope with
accelerometer data: for example, the accelerometer in my laptop is
also seen as a joystick and I can play neverball by holding the laptop
in my hands and rotating it appropriately (I'm pretty sure the
accelerometer in other laptop models is also supported in the same
way).

> Please also see here for more details on the Wii Remote kernel driver
> (INTERFACE/INTERFACE_SYSFS/INTERFACE_INPUT):
> https://github.com/dvdhrm/xwiimote/tree/master/doc

Thank you very much. However, these documents don't explain why a
joystick device is created for the Wii Remote and not for the Wii
Remote Accelerator. I've tried looking around the code (wiimote
driver, the hid driver and the joystick driver), and I *think* that
what happens is that the devices created when a wiimote is connected
are all passed to the joydev handler, and this catches the Wii Remote
device, because it's marked as a GAMEPAD (I can't see where this is
done by the wiimote driver, but I think hid does it automatically
because of what the hardware itself reports as class). The Wii Remote
Accelerator is NOT grabbed by joydev because it does not report an
ABS_{X,WHEEL,THROTTLE, nor a BTN_{JOYSICK,GAMEPAD,TRIGGER_HAPPY}.
This also explains why the Accelerator _does_ get exposed as a
joystick if I change the reported axes as X, Y and Z instead of RX,
RY, RZ.

If my findings are correct, then it should be sufficient to 'unmark'
the Remote device as gamepad (assuming this is possible) and mark the
Accelerator as such instead. This would expose the wiimote as a
joystick with 3 axes and no buttons, which usage-wise is better than a
joystick with 7 buttons and no axes. However, I'm not sure on how to
do that.

> If you want to extend the Wii Remote interface, I am open for
> suggestions but I haven't found a proper way to report the data to
> user-space so I let user-space handle the parsed device data.

IMO the current interface is quite satisfactory. The only thing that I
would change is that the Accelerator device should ALSO expose buttons
(possibly with a different keymap in that case). I have something in
mind to this end, I should be able to give it a test and submit an RFC
patch within a couple of days.

-- 
Giuseppe "Oblomov" Bilotta
