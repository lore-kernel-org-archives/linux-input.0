From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Mon, 2 Apr 2007 16:48:10 -0400
Message-ID: <20070402204810.GC14838@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Some mice like the Cortron Trackball use the fourth bit of the first byte
(yes, that one that the protocol tells to be always 1, oh well) to represent
the fourth button. This patch adds an option to use the fourth bit to
represent the fourth button.

Please comment on this and please keep me on Cc list, I'm not subscribed to
linux-input.

---
 drivers/input/mouse/psmouse-base.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- linus-2.6.orig/drivers/input/mouse/psmouse-base.c
+++ linus-2.6/drivers/input/mouse/psmouse-base.c
@@ -64,6 +64,13 @@ static unsigned int psmouse_resync_time;
 module_param_named(resync_time, psmouse_resync_time, uint, 0644);
 MODULE_PARM_DESC(resync_time, "How long can mouse stay idle before forcing resync (in seconds, 0 = never).");
 
+static unsigned int psmouse_4th_bit_as_button;
+module_param_named(4th_bit_as_button, psmouse_4th_bit_as_button, uint, 0);
+MODULE_PARM_DESC(4th_bit_as_button, "Interpret the 4th bit of the first byte "
+		 "as 4th button. Some mice like Cortron Trackballs use the "
+		 "4th bit (which should be always set) of the first byte as "
+		 "4th button");
+
 PSMOUSE_DEFINE_ATTR(protocol, S_IWUSR | S_IRUGO,
 			NULL,
 			psmouse_attr_show_protocol, psmouse_attr_set_protocol);
@@ -176,6 +183,14 @@ static psmouse_ret_t psmouse_process_byt
 		packet[1] |= (packet[0] & 0x40) << 1;
 	}
 
+ /*
+ * Use the 4th bit of the first package as button
+ */
+	if (psmouse_4th_bit_as_button) {
+		input_report_key(dev, BTN_SIDE, (packet[0] >> 3) & 1);
+		packet[0] |= 0x08;
+	}
+
 /*
  * Generic PS/2 Mouse
  */
@@ -643,6 +658,9 @@ static int psmouse_extensions(struct psm
 		psmouse_reset(psmouse);
 	}
 
+	if (psmouse_4th_bit_as_button)
+		set_bit(BTN_SIDE, psmouse->dev->keybit);
+
 	return PSMOUSE_PS2;
 }
 
