From: Gary Stein <lordcnidarian@gmail.com>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Thu, 10 Dec 2009 12:47:06 -0500
Message-ID: <fce72f9b0912100947q2214c471r71f6cf6e81212cd2@mail.gmail.com>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>
	 <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:60135 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761211AbZLJRxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 12:53:01 -0500
Received: by ewy6 with SMTP id 6so115406ewy.29
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 09:53:06 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Ok, I'll go through the coding issues, that checkpatch.pl was useful,
I was not positive on all of the coding standards, but with that
script I can setup my IDE properly to make sure everything works out
(like c99 comments and 80 char limits)

The wrapping is whatever gmail wants to do in their web interface.

I wanted to do FF_CUSTOM (which appears in input.h) and I did try that
for awhile but in the end ff-memless didn't seem to pass everything
along even if I set it up in the flags, etc.

It would be more work, but is there any way to add a different
=46F_CONSTANT through the union process?

It is testing code now, any I hope someone else has this setup to
confirm that it works fine, but I'll clean it up to match the
guidelines and strip out the custom stuff.

gary

On Wed, Dec 9, 2009 at 8:24 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 8 Dec 2009, Gary Stein wrote:
>
>> This implements a new driver for the Logitech Flight System G940
>> http://www.logitech.com/index.cfm/gaming/joysticks/devices/5855&cl=3D=
us,en
>
> Thanks a lot for the driver.
>
>> And I added the ability to bypass the polar coordinate system used b=
y
>> FF_CONSTANT to a Cartesian coordinate system directly by overloading
>> FF_RAMP. =A0This was done because (at least for the ff-memless drive=
rs),
>> you have to do polar coordinate math to get a level and direction as=
 a
>> 16 bit number, set with FF_CONSTANT which then calls fixp to convert=
 to
>> Cartesian coordinates (x,y) which is then put in the FF_RAMP fields =
and
>> then fed to the HID. =A0I just created a way to set those FF_RAMP fi=
elds
>> of the input.h union that goes right to the joystick. =A0However, it=
 does
>> support the normal way also.
>>
>> This was done because I needed independent X,Y control and was losin=
g
>> accuracy through the Cartesian to Polar to Cartesian process. =A0For=
 the
>> driver I can remove this and resubmit if necessary.
>
> This has been commented on by Dmitry already.
>
>> I have been using this code in production for several weeks and has =
not
>> had problems, but it obviously needs to have testing by other
>> individuals that own this stick. =A0I have posted this to linux-inpu=
t but
>> if it needs to be cross posted to linux-kernel@vger.kernel.org pleas=
e
>> let me know.
>
> linux-input@ is OK for this purpose, thanks.
>
>> + =A0 =A0//only constant supported
>
> Using of C comment-type is preferred in the kernel code, could you pl=
ease
> use those instead? (this applies to the rest of the patch as well).
>
>> + =A0 =A0switch (effect->type) {
>> + =A0 =A0 =A0 =A0case FF_RAMP:
>> + =A0 =A0 =A0 =A0//these values are supposed to be -127 to 127
>> + =A0 =A0 =A0 =A0x =3D effect->u.ramp.start_level;
>> + =A0 =A0 =A0 =A0y =3D effect->u.ramp.end_level;
>> +
>> + =A0 =A0 =A0 =A0//There are 63 fields, only really figured out 3 of=
 them
>> + =A0 =A0 =A0 =A0//0 - seems to be command field
>> + =A0 =A0 =A0 =A0//1 - 30 deal with the x axis?
>> + =A0 =A0 =A0 =A0//31 -60 deal with the y axis?
>> +
>> + =A0 =A0 =A0 =A0//1 is x axis constant force
>> + =A0 =A0 =A0 =A0//31 is y axis constant force
>> +
>> + =A0 =A0 =A0 =A0//other interesting things for fields 1,2,3,4 on x =
axis (same
>> for 31,32,33,34 on y axis)
>> + =A0 =A0 =A0 =A0//0 0 127 127 makes the joystick autocenter hard
>> + =A0 =A0 =A0 =A0//127 0 127 127 makes the joystick loose on the rig=
ht, but
>> stops all movemnt left
>> + =A0 =A0 =A0 =A0//-127 0 -127 -127 makes the joystick loose on the =
left, but
>> stops all movement right
>> + =A0 =A0 =A0 =A0//0 0 -127 -127 makes the joystick rattle very hard
>> +
>> + =A0 =A0 =A0 =A0//I'm sure these are effects that I don't know enou=
gh about
>
> Maybe this deserves comment on better place than being buried inside =
the
> comment inside switch-case?
>
> Maybe a short description of the protocol (or at least the part you h=
ave
> already understood) can be put at the beginning of the file in the
> comment, or into some documentation file?
>
>> + =A0 =A0 =A0 =A0//dbg_hid("(x, y)=3D(%04x, %04x)\n", x, y);
>> + =A0 =A0 =A0 =A0//printk("Custom (x, y)=3D(%04x, %04x)\n", x, y);
>
> Please remove this for the final submission of the patch.
>
>> + =A0 =A0 =A0 =A0usbhid_submit_report(hid, report, USB_DIR_OUT);
>> + =A0 =A0 =A0 =A0break;
>> +
>> + =A0 =A0 =A0 =A0default:
>> + =A0 =A0 =A0 =A0 =A0 =A0printk("FF Type Not Supported: %d\n",effect=
->type);
>
> KERN_INFO?
>
>> + =A0 =A0 error =3D input_ff_create_memless(dev, NULL, hid_lg3ff_pla=
y);
>> + =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return error;
>> +
>> + =A0 =A0 if ( test_bit(FF_AUTOCENTER, dev->ffbit) )
>
> Style nitpick -- please remove the spaces before and after braces her=
e.
>
> Othwerwise the patch looks generally OK to me.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
