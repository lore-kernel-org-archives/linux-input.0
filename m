Return-Path: <SRS0=LNck=AR=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A232EC433E0
	for <linux-input@archiver.kernel.org>; Mon,  6 Jul 2020 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E87220672
	for <linux-input@archiver.kernel.org>; Mon,  6 Jul 2020 23:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+/4in86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGFXux (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFXuw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2020 19:50:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D8C061755
        for <linux-input@vger.kernel.org>; Mon,  6 Jul 2020 16:50:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f16so7312310pjt.0
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2020 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5yLMA0bO8aht8FZuYrcOO7KiK+q7Iemo//4lIfDKr8=;
        b=Q+/4in86Ak5nmQ4TbwEh515hpfyJnt5gGVfPFEd9TBvTTlOKyFmFyb4FELvoKnJk43
         V21F/NEjRxaUA0/zdadSwkREh+zFcJ8cmE+Vmh6WCt59I9RhkPc7XSq2jHN/H/wXTw+I
         eV9E48qqlXNFqhuReljhaecu8nVXIhU5wJMy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5yLMA0bO8aht8FZuYrcOO7KiK+q7Iemo//4lIfDKr8=;
        b=FCnCl4QEkE5j8WvovfhiGwY2bLA1eWt8D+ISwU6hSw8RvJKa6TM8U90LjVoE/6LZJR
         +LToaz6icKanL+yHg+9UR+OxkDtb5r9EDmQQijkZLdW8H1BW5Yi2jZzXdmH6BuS10Pdm
         qf0r6agLxzgbqc3b9/8NX+Yo5NbqOTQduRGer2bp+JcbbJ7j++PIeTXVDlGrM8TQpCP3
         KM9T9dnbpmwwLMvMQ+fmArcNvez8/M5Ers1bF/BbfWVZ2YlZqDfS7dfECC3NTPSgmYJV
         QVWta988wt1EpTfhw12YOEUZQlvSRPWclf0Y00a74LtIcjNkMnfU9NAFuwoz2nR8lS2Q
         wfWg==
X-Gm-Message-State: AOAM5316k3aWilLqbzK2SS8NGtEOUywXpdA9kjajmgVBVeCEYOaUUu5L
        ++2yuAuCjP6Z3GbEbu6l5hhumA==
X-Google-Smtp-Source: ABdhPJy+yxD6OOrCEcOHK/yg0PlZi6enOIQCgawxTWjD5FwuHWhQw2N2Uy0V5gMVPVW1IOLbak7xVA==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr45379828pls.29.1594079451057;
        Mon, 06 Jul 2020 16:50:51 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:a28c:fdff:feeb:4a32])
        by smtp.gmail.com with ESMTPSA id c27sm20014383pfj.163.2020.07.06.16.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:50:50 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, jiada_wang@mentor.com,
        dmitry.torokhov@gmail.com, dbasehore@chromium.org
Subject: [PATCH v2] Input: elan_i2c - only increment wakeup count on touch
Date:   Mon,  6 Jul 2020 16:50:46 -0700
Message-Id: <20200706235046.1984283-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This moves the wakeup increment for elan devices to the touch report.
This prevents the drivers from incorrectly reporting a wakeup when the
resume callback resets then device, which causes an interrupt to
occur.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/input/mouse/elan_i2c_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3f9354baac4b..6291fb5fa015 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -951,6 +951,8 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	u8 hover_info = packet[ETP_HOVER_INFO_OFFSET];
 	bool contact_valid, hover_event;
 
+	pm_wakeup_event(&data->client->dev, 0);
+
 	hover_event = hover_info & 0x40;
 	for (i = 0; i < ETP_MAX_FINGERS; i++) {
 		contact_valid = tp_info & (1U << (3 + i));
@@ -974,6 +976,8 @@ static void elan_report_trackpoint(struct elan_tp_data *data, u8 *report)
 	u8 *packet = &report[ETP_REPORT_ID_OFFSET + 1];
 	int x, y;
 
+	pm_wakeup_event(&data->client->dev, 0);
+
 	if (!data->tp_input) {
 		dev_warn_once(&data->client->dev,
 			      "received a trackpoint report while no trackpoint device has been created. Please report upstream.\n");
@@ -998,7 +1002,6 @@ static void elan_report_trackpoint(struct elan_tp_data *data, u8 *report)
 static irqreturn_t elan_isr(int irq, void *dev_id)
 {
 	struct elan_tp_data *data = dev_id;
-	struct device *dev = &data->client->dev;
 	int error;
 	u8 report[ETP_MAX_REPORT_LEN];
 
@@ -1016,8 +1019,6 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	if (error)
 		goto out;
 
-	pm_wakeup_event(dev, 0);
-
 	switch (report[ETP_REPORT_ID_OFFSET]) {
 	case ETP_REPORT_ID:
 		elan_report_absolute(data, report);
@@ -1026,7 +1027,7 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 		elan_report_trackpoint(data, report);
 		break;
 	default:
-		dev_err(dev, "invalid report id data (%x)\n",
+		dev_err(&data->client->dev, "invalid report id data (%x)\n",
 			report[ETP_REPORT_ID_OFFSET]);
 	}
 
-- 
2.27.0.383.g050319c2ae-goog

