From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: TPS6507X - add MFD dependency
Date: Mon, 11 Jul 2011 23:40:23 +0900
Message-ID: <20110711144020.GC31424@opensource.wolfsonmicro.com>
References: <4E1B05B8.1020006@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33974 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752653Ab1GKOkc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 10:40:32 -0400
Content-Disposition: inline
In-Reply-To: <4E1B05B8.1020006@visionsystems.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Mon, Jul 11, 2011 at 04:16:24PM +0200, Yegor Yefremov wrote:
> touchscreen unit is only working if mfd device is activated, so
> define it as dependency. I2C dependency is obsolete, cause
> TPS6507X itself depends on it.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
