From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V1] input: fix memory leak in da9052 touchscreen driver
Date: Wed, 08 Jan 2014 09:26:16 -0800
Message-ID: <7aad8e91-f5d9-4527-8a94-bc038a9ccd85@email.android.com>
References: <201401081709.s08H9nMr038265@swsrvapps-02.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:58270 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbaAHRnm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 12:43:42 -0500
In-Reply-To: <201401081709.s08H9nMr038265@swsrvapps-02.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anthony Olech <anthony.olech.opensource@diasemi.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Huqiu Liu <liuhq11@mails.tsinghua.edu.cn>, David Dajun Chen <david.chen@diasemi.com>

Anthony Olech <anthony.olech.opensource@diasemi.com> wrote:
>The touchscreen component driver for the da9052/3 Dialog PMICs
>leaks memory by not freeing the input device in the remove call.
>
>This patch matches the existing call to input_alloc_device()
>in da9052_ts_probe() to a new call to input_free_device() in
>da9052_ts_remove()
>
>Suggested-by: Huqiu Liu <liuhq11@mails.tsinghua.edu.cn>
>Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
>---
>This patch is relative to linux-next repository tag next-20140108
>
>Many thanks to Huqiu Liu who found the bug.

No, this is not a bug. Please refer to input API spec in input.h

Thanks.

>
> drivers/input/touchscreen/da9052_tsi.c |    2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/input/touchscreen/da9052_tsi.c
>b/drivers/input/touchscreen/da9052_tsi.c
>index ab64d58..43a69d1 100644
>--- a/drivers/input/touchscreen/da9052_tsi.c
>+++ b/drivers/input/touchscreen/da9052_tsi.c
>@@ -320,6 +320,7 @@ err_free_mem:
> static int  da9052_ts_remove(struct platform_device *pdev)
> {
> 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
>+	struct input_dev *input_dev = tsi->dev;
> 
> 	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> 
>@@ -328,6 +329,7 @@ static int  da9052_ts_remove(struct platform_device
>*pdev)
> 
> 	input_unregister_device(tsi->dev);
> 	kfree(tsi);
>+	input_free_device(input_dev);
> 
> 	return 0;
> }


-- 
Dmitry
