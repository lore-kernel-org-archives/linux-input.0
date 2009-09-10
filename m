From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.31-rc6 (yeah, I know...): weird tty / X.org state currently
Date: Thu, 10 Sep 2009 09:49:06 -0700
Message-ID: <20090910172244.71282526EC9@mailhub.coreip.homeip.net>
References: <20090910103126.GA17742@rhlx01.hs-esslingen.de> <20090910165837.50544526EC9@mailhub.coreip.homeip.net> <20090910164232.GA27404@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:10550 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZIJQtN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2009 12:49:13 -0400
In-Reply-To: <20090910164232.GA27404@rhlx01.hs-esslingen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 10 September 2009 09:42:32 am Andreas Mohr wrote:
> Hi,
>
> On Thu, Sep 10, 2009 at 09:25:00AM -0700, Dmitry Torokhov wrote:
> > On Thursday 10 September 2009 03:31:26 am Andreas Mohr wrote:
> > > Possibly the kernel's control key state got stuck in a weird state,
> > > perhaps due to some input layer race conditions or so.
> > >
> > > Or is it X.org's input handling which is responsible for Ctrl-Alt-F1
> > > etc. combos? I wouldn't think so...
> >
> > X is solely responsible for handling input when active. It switches
> > console in RAW mode which bypasses kernel processing) and does it's
> > own thing. This includes switching VTs upon Ctrl-ALt-Fx.
>
> OK, but what's puzzling is that there's no indication whatsoever that
> there's any broken Ctrl activity (neither in konsole nor in a tty),
> yet the tty gets switched readily as soon as only Alt-Fx gets pressed in
> X.org.
>
> IOW (unless that's wrong) you're saying that it's X.org which has
> a broken Ctrl key state (but solely when doing the Alt-Fx switch,
> _not_ when doing Ctrl-L or regular letter input), not the kernel.
>
> If so, would this problem warrant notifying X.org upstream,
> or is it likely to be fixed in newer X.org releases?

I don't follow X development unfortunately but I think it is a good
idea to ask there.

-- 
Dmitry
