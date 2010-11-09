From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ir-core and default IR maps
Date: Mon, 8 Nov 2010 22:32:42 -0800
Message-ID: <20101109063242.GA10496@core.coreip.homeip.net>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com>
 <20101107060147.GC3823@core.coreip.homeip.net>
 <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com>
 <4CD7F6A7.8040206@redhat.com>
 <AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com>
 <AANLkTimPKkvdWWTPoWGCRmp-biwup1dEQpaKYEk8t9ED@mail.gmail.com>
 <4CD805D8.2000808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52784 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0KIGcu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 01:32:50 -0500
Received: by gxk23 with SMTP id 23so4015319gxk.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 22:32:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CD805D8.2000808@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

On Mon, Nov 08, 2010 at 12:14:48PM -0200, Mauro Carvalho Chehab wrote:
> Em 08-11-2010 11:41, jonsmirl@gmail.com escreveu:
> > On Mon, Nov 8, 2010 at 8:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> >> To achieve plug and play at least one of four choices has to happen:
> > 
> > There is another option, the IR maps get integrated into user space
> > keyboard mapping package. This may be possible with the new
> > libxkbcommon package.
> 
> That seems interesting.
> 

I disagree here. libxkbcommon provides X interface while applications
might want to access evdev nodes directly. If anything, parts of
ir-utils dealing with keymap selection should be moved into udev. Maybe
we should split utilities that select protocol from the keymap setting
and use udev keymap utilities to do the task.

Thanks.

-- 
Dmitry
