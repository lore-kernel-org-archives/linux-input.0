From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Wed, 20 Jul 2016 22:25:42 +0200
Message-ID: <20160720202542.GB2290@amd>
References: <20160720014424.GI19250@dtor-ws>
 <20160720065405.GD3792@amd>
 <20160720164503.GB25655@dtor-ws>
 <201607201856.51367@pali>
 <20160720170412.GC25655@dtor-ws>
 <20160720171449.GD25655@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46960 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781AbcGTUZp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 16:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20160720171449.GD25655@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Aaro Koskinen <aaro.koskinen@iki.fi>

On Wed 2016-07-20 10:14:49, Dmitry Torokhov wrote:
> Input: tsc200x - report proper input_dev name
> 
> From: Michael Welling <mwelling@ieee.org>
> 
> Passes input_id struct to the common probe function for the tsc200x drivers
> instead of just the bustype.
> 
> This allows for the use of the product variable to set the input_dev->name
> variable according to the type of touchscreen used. Note that when we
> introduced support for TSC2004 we started calling everything TSC200X, so
> let's keep this quirk.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
