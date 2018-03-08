From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH] Input: i8042: add Lenovo ThinkPad L460 to i8042 reset list
Date: Thu, 8 Mar 2018 17:35:14 +0100
Message-ID: <3063cecf-a893-6c0e-06cd-dfe325c45e2f@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Reset i8042 before probing because of insufficient
BIOS initialisation of the i8042 serial controller.
This makes synaptics touchpad detection possible.
Without resetting the synaptics touchpad is not detected
because there are always NACK messages from AUX port.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 6cbbdc6..7755134 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -627,6 +627,13 @@ static inline void i8042_write_command(int val)
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
 		},
 	},
+	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+	},
 	{ }
 };
 
-- 
1.9.1
