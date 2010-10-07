From: Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH 2/3] keyboard,
	kdb: inject SYN events in kbd_clear_keys_helper
Date: Thu,  7 Oct 2010 15:35:47 -0500
Message-ID: <1286483748-1171-3-git-send-email-jason.wessel@windriver.com>
References: <1286483748-1171-1-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <1286483748-1171-1-git-send-email-jason.wessel@windriver.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: dmitry.torokhov@gmail.com
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Maxim Levitsky <maximlevitsky@gmail.com>

The kbd_clear_keys_helper injects the keyup events alright, but it
doesn't inject SYN events, and therefore X evdev driver doesn't pick
these injected events untill next SYN event.

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 drivers/char/keyboard.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 0c6c641..7df6af5 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -368,6 +368,7 @@ static int kbd_clear_keys_helper(struct input_handle *handle, void *data)
 {
 	unsigned int *keycode = data;
 	input_inject_event(handle, EV_KEY, *keycode, 0);
+	input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
 	return 0;
 }
 
-- 
1.6.3.3


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
