Return-Path: <SRS0=Maqc=YL=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B81CCA9EA9
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E36222D1
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 22:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436489;
	bh=NwcaHzqZ1lU4FzfoWU8IZZNT9FuebeODGEm+5dugqd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrRrfo251uuRk+dmuMwtWcxdqAdavE9doGsAORlcDgmZuwBh3lxDGVzpKGzm0pq2V
	 QZ6NoZ4N2W9zFJ3QT8fLl1XWNQ+Z0pXHYg6zFwOpFHqIArcqDijjZ1Yk1YeQTh8qbJ
	 SP4NtZOmIHrYcb0Pg9z10kpEs6mldP64wpjc/GvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbfJRWIH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387524AbfJRWIG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Oct 2019 18:08:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4895F205F4;
        Fri, 18 Oct 2019 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436486;
        bh=NwcaHzqZ1lU4FzfoWU8IZZNT9FuebeODGEm+5dugqd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsF8NQtedU68/tgWYtn7QdCspwhbXH4pLWzcmcP5O47emDRtE7p5pC4/DeOwzeFN7
         tnHh5qh1Xn+8NfOQ+FhalC7q+pnnyBg21serAu5dhaF5QXOTrVitVp1A+P4dfmjDSM
         M6KJB+T3CBjMw0Q/vJaa2TS+pivwrx8f1+QoBHzs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Sax <jsbc@gmx.de>, Tim Aldridge <taldridge@mac.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/56] HID: i2c-hid: add Direkt-Tek DTLAPY133-1 to descriptor override
Date:   Fri, 18 Oct 2019 18:07:02 -0400
Message-Id: <20191018220753.10002-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Julian Sax <jsbc@gmx.de>

[ Upstream commit 399474e4c1100bca264ed14fa3ad0d68fab484d8 ]

This device uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override list.

Reported-by: Tim Aldridge <taldridge@mac.com>
Signed-off-by: Julian Sax <jsbc@gmx.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index cac262a912c12..89f2976f9c534 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -330,6 +330,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Direkt-Tek DTLAPY133-1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Direkt-Tek"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "DTLAPY133-1"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Mediacom Flexbook Edge 11",
 		.matches = {
-- 
2.20.1

