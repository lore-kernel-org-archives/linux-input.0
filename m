From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/3] Input: fix typo error in MELFAS touch device
 driver
Date: Thu, 29 May 2014 00:05:09 -0700
Message-ID: <20140529070509.GA11817@core.coreip.homeip.net>
References: <537D3E90.1020805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60018 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275AbaE2HFM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 03:05:12 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so12397836pad.30
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 00:05:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537D3E90.1020805@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Thu, May 22, 2014 at 09:02:24AM +0900, Beomho Seo wrote:
> This patchset fix typo error in MELFAS touch device drivers.
> 
> Changes in v2:
> - Add patch set for mms114 and mcs5000_ts drivers.
> 
> Beomho Seo (3):
>   Input: mcs_touchkey: fix incorrect input device name
>   Input: mms114: fix incorrect input device name
>   Input: mcs5000_ts: fix incorrect input device name

Applied all 3, thank you.

> 
>  drivers/input/keyboard/mcs_touchkey.c  |    2 +-
>  drivers/input/touchscreen/mcs5000_ts.c |    2 +-
>  drivers/input/touchscreen/mms114.c     |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 1.7.9.5

-- 
Dmitry
