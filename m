From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v4] input: keyboard: Add keys driver for the
 LPC32xx SoC
Date: Thu, 21 Jun 2012 01:56:23 -0700
Message-ID: <20120621085623.GF2193@core.coreip.homeip.net>
References: <1339443891-15197-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37968 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758998Ab2FUI42 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 04:56:28 -0400
Content-Disposition: inline
In-Reply-To: <1339443891-15197-1-git-send-email-stigge@antcom.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: axel.lin@gmail.com, riyer@nvidia.com, michael.hennerich@analog.com, grant.likely@secretlab.ca, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com

On Mon, Jun 11, 2012 at 09:44:51PM +0200, Roland Stigge wrote:
> This patch adds a driver for the key scan interface of the LPC32xx SoC
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> For the DT binding: Acked-by: Rob Herring <rob.herring@calxeda.con>

Not a real review, just a quick question - if th driver is DT-only now
do we need to have the platform data or it would make more sense to read
DT-bindings and fill the main device structure directly?

Thanks.

> +
> +	matrix_keypad_build_keymap(NULL, NULL, kscandat->kscancfg->matrix_sz,
> +				   kscandat->kscancfg->matrix_sz,
> +				   kscandat->kscancfg->keymap, kscandat->input);

This function may fail now.

-- 
Dmitry
