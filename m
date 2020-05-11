Return-Path: <SRS0=OZNg=6Z=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CEC54E91
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 14:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2CC20708
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 14:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgEKOF1 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 11 May 2020 10:05:27 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34485 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgEKOF1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 May 2020 10:05:27 -0400
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6C8E7240014;
        Mon, 11 May 2020 14:05:24 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v4 1/5] ARM: at91: add atmel tcb capabilities
Date:   Mon, 11 May 2020 16:05:01 +0200
Message-Id: <20200511140505.1649111-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511140505.1649111-1-kamel.bouhara@bootlin.com>
References: <20200511140505.1649111-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Some atmel socs have extra tcb capabilities that allow using a generic
clock source or enabling a quadrature decoder.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 include/soc/at91/atmel_tcb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200ce151..1d7071dc0bca 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -36,9 +36,14 @@ struct clk;
 /**
  * struct atmel_tcb_config - SoC data for a Timer/Counter Block
  * @counter_width: size in bits of a timer counter register
+ * @has_gclk: boolean indicating if a timer counter has a generic clock
+ * @has_qdec: boolean indicating if a timer counter has a quadrature
+ * decoder.
  */
 struct atmel_tcb_config {
 	size_t	counter_width;
+	bool    has_gclk;
+	bool    has_qdec;
 };
 
 /**
-- 
2.25.0

