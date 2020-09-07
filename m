Return-Path: <SRS0=pnPe=CQ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD3C43461
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619D321D40
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496401;
	bh=Cez5YrJMd+kRD6GKDOhBagZay32pDINJhG2yn//Ywjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KFBaKgekksGfNhwiY0Hx2kHKblC4k8mDAhl0AYMIHwpuA0kNKYonkn03Q+/dZWuJq
	 /X6owdCjLB8knyHCaVad53FmekESZz+9BQZHD+EtVpnmU0TwoYkXtzO49Sww4I6TP0
	 c+1qPuh5Ngujwtg3EBceTdGqGn0vpR0/4guIGbtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgIGQdU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbgIGQdL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CBE21789;
        Mon,  7 Sep 2020 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496391;
        bh=Cez5YrJMd+kRD6GKDOhBagZay32pDINJhG2yn//Ywjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZr+XwSSAKRIy8uDQkeQIwr5YI2rihR70lNYJD9PKtNHnTtLV2zfkwS1RNadGGUjK
         6J/u9XIx5YIqx8AhGJFE+2KTcCwwWAZTW3UaA8prXdTVVaCrmM4odlweP6+mINp5CB
         ekS3I8imtG7V8JaEpI6diayOgZUccY9OkpbEXmvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 40/53] HID: elan: Fix memleak in elan_input_configured
Date:   Mon,  7 Sep 2020 12:32:06 -0400
Message-Id: <20200907163220.1280412-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit b7429ea53d6c0936a0f10a5d64164f0aea440143 ]

When input_mt_init_slots() fails, input should be freed
to prevent memleak. When input_register_device() fails,
we should call input_mt_destroy_slots() to free memory
allocated by input_mt_init_slots().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-elan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 45c4f888b7c4e..dae193749d443 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -188,6 +188,7 @@ static int elan_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	ret = input_mt_init_slots(input, ELAN_MAX_FINGERS, INPUT_MT_POINTER);
 	if (ret) {
 		hid_err(hdev, "Failed to init elan MT slots: %d\n", ret);
+		input_free_device(input);
 		return ret;
 	}
 
@@ -198,6 +199,7 @@ static int elan_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (ret) {
 		hid_err(hdev, "Failed to register elan input device: %d\n",
 			ret);
+		input_mt_destroy_slots(input);
 		input_free_device(input);
 		return ret;
 	}
-- 
2.25.1

