From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problems with Elantech touchpad in 3.18-rc2
Date: Fri, 31 Oct 2014 10:35:50 -0700
Message-ID: <20141031173550.GE32331@dtor-ws>
References: <545271E1.30306@gmail.com>
 <20141030180331.GF36444@dtor-ws>
 <CA+55aFzkh8NMSPSe7D=sYHPqU3_v3PBUEQrjH7PvFPwkp=ytuA@mail.gmail.com>
 <20141030192506.GH36444@dtor-ws>
 <20141031162436.GA36996@dtor-ws>
 <20141031173040.GA24184@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57059 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaJaRfz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 13:35:55 -0400
Received: by mail-ie0-f182.google.com with SMTP id rd18so1745149iec.27
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 10:35:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141031173040.GA24184@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roel Aaij <roel.aaij@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>

On Fri, Oct 31, 2014 at 06:30:40PM +0100, Pavel Machek wrote:
> On Fri 2014-10-31 09:24:36, Dmitry Torokhov wrote:
> > On Thu, Oct 30, 2014 at 12:25:06PM -0700, Dmitry Torokhov wrote:
> > > On Thu, Oct 30, 2014 at 12:06:03PM -0700, Linus Torvalds wrote:
> > > > On Thu, Oct 30, 2014 at 11:03 AM, Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > Linus, any guidance here? Can we live with such regression?
> > > > 
> > > > No. If people are already finding machines with problems, that means
> > > > that there will be a lot of them once distributions move to that
> > > > kernel.
> > > 
> > > My only argument here is that failure is much less severe than with MUX
> > > case: when in legacy mode the worst that is happening is that advanced
> > > features (multi-touch, two-finger scroilling, etc) do not work so the
> > > experience is similar to Windows box with no venrod drivers installed.
> > > Whereas when active MUX does not work but we are tying to use it your
> > > device is completely hosed.
> > 
> > So I slept on it and I decided that we should indeed revert the patch,
> > since it causes more grief to people with good hardware than I
> > expected. We should not punish owners of good hardware because some
> > vendors can't write their firmware.
> 
> You can still add "for anything manufactured in 2015+, assume it does
> not need MUX" and add a whitelist entry for any machine with external
> ps/2 ports that still needs it... I guess there would be very little
> of them made in 2015+.

No, that Clevo W650SH that Roel has is a Haswell and is fairly recent
and has no external PS/2 ports and still wants to be in active MUX mode.
So we'll have to continue with the blacklist I'm afraid.

-- 
Dmitry
