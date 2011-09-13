From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] TSC-40: Improve EEPROM error handling
Date: Tue, 13 Sep 2011 10:50:32 +0200
Message-ID: <20110913085032.GC27776@linutronix.de>
References: <CAH9NwWcH3LyQ4D3eEXKRF78EC5eCt4C_N956L6oEHEjhujybow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36325 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab1IMIud (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:50:33 -0400
Content-Disposition: inline
In-Reply-To: <CAH9NwWcH3LyQ4D3eEXKRF78EC5eCt4C_N956L6oEHEjhujybow@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

* Christian Gmeiner | 2011-09-13 10:18:41 [+0200]:

>diff --git a/drivers/input/touchscreen/tsc40.c
>b/drivers/input/touchscreen/tsc40.c
>index b73ef2f..d914522 100644
>--- a/drivers/input/touchscreen/tsc40.c
>+++ b/drivers/input/touchscreen/tsc40.c
>@@ -49,7 +49,6 @@ struct tsc_ser {
>
> #define RESPONSE_ACK   0x06
>#define RESPONSE_NAK    0x15
>-#define NACK_DETAIL_NT (1 << 3)
>
> #define ID_EPROM_UNUSED        (1 << 7)
>
>@@ -96,11 +95,25 @@ static void handle_reset(struct serio *serio,
>unsigned char data)
>
>       /* NAK + EEPROM available */
>       if (ptsc->idx == 1) {
>-               if (!(data & NACK_DETAIL_NT)) {
>+               if (data & (1 << 0)) {
>+                       dev_warn(&serio->dev, "EEPROM data empty\n");
>+                       state_after_reset(ptsc, 1);
>+                       return;
>+               } else if (data & (1 << 1)) {
>+                       dev_warn(&serio->dev, "EEPROM data abnormal\n");
>                       state_after_reset(ptsc, 0);
>                       return;
>-               }
>-               state_after_reset(ptsc, 0);
>+               } else if (data & (1 << 2)) {
>+                       dev_warn(&serio->dev, "EEPROM write error\n");
>+                       state_after_reset(ptsc, 0);
>+                       return;
>+               } else if (data & (1 << 3)) {
>+                       dev_warn(&serio->dev, "Touch screen not connected\n");
>+                       state_after_reset(ptsc, 0);
>+                       return;
>+               } else
>+                       BUG_ON(1);
>+

That BUG() isn't really nice. Since you in probe at this time, couldn't
you print something and abort loading the driver?

Sebastian
