From: Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH 3/3] sysrq,
	keyboard: properly deal with alt-sysrq in sysrq input filter
Date: Thu,  7 Oct 2010 15:35:48 -0500
Message-ID: <1286483748-1171-4-git-send-email-jason.wessel@windriver.com>
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
Cc: kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch addresses 2 problems:

1) You should still be able to use alt-PrintScreen to capture a grab
   of a single window when the sysrq filter is active.

2) The sysrq filter should reset the low level key mask so that future
   key presses will not show up as a repeated key.  The problem was
   that when you executed alt-sysrq g and then resumed the kernel, you
   would have to press 'g' twice to get it working again.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>
CC: linux-input@vger.kernel.org
Reported-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 drivers/char/sysrq.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index ef31bb8..b1fad74 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -566,6 +566,57 @@ static const unsigned char sysrq_xlate[KEY_MAX + 1] =
 static bool sysrq_down;
 static int sysrq_alt_use;
 static int sysrq_alt;
+static bool sysrq_kbd_triggered;
+
+/*
+ * This function was a copy of input_pass_event but modified to allow
+ * by-passing a specific filter, to allow for injected events without
+ * filter recursion.
+ */
+static void input_pass_event_ignore(struct input_dev *dev,
+			     unsigned int type, unsigned int code, int value,
+			     struct input_handle *ignore_handle)
+{
+	struct input_handler *handler;
+	struct input_handle *handle;
+
+	rcu_read_lock();
+
+	handle = rcu_dereference(dev->grab);
+	if (handle)
+		handle->handler->event(handle, type, code, value);
+	else {
+		bool filtered = false;
+
+		list_for_each_entry_rcu(handle, &dev->h_list, d_node) {
+			if (!handle->open || handle == ignore_handle)
+				continue;
+			handler = handle->handler;
+			if (!handler->filter) {
+				if (filtered)
+					break;
+
+				handler->event(handle, type, code, value);
+
+			} else if (handler->filter(handle, type, code, value))
+				filtered = true;
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Pass along alt-print_screen, if there was no sysrq processing by
+ * sending a key press down and then passing the key up event.
+ */
+static void simulate_alt_sysrq(struct input_handle *handle)
+{
+	input_pass_event_ignore(handle->dev, EV_KEY, KEY_SYSRQ, 1, handle);
+	input_pass_event_ignore(handle->dev, EV_SYN, SYN_REPORT, 0, handle);
+	input_pass_event_ignore(handle->dev, EV_KEY, KEY_SYSRQ, 0, handle);
+	input_pass_event_ignore(handle->dev, EV_SYN, SYN_REPORT, 0, handle);
+}
 
 static bool sysrq_filter(struct input_handle *handle, unsigned int type,
 		         unsigned int code, int value)
@@ -580,9 +631,11 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
 		if (value)
 			sysrq_alt = code;
 		else {
-			if (sysrq_down && code == sysrq_alt_use)
+			if (sysrq_down && code == sysrq_alt_use) {
 				sysrq_down = false;
-
+				if (!sysrq_kbd_triggered)
+					simulate_alt_sysrq(handle);
+			}
 			sysrq_alt = 0;
 		}
 		break;
@@ -590,13 +643,18 @@ static bool sysrq_filter(struct input_handle *handle, unsigned int type,
 	case KEY_SYSRQ:
 		if (value == 1 && sysrq_alt) {
 			sysrq_down = true;
+			sysrq_kbd_triggered = false;
 			sysrq_alt_use = sysrq_alt;
 		}
 		break;
 
 	default:
-		if (sysrq_down && value && value != 2)
+		if (sysrq_down && value && value != 2 && !sysrq_kbd_triggered) {
+			sysrq_kbd_triggered = true;
 			__handle_sysrq(sysrq_xlate[code], true);
+			/* Clear handled keys from being flagged as a repeated stroke */
+			__clear_bit(code, handle->dev->key);
+		}
 		break;
 	}
 
-- 
1.6.3.3


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
