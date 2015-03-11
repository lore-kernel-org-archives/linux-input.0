From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
Date: Wed, 11 Mar 2015 10:46:37 +0100
Message-ID: <1426067197.4244.41.camel@x220>
References: <Jonathan Richardson <jonathar@broadcom.com>
	 <1426036669-21659-1-git-send-email-jonathar@broadcom.com>
	 <1426036669-21659-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:59151 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755AbbCKJqk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 05:46:40 -0400
In-Reply-To: <1426036669-21659-2-git-send-email-jonathar@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Scott Branden <sbranden@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, Joe Perches <joe@perches.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

One nit is all I can report.

On Tue, 2015-03-10 at 18:17 -0700, Jonathan Richardson wrote:
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
 
> +config TOUCHSCREEN_IPROC
> +	tristate "IPROC touch panel driver support"
> +	help
> +	  Say Y here if you want to add support for the IPROC touch
> +	  controller to your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called iproc-ts.

The module will be called "bcm_iproc_tsc", won't it?

> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile

> +obj-$(CONFIG_TOUCHSCREEN_IPROC)		+= bcm_iproc_tsc.o


Paul Bolle

