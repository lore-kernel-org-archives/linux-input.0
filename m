From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make the dummy touchkit_ps2_detect() static
Date: Mon, 27 Aug 2007 23:28:12 +0200
Message-ID: <20070827212812.GU4121@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The dummy touchkit_ps2_detect() for the CONFIG_MOUSE_PS2_TOUCHKIT=n case 
shouldn't be a global function.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

This patch has been sent on:
- 14 Aug 2007

--- a/drivers/input/mouse/touchkit_ps2.h
+++ b/drivers/input/mouse/touchkit_ps2.h
@@ -15,7 +15,8 @@
 #ifdef CONFIG_MOUSE_PS2_TOUCHKIT
 int touchkit_ps2_detect(struct psmouse *psmouse, int set_properties);
 #else
-inline int touchkit_ps2_detect(struct psmouse *psmouse, int set_properties)
+static inline int touchkit_ps2_detect(struct psmouse *psmouse,
+				      int set_properties)
 {
 	return -ENOSYS;
 }
