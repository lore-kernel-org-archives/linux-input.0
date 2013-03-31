From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: ad714x - add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Sun, 31 Mar 2013 00:31:31 -0700
Message-ID: <20130331073131.GD7919@core.coreip.homeip.net>
References: <003a01ce293f$c70c3eb0$5524bc10$%han@samsung.com>
 <003b01ce293f$ea9a9200$bfcfb600$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:59082 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666Ab3CaHbe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Mar 2013 03:31:34 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so696113dak.11
        for <linux-input@vger.kernel.org>; Sun, 31 Mar 2013 00:31:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <003b01ce293f$ea9a9200$bfcfb600$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org, 'Michael Hennerich' <michael.hennerich@analog.com>

On Mon, Mar 25, 2013 at 07:02:53PM +0900, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
> 
> drivers/input/misc/ad714x-i2c.c:17:12: warning: 'ad714x_i2c_suspend' defined but not used [-Wunused-function]
> drivers/input/misc/ad714x-i2c.c:22:12: warning: 'ad714x_i2c_resume' defined but not used [-Wunused-function]
> drivers/input/misc/ad714x-spi.c:20:12: warning: 'ad714x_spi_suspend' defined but not used [-Wunused-function]
> drivers/input/misc/ad714x-spi.c:25:12: warning: 'ad714x_spi_resume' defined but not used [-Wunused-function]
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied both, thank you Jingoo.

-- 
Dmitry
