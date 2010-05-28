From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [git pull] Input updates for 2.6.35-rc0
Date: Fri, 28 May 2010 16:01:25 +0100
Message-ID: <1275058885.31676.7166.camel@localhost.localdomain>
References: <20100520165243.GA20861@core.coreip.homeip.net>
	 <alpine.LFD.2.00.1005271837050.11382@i5.linux-foundation.org>
	 <AANLkTiklv48cDWNqKlFfh5RVtxxNH8shH_JjDypPgeHA@mail.gmail.com>
	 <alpine.LFD.2.00.1005272108210.11382@i5.linux-foundation.org>
	 <AANLkTinPt49coLNjPqJSSxDP8zTmnjbKuIP1NuQFvwL-@mail.gmail.com>
	 <20100528061957.GA19624@quokka.bne.redhat.com>
	 <alpine.LFD.2.00.1005280724550.11382@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:37770 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755577Ab0E1PBf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 11:01:35 -0400
In-Reply-To: <alpine.LFD.2.00.1005280724550.11382@i5.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dave Airlie <airlied@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, Arjan Opmeer <arjan@opmeer.net>, Eric Piel <eric.piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, 2010-05-28 at 07:28 -0700, Linus Torvalds wrote:
> 
> On Fri, 28 May 2010, Peter Hutterer wrote:
> > 
> > Default behaviour is tapping on for no-button touchpads (like the ones on
> > the apples) and tapping off for everything else.
> 
> It may well be a good default when the buttons are physically separate 
> (like on a lot of touchpads). But when the bottom of the touchpad itself 
> is the button (ie the touchpad has a rocker, and you have to press down on 
> the touchpad itself), the buttons technically _exist_, but they are 
> basically useless.

I had one of those machines, and yes, the touchpad is horrible :)

> That Dell machine got a lot of bad reviews for its horribe touchpad, and I 
> used to not understand why people disliked the touchpad so much - it 
> didn't feel horrible to me. But now I wonder if Windows has the same 
> logic, and reviewers - like me - hadn't realized to enable the tap 
> feature.

On windows, it's basically as horrible as you suggested if you don't
install the elantech drivers.

For the default GNOME configuration, we could certainly switch it again,
but we would break people with older laptops.

Seeing as we already know if there's physical buttons, we would just
need to know whether the physical buttons are embedded in the touchpad
like on yours. Then we could make an informed decision about the
defaults.

I'm sure that Peter would love the challenge of exporting that to the
desktops :)

Cheers

