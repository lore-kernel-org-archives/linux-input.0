From: Ken Phillis Jr <kphillisjr@gmail.com>
Subject: Re: [PATCH 1/2] joydev: Map ABS_{THROTTLE,GAS,BREAK} to positive values.
Date: Fri, 13 Dec 2013 23:13:26 -0600
Message-ID: <CACiKS=QHY6Zq69+zRamZu6xPDUQs0DzNXB8TO_y977fq+qY2pw@mail.gmail.com>
References: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:46743 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3LNFN1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 00:13:27 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so2337564qec.23
        for <linux-input@vger.kernel.org>; Fri, 13 Dec 2013 21:13:27 -0800 (PST)
In-Reply-To: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Franzke <benjaminfranzke@googlemail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 11, 2013 at 2:15 AM, Benjamin Franzke
<benjaminfranzke@googlemail.com> wrote:
> Gamepads like XInput devices have triggers with a range from
> e.g. 0 to 255.
> When the conventional joydev AXES correction/mapping method is used,
> the default state 0 (i.e. when the user does not press a button or trigger)
> is mapped to -32767 (and 255 to 32767).
> You'll get 0 only when pressing the trigger half-way down.
> This has several drawbacks:
>  - A trigger is not usable at all when configured to have 2 directions
>    when there is physically only one.
>  - Applications that let the user configure joystick input assignments
>    may register the mapped non-zero default state as a press,
>    preventing the user from configuring any sensible value.
>
> Traditonal calibration e.g. with jscal does not help to get a usable
> experience either, it'll map the default state to -32767 as well.
> Only manually editing the calibration data does work currently.
>
> This patch tries to fix this issue by calculating a positive-only range for
> the throttle break and gas ABS bits.
> Maybe other ABS types need to be added to this scheme as well(?)
>
> Note:
> Although joydev is considered obsolete and people are encouraged to just
> use evdev, joydev should still be fixed, because
>  1. many applications still use it.
>  2. userspace already copies the joydev correction code to evdev (e.g. libSDL).
>
> This bug should be fixed here in joydev first, and when we have a good
> sensible state, this should be propagated to the application/libraries
> that copied the joydev correction code.
>
> Gamepad drivers will need to advertise triggers as THROTTLE,GAS,BREAK instead
> of e.g. ABS_{RZ,Z} where phyisically appropriate, to make use of this.
>
> I've considered changing the current joydev correction calculation for all ABS
> types, to have only a scaling functionality by default, no translation
> (all positive values remain positive, negatives negative and zero remains zero),
> so that drivers would need to expose zero-centered ABS values.
> It turned out to many drivers would need to be adjusted, which i cant
> test.
>
> Signed-off-by: Benjamin Franzke <benjaminfranzke@googlemail.com>


I have serious concerns that this Patch and the Next patch will the
input detection of the triggers on various games powered by SDL2. Have
you tested this against games listed on steam that have full
controller support?
