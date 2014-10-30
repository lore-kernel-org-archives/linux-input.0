From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problems with Elantech touchpad in 3.18-rc2
Date: Thu, 30 Oct 2014 12:25:06 -0700
Message-ID: <20141030192506.GH36444@dtor-ws>
References: <545271E1.30306@gmail.com>
 <20141030180331.GF36444@dtor-ws>
 <CA+55aFzkh8NMSPSe7D=sYHPqU3_v3PBUEQrjH7PvFPwkp=ytuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:59012 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588AbaJ3TZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2014 15:25:10 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so5747644pdj.28
        for <linux-input@vger.kernel.org>; Thu, 30 Oct 2014 12:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzkh8NMSPSe7D=sYHPqU3_v3PBUEQrjH7PvFPwkp=ytuA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roel Aaij <roel.aaij@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Oct 30, 2014 at 12:06:03PM -0700, Linus Torvalds wrote:
> On Thu, Oct 30, 2014 at 11:03 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Linus, any guidance here? Can we live with such regression?
> 
> No. If people are already finding machines with problems, that means
> that there will be a lot of them once distributions move to that
> kernel.

My only argument here is that failure is much less severe than with MUX
case: when in legacy mode the worst that is happening is that advanced
features (multi-touch, two-finger scroilling, etc) do not work so the
experience is similar to Windows box with no venrod drivers installed.
Whereas when active MUX does not work but we are tying to use it your
device is completely hosed.

> 
> And I'd much rather maintain an old blacklist of broken machines, than
> start from scratch and have a whitelist for machines that want muxing.
> 
> So I guess we'll need to revert and go back to the bad old days.
> 
> That said, before we do that, maybe we can find a middle ground for
> the default behavior. The old behavior is to always try to mux if the
> hw seems to support it. The new behavior is to never try to mux by
> default. How about "try to mux if the controller seems to support it,
> but if you don't actually find any muxed devices behind the
> controller, go back to no-mux mode"?
> 
> Is there any way to do something like that? I don't actually know how
> the heck people set up those touchpads, so maybe I'm just whistling in
> the dark, and you can't even tell.
> 
> IOW, can we just enumerate the muxed devices, and see if they actually
> use anything else than just index zero? Make the default a bit more
> dynamic than just "all on" or "all off"?
> 
> Put another way: right now we do a lot of checking in
> i8042_check_aux(), but we don't do *any* checking of the individual
> muxed ports.  Could we perhaps do some check per mux port? Do some
> PSMOUSE_CMD_ENABLE thing and see if you get anything back?

Very often (most often) with broken MUX we do see the device, it simply
does not react properly (refuses to get enabled, fails to activate in
advanced mode, spews garbage into data stream, etc), so I don't think
that putting entire psmouse initialization sequence with all various
protocols into i8042_check_aux() is good idea.

And I have no idea whatsoever how they will behave if you try activating
MUX mode, try using it, and then deactivate. I think that code path is
even less travelled than active MUX one.

-- 
Dmitry
