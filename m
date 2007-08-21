From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] 10-dots braille keyboards
Date: Tue, 21 Aug 2007 02:38:03 +0200
Message-ID: <20070821003803.GB3658@interface.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

Some braille keyboards have 10 dots, so extend the Input braille keys
definitions.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/include/linux/input.h b/include/linux/input.h
index e02c6a6..17df5a7 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -552,6 +552,8 @@ struct input_absinfo {
 #define KEY_BRL_DOT6		0x1f6
 #define KEY_BRL_DOT7		0x1f7
 #define KEY_BRL_DOT8		0x1f8
+#define KEY_BRL_DOT9		0x1f9
+#define KEY_BRL_DOT10		0x1fa
 
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
diff --git a/include/linux/keyboard.h b/include/linux/keyboard.h
index de76843..7ddbc30 100644
--- a/include/linux/keyboard.h
+++ b/include/linux/keyboard.h
@@ -437,8 +437,10 @@ extern unsigned short plain_map[NR_KEYS];
 #define K_BRL_DOT6      K(KT_BRL, 6)
 #define K_BRL_DOT7      K(KT_BRL, 7)
 #define K_BRL_DOT8      K(KT_BRL, 8)
+#define K_BRL_DOT9      K(KT_BRL, 9)
+#define K_BRL_DOT10     K(KT_BRL, 10)
 
-#define NR_BRL		9
+#define NR_BRL		11
 
 #define MAX_DIACR	256
 #endif
