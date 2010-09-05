From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 5/8] IR: extend MCE keymap.
Date: Mon,  6 Sep 2010 01:22:41 +0300
Message-ID: <1283725364-4053-6-git-send-email-maximlevitsky@gmail.com>
References: <1283725364-4053-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34156 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0IEWW7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Sep 2010 18:22:59 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so2219369fxm.19
        for <linux-input@vger.kernel.org>; Sun, 05 Sep 2010 15:22:58 -0700 (PDT)
In-Reply-To: <1283725364-4053-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lirc-list@lists.sourceforge.net
Cc: Jarod Wilson <jarod@wilsonet.com>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>

These keys are found on remote bundled with
Toshiba Qosmio F50-10q.

Found and tested by, Sami R <maesesami@gmail.com>

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 drivers/media/IR/keymaps/rc-rc6-mce.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/media/IR/keymaps/rc-rc6-mce.c b/drivers/media/IR/keymaps/rc-rc6-mce.c
index 64264f7..39557ad 100644
--- a/drivers/media/IR/keymaps/rc-rc6-mce.c
+++ b/drivers/media/IR/keymaps/rc-rc6-mce.c
@@ -19,6 +19,7 @@ static struct ir_scancode rc6_mce[] = {
 
 	{ 0x800f0416, KEY_PLAY },
 	{ 0x800f0418, KEY_PAUSE },
+	{ 0x800f046e, KEY_PLAYPAUSE },
 	{ 0x800f0419, KEY_STOP },
 	{ 0x800f0417, KEY_RECORD },
 
@@ -37,6 +38,8 @@ static struct ir_scancode rc6_mce[] = {
 	{ 0x800f0411, KEY_VOLUMEDOWN },
 	{ 0x800f0412, KEY_CHANNELUP },
 	{ 0x800f0413, KEY_CHANNELDOWN },
+	{ 0x800f043a, KEY_BRIGHTNESSUP },
+	{ 0x800f0480, KEY_BRIGHTNESSDOWN },
 
 	{ 0x800f0401, KEY_NUMERIC_1 },
 	{ 0x800f0402, KEY_NUMERIC_2 },
-- 
1.7.0.4

