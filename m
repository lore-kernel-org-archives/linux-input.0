From: Hauke Pribnow <hauke.pribnow@gmx.net>
Subject: [2/2] Input: input.h - Add and extend KEY_* usage detail comments
Date: Thu, 8 Oct 2015 11:07:04 +0200
Message-ID: <56163238.1090709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64408 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbbJHJHV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Oct 2015 05:07:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: anssi.hannula@iki.fi

The KEY_* definitions in input.h had no formal functional definitions 
when they were first introduced. This led to a situation where some keys 
were used inconsistently across different drivers. For example, 
KEY_POWER was used both in some very low-level situations (where 
pressing the key should directly shut down the whole system) and on 
high-level home media remote controls (where the pressing the key should 
either make the system go to some standby mode or should even just quit 
some currently running application). To reach a more consistent usage of 
KEY_* definitions, it is crucial to add and extend comments in input.h 
to assign functional key definitions to KEY_* definitions, preferrably 
based on the USB HID Usage Tables for keys that are not defined in such 
a way yet.

This patch mainly adds such funtional definitions for KEY_POWER and 
KEY_POWER2. It further adds some information on how these definitions 
are related to each other.

Signed-off-by: Hauke Pribnow <hauke.pribnow@gmx.net>

---
Hello again,

similar to the first patch, this patch also deals with KEY_* definition 
usage inconsistencies. See more details in the additional information 
text of the prior patch mail. I found out that most remote controls use 
KEY_POWER2 and most integrated devices (that have their own power 
button) use KEY_POWER. However, this is unfortunately not always the 
case, so some remote controls also use KEY_POWER. This calls for a 
better functional definition of the two buttons.

The reason why I split up my attempt to functionally define the keys 
better into two patches is that I'm not completely sure if I 
"interpreted" KEY_POWER2 correctly. As written in the comments for that 
KEY_* definition below, I did not find an entry in the USB HID Usage 
Tables that would match KEY_POWER2 well. I did find a "Quit" entry in 
the Tables under 15.6 though... but I'm not sure if that would quite fit 
to KEY_POWER2.

That's why I was hoping for some additional ideas on how this situation 
might be resolved better.

Thanks a lot for any kind of feedback in advance,
Hauke

  include/uapi/linux/input.h | 20 ++++++++++++++++----
  1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 731417c..bffcd2c 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -328,7 +328,10 @@ struct input_keymap_entry {
  #define KEY_MUTE        113
  #define KEY_VOLUMEDOWN        114
  #define KEY_VOLUMEUP        115
-#define KEY_POWER        116    /* SC System Power Down */
+#define KEY_POWER        116    /* SC System Power Down (USB HID
+                                           Usage Tables 4.5.1). Use 
KEY_POWER2
+                                           for a less "powerful" power 
button.
+                                           See comment there for 
details. */
  #define KEY_KPEQUAL        117
  #define KEY_KPPLUSMINUS        118
  #define KEY_PAUSE        119
@@ -357,8 +360,10 @@ struct input_keymap_entry {
  #define KEY_MENU        139    /* Menu (show menu) */
  #define KEY_CALC        140    /* AL Calculator */
  #define KEY_SETUP        141
-#define KEY_SLEEP        142    /* SC System Sleep */
-#define KEY_WAKEUP        143    /* System Wake Up */
+#define KEY_SLEEP        142    /* SC System Sleep (USB HID Tables
+                                           4.5.1) */
+#define KEY_WAKEUP        143    /* SC System Wake Up (USB HID Tables
+                                           4.5.1) */
  #define KEY_FILE        144    /* AL Local Machine Browser */
  #define KEY_SENDFILE        145
  #define KEY_DELETEFILE        146
@@ -562,7 +567,14 @@ struct input_keymap_entry {
  #define KEY_SELECT        0x161
  #define KEY_GOTO        0x162
  #define KEY_CLEAR        0x163
-#define KEY_POWER2        0x164
+#define KEY_POWER2        0x164    /* A less "powerful" power key like the
+                                           power key on a remote that 
typically
+                                           does not power down your whole
+                                           system but either puts it 
into some
+                                           standby mode or just exits some
+                                           currently running 
application. (A
+                                           key like this is not defined 
in the
+                                           USB HID Usage Tables.) */
  #define KEY_OPTION        0x165
  #define KEY_INFO        0x166    /* AL OEM Features/Tips/Tutorial */
  #define KEY_TIME        0x167
-- 
2.1.4


