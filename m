From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm831x-ts - Default pressure measurements on
Date: Wed, 9 Mar 2011 14:28:13 +0000
Message-ID: <20110309142813.GA24877@opensource.wolfsonmicro.com>
References: <1299679112-15245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110309141139.GA5482@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40249 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756974Ab1CIO2P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 09:28:15 -0500
Content-Disposition: inline
In-Reply-To: <20110309141139.GA5482@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Wed, Mar 09, 2011 at 03:11:39PM +0100, Henrik Rydberg wrote:

> > -	wm831x_ts->pressure = pdata && pdata->pressure;
> > +	if (pdata)
> > +		wm831x_ts->pressure = pdata->pressure;
> > +	else
> > +		wm831x_ts->pressure = true;

> wm831x_ts->pressure = !pdata || pdata->pressure;

> should suffice.

It does have some substantial drawbacks in terms of legibility, though.
