From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: kernel panic in spi_complete() on spitz (PXA270)
Date: Thu, 30 Jun 2011 08:59:58 -0700
Message-ID: <20110630155957.GF3249@opensource.wolfsonmicro.com>
References: <1308845380.4533.54.camel@oct.suse.cz>
 <201106301352.21684.marek.vasut@gmail.com>
 <1309445118.4406.47.camel@oct.suse.cz>
 <4E0C957F.8080807@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54791 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750999Ab1F3QAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jun 2011 12:00:04 -0400
Content-Disposition: inline
In-Reply-To: <4E0C957F.8080807@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Stanislav Brabec <utx@penguin.cz>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, zaurus-devel@lists.linuxtogo.org, spi-devel-general@lists.sourceforge.net, vapier@gentoo.org, khilman@deeprootsystems.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org

On Thu, Jun 30, 2011 at 06:25:51PM +0300, Igor Grinberg wrote:
> On 06/30/11 17:45, Stanislav Brabec wrote:

> > from this thread. Without it, ADS7846 does not work on spitz (ADS7846
> > does not have any dedicated regulator there). I want to
> > add .needs_regulator bool to ads7846.c and send the patch again to the
> > list.

> Please, don't...
> I thought we've finished discussing the regulator issue...

> Instead of patching the driver and the platform data and the board file,
> you should do _either_ of the following:
> 1) add regulator definition for ads7846 into the board file
> 2) enable the CONFIG_REGULATOR_DUMMY in your kernel configuration
> 3) use regulator_use_dummy_regulator() call in the board file.

> Using either of the above, you will not need the patch for ads7846, only for the board file.

Yes, we've been through this repeatedly.  None of these options take any
appreciable time to implement, it'd be much more productive to just do
so.
