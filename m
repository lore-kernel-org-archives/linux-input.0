Return-Path: <SRS0=iUnu=55=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F1AC2BB86
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DD62073E
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="oIfP/W7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgDMNch (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:32:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:63324 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgDMNcb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Apr 2020 09:32:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4918gJ3Msdz2Fw;
        Mon, 13 Apr 2020 15:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586784748; bh=jOswEKU7i79mQ5w2Qdg1LzFaQcsH2Fj/+9CwRqdDBhA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=oIfP/W7WK9rtawcxXpgxUacPO+mUWJc0+me5sPeB9V13Klk4fPOal+s5hpu5d8b1n
         Ua8EvHv8qhQntZP9WhGU+M4tiGtVXcPOSW5E+mGOF8LEFc57dYLHpbS3Z6bz4JsyxM
         ins+OlgElyASn/FsnT0KcoYHvfhDSLYiSoiJd/6Lfi5bHC3FFkJlcKH+byv1EiZSDB
         J7udXqqht6wQaRohOlLlUbzk5ePf60rqgjU875PnEmEDc+hRFZYEl8jH9lK4LM1zi8
         WnzAEiJhZvAfDyLsjq087p4YPsxU/lBdKoieiWLO2kT4SYQwqMlCltyBYP7NjL+ROO
         KqJAKetufw6kw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 13 Apr 2020 15:32:27 +0200
Message-Id: <69650370cea763a06843020220373fd8086ee01f.1586784389.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1586784389.git.mirq-linux@rere.qmqm.pl>
References: <cover.1586784389.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 9/9] dt-bindings: input: elants-i2c: Document eKTF3624
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Chen <james.chen@emc.com.tw>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Liu <scott.liu@emc.com.tw>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

The eKTF3624 hardware is similar to eKTH3500.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/devicetree/bindings/input/elants_i2c.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/elants_i2c.txt b/Documentation/devicetree/bindings/input/elants_i2c.txt
index 45fab32bbc19..1bc60303f0ea 100644
--- a/Documentation/devicetree/bindings/input/elants_i2c.txt
+++ b/Documentation/devicetree/bindings/input/elants_i2c.txt
@@ -1,7 +1,7 @@
 Elantech I2C Touchscreen
 
 Required properties:
-- compatible: must be "elan,ekth3500".
+- compatible: must be "elan,ekth3500" or "elan,ektf3624".
 - reg: I2C address of the chip.
 - interrupts: interrupt to which the chip is connected (see interrupt
   binding[0]).
-- 
2.20.1

