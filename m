Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C7EB64D9
	for <linux-input@archiver.kernel.org>; Thu, 29 Jun 2023 21:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjF2VlX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjF2VlW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2023 17:41:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9D2D71;
        Thu, 29 Jun 2023 14:41:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1327938f8f.0;
        Thu, 29 Jun 2023 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688074879; x=1690666879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlwouPfcUKeU2liu8ipQl7VYxOU9K6yP4hsdhfdrrEo=;
        b=Hoo8acKR2XDr9/IhwMf5ve0jYOXSoJNTu+9SuoPFg2TyvYwiecGifT4T/QmaOH1i+S
         UwTVJWO7ZjV1OQjaV0ZC9CNXrn+SI5+EMRenGBELeD3wHxVwBQBpj1DNmyotSYoDrHRC
         RTQSJBQBS31CgwM9D668XvI7hL21VQZVpQ1vR2O4lF81T9ULxJLsOqKcUelfNpd2nQZ5
         PdEYAWBw8gwTCDOhmNPggXddjdXfASk4OU0USyy8fi4I6f0XFDgHstzwwJFxZcCXP966
         NsJrtCN0J+K9A7J5aunMvyJ8I7mkbHeHvm6Om8Lx97zCCLQNIzqOeLxtwo1Tj/UJl5l8
         0KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074879; x=1690666879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlwouPfcUKeU2liu8ipQl7VYxOU9K6yP4hsdhfdrrEo=;
        b=OEimfayLisciOT0j1F0Ky30ebMum6A6jzAdtK3yoZobS1Dd3V1nWhNsDFVEjlz4GI7
         rktzUXY91ZxqqDOYsCq4vLzYGZaYxBsA2zOQmR0STTkG1eXtwifFImpO0obz5J/YezBC
         uToZp45JMTF3da8/VypJBt5ceknx4VDKk6WwU6gdQql5NHegyfWk9/EATMJc43B4+OK5
         loamQG6o6+99pYTzaA/VPLY0UVp5bOYOQepAur41AQzWb8fl7bqsbIz35+GXo7lcja9K
         KezTAPv8HWHszvzz3VJ8qfA458jlkwucv2fGqVLHhhCxTIV7iGe+PEeRDFVXRGEjOsQb
         89uw==
X-Gm-Message-State: ABy/qLaQjl60/o8V6sSlhHCIgkj0NNRuICUk1muWmI/rbuLZHw46fLWf
        Fx6GsZFVFXn/xGqsyfUM/7j9SDSnrNffzg==
X-Google-Smtp-Source: APBJJlEfWfr/Lg+TsX5r9PZPUIQUlI0VZwrBjD4uxXCDqLB+XIS8Hr1GZ1kD6nkHm5SlvKP+rbeflQ==
X-Received: by 2002:a5d:6546:0:b0:314:17c0:79d4 with SMTP id z6-20020a5d6546000000b0031417c079d4mr644302wrv.14.1688074879137;
        Thu, 29 Jun 2023 14:41:19 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id a25-20020a5d4579000000b003048477729asm16735651wrc.81.2023.06.29.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:41:18 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>
Subject: [PATCH] HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed
Date:   Thu, 29 Jun 2023 22:40:12 +0100
Message-ID: <20230629214011.987303-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
References: <20230629192422.980071-1-stuart.a.hayhurst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Previously, support for the G502 had been attempted in commit 27fc32f.
This caused some issues and was reverted by addf338.
Since then, a new version of this mouse has been released (Lightpseed Wireless), and works correctly.

This device has support for battery reporting with the driver

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5e1a412fd28f..94a045ef8e50 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4598,6 +4598,8 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.40.1.521.gf1e218fcd8

