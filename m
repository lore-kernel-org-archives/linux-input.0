From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] Add chip driver for WM9705 touchscreen
Date: Thu, 28 Feb 2008 11:46:33 +0000
Message-ID: <20080228114633.GA20092@rakim.wolfsonmicro.main>
References: <12040332183316-git-send-email-broonie@opensource.wolfsonmicro.com> <12040332181161-git-send-email-broonie@opensource.wolfsonmicro.com> <20080227230932.3e7f699c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57873 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751741AbYB1Lqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Feb 2008 06:46:35 -0500
Content-Disposition: inline
In-Reply-To: <20080227230932.3e7f699c.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, Pete MacKay <linux01@architechnical.net>, Ian Molton <spyro@f2s.com>, Vince Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>

On Wed, Feb 27, 2008 at 11:09:32PM -0800, Andrew Morton wrote:
> On Tue, 26 Feb 2008 13:40:14 +0000 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > + *
> > + * Adjust this value if you are having problems with pen detect not
> > + * detecting any down events.
> > + */
> > +static int pdd = 8;
> > +module_param(pdd, int, 0);
> > +MODULE_PARM_DESC(pdd, "Set pen detect comparator threshold");

> I guess that's all the documentation we get ;) It won't kill us - we've done
> worse..

> It would be rather nice if the kerneldoc system could extract the above
> comments and put them in a module-parameters-documentation section, but I
> don't think it can do that.

What would be really nice for this application would be a way to pass
platform data to devices enumerated by non-platform buses - most of the
time these parameters are determined by the board the system is on.  In
that case we'd be able to provide kerneldoc for the struct used to pass
in platform data.

> > +	if (timeout <= 0) {

> timeout cannot be negative here.

Fixed, thanks.
