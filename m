From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: psmouse: "bad data from KBD - bad parity" every 2ms with
 synaptics touchpad
Date: Tue, 1 Nov 2011 23:00:12 -0700
Message-ID: <20111102060012.GB29035@core.coreip.homeip.net>
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
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63691 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1KBGAS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 02:00:18 -0400
Received: by ggnb2 with SMTP id b2so229812ggn.19
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2011 23:00:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111101193458.GA10933@elie.hsd1.il.comcast.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Damjan Jovanovic <damjan.jov@gmail.com>, linux-input@vger.kernel.org, Arvind K <arvindkhadri@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

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

If this was working and then stopped I'd try removing the keyboard and
cleaning and reseating the touchpad connector.

> 
>  - Others, any idea what information would be useful to track this
>    further?  Are there tools or patches for tracing what the kernel
>    gets told by the touchpad, so we could see the nature of these
>    parity errors?

Booting with i8042.debug=1 or doing
"echo 1 > /sys/module/i8042/parameters/debug" will dump all data from
the keyboard controller to dmesg. It is quite a bit though (80 pps @ 6
bytes/packet).

-- 
Dmitry
