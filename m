From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: User-space interface to read/write touchscreen controller
 registers (atmel_mxt_ts.c)
Date: Wed, 27 Jul 2011 13:49:20 +0100
Message-ID: <20110727124920.GF300@sirena.org.uk>
References: <4E2968ED.4030708@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44548 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab1G0MtW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2011 08:49:22 -0400
Content-Disposition: inline
In-Reply-To: <4E2968ED.4030708@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, Jul 22, 2011 at 03:11:25PM +0300, Iiro Valkonen wrote:

Please fix your mail client to word wrap within paragraphs.  I've
reformatted your text for legibility.

> we have a need to access the configuration registers/register blocks
> of the touchscreen controller from the user space. There are several
> reasons for this, and while some of them are related to debugging,
> some can be valuable in normal use cases. For example, a configuration
> parameter might need to be semi-permanently changed to improve
> performance, or some parameter could even be updated for different
> usage modes of the device. This interface would make it very easy.
> Currently, a change in the board file and kernel recompile is needed
> to change the settings. 

For diagnostic access the regmap API was merged during this merge
window, it provides debugfs access to the register map.  That doesn't
help with the coefficient data but it should be enough for debugging.
