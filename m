From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/6] Build system and MAINTAINERS entry for WM97xx
	touchscreen drivers
Date: Wed, 2 Apr 2008 01:04:00 -0400
Message-ID: <20080402050400.GA14189@anvil.corenet.prv>
References: <20080401102825.GA30868@rakim.wolfsonmicro.main> <1207046169-2152-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-2-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-3-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-4-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-5-git-send-email-broonie@opensource.wolfsonmicro.com> <1207046169-2152-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:13238 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbYDBFEH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2008 01:04:07 -0400
Received: by py-out-1112.google.com with SMTP id u52so3539495pyb.10
        for <linux-input@vger.kernel.org>; Tue, 01 Apr 2008 22:04:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1207046169-2152-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Hi Mark,

On Tue, Apr 01, 2008 at 11:36:09AM +0100, Mark Brown wrote:
> +config TOUCHSCREEN_WM9705
> +	bool "WM9705 Touchscreen interface support"
> +	depends on TOUCHSCREEN_WM97XX
> +	help
> +	  Say Y here if you have a Wolfson Microelectronics WM9705 touchscreen
> +	  controller connected to your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called wm9705.

This is not correct. The chip drivers are compiled into wm97xx-ts
module, there is no wm9705 module. I fixed it on my side and
applied the series to wm97xx branch of my input tree. I also moved
changes to Makefile/Kconfig to the appropriate patches instead of
doing bulk update as a separate patch. Please take a look and let
me know if you see anything wrong.

Thank you.


-- 
Dmitry
