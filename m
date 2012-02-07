From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Tue, 7 Feb 2012 23:38:24 +0100
Message-ID: <20120207223824.GA15836@polaris.bitmath.org>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se>
 <20120125132612.GA3890@polaris.bitmath.org>
 <4F200D14.80702@gmail.com>
 <20120125150035.GA4222@polaris.bitmath.org>
 <20120130072732.GA1855@core.coreip.homeip.net>
 <4F3113F6.6000403@gmail.com>
 <20120207161231.GA13128@polaris.bitmath.org>
 <4F3192F4.1040401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:36983 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831Ab2BGWgy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2012 17:36:54 -0500
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id B8061C261
	for <linux-input@vger.kernel.org>; Tue,  7 Feb 2012 23:36:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F3192F4.1040401@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

> >>Any hints on how to do this in userspace? Of course I could hack up
> >>xf86-input-evdev, but I'd like to do this at the highest possible
> >>layer, ie the input subsystem.
> >The application you describe could well be implemented in the driver
> >you submitted; a simple handling of the MT data resulting in normal
> >input events.
> 
> Yes, that was my initial idea. But as I had the impression that an
> userspace solution was preferred, I wondered how to solve that.

The conclusion was that as is, the device is unsuitable as an MT
device, needing either further in-kernel conversion or some other,
non-MT way of getting the data to userspace. Converting the data as
you describe, outputting normal input events, falls into the first
category.

Thanks,
Henrik
