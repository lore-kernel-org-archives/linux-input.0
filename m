From: Milind Arun Choudhary <milindchoudhary@gmail.com>
Subject: [KJ][PATCH]SPIN_LOCK_UNLOCKED cleanup in drivers/char/keyboard
Date: Thu, 19 Apr 2007 16:49:02 +0530
Message-ID: <20070419111902.GB11493@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kernel Janitors <kernel-janitors@lists.osdl.org>, INPUT <linux-input@atrey.karlin.mff.cuni.cz>
Cc: Andrw Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

SPIN_LOCK_UNLOCKED cleanup,use __SPIN_LOCK_UNLOCKED instead 

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>

---
 keyboard.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index cb8d691..df9bfc1 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -110,7 +110,7 @@ struct kbd_struct kbd_table[MAX_NR_CONSOLES];
 static struct kbd_struct *kbd = kbd_table;
 
 struct vt_spawn_console vt_spawn_con = {
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = __SPIN_LOCK_UNLOCKED(vt_spawn_con.lock),
 	.pid  = NULL,
 	.sig  = 0,
 };
-- 
Milind Arun Choudhary
