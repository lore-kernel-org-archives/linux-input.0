From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Enable ADC Filter on UCB1400
Date: Tue, 4 Aug 2009 05:51:35 +0200
Message-ID: <200908040551.35532.marek.vasut@gmail.com>
References: <200907301922.24818.marek.vasut@gmail.com> <20090803191600.EA5CC526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60457 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbZHDDvx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2009 23:51:53 -0400
Received: by bwz19 with SMTP id 19so2840966bwz.37
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2009 20:51:53 -0700 (PDT)
In-Reply-To: <20090803191600.EA5CC526EA5@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, sameo@linux.intel.com

Dne Po 3. srpna 2009 21:15:41 Dmitry Torokhov napsal(a):
> On Thu, Jul 30, 2009 at 07:22:24PM +0200, Marek Vasut wrote:
> > Hi!
> >
> > please consider applying the following patch. I tested it on Palm
> > Tungsten|C (ADCSYNC connected, both disabled and enabled through module
> > parameter) and a friend of mine tested it on Toradex Colibri (ADCSYNC not
> > connected, disabled).
> >
> > Thanks
> >
> > From 65cb92df1aba511fbc44d62fa25d5cf38a687952 Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Thu, 30 Jul 2009 19:03:10 +0200
> > Subject: [PATCH] Enable ADC Filter on UCB1400
> >
> > This patch enables ADC filtering on UCB1400 codec by default. The
> > benefit from this change is mostly on some Colibri boards where the
> > ADCSYNC pin of the UCB1400 codec isn't connected causing the touchscreen
> > to jitter very badly. This change has no visible effect on boards where
> > the ADCSYNC pin is connected.
>
> I wonder if it would not be safer to only enable filtering if platform
> requests it (via platform data)?

Hi!

It'd be much safer, yes. But:
1) as I said, this has no side effects (yes, this sounds like a very strong 
argument, I know ;-) ).
2) Im still waiting for Eric Miao to make his way through the 'passing 
platform data to devices on the ac97 bus' thread in alsa-ML. This basically 
means, there's currently no way to pass platform data to ac97 devices. Of 
course, this driver (ucb1400) wont be the only one which will get special 
patching treatment once those AC97 patches are in.

btw. I hope Eric can make it before .32

Thanks!
