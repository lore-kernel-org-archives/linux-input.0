Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFBC433DB
	for <linux-input@archiver.kernel.org>; Tue, 23 Mar 2021 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889AC619B9
	for <linux-input@archiver.kernel.org>; Tue, 23 Mar 2021 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWJjS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:39:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCWJjK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Mar 2021 05:39:10 -0400
Received: from linux-e202.suse.de ([46.90.47.149]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mzhzd-1lbTS92LAX-00vebx; Tue, 23 Mar 2021 10:39:08 +0100
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, dt.tangr@gmail.com
Subject: [PATCH] input: nspire-keypad: enable interrupts only when opened
Date:   Tue, 23 Mar 2021 10:39:05 +0100
Message-ID: <3383725.iizBOSrK1V@linux-e202.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:rs1x3opKy42tMOk9Vc7BKsWk5ijx6ULXO0M8g/LOK1nkqZw1jGg
 pw6hkylOUjmDZ5YIajuZnAQIBNqP+BDQrMYjaZD13OzR/KktFcQsTJTjsZfZHjeGquJVJnX
 G+CkqzURYKZxNL8HDW2CYq/sfj4uVhP8V/2MSskG7wsRsYHpYmiAYmWhOQ+Igf3A+MXl2x6
 JES6adgecqK/vKoObBW0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p4n4GD+PvF4=:iRo6VKffI06EQ9YhwoSPVg
 p7fHpxGaLIkmVZxjzavvCdrBhjyizEBbnZxzXMFRUbYS1UxFBcIa6gGCBMwovWnaS2wwv4tFX
 gat8GGmSic77Gg22zQK5eyF0yoFfvemp4usSeH0DWxrXy7P0YQODAsXOHQoG1D9fEX3u0mQX9
 QUwQcpRrHOnhUK1zVqYxCL0rm8wyDJhC+2MhwDoXTkIs7pQii0CQjxO5/7nUBn726bHf9+yYV
 Oqt/nu56531eYo0t1nF51/oVHn79f0TRwO0Nr88SyMlTvmKFQUBU/zxHkhvy6emKmTMYK3q7z
 tXlgNknfzDNPazDfk4wgfsM8m2siL15pYn5L6NclR6ieJYz+myb4KTO7NJIQdb/O6J+YTDsGG
 LtHSUcVofnrkOKY6OXeHZzllHfj5r2HZzduY08VE8JZ5l+dWYMWxBhGzqPiTCMBnNoYc2ZHkm
 yn2qL2xNlQ==
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The driver registers an interrupt handler in _probe, but didn't configure
them until later when the _open function is called. In between, the keypad
can fire an IRQ due to touchpad activity, which the handler ignores. This
causes the kernel to disable the interrupt, blocking the keypad from
working.

Fix this by disabling interrupts before registering the handler.
Additionally, disable them in _close, so that they're only enabled while
open.

Fixes: fc4f31461892 ("Input: add TI-Nspire keypad support")
Signed-off-by: Fabian Vogt <fabian@ritter-vogt.de>
---
 drivers/input/keyboard/nspire-keypad.c | 56 ++++++++++++++------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index 63d5e488137d..e9fa1423f136 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -93,9 +93,15 @@ static irqreturn_t nspire_keypad_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int nspire_keypad_chip_init(struct nspire_keypad *keypad)
+static int nspire_keypad_open(struct input_dev *input)
 {
+	struct nspire_keypad *keypad = input_get_drvdata(input);
 	unsigned long val = 0, cycles_per_us, delay_cycles, row_delay_cycles;
+	int error;
+
+	error = clk_prepare_enable(keypad->clk);
+	if (error)
+		return error;
 
 	cycles_per_us = (clk_get_rate(keypad->clk) / 1000000);
 	if (cycles_per_us == 0)
@@ -121,30 +127,6 @@ static int nspire_keypad_chip_init(struct nspire_keypad *keypad)
 	keypad->int_mask = 1 << 1;
 	writel(keypad->int_mask, keypad->reg_base + KEYPAD_INTMSK);
 
-	/* Disable GPIO interrupts to prevent hanging on touchpad */
-	/* Possibly used to detect touchpad events */
-	writel(0, keypad->reg_base + KEYPAD_UNKNOWN_INT);
-	/* Acknowledge existing interrupts */
-	writel(~0, keypad->reg_base + KEYPAD_UNKNOWN_INT_STS);
-
-	return 0;
-}
-
-static int nspire_keypad_open(struct input_dev *input)
-{
-	struct nspire_keypad *keypad = input_get_drvdata(input);
-	int error;
-
-	error = clk_prepare_enable(keypad->clk);
-	if (error)
-		return error;
-
-	error = nspire_keypad_chip_init(keypad);
-	if (error) {
-		clk_disable_unprepare(keypad->clk);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -152,6 +134,11 @@ static void nspire_keypad_close(struct input_dev *input)
 {
 	struct nspire_keypad *keypad = input_get_drvdata(input);
 
+	/* Disable interrupts */
+	writel(0, keypad->reg_base + KEYPAD_INTMSK);
+	/* Acknowledge existing interrupts */
+	writel(~0, keypad->reg_base + KEYPAD_INT);
+
 	clk_disable_unprepare(keypad->clk);
 }
 
@@ -210,6 +197,25 @@ static int nspire_keypad_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	error = clk_prepare_enable(keypad->clk);
+	if (error) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		return error;
+	}
+
+	/* Disable interrupts */
+	writel(0, keypad->reg_base + KEYPAD_INTMSK);
+	/* Acknowledge existing interrupts */
+	writel(~0, keypad->reg_base + KEYPAD_INT);
+
+	/* Disable GPIO interrupts to prevent hanging on touchpad */
+	/* Possibly used to detect touchpad events */
+	writel(0, keypad->reg_base + KEYPAD_UNKNOWN_INT);
+	/* Acknowledge existing GPIO interrupts */
+	writel(~0, keypad->reg_base + KEYPAD_UNKNOWN_INT_STS);
+
+	clk_disable_unprepare(keypad->clk);
+
 	input_set_drvdata(input, keypad);
 
 	input->id.bustype = BUS_HOST;
-- 
2.25.1




