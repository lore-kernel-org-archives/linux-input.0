Return-Path: <SRS0=Jdnn=A7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44496C4167B
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E6122BF5
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281143;
	bh=YtDnHAVbA9/a5sdIs/kcn/Sqz1wweEJKvU0Wv/lqQr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iI6g5oMZq5iE7SaCqqAtlCD2CLCZ8tROBkuPFo2BgJ0ZFvliAmoLrbRtRZ+4JZHGx
	 e3BSnczLZf6LfI0+9fVjX5ct8Td/d4p/Hh0MiSwhQRwJiZz+18yYUrL6i0tdrs51+P
	 cOa0F4n5dhVOBkoQwcSBrerEQUFmIwDf/d2WG+0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGTVjB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgGTVi7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Jul 2020 17:38:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACD922C7B;
        Mon, 20 Jul 2020 21:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281139;
        bh=YtDnHAVbA9/a5sdIs/kcn/Sqz1wweEJKvU0Wv/lqQr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqJk2vzlYQKNXaMYcMbD0z8GZciNOLjY4JEuD7w+FsXS/lpeDqx8rWGWDDRRemR9f
         +IKsoXuCsMPx+CATVOXjKKAkY7WUPTgdB2nxECtGYiax6F0ajTMji9GETyyfqIzhwl
         OqzDdUoBQAOYO42akAe6YY4b3Ta0VXcDdD5AxH7w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/19] Input: add `SW_MACHINE_COVER`
Date:   Mon, 20 Jul 2020 17:38:37 -0400
Message-Id: <20200720213851.407715-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213851.407715-1-sashal@kernel.org>
References: <20200720213851.407715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Merlijn Wajer <merlijn@wizzup.org>

[ Upstream commit c463bb2a8f8d7d97aa414bf7714fc77e9d3b10df ]

This event code represents the state of a removable cover of a device.
Value 0 means that the cover is open or removed, value 1 means that the
cover is closed.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
Link: https://lore.kernel.org/r/20200612125402.18393-2-merlijn@wizzup.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mod_devicetable.h        | 2 +-
 include/uapi/linux/input-event-codes.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 84e4e20352d9f..610cdf8082f2e 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -299,7 +299,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_SW_MAX		0x10
 #define INPUT_DEVICE_ID_PROP_MAX	0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 61a5799b440b9..c3e84f7c8261a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -795,7 +795,8 @@
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
-#define SW_MAX			0x0f
+#define SW_MACHINE_COVER	0x10  /* set = cover closed */
+#define SW_MAX			0x10
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
2.25.1

