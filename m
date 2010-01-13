From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Questions about Multi-touch Protocal
Date: Thu, 14 Jan 2010 08:25:06 +1000
Message-ID: <20100113222506.GA14525@barra.bne.redhat.com>
References: <4B42D998.4050303@samsung.com>
 <4B432BDB.3000103@euromail.se>
 <4B43DE36.6000907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:44470 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab0AMW0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 17:26:43 -0500
Content-Disposition: inline
In-Reply-To: <4B43DE36.6000907@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz

On Wed, Jan 06, 2010 at 09:49:58AM +0900, Joonyoung Shim wrote:
> >> First, what is the purpose of ABS_MT_TOUCH_MAJOR event? I wonder how
> >> it is used at userspace side.
> > 
> > In a graphical program it can of course be used as is, but in the specific
> > application of creating gesture events, the TOUCH and WIDTH parameters can be
> > used to, e.g., approximate finger pressure or distinguish between index finger
> > and thumb. With the addition of the MINOR parameters, one can also distinguish
> > between a sweeping finger and a pointing finger, and with ORIENTATION, one can
> > detect twisting of fingers.
> > 
> >> Should the ABS_MT_TOUCH_MAJOR be the mininum set of events for multi
> >> touch? I'm not sure whether this question is valid because of first
> >> question.
> > 
> > Each finger packet should have an ABS_MT_TOUCH_MAJOR value. In can be computed
> > from various types of sensory input, e.g., the size of the contact area or a
> > pressure sensor.
> > 
> 
> Hmm, I think ABS_MT_TOUCH_MAJOR is similar to ABS_PRESSURE, of course it
> can be used other purposes. If the device doesn't support the pressure,
> the driver doesn't report ABS_PRESSURE, so if the device cannot get a
> touching size of the finger, how can the driver report it?

Note that ABS_MT_TOUCH_MAJOR complements ABS_PRESSURE but cannot substitute
it. The nature of our fingures usually mean that with increasing pressure
the touch size increases as the finger flattens. This is only useful as a
relative indicator though, as fingers differ greatly in size.

Cheers,
  Peter
