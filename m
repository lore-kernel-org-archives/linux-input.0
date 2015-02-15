From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] MAINTAINERS: Update rydberg's addresses
Date: Sun, 15 Feb 2015 13:19:21 +0100
Message-ID: <20150215121447.GA19277@amd>
References: <1418979967-2134-1-git-send-email-rydberg@bitmath.org>
 <CAN+gG=Gmgk+wKSnHkSAERoWt+1PqAojNSZt6jo=qmzPOqJs+3Q@mail.gmail.com>
 <54BED60C.3030303@bitmath.org>
 <20150121043520.GB17900@jelly.redhat.com>
 <54BFC4D3.6090607@bitmath.org>
 <CAN+gG=EUNk8AR4PR3qk8L05stx1jUEn9anA6xi+1Qjob00h_hg@mail.gmail.com>
 <54C00046.1000305@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40443 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbbBOMTZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Feb 2015 07:19:25 -0500
Content-Disposition: inline
In-Reply-To: <54C00046.1000305@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed 2015-01-21 20:38:46, Henrik Rydberg wrote:
> Hi Benjamin,
> 
> > - there is a fragmentation problem: we would have to fix the bug in
> > xorg-synaptics (which is slowly waiting for its death), libinput,
> > ChromeOS, Qt Embedded, Kivy (I think), etc...
> 
> Indeed, this is the problem I wanted to highlight. As the fragmentation problem
> grows (graphics, input, compositors, toolkits), the need for a common
> denominator grows as well. However, I do not think the kernel should be the
> single common denominator for all the world's problems. Rather, the purpose of
> the kernel is to convey hardware information and control as accurately,
> effectively and generically as possible.

No, sorry, that's not true.

Kernel should provide hardware abstraction, hiding differences between
different machines.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
