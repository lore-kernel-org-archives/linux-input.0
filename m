From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Fri, 20 Nov 2009 17:17:29 +0300
Message-ID: <78f5d6bf0911200617r1771fe24p5368985de34e376a@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	<78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com>
	<4A2A5D8E.1050309@gmail.com> <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com>
	<20090609140949.78d4448a@dxy.sh.intel.com> <78f5d6bf0906110238w6f90331ex3cf8c0fdd44f3354@mail.gmail.com>
	<78f5d6bf0906111311p37620e53scc5ed8a695b5be94@mail.gmail.com>
	<78f5d6bf0907091041o3f8b712cxdc674c9c553a9f4@mail.gmail.com>
	<4A562FC1.60809@gmail.com> <78f5d6bf0911090400n1bee3396x1cbd9b4722f87942@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62141 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZKTORn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 09:17:43 -0500
Received: by fxm21 with SMTP id 21so3719788fxm.21
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2009 06:17:49 -0800 (PST)
In-Reply-To: <78f5d6bf0911090400n1bee3396x1cbd9b4722f87942@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello!

My decision to replace usb_unlink_urb() with usb_kill_urb() was wrong.
After fixing usbhid->urbctrl initialization I got kernel crashes
again, and according to logs, it was crashing inside irq handling.
I changed that line back to usb_unlink_urb() and got working driver.

I found out reason of device/driver hangs: device doesn't like inplace
effect updates (for any changes effect should be deleted and
reuploaded). Inplace changes also work, but device becomes stuck after
closing and doesn't play anything from ffmvforce anymore until
reconnected.

This describes, why windows driver resets device on each open (report
52 01). Also windows driver sends enable/disable actuators on device
open/close.

Actually, it would be good to do reset and enable actuators on device
open and disable actuators on close, but that will break access of
several applications to one device.
