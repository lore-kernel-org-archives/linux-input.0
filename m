From: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
Subject: [PATCH] input: alps: Add support for the touchpad on Dell Latitude E6410
Date: Sat, 15 May 2010 15:52:04 +0200
Message-ID: <1273931524-15654-1-git-send-email-thomas@archlinux.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerolde.archlinux.org ([66.211.214.132]:50622 "EHLO
	archlinux.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752472Ab0EON7w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 May 2010 09:59:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, alessandro@molarulez.com, =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>

---
 drivers/input/mouse/alps.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 99d5876..0c83070 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -66,6 +66,8 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshiba Tecra A11-11L */
+	{ { 0x73, 0x02, 0x64 }, 0xff, 0xff,
+		ALPS_PASS | ALPS_DUALPOINT },				  /* Dell Latitude E6410 */
 };
 
 /*
-- 
1.7.1

