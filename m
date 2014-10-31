From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problems with Elantech touchpad in 3.18-rc2
Date: Fri, 31 Oct 2014 09:24:36 -0700
Message-ID: <20141031162436.GA36996@dtor-ws>
References: <545271E1.30306@gmail.com>
 <20141030180331.GF36444@dtor-ws>
 <CA+55aFzkh8NMSPSe7D=sYHPqU3_v3PBUEQrjH7PvFPwkp=ytuA@mail.gmail.com>
 <20141030192506.GH36444@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:63281 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbaJaQYl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 12:24:41 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so1260650igd.2
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 09:24:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141030192506.GH36444@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roel Aaij <roel.aaij@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>

On Thu, Oct 30, 2014 at 12:25:06PM -0700, Dmitry Torokhov wrote:
> On Thu, Oct 30, 2014 at 12:06:03PM -0700, Linus Torvalds wrote:
> > On Thu, Oct 30, 2014 at 11:03 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Linus, any guidance here? Can we live with such regression?
> > 
> > No. If people are already finding machines with problems, that means
> > that there will be a lot of them once distributions move to that
> > kernel.
> 
> My only argument here is that failure is much less severe than with MUX
> case: when in legacy mode the worst that is happening is that advanced
> features (multi-touch, two-finger scroilling, etc) do not work so the
> experience is similar to Windows box with no venrod drivers installed.
> Whereas when active MUX does not work but we are tying to use it your
> device is completely hosed.

So I slept on it and I decided that we should indeed revert the patch,
since it causes more grief to people with good hardware than I
expected. We should not punish owners of good hardware because some
vendors can't write their firmware.

Thanks.

-- 
Dmitry
