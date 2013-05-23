From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 09:32:52 -0700
Message-ID: <20130523163252.GD15494@core.coreip.homeip.net>
References: <002601ce579f$af006ba0$0d0142e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62005 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3EWQcz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 12:32:55 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so1250586pdb.12
        for <linux-input@vger.kernel.org>; Thu, 23 May 2013 09:32:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <002601ce579f$af006ba0$0d0142e0$@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org

On Thu, May 23, 2013 at 07:24:18PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> Also, unnecessary dev_set_drvdata() is removed, because the driver core
> clears the driver data to NULL after device_release or on probe failure.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied both, thanks.

-- 
Dmitry
