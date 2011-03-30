From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] fix crash in synaptics_module_init()
Date: Wed, 30 Mar 2011 17:05:38 +0100
Message-ID: <4D9370F202000078000392A9@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: stable@kernel.org, dtor@mail.ru, dilinger@queued.net

'struct dmi_system_id' arrays must always have a terminator to keep
dmi_check_system() from looking at data (and possibly crashing) it
isn't supposed to look at.

The issue went unnoticed until ef8313bb1a22e7d2125d9d758aa8a81f1de91d81,
but was introduced about a year earlier with
7705d548cbe33f18ea7713b9a07aa11047aaeca4 (which also similarly changed
lifebook.c, but the problem there got eliminated shortly afterwards).

The first hunk therefore is a stable candidate back to 2.6.33, while
the full change is needed only on 2.6.38.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Andres Salomon <dilinger@queued.net>
Cc: stable@kernel.org 

---
 drivers/input/mouse/synaptics.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 2.6.39-rc1/drivers/input/mouse/synaptics.c
+++ 2.6.39-rc1-mouse-synaptics-dmi/drivers/input/mouse/synaptics.c
@@ -836,8 +836,8 @@ static const struct dmi_system_id __init
 		},
 
 	},
-	{ }
 #endif
+	{ }
 };
 
 static bool broken_olpc_ec;
@@ -851,8 +851,8 @@ static const struct dmi_system_id __init
 			DMI_MATCH(DMI_PRODUCT_NAME, "XO"),
 		},
 	},
-	{ }
 #endif
+	{ }
 };
 
 void __init synaptics_module_init(void)



