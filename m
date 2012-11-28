From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Wed, 28 Nov 2012 02:01:53 +0100
Message-ID: <3042387.HFktfBSNhs@vostro.rjw.lan>
References: <8159607.SRZZrRIPNF@orthese> <1418196.mMF7t2R2GI@orthese> <alpine.LNX.2.00.1211272123370.3933@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34800 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715Ab2K1A5K (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 19:57:10 -0500
In-Reply-To: <alpine.LNX.2.00.1211272123370.3933@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jan-Matthias Braun <jan_braun@gmx.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

On Tuesday, November 27, 2012 09:26:11 PM Jiri Kosina wrote:
> On Sun, 25 Nov 2012, Jan-Matthias Braun wrote:
> 
> > Hi all,
> > 
> > sorry for the e-mail address hopping. Answers to both addresses are okay.
> > 
> > I have now done a git bisection from 3.0 to 3.1 and have found commit
> > 1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race conditions between runtime PM and system sleep (v2)
> > to be the first one to introduce the necessity of a module reload after resume.
> > 
> > I hope that this helps in finding a solution. As I (again) don't immediatly know how to go on, I kindly ask you to give me some hints for testing/patching or even a possible solution. :-)
> > In the meat time I would leave out the bisection between kernel versions 3.5 and 3.6, except the case that you think this would be helpful for further diagnoses.
> > 
> > Cheers,
> 
> Let's add Rafael to CC then.
> 
> Rafael, could you please take a look? If you find the below unreadable, 
> the whole thread can be seen in linux-input archive at
> 
> 	http://www.spinics.net/lists/linux-input/msg23675.html

Thanks for the pointer, I'll have a look at it tomorrow.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
