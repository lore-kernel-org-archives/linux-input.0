From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyttsp4 - fix potential NULL pointer dereference in cyttsp4_watchdog_timer()
Date: Sun, 25 Aug 2013 22:26:00 -0700
Message-ID: <2cac6f3b-3107-4ead-95e3-f4070b894dc6@email.android.com>
References: <CAPgLHd9YkK2-nqympYoKb+OTWfkND+3SJYGw_vCRbN6VpXWZog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35612 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab3HZF0N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 01:26:13 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so2977958pdj.25
        for <linux-input@vger.kernel.org>; Sun, 25 Aug 2013 22:26:06 -0700 (PDT)
In-Reply-To: <CAPgLHd9YkK2-nqympYoKb+OTWfkND+3SJYGw_vCRbN6VpXWZog@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, javier@dowhile0.org, fery@cypress.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

Wei Yongjun <weiyj.lk@gmail.com> wrote:
>From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
>The dereference should be moved below the NULL test.
>
>Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>---
> drivers/input/touchscreen/cyttsp4_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/input/touchscreen/cyttsp4_core.c
>b/drivers/input/touchscreen/cyttsp4_core.c
>index 963da05..ffa8e35 100644
>--- a/drivers/input/touchscreen/cyttsp4_core.c
>+++ b/drivers/input/touchscreen/cyttsp4_core.c
>@@ -1244,11 +1244,11 @@ static void cyttsp4_watchdog_timer(unsigned
>long handle)
> {
> 	struct cyttsp4 *cd = (struct cyttsp4 *)handle;
> 
>-	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
>-
> 	if (!cd)
> 		return;
> 

Actually this test does not make any sense and we should rather remove it.

>+	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
>+
> 	if (!work_pending(&cd->watchdog_work))
> 		schedule_work(&cd->watchdog_work);
> 

Hi Wei,
Thanks.

-- 
Dmitry
