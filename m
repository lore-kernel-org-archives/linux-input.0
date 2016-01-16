From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: adding xpad support for PS-PC Smart Joypad
Date: Fri, 15 Jan 2016 16:43:46 -0800
Message-ID: <CAKdAkRTjs6r4fE5F3g9qw1kszRkrLQ6L3AVAxLtkRiv16OU9JQ@mail.gmail.com>
References: <CAPMSj_FGPyTVtS-F-U6C-Jji8V7_yv9-nqu4=9+1_7wCNP2UnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36041 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161163AbcAPAnr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 19:43:47 -0500
Received: by mail-oi0-f50.google.com with SMTP id o124so136784332oia.3
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 16:43:47 -0800 (PST)
In-Reply-To: <CAPMSj_FGPyTVtS-F-U6C-Jji8V7_yv9-nqu4=9+1_7wCNP2UnQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Allen M." <ase1592@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Allen,

On Fri, Jan 15, 2016 at 9:42 AM, Allen M. <ase1592@gmail.com> wrote:
> Hello, I have a Playstation 1 to USB device I'd like to request to be added
> as an xpad supported device. verbose lsusb output for the device can be
> found here: http://ix.io/nq3
>
> The device currently works fine as a generic joystick. However, it needs
> the MAP_DPAD_AS_BUTTONS option in order for it to be used with a dance pad.
> Let me know if I need to do anything further or if I need to provide more
> info for the device.

This looks like a generic HID device, not Xbox device, so xpad driver
would be wrong one to add it to. Can you have UDEV rule to remap
buttons form userspace when the device is discovered, similarly to
what we do for keyboards?

Thanks.

-- 
Dmitry
