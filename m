From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make the dummy touchkit_ps2_detect() static
Date: Tue, 14 Aug 2007 23:22:52 +0200
Message-ID: <20070814212252.GF18945@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The dummy touchkit_ps2_detect() for the CONFIG_MOUSE_PS2_TOUCHKIT=n case 
shouldn't be a global function.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
64d15c53e66b200d832a6009aa24c344883bcbcf 
diff --git a/drivers/input/mouse/touchkit_ps2.h b/drivers/input/mouse/touchkit_ps2.h
index 61e9dfd..8a0dd35 100644
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
