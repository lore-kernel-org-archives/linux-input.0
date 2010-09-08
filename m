From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH v3 1/1] input: add support for Nomadik SKE keypad controller
Date: Wed, 8 Sep 2010 16:19:45 +0200
Message-ID: <AANLkTinYfUVGignRSA+GPWz4yHothgm6TTyt7ruMvmS9@mail.gmail.com>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
	<4C8645CB.9070206@codeaurora.org>
	<33A307AF30D7BF4F811B1568FE7A9B181C8565B5@EXDCVYMBSTM006.EQ1STM.local>
	<4C87885C.70704@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0IHOTr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 10:19:47 -0400
Received: by qwh6 with SMTP id 6so34576qwh.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 07:19:47 -0700 (PDT)
In-Reply-To: <4C87885C.70704@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

2010/9/8 Trilok Soni <tsoni@codeaurora.org>:
> [Sundar]
>> Yes it can. I am seeing increasing tendency to migrate to threaded_irq from the legacy irq recently
>> and hence the threaded request.
>
> Use threaded_irq only when needed with different flags and not everywhere. In this case we don't
> need threaded irq at all.

Look closer at the IRQ handler:

+static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
(...)
+       /*
+        * if KPASON is not ready, we cannot read data registers
+        * so wait for a debounce period; if still not settled,
+        * we fire a timer and exit the IRQ
+        */
+       while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && timeout--)
+               cpu_relax();

Active polling. Surely you want this to be preemptible? Thus ->
threaded handler.

Yours,
Linus Walleij
