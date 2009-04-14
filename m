From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: [PATCH] Input: bf54x-keys: Remove depreciated IRQF_SAMPLE_RANDOM flag
Date: Tue, 14 Apr 2009 10:40:10 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D0A1CB1DB@limkexm3.ad.analog.com>
References: <1236310491-24387-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:23294 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbZDNJkS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2009 05:40:18 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1236310491-24387-1-git-send-email-cooloney@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Hennerich, Michael" <Michael.Hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

diff --git a/drivers/input/keyboard/bf54x-keys.c
b/drivers/input/keyboard/bf54x-keys.c
index c6f4e16..73c4481 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -252,7 +252,7 @@ static int __devinit bfin_kpad_probe(struct
platform_device *pdev)
        }

        error = request_irq(bf54x_kpad->irq, bfin_kpad_isr,
-                                IRQF_SAMPLE_RANDOM, DRV_NAME, pdev);
+                                0 , DRV_NAME, pdev);
        if (error) {
                printk(KERN_ERR DRV_NAME
                        ": unable to claim irq %d; error %d\n",

