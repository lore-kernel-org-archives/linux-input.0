From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Correct HID for Microsoft keyboards
Date: Fri, 30 Jan 2015 10:30:43 -0500
Message-ID: <CAN+gG=EW91RFJ8Dma9g-03B2p3ntmGtAGgo5q3iPOYYATqKgZA@mail.gmail.com>
References: <BLU436-SMTP1515403F273D791A370736A93310@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37439 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbA3Pao (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 10:30:44 -0500
Received: by mail-qa0-f53.google.com with SMTP id n4so20370140qaq.12
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2015 07:30:44 -0800 (PST)
In-Reply-To: <BLU436-SMTP1515403F273D791A370736A93310@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alistair Leslie-Hughes <leslie_alistair@hotmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

HI Al,

On Fri, Jan 30, 2015 at 4:15 AM, Alistair Leslie-Hughes
<leslie_alistair@hotmail.com> wrote:
> Hi,
>
> On USB Microsoft keyboards, it creates a joystick device (/dev/input/js0).
> This appears to be affect applications like WINE when attempting to play
> certain games.
>
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=52841
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=37982
>
> I can confirm that, at least, the /dev/input/js0 is no longer created on
> boot.  This might not be the correct way to do this but hopefully I'm not
> completely off track.
>
> And advice/comments would be good.

Hmm, it looks like your patch fixes 2 things:
- it adds support for 4 "new" microsoft keyboards
- it adds an automatic ignore in some cases for the keyboards.

I am not confident in having a patch which does these 2 things because
we won't be able to bisect the change if it breaks someone else
device.

Also, it's easier for us to review the patch if you inline it in your
mail. Please use git send-email on your next submission.

Please resubmit your patch after having split it in 2. One for the 4
new keyboards (it should be applied quickly), and one other with only
the hid_ignore hunk.
Also, pleas make tests if the hid_ignore hunk is really necessary,
because my nose told me that his one will break other supported
devices.

Cheers,
Benjamin

PS: please also CC Jiri for your next submission if you want your
patches to be included.

>
> Best Regards
>  Alistair Leslie-Hughes
