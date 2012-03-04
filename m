From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: add support for TI Touchscreen controller
Date: Sun, 4 Mar 2012 08:03:17 -0800
Message-ID: <20120304160317.GC27647@core.coreip.homeip.net>
References: <1323430182-27626-1-git-send-email-rachna@ti.com>
 <20111230035521.GD17850@core.coreip.homeip.net>
 <4CE347531D4CA947960AF71FF095B93201B58E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:46055 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab2CDWJj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Mar 2012 17:09:39 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so4191532dad.11
        for <linux-input@vger.kernel.org>; Sun, 04 Mar 2012 14:09:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE347531D4CA947960AF71FF095B93201B58E@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Rachna,

Sorry for not replying earlier.

On Mon, Jan 02, 2012 at 12:21:59PM +0000, Patil, Rachna wrote:
> On Fri, Dec 30, 2011 at 09:25:21, Dmitry Torokhov wrote:
> > -
> > -		if (ts_dev->pen == 0) {
> > -			if ((z1 != 0) && (z2 != 0)) {
> > -				/* cal pressure using formula
> > -				 * Resistance(touch) = x plate resistance *
> > -				 * x postion/4096 * ((z2 / z1) - 1)
> > -				 */
> > -				z = z2 - z1;
> > -				z *= val_x;
> > -				z *= ts_dev->x_plate_resistance;
> > -				z /= z1;
> > -				z = (z + 2047) >> 12;
> > -
> > -				if ((diffx < 15) && (diffy < 15)
> > -						&& (z <= MAX_12BIT)) {
> 
> Using defuzz alone does not solve the problem. I am trying to
> filter out odd random values from the ADC that are incorrect
> (Not only noise). Hence as explained I am using delta algorithm.
> As a part of this algorithm I am checking for value being less than 15.
> 

Ah, yes, I misread the original code. But would not that mean that quick
gestures across the screen (resulting in delta being greater than 15)
would be refused as invalid?

Anyway, tslib (the library that is normally used to interface with
touchscreens) has, among many other useful thngs, a 'variance' filter
that should implement what you are trying to do in kernel. What I am
going to do is apply the version of the driver that does not do the
variance filtering (but still has the delta filtering of data in FIFO
queue). We can revisit doing variance (in kernel or elsewhere) if tslib
is not working fot you at a later time.

Thanks.

-- 
Dmitry
