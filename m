Return-Path: <SRS0=mZiH=6B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D291CC2D0EF
	for <linux-input@archiver.kernel.org>; Fri, 17 Apr 2020 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB264221F4
	for <linux-input@archiver.kernel.org>; Fri, 17 Apr 2020 20:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgDQUU2 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:20:28 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46971 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUU1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Apr 2020 16:20:27 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id CACBE40002;
        Fri, 17 Apr 2020 20:20:23 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v5 2/5] dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
Date:   Fri, 17 Apr 2020 22:28:56 +0200
Message-Id: <20200417202859.35427-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417202859.35427-1-contact@artur-rojek.eu>
References: <20200417202859.35427-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Introduce support for touchscreen channels found in JZ47xx SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
---

 Changes:

 v2-v5: no change

 include/dt-bindings/iio/adc/ingenic,adc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 42f871ab3272..95e20a8d6dc8 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -7,5 +7,7 @@
 #define INGENIC_ADC_AUX		0
 #define INGENIC_ADC_BATTERY	1
 #define INGENIC_ADC_AUX2	2
+#define INGENIC_ADC_TOUCH_XP	3
+#define INGENIC_ADC_TOUCH_YP	4
 
 #endif
-- 
2.26.1

