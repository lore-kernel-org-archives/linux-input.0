From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Accelerometer drivers in drivers/hwmon
Date: Mon, 4 Oct 2010 11:03:33 -0700
Message-ID: <20101004180333.GD8321@core.coreip.homeip.net>
References: <20100925132330.4ee5e6a7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33927 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393Ab0JDSDo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Oct 2010 14:03:44 -0400
Received: by iwn5 with SMTP id 5so7195205iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Oct 2010 11:03:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100925132330.4ee5e6a7@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-input@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Takashi Iwai <tiwai@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>

Hi Jean,

On Sat, Sep 25, 2010 at 01:23:30PM +0200, Jean Delvare wrote:
> Hi Dmitry,
> 
> I would like to kick the following 5 drivers out of drivers/hwmon: ams,
> hdaps, hp_accel, lis3lv02d and applesmc. These are primarily
> accelerometer devices, so the drivers do not belong to hwmon.
> 
> ams, hdaps, hp_accel and lis3lv02d don't even register a hwmon device.
> They are pure accelerometer drivers as far as I can see. Would you take
> them in drivers/input/misc?
> 
> applesmc is more complex, it's a multifunction device. Maybe it would
> better go to drivers/macintosh, where the other thermal management
> drivers for mac machines live.
> 
> If you don't want hdaps and hp_accel, they might also fit under
> drivers/platform/x86. There are quite a few laptop-specific drivers
> living there already.
> 
> If nobody wants these drivers, drivers/misc is yet another option. I'm
> open to suggestions. Virtually anything which moves these drivers
> outside of drivers/hwmon will make me happy.
>

I looked over the drivers and none of them (with possible exception of
lis3lv02d) are pure input devices either. I think the best course of
action would be to move ams, applesmc, hdaps and hp_accel into
drivers/*/platform (I'd say drivers/x86/platform except that I think
apple one might not be x86 only).

lis3lv02d could ether go into drivers/misc or stay where it is for the
time being, pending resolution on overall IIO/Input/accelerometers
decision. I'd take it in input/misc but accelerometer guys need to
decide on common sysfs layout for such devices.

-- 
Dmitry
