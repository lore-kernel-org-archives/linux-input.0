From: Igor Murzov <intergalactic.anonymous@gmail.com>
Subject: [PATCH] Input: i8042 - add Lenovo Ideapad U455 to 'reset' blacklist
Date: Thu, 2 Feb 2012 18:22:25 +0400
Message-ID: <20120202182225.68666279@garik>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50347 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab2BBOWe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2012 09:22:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Igor Murzov <e-mail@date.by>, Tomas Miljenovic <TomasM@tomasm.tk>, Ike Panhc <ike.pan@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey V <sftp.mtuci@gmail.com>

>From 2d5a38a56453421e82428155f4b00303f3fb19b2 Mon Sep 17 00:00:00 2001
From: Igor Murzov <e-mail@date.by>
Date: Wed, 1 Feb 2012 03:11:53 +0400
Subject: [PATCH] Input: i8042 - add Lenovo Ideapad U455 to 'reset' blacklist

Lenovo Ideapad U455 needs to be in the reset quirk list for its
touchpad's proper function.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=40672

Signed-off-by: Igor Murzov <e-mail@date.by>
---
 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index b4cfc6c..5ec774d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -512,6 +512,13 @@ static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
 		},
 	},
+	{
+		/* Lenovo Ideapad U455 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
+		},
+	},
 	{ }
 };
 
-- 
1.7.5.1

