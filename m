From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: ads7846 - use spi_get_drvdata() and
 spi_set_drvdata()
Date: Sun, 7 Apr 2013 21:08:20 -0700
Message-ID: <20130408040820.GB6479@core.coreip.homeip.net>
References: <001d01ce3292$746da5c0$5d48f140$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32792 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3DHEIX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Apr 2013 00:08:23 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so3036525pad.25
        for <linux-input@vger.kernel.org>; Sun, 07 Apr 2013 21:08:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <001d01ce3292$746da5c0$5d48f140$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org

On Sat, Apr 06, 2013 at 03:46:23PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
> can directly pass a struct spi_device.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied all 3, thank you Jingoo.

-- 
Dmitry
