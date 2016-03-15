From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Handling of non-positional data through evdev
Date: Tue, 15 Mar 2016 12:26:14 -0700
Message-ID: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33902 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965792AbcCOT0P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 15:26:15 -0400
Received: by mail-pf0-f181.google.com with SMTP id x3so40881607pfb.1
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2016 12:26:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I'm working on a device driver for an input device, which has both
directional axes in addition to sensors (accelerometer and gyro). I'm
trying to figure out how to map these axes properly, but I'm stumbling
on some road blocks. Directional axes should be mapped to e.g.
ABS_X/_Y/_Z, while relative axes make most sense for sensors. The main
issue I'm seeing is that there is no way to determine using evdev what
type of data is exposed on an axis.

Based on definitions in input.h, it seems traditionally ABS_X/_Y/_Z
had a resolution of 'units per millimeter', while ABS_RX/_RY/_RZ where
meant for rotational axes in 'units per radian'. Over the years
handling of these axes evolved, where gamepads often use
ABS_RX/_RY/_RZ for the right stick, which is 'units per millimeter'.

In a similar way some drivers are currently reporting acceleration
through absolute axes (e.g. wii driver). The application has to know
it is dealing with the wii gamepad to be able to really understand the
data. Then there is also a special flag 'INPUT_PROP_ACCELEROMETER'
which some drivers use to report acceleration data through absolute /
relative axes provided the device doesn't report any directional axes
on that same node.

As I have shown, handling of non-positional data is sort of handled
now on a case by case basis. As an application developer you pretty
much have to check the product/vendor IDs to really be able to handle
a device. You can't just rely on detecting the type of axes. Moving
forward I would like to determine what the best way of handling
non-positional data is through evdev.

In my opinion the main problem of the current API is that there is no
way to determine what 'unit' is reported on an axes. Is it positional
data, is it (angular) velocity, is it acceleration, something else?
Ideally I think there should have been some 'type' field in
'input_absinfo', which allowed someone to determine the data type and
e.g. map a resolution of '1024' units to 1G of acceleration or a
certain number of radians per second. Unfortunately user space can't
be broken, but potentially a new ioctl could be invented to add such
information (if that's the way forward) returning e.g.
'input_relinfo'. Another option is to add a new axis type.

What are your thoughts on this matter? Ideally I would like to find a
nice solution if possible.

Thanks,
Roderick
