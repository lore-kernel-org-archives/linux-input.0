From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 7/10] iio: lpc32xx-adc: Remove driver conflict due to
 device tree
Date: Wed, 18 Apr 2012 15:02:26 -0700
Message-ID: <20120418220226.GA8035@kroah.com>
References: <1334756176-25144-1-git-send-email-stigge@antcom.de>
 <1334756176-25144-8-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2DRWCb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 18:02:31 -0400
Received: by pbcun15 with SMTP id un15so9458002pbc.19
        for <linux-input@vger.kernel.org>; Wed, 18 Apr 2012 15:02:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334756176-25144-8-git-send-email-stigge@antcom.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, thierry.reding@avionic-design.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, devel@driverdev.osuosl.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, dan.carpenter@oracle.com

On Wed, Apr 18, 2012 at 03:36:12PM +0200, Roland Stigge wrote:
> Previously, the touchscreen and ADC drivers of the LPC32xx SoC had a Kconfig
> conflict declared because they use the same hardware. Upon the introduction of
> device tree support in both drivers, the conflict must be removed to enable
> the same kernel to support different hardware (configured via the device tree).
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

