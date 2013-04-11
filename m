From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - Place SIMPLE_DEV_PM_OPS inside CONFIG_PM_SLEEP if block
Date: Thu, 11 Apr 2013 07:45:06 -0700
Message-ID: <15d0acb8-e4f3-410f-8507-273d31ff3854@email.android.com>
References: <1365657360-877-1-git-send-email-festevam@gmail.com> <a9c28a66-b5e7-4e83-9d6a-d2c680d0ca1a@email.android.com> <CAOMZO5C_QW_BWCqNufs7BT5Cx4OZMULp0vvqOUfL3Y5nME14GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:53484 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932712Ab3DKOpK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Apr 2013 10:45:10 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so887809pdj.5
        for <linux-input@vger.kernel.org>; Thu, 11 Apr 2013 07:45:09 -0700 (PDT)
In-Reply-To: <CAOMZO5C_QW_BWCqNufs7BT5Cx4OZMULp0vvqOUfL3Y5nME14GQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Fabio Estevam <festevam@gmail.com> wrote:

>Hi Dmitry,
>
>On Thu, Apr 11, 2013 at 2:28 AM, Dmitry Torokhov
><dmitry.torokhov@gmail.com> wrote:
>> Fabio Estevam <festevam@gmail.com> wrote:
>>
>>>From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>>SIMPLE_DEV_PM_OPS should be inside the CONFIG_PM_SLEEP 'if' block
>>>because
>>>imx_kbd_suspend and imx_kbd_resume definitions are inside this block.
>>
>> No, it does not. It compiles just fine if CONFIG_PM_SLEEP is not
>defined.
>
>I am not sure how to disable CONFIG_PM_SLEEP properly in the
>defconfig, but I did this quick test to simulate it:
>
>--- a/drivers/input/keyboard/imx_keypad.c
>+++ b/drivers/input/keyboard/imx_keypad.c
>@@ -536,7 +536,7 @@ static int imx_keypad_probe(struct platform_device
>*pdev)
>        return 0;
> }
>
>-#ifdef CONFIG_PM_SLEEP
>+#if 0

This is not the same thing as SIMPLE_DEV_PM_OPS change their definition depending on CONFIG_PM_SLEEP.


Thanks.

-- 
Dmitry
