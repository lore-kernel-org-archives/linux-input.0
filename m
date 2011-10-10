From: Samuel Ortiz <samuel.ortiz@intel.com>
Subject: Re: [PATCH v2 2/6] MFD: twl6040: Cache the vibra control registers
Date: Mon, 10 Oct 2011 21:04:08 +0200
Message-ID: <20111010190407.GD2592@sortiz-mobl>
References: <1316760584-27426-1-git-send-email-peter.ujfalusi@ti.com>
 <1316760584-27426-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:57263 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab1JJTBC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 15:01:02 -0400
Content-Disposition: inline
In-Reply-To: <1316760584-27426-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org

Hi Peter,

On Fri, Sep 23, 2011 at 09:49:40AM +0300, Peter Ujfalusi wrote:
> The vibra control register will be used from the ASoC codec driver as well.
> In order to avoid latency issues caused by I2C read access, cache the two
> control register within the core driver, so we do not need to reach out
> to the chip to read it back.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

