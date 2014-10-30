From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problems with Elantech touchpad in 3.18-rc2
Date: Thu, 30 Oct 2014 12:06:03 -0700
Message-ID: <CA+55aFzkh8NMSPSe7D=sYHPqU3_v3PBUEQrjH7PvFPwkp=ytuA@mail.gmail.com>
References: <545271E1.30306@gmail.com>
	<20141030180331.GF36444@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:34403 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbaJ3TGF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2014 15:06:05 -0400
Received: by mail-vc0-f173.google.com with SMTP id le20so3093654vcb.4
        for <linux-input@vger.kernel.org>; Thu, 30 Oct 2014 12:06:03 -0700 (PDT)
In-Reply-To: <20141030180331.GF36444@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Roel Aaij <roel.aaij@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Oct 30, 2014 at 11:03 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Linus, any guidance here? Can we live with such regression?

No. If people are already finding machines with problems, that means
that there will be a lot of them once distributions move to that
kernel.

And I'd much rather maintain an old blacklist of broken machines, than
start from scratch and have a whitelist for machines that want muxing.

So I guess we'll need to revert and go back to the bad old days.

That said, before we do that, maybe we can find a middle ground for
the default behavior. The old behavior is to always try to mux if the
hw seems to support it. The new behavior is to never try to mux by
default. How about "try to mux if the controller seems to support it,
but if you don't actually find any muxed devices behind the
controller, go back to no-mux mode"?

Is there any way to do something like that? I don't actually know how
the heck people set up those touchpads, so maybe I'm just whistling in
the dark, and you can't even tell.

IOW, can we just enumerate the muxed devices, and see if they actually
use anything else than just index zero? Make the default a bit more
dynamic than just "all on" or "all off"?

Put another way: right now we do a lot of checking in
i8042_check_aux(), but we don't do *any* checking of the individual
muxed ports.  Could we perhaps do some check per mux port? Do some
PSMOUSE_CMD_ENABLE thing and see if you get anything back?

Am I being crazy again?

                     Linus
