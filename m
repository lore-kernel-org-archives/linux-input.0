From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Tue, 8 Dec 2009 22:36:08 -0800
Message-ID: <20091209063608.GA3278@core.coreip.homeip.net>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:39199 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994AbZLIGgF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 01:36:05 -0500
Received: by pwj9 with SMTP id 9so2152131pwj.21
        for <linux-input@vger.kernel.org>; Tue, 08 Dec 2009 22:36:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary Stein <lordcnidarian@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi Gary,

On Tue, Dec 08, 2009 at 05:39:09PM -0500, Gary Stein wrote:
> This implements a new driver for the Logitech Flight System G940
> http://www.logitech.com/index.cfm/gaming/joysticks/devices/5855&cl=us,en
> 
> It is a force feedback joystick with HOTAS, the input part is
> supported through normal /dev/input/js0, however it appears the FF
> USB-HID is not the same as in hid-lgff for the Force 3D Pro or G27/G25
> Racing Wheels.
> 
> This patch is applied to 2.6.31 (the stable development branch at the
> time).  I tried to follow the code style of the hid-lg2ff branch for
> the changed up rumble of another logitech device and created a
> hid-lg3ff.c
> 
> I then had to appropriately modify Kconfig so it was in menuconfig,
> add the USB ID hid-ids and hid-core.c, change hid-lg to create a new
> v3 lgff, and overload the function pointers for autocentering etc.
> 
> I have comments in the code to help explain what is happening, I
> actually had to probe the USB-HID with a series of numbers to find
> which fields provided what response, as I could not obtain
> documentation from Logitech.
> 
> It appears that Logitech has expanded to a two-complement system with
> 64 fields with 0 being the command, 1-4 being the X axis, and 31-24
> being the Y axis.  I have seen online that in windows you can turn on
> light (red and green) on the stick, but I have not figured those out
> yet/should not be part of the FF device.
> 
> It supports the same form of FF_CONSTANT as any other joystick in
> ff-memless.c.  Probably less appreciated is included in this patch, I
> have made revisions to ff-memless to account for my specific
> application.
> 

Thank you very much for your patch.

> There was a signed/unsigned bug with gcc 4.4.2 producing invalid
> values using a gain in 2.6.31 that was added recently in which I had
> to add a int cast to fix.
> 

I will apply this part of the fix separately.

> And I added the ability to bypass the polar coordinate system used by
> FF_CONSTANT to a Cartesian coordinate system directly by overloading
> FF_RAMP.  This was done because (at least for the ff-memless drivers),
> you have to do polar coordinate math to get a level and direction as a
> 16 bit number, set with FF_CONSTANT which then calls fixp to convert
> to Cartesian coordinates (x,y) which is then put in the FF_RAMP fields
> and then fed to the HID.  I just created a way to set those FF_RAMP
> fields of the input.h union that goes right to the joystick.  However,
> it does support the normal way also.
> 
> This was done because I needed independent X,Y control and was losing
> accuracy through the Cartesian to Polar to Cartesian process.  For the
> driver I can remove this and resubmit if necessary.
> 

Unfortunately this requires application knowledge that this particular
device overloaded the meaning of FF_RAMP which is not acceptable.
Applications should expect the devices behave similarly as long as they
signal in their capailities support for a particular FF effect.

If there is unacceptable loss of accuracy we need to consider fixing it
while staying within limits of particular effect, in this case
FF_CONSTANT.

There are also a few soding standard issues with the patch that would
need to be resolved before it is accepted - we prefer C (not C++) style
comments, the fragments of the code that are clearly experimental and
not needed anymore should not be ocmmented out but rather removed,
identation done with tabls, etc. Please try running scrips/checkpatch.pl
and it should point out most of the issue.

Please also check your mailer - it line-wraps you mails which makes
patches unappliable,

Thank you.

-- 
Dmitry
