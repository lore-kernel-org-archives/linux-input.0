From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: psmouse: "bad data from KBD - bad parity" every 2ms with
 synaptics touchpad
Date: Wed, 2 Nov 2011 07:46:34 +0100
Message-ID: <20111102064634.GA4559@polaris.bitmath.org>
References: <20111030195253.3248.82914.reportbug@debian>
 <20111030203044.GB18681@elie.hsd1.il.comcast.net>
 <CAAyXcGAC5W5md17=V5rx-kaL7PTmBig4a-4ZhRvAVLVZ7wWzSg@mail.gmail.com>
 <20111031092748.GB24978@elie.hsd1.il.comcast.net>
 <CAAyXcGCz0Z8xkEin5DVhTa8p6Jc8oOtgghH2EWoSaLrRqCzWdg@mail.gmail.com>
 <CAAyXcGDOsmp+PVhHZx3JFjApF2_UbE8dr8jnHKJNDEm5=bWrzA@mail.gmail.com>
 <20111101080210.GB4566@elie.hsd1.il.comcast.net>
 <CAJm2B-kA63Tifyifd0mRwhaVcr-vdrvk+UGnFHnKwX4=77WL+A@mail.gmail.com>
 <20111101193458.GA10933@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:60221 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab1KBGhR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 02:37:17 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 0F03DE9359
	for <linux-input@vger.kernel.org>; Wed,  2 Nov 2011 07:37:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111101193458.GA10933@elie.hsd1.il.comcast.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Damjan Jovanovic <damjan.jov@gmail.com>, linux-input@vger.kernel.org, Arvind K <arvindkhadri@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Peter Hutterer <peter.hutterer@who-t.net>

On Tue, Nov 01, 2011 at 02:34:58PM -0500, Jonathan Nieder wrote:
> Damjan Jovanovic wrote:
> 
> > Maybe that touchpad doesn't send proper parity. See what we did in commit
> > 6b9d363c49d22395d0cf8729c5963f83cfbb6d69, and try to disable parity
> > checking for that touchpad the same way?
> 
> Sure, though it would be nice to understand the problem better first.
> 
> So:
> 
>  - Arvind, could you say a little more about when this started
>    happening[1]?  Did you change your configuration, or was there any
>    upgrade around the same time (/var/log/dpkg.log* should say)?  Any
>    idea why this wasn't always happening from the start?
> 
>  - Others, any idea what information would be useful to track this
>    further?  Are there tools or patches for tracing what the kernel
>    gets told by the touchpad, so we could see the nature of these
>    parity errors?
> 
>  - Is there a dump or cache of bugzilla.kernel.org available anywhere?
>    I would like to look at bug#6105 (referred to by 6b9d363c) in case
>    it points to some hints or useful debugging tools.

I would check for spurious DKMS packages as well.

Henrik
