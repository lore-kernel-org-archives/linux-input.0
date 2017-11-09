From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH v2 3/5] Input: add KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 9 Nov 2017 23:44:34 +0100
Message-ID: <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The key has the same use as the SW_ROTATE_LOCK, but is used on devices
where the state is not tracked by the hardware but has to be handled
in software.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

---

Changes in v2:
- New patch, add support for KEY_ROTATE_LOCK_TOGGLE

 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index f4058bd4c373..ba5d709a8923 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -593,6 +593,7 @@
 #define BTN_DPAD_RIGHT		0x223
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
+#define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
-- 
2.15.0
