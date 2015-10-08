From: Hauke Pribnow <hauke.pribnow@gmx.net>
Subject: [1/2] Input: input.h - Add and extend KEY_* usage detail comments
Date: Thu, 8 Oct 2015 11:06:54 +0200
Message-ID: <5616322E.4040807@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:56484 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbbJHJHG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Oct 2015 05:07:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: anssi.hannula@iki.fi

The KEY_* definitions in input.h had no formal functional definitions=20
when they were first introduced. This led to a situation where some key=
s=20
were used very inconsistently across different drivers. For example,=20
KEY_SETUP was used both in some very low-level situations (like=20
resetting the settings to the device defaults or to lauch some system=20
backup tool for some integrated devices) and on high-level home media=20
remote controls (where the key should open some kind of configuration=20
window). To reach a more consistent usage of KEY_* definitions, it is=20
crucial to add and extend comments in input.h to assign functional key=20
definitions to KEY_* definitions, preferrably based on the USB HID Usag=
e=20
Tables for keys that are not defined in such a way yet.

This patch adds such funtional definitions for KEY_SETUP, KEY_CONFIG an=
d=20
KEY_CONTROLPANEL. It further adds some information on how these=20
definitions are related to each other.

Signed-off-by: Hauke Pribnow <hauke.pribnow@gmx.net>

---
Hello everyone,

first of all: I hope that I read enough about "The Process" so that I=20
did not make any mistake in submitting this patch. This is my first=20
Linux kernel patch ever - so please bear with me.

Here's some more details that made me create this patch: I'm currently=20
revising the keytable for a home media USB RF remote I own. During this=
=20
process I got into contact with the original kernel driver module autho=
r=20
who created the first keytable for this remote. He reviewed my proposed=
=20
changes and agreed with most of my changes except of one: We ended up=20
being confused about the meaning of the KEY_SETUP and KEY_CONFIG=20
definitions in input.h. Since the input.h does not contain any=20
information on what the functional definitions behind the KEY_*=20
definitions are, I got into contact with the original author of the=20
input.h file, Vojt=C4=9Bch Pavl=C3=ADk, and asked for his opinion.

He clarified that the KEY_* definitions had no formal definitions when=20
they were first introduced. He concluded that it's basically about=20
retro-defining what the keys mean. In my initial mail to him I proposed=
=20
the definitions for KEY_SETUP and KEY_CONFIG like in the patch at hand=20
to him. Fortunately he agreed in his reply that the reasoning behind my=
=20
definitions makes sense. So I went ahead and created this first patch o=
f=20
two.

Thanks a lot for any kind of feedback in advance,
Hauke

  include/uapi/linux/input.h | 22 +++++++++++++++++++---
  1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 731417c..ffb232a 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -356,7 +356,11 @@ struct input_keymap_entry {
  #define KEY_HELP		138	/* AL Integrated Help Center */
  #define KEY_MENU		139	/* Menu (show menu) */
  #define KEY_CALC		140	/* AL Calculator */
-#define KEY_SETUP		141
+#define KEY_SETUP		141	/* SC System Setup, i.e. enter BIOS-
+                                           level system (USB HID Usage=
=20
Tables
+					   4.5.1). KEY_CONTROLPANEL makes more
+					   sense for application- or operating
+                                           system-level configuration=20
tasks. */
  #define KEY_SLEEP		142	/* SC System Sleep */
  #define KEY_WAKEUP		143	/* System Wake Up */
  #define KEY_FILE		144	/* AL Local Machine Browser */
@@ -388,7 +392,14 @@ struct input_keymap_entry {
  #define KEY_REWIND		168
  #define KEY_PHONE		169	/* Media Select Telephone */
  #define KEY_ISO			170
-#define KEY_CONFIG		171	/* AL Consumer Control Configuration */
+#define KEY_CONFIG		171	/* AL Consumer Control Configuration
+                                           (USB HID Usage Tables=20
15.15). Such
+                                           a tool should allow associa=
ting
+                                           keys/buttons with a consume=
r
+                                           device. KEY_CONTROLPANEL=20
should be
+                                           assigned to keys that are=20
intended
+                                           for more generic configurat=
ion
+                                           applications. */
  #define KEY_HOMEPAGE		172	/* AC Home */
  #define KEY_REFRESH		173	/* AC Refresh */
  #define KEY_EXIT		174	/* AC Exit */
@@ -737,7 +748,12 @@ struct input_keymap_entry {
  #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
  #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
  #define KEY_JOURNAL		0x242	/* AL Log/Journal/Timecard */
-#define KEY_CONTROLPANEL		0x243	/* AL Control Panel */
+#define KEY_CONTROLPANEL		0x243	/* AL Control Panel (USB HID
+                                                   Usage Tables 15.15)=
=2E Use
+                                                   this instead of=20
KEY_SETUP
+                                                   for application- or
+                                                   operating system- l=
evel
+                                                   configuration tasks=
=2E */
  #define KEY_APPSELECT		0x244	/* AL Select Task/Application */
  #define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
  #define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
--=20
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
