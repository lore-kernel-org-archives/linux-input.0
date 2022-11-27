Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B9C46467
	for <linux-input@archiver.kernel.org>; Sun, 27 Nov 2022 14:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiK0O26 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiK0O25 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 27 Nov 2022 09:28:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB6DFFA
        for <linux-input@vger.kernel.org>; Sun, 27 Nov 2022 06:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD49BB80ADD
        for <linux-input@vger.kernel.org>; Sun, 27 Nov 2022 14:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C13C433D7;
        Sun, 27 Nov 2022 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669559333;
        bh=1SwKjxr+K6YyjREEqd1X60aPy6gpeA8Bj9Fhi8pp6vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYEEZ3neR0rAObvN09WJNwxdKX6QIQZ71jJwAVgv1OG2VaYywgGeS7JgQG9oJCYXj
         7J/wxxzdgkv68ziurBQK7DYx9DyFVtGbSG17EgdCRlNTdGNVXdSf9noa4qRhTG64da
         QIDiTv9MiGq0lv8eRatmkXQDfWb0RecF48HWV9cIUf9nOBhx/9zMWlL7YR5i1zG22f
         Zle4w7ZPaECfwG7YwUAm/0d7t1qla3lPPR6vLErII+DiGWyMlWtueljw9fCeVs26H/
         xcH+PoHVYaBbNHu1bJPwaPAYwIQh6bgCz03U2WH74yRU2EmTn7DxeH2pOAkhmcemKG
         dGTMaJ2tYk2IA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomohiro Yoshidomi <sylph23k@gmail.com>
Subject: [PATCH 1/9] Input: psxpad - Fix padding for DMA safe buffers.
Date:   Sun, 27 Nov 2022 14:41:08 +0000
Message-Id: <20221127144116.1418083-2-jic23@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221127144116.1418083-1-jic23@kernel.org>
References: <20221127144116.1418083-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

On some architectures (e.g. arm64), ____cachline_aligned only aligns
to the cacheline size of the L1 cache size. L1_CACHE_BYTES in
arch64/include/asm/cache.h  Unfortunately DMA safety on these
architectures requires the buffer no share a last level cache cacheline
given by ARCH_DMA_MINALIGN which has a greater granularity.
ARCH_DMA_MINALIGN is not defined for all architectures, but when it is
defined it is used to set the size of ARCH_KMALLOC_MINALIGN
to allow DMA safe buffer allocations.

As such the correct alignment requirement is
__aligned(ARCH_KMALLOC_MINALIGN).
This has recently been fixed in other subsystems such as IIO.

Fixes: 8be193c7b1f4 ("Input: add support for PlayStation 1/2 joypads connected via SPI")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomohiro Yoshidomi <sylph23k@gmail.com>
---
 drivers/input/joystick/psxpad-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index a32656064f39..8098d205b58d 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -65,8 +65,8 @@ struct psxpad {
 	bool motor2enable;
 	u8 motor1level;
 	u8 motor2level;
-	u8 sendbuf[0x20] ____cacheline_aligned;
-	u8 response[sizeof(PSX_CMD_POLL)] ____cacheline_aligned;
+	u8 sendbuf[0x20] __aligned(ARCH_KMALLOC_MINALIGN);
+	u8 response[sizeof(PSX_CMD_POLL)] __aligned(ARCH_KMALLOC_MINALIGN);
 };
 
 static int psxpad_command(struct psxpad *pad, const u8 sendcmdlen)
-- 
2.38.1

