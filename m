From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Wed, 20 Jul 2016 04:26:44 +0300
Message-ID: <20160720012644.GA3126@blackmetal.musicnaut.iki.fi>
References: <20160717175257.GA26719@amd>
 <20160717182445.GA20058@deathstar>
 <20160717184209.GA30119@amd>
 <20160717185134.GA20462@deathstar>
 <20160717200339.GA29562@amd>
 <20160717225636.GB20462@deathstar>
 <20160719235120.GD19250@dtor-ws>
 <20160720003908.GA32423@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:53224 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbcGTB0t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2016 21:26:49 -0400
Content-Disposition: inline
In-Reply-To: <20160720003908.GA32423@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

On Tue, Jul 19, 2016 at 07:39:08PM -0500, Michael Welling wrote:
> On Tue, Jul 19, 2016 at 04:51:20PM -0700, Dmitry Torokhov wrote:
> > On Sun, Jul 17, 2016 at 05:56:36PM -0500, Michael Welling wrote:
> > > On Sun, Jul 17, 2016 at 10:03:39PM +0200, Pavel Machek wrote:
> > > > Ok, thanks for the information. I believe changing it back to
> > > > "TSC2005" version makes sense (and then fixing it in stable).
> > 
> > Do we know how many users are affected?
> 
> Anyone with an old N900 and the smarts to update the kernel.

I think tsc2005 could be also used on N810.

A.
