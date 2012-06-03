From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: Wiimote joystick reports no axes
Date: Sun, 3 Jun 2012 14:16:03 +0200
Message-ID: <CANq1E4R_Ciq4dLxmFzXB251u+jra-mioqkvBK6yQyGYKL8YvfA@mail.gmail.com>
References: <CAOxFTcySV3g2ieHqnC312RneiAj_CzY7Nba7bMpKkqgbvyt3mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55386 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab2FCMQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jun 2012 08:16:05 -0400
Received: by wgbdr13 with SMTP id dr13so3231594wgb.1
        for <linux-input@vger.kernel.org>; Sun, 03 Jun 2012 05:16:03 -0700 (PDT)
In-Reply-To: <CAOxFTcySV3g2ieHqnC312RneiAj_CzY7Nba7bMpKkqgbvyt3mQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Giuseppe

On Sun, Jun 3, 2012 at 12:26 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Hello,
>
> I've recently started playing around with the new HID Wiimote driver,
> and found out that the joystick device associated with the remote
> reports no axes and 7 buttons (even in the latest linux git).

You cannot use the joystick device with the Wii Remote driver. The Wii
Remote driver supports power management and this is only possible by
splitting the input data across multiple input-devices. We also need
multiple input devices because the Wii Remote reports more ABS data
than we could send via a single device.

> I believe that the reason for this is that the joystick is created for
> the "Nintendo Wii Remote" device, but the actual axis information is
> passed on by the "Nintendo Wii Remote Accelerometer" device. I would
> have loved to provide a patch to fix this, but I can't grasp correctly
> how the joystick device creation is delegated from hid.

Why do you want to fix this? The Wii Remote provides accelerometer
data. Does the joystick interface really need accelerometer data?
Please also see here for more details on the Wii Remote kernel driver
(INTERFACE/INTERFACE_SYSFS/INTERFACE_INPUT):
https://github.com/dvdhrm/xwiimote/tree/master/doc

If you want to extend the Wii Remote interface, I am open for
suggestions but I haven't found a proper way to report the data to
user-space so I let user-space handle the parsed device data.

> --
> Giuseppe "Oblomov" Bilotta

Regards
David
