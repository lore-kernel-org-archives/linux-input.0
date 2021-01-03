Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5101C433E0
	for <linux-input@archiver.kernel.org>; Sun,  3 Jan 2021 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF20208BA
	for <linux-input@archiver.kernel.org>; Sun,  3 Jan 2021 21:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhACVmo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbhACVmn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 3 Jan 2021 16:42:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C405207FB;
        Sun,  3 Jan 2021 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710123;
        bh=f5HRcpwYvpNIh4GkApBvbGLSbjNDVAx2sRZN2aNxuA0=;
        h=From:To:Cc:Subject:Date:From;
        b=AtkVVqe4hJXqaOSLdEf2zRhmdbYTBPFPgW6qaPfzPrIGKm6h+bPe/Ejp7ZdNNGn+h
         GC5+En6ajNRjYxT1PnTdr/+jMRDDUs4YGp/8Hv/DhFbRS9Xco+ELClcvd36Gl1xfNZ
         JsfZLKBpGkqgFpkQPbYPHXE9Gdad0MyFtIs6pKZd8ygnM/0yPpcSm1l2CjKzc+eNgZ
         rZbhxs0HvXgftE/om8VIfWmdaQXp7vPZ0MCZjR5w9v2g0chUxpqSQq8mhFa39xYFlH
         HciGXcCaFMd8geu4eWtraaKTso7XJOdTr6kNWBmYM7sRWeNPx8fMFyP+IviTN6LOR7
         B6amMtWc9gAtA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rishi Gupta <gupt21@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: sony: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:41:44 +0100
Message-Id: <20210103214159.1996262-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without crc32 support, this driver fails to link:

arm-linux-gnueabi-ld: drivers/hid/hid-sony.o: in function `sony_raw_event':
hid-sony.c:(.text+0x8f4): undefined reference to `crc32_le'
arm-linux-gnueabi-ld: hid-sony.c:(.text+0x900): undefined reference to `crc32_le'
arm-linux-gnueabi-ld: drivers/hid/hid-sony.o:hid-sony.c:(.text+0x4408): more undefined references to `crc32_le' follow

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7bdda1b5b221..09fa75a2b289 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -899,6 +899,7 @@ config HID_SONY
 	depends on NEW_LEDS
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
+	select CRC32
 	help
 	Support for
 
-- 
2.29.2

