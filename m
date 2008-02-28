From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/6] Add chip driver for WM9712 touchscreen
Date: Thu, 28 Feb 2008 13:07:34 +0000
Message-ID: <20080228130734.GB20092@rakim.wolfsonmicro.main>
References: <12040332183316-git-send-email-broonie@opensource.wolfsonmicro.com> <12040332181161-git-send-email-broonie@opensource.wolfsonmicro.com> <12040332181394-git-send-email-broonie@opensource.wolfsonmicro.com> <20080227230937.e3e0fb41.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51521 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755616AbYB1NHh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Feb 2008 08:07:37 -0500
Content-Disposition: inline
In-Reply-To: <20080227230937.e3e0fb41.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Mike Arthur <mike.arthur@wolfsonmicro.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>, Stanley Cai <stanley.cai@intel.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, Pete MacKay <linux01@architechnical.net>, Ian Molton <spyro@f2s.com>, Vince Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>

On Wed, Feb 27, 2008 at 11:09:37PM -0800, Andrew Morton wrote:

> I assume we don't support more than one attached device per host?

Yes.

> If so, is that a problem?  One could envisage an application with lots
> of screens attached to one Linux box.

Indeed, but it's fairly unlikely that such an application would do so
using multiple instances of these particular controllers.  They are all
primary-only devices so having more than one of them in the system
requires multiple AC97 controllers which is pretty unusual.  They're
also multi function devices with audio CODECs as well - people would be
relatively unlikely to use them for the touchscreen functionality alone.

If someone does come up with an application which needs more than one of
these we can deal with it then but it's not an issue for most applications.
