From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Wed, 9 Dec 2009 14:24:35 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56229 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755539AbZLINY3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Dec 2009 08:24:29 -0500
In-Reply-To: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary Stein <lordcnidarian@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, 8 Dec 2009, Gary Stein wrote:

> This implements a new driver for the Logitech Flight System G940
> http://www.logitech.com/index.cfm/gaming/joysticks/devices/5855&cl=us,en

Thanks a lot for the driver.

> And I added the ability to bypass the polar coordinate system used by 
> FF_CONSTANT to a Cartesian coordinate system directly by overloading 
> FF_RAMP.  This was done because (at least for the ff-memless drivers), 
> you have to do polar coordinate math to get a level and direction as a 
> 16 bit number, set with FF_CONSTANT which then calls fixp to convert to 
> Cartesian coordinates (x,y) which is then put in the FF_RAMP fields and 
> then fed to the HID.  I just created a way to set those FF_RAMP fields 
> of the input.h union that goes right to the joystick.  However, it does 
> support the normal way also.
>
> This was done because I needed independent X,Y control and was losing
> accuracy through the Cartesian to Polar to Cartesian process.  For the
> driver I can remove this and resubmit if necessary.

This has been commented on by Dmitry already.

> I have been using this code in production for several weeks and has not 
> had problems, but it obviously needs to have testing by other 
> individuals that own this stick.  I have posted this to linux-input but 
> if it needs to be cross posted to linux-kernel@vger.kernel.org please 
> let me know.

linux-input@ is OK for this purpose, thanks.

> +    //only constant supported

Using of C comment-type is preferred in the kernel code, could you please 
use those instead? (this applies to the rest of the patch as well).

> +    switch (effect->type) {
> +        case FF_RAMP:
> +        //these values are supposed to be -127 to 127
> +        x = effect->u.ramp.start_level;
> +        y = effect->u.ramp.end_level;
> +
> +        //There are 63 fields, only really figured out 3 of them
> +        //0 - seems to be command field
> +        //1 - 30 deal with the x axis?
> +        //31 -60 deal with the y axis?
> +
> +        //1 is x axis constant force
> +        //31 is y axis constant force
> +
> +        //other interesting things for fields 1,2,3,4 on x axis (same
> for 31,32,33,34 on y axis)
> +        //0 0 127 127 makes the joystick autocenter hard
> +        //127 0 127 127 makes the joystick loose on the right, but
> stops all movemnt left
> +        //-127 0 -127 -127 makes the joystick loose on the left, but
> stops all movement right
> +        //0 0 -127 -127 makes the joystick rattle very hard
> +
> +        //I'm sure these are effects that I don't know enough about

Maybe this deserves comment on better place than being buried inside the 
comment inside switch-case?

Maybe a short description of the protocol (or at least the part you have 
already understood) can be put at the beginning of the file in the 
comment, or into some documentation file?

> +        //dbg_hid("(x, y)=(%04x, %04x)\n", x, y);
> +        //printk("Custom (x, y)=(%04x, %04x)\n", x, y);

Please remove this for the final submission of the patch.

> +        usbhid_submit_report(hid, report, USB_DIR_OUT);
> +        break;
> +
> +        default:
> +            printk("FF Type Not Supported: %d\n",effect->type);

KERN_INFO?

> +	error = input_ff_create_memless(dev, NULL, hid_lg3ff_play);
> +	if (error)
> +		return error;
> +
> +	if ( test_bit(FF_AUTOCENTER, dev->ffbit) )

Style nitpick -- please remove the spaces before and after braces here.

Othwerwise the patch looks generally OK to me.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
