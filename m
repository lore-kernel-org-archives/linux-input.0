From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Tue, 23 Nov 2010 14:30:18 -0800
Message-ID: <20101123223018.GC20283@core.coreip.homeip.net>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64805 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab0KWWaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 17:30:39 -0500
Received: by gxk22 with SMTP id 22so368494gxk.19
        for <linux-input@vger.kernel.org>; Tue, 23 Nov 2010 14:30:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Tue, Nov 23, 2010 at 12:48:07PM -0800, Ping Cheng wrote:
> Hi all,
> 
> I am not going to write a patch for this request before I get the
> permission for the new tool type. It affects all touch screen devices
> (under drivers/input/touchscreen) that support both pen and touch.
> 
> Right now, in the user land, BTN_TOUCH is used to indicate a single
> touch events. BTN_TOUCH and !BTN_TOOL_PEN
> (http://udev.sourcearchive.com/documentation/161-1/input__id_8c-source.html)
> are used to determine if the device is a touch screen device or not a
> pen. With both pen and touch on the same logical port (serial touch
> screen with pen and touch enabled, refer to wacom_w8001.c), BTN_TOUCH
> and !BTN_TOOL_PEN will always be false, which indicates a
> non-touchscreen device. That is wrong.
> 
> Unless we have other means to tell the user land a device is a
> touchscreen, BTN_TOUCH with !BTN_TOOL_PEN won't do the job for us.
> 
> I've already had a value for the new type:
> 
> +#define BTN_TOOL_TOUCH       0x149
> 
> This new type resolves the confusion we had for the existing serial
> pen and touch enabled touchscreen devices. Considering we are merging
> the two logical ports for USB devices, the new type is required for
> the future USB touchscreen support as well.

How is BTN_TOOL_TOUCH is different from BTN_TOOL_FINGER?

-- 
Dmitry
