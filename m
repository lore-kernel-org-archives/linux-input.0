From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 1/2] Input: Add keycodes for some missing Fn key combinations
Date: Sat, 17 May 2014 16:43:36 +0200
Message-ID: <1400337817-14473-2-git-send-email-pali.rohar@gmail.com>
References: <201405171639.45722@pali>
 <1400337817-14473-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <1400337817-14473-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-hotplug-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-hotplug@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

There are already defined some Fn key combinations, but not all.
This patch adds missing combinations for support in dell-wmi driver.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 include/uapi/linux/input.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index f484952..3a32799 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -672,6 +672,12 @@ struct input_keymap_entry {
 #define KEY_FN_F		0x1e2
 #define KEY_FN_S		0x1e3
 #define KEY_FN_B		0x1e4
+#define KEY_FN_Q		0x1e5
+#define KEY_FN_W		0x1e6
+#define KEY_FN_R		0x1e7
+#define KEY_FN_T		0x1e8
+#define KEY_FN_A		0x1e9
+#define KEY_FN_G		0x1ea
=20
 #define KEY_BRL_DOT1		0x1f1
 #define KEY_BRL_DOT2		0x1f2
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-hotplug=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
