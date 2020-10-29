Return-Path: <SRS0=X7PX=EE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEAFC55179
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14FC21655
	for <linux-input@archiver.kernel.org>; Thu, 29 Oct 2020 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgJ2RPm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:15:42 -0400
Received: from goliath.siemens.de ([192.35.17.28]:36929 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RPm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Oct 2020 13:15:42 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 09TH45pC011922
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 18:04:05 +0100
Received: from dev.vm7.ccp.siemens.com ([139.22.33.215])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id 09TH45WF002436;
        Thu, 29 Oct 2020 18:04:05 +0100
Received: from mail2.siemens.de (localhost [127.0.0.1])
        by dev.vm7.ccp.siemens.com (Postfix) with ESMTP id 122DD70FF87;
        Thu, 29 Oct 2020 18:04:05 +0100 (CET)
From:   Andrej Valek <andrej.valek@siemens.com>
To:     nick@shmanahar.org, hadess@hadess.net, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrej Valek <andrej.valek@siemens.com>
Subject: [PATCH 1/3] Input: goodix - add option to disable firmware loading
Date:   Thu, 29 Oct 2020 18:03:11 +0100
Message-Id: <20201029170313.25529-2-andrej.valek@siemens.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029170313.25529-1-andrej.valek@siemens.com>
References: <20201029170313.25529-1-andrej.valek@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Firmware file loadind for GT911 controller takes too much time (~60s).
There is no check that configuration is the same which is already present.
This happens always during boot, which makes touchscreen unusable.

Add there an option to prevent firmware file loading, but keep it enabled
by default.

Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
---
 drivers/input/touchscreen/goodix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 02c75ea385e08..44336ecd2acdf 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -941,7 +941,9 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 	default:
 		if (ts->gpiod_int && ts->gpiod_rst) {
 			ts->reset_controller_at_probe = true;
-			ts->load_cfg_from_disk = true;
+			/* Prevent cfg loading for each start */
+			ts->load_cfg_from_disk = !device_property_read_bool(dev,
+						 "touchscreen-do-not-load-fw");
 			ts->irq_pin_access_method = IRQ_PIN_ACCESS_GPIO;
 		}
 	}
-- 
2.20.1

