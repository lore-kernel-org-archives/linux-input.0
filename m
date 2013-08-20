From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mc13xxx-ts: use zero as default value if no pdata was
 defined
Date: Tue, 20 Aug 2013 03:34:33 +0200
Message-ID: <20130820013433.GE13324@zurbaran>
References: <1376396070-24507-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40676 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab3HTBej (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Aug 2013 21:34:39 -0400
Content-Disposition: inline
In-Reply-To: <1376396070-24507-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Michael,

On Tue, Aug 13, 2013 at 02:14:30PM +0200, Michael Grzeschik wrote:
> In case of devicetree, we currently don't have a way to append pdata for
> the touchscreen. The current approach is to bail out in that case.
> This patch makes it possible to probe the touchscreen without pdata
> and use zero as default values for the atox and ato adc conversion.
Would that still make the touchscreen somehow functional ?
If that's the case, and if Dmitry is fine with the ts part of this
patch, could you please separate the mfd part of this patch into a
separate one ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
