Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E0C433DB
	for <linux-input@archiver.kernel.org>; Thu,  4 Mar 2021 09:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13264EED
	for <linux-input@archiver.kernel.org>; Thu,  4 Mar 2021 09:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhCDJL5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:11:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:11477 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237332AbhCDJLf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 4 Mar 2021 04:11:35 -0500
IronPort-SDR: lEZmVP1rLumsxaHCGqg13pp4W/hRyobzgy81K8tdC+VUOU88XvXM5mdcm0D0voSm5Ac7QaNEJA
 mPWrfCUqLuRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166632761"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="166632761"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 01:09:50 -0800
IronPort-SDR: WxN83qVuvjUselEyWfygPSr4RWxenoNmQjPXz9PdQlawaW69d3ir2/pBZrvrEYIwI038KTZSsf
 vGMDv2XcByHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507284652"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 01:09:48 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: docs - Update according to the latest API changes
Date:   Thu,  4 Mar 2021 12:09:48 +0300
Message-Id: <20210304090948.27014-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The old device property API is about to be removed, so
explaing how to use complete software nodes instead.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/input/devices/rotary-encoder.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/input/devices/rotary-encoder.rst b/Documentation/input/devices/rotary-encoder.rst
index 810ae02bdaa0d..5865748c13b96 100644
--- a/Documentation/input/devices/rotary-encoder.rst
+++ b/Documentation/input/devices/rotary-encoder.rst
@@ -107,13 +107,17 @@ example below:
 		},
 	};
 
-	static const struct property_entry rotary_encoder_properties[] __initconst = {
+	static const struct property_entry rotary_encoder_properties[] = {
 		PROPERTY_ENTRY_U32("rotary-encoder,steps-per-period", 24),
 		PROPERTY_ENTRY_U32("linux,axis",		      ABS_X),
 		PROPERTY_ENTRY_U32("rotary-encoder,relative_axis",    0),
 		{ },
 	};
 
+	static const struct software_node rotary_encoder_node = {
+		.properties = rotary_encoder_properties,
+	};
+
 	static struct platform_device rotary_encoder_device = {
 		.name		= "rotary-encoder",
 		.id		= 0,
@@ -122,7 +126,7 @@ example below:
 	...
 
 	gpiod_add_lookup_table(&rotary_encoder_gpios);
-	device_add_properties(&rotary_encoder_device, rotary_encoder_properties);
+	device_add_software_node(&rotary_encoder_device.dev, &rotary_encoder_node);
 	platform_device_register(&rotary_encoder_device);
 
 	...
-- 
2.30.1

