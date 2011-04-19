From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH v2] hid: assorted usage updates from hut 1.12
Date: Tue, 19 Apr 2011 15:28:30 -0400
Message-ID: <1303241310-21354-1-git-send-email-jarod@redhat.com>
References: <4DADDEBF.3050407@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23630 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab1DST2k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2011 15:28:40 -0400
In-Reply-To: <4DADDEBF.3050407@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

I've got a Tivo Slide bluetooth remote/dongle, which uses a fair number
of hid usages that aren't currently mapped in hid-input.c. I'd initially
written additions to hid-input.c with just this device in mind,
including some bits that were specific to the device. This go around,
I'm looking at adding/correcting as many generic HID usages from the HID
Usage Tables, version 1.12, as I can -- which also serves to enable all
but four of the buttons on the Tivo Slide remote[*].

Outside of fixing the obviously incorrect mapping of 0xc 0x45 from
KEY_RADIO to KEY_RIGHT, and making use of the new KEY_IMAGES (just added
in 2.6.39-rc4) for AL Image Browser instead of KEY_MEDIA, these are
purely additions, and thus should have no negative impact on any already
functional HID devices. Most of the added mappings seemed to be
perfectly logical to me, but there were a few that were mapped on more
of an "I think this makes the most sense" basis.

[*] I'll handle the last four tivo buttons via an hid-tivo.c follow-up.

CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
---
v2: fix incorrect duplicate case value for KEY_PLAYER mapping

 drivers/hid/hid-input.c |   60 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7f552bf..88d4703 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -44,11 +44,11 @@ static const unsigned char hid_keyboard[256] = {
 	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
 	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
 	115,114,unk,unk,unk,121,unk, 89, 93,124, 92, 94, 95,unk,unk,unk,
-	122,123, 90, 91, 85,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	122,123, 90, 91, 85,unk,unk,unk,unk,unk,unk,unk,111,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,179,180,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
-	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	unk,unk,unk,unk,unk,unk,unk,unk,111,unk,unk,unk,unk,unk,unk,unk,
 	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
 	150,158,159,128,136,177,178,176,142,152,173,140,unk,unk,unk,unk
 };
@@ -365,6 +365,18 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			case 0x1: map_key_clear(KEY_POWER);  break;
 			case 0x2: map_key_clear(KEY_SLEEP);  break;
 			case 0x3: map_key_clear(KEY_WAKEUP); break;
+			case 0x4: map_key_clear(KEY_CONTEXT_MENU); break;
+			case 0x5: map_key_clear(KEY_MENU); break;
+			case 0x6: map_key_clear(KEY_PROG1); break;
+			case 0x7: map_key_clear(KEY_HELP); break;
+			case 0x8: map_key_clear(KEY_EXIT); break;
+			case 0x9: map_key_clear(KEY_SELECT); break;
+			case 0xa: map_key_clear(KEY_RIGHT); break;
+			case 0xb: map_key_clear(KEY_LEFT); break;
+			case 0xc: map_key_clear(KEY_UP); break;
+			case 0xd: map_key_clear(KEY_DOWN); break;
+			case 0xe: map_key_clear(KEY_POWER2); break;
+			case 0xf: map_key_clear(KEY_RESTART); break;
 			default: goto unknown;
 			}
 			break;
@@ -474,16 +486,39 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		}
 		break;
 
-	case HID_UP_CONSUMER:	/* USB HUT v1.1, pages 56-62 */
+	case HID_UP_CONSUMER:	/* USB HUT v1.12, pages 75-84 */
 		switch (usage->hid & HID_USAGE) {
 		case 0x000: goto ignore;
+		case 0x030: map_key_clear(KEY_POWER);		break;
+		case 0x031: map_key_clear(KEY_RESTART);		break;
+		case 0x032: map_key_clear(KEY_SLEEP);		break;
 		case 0x034: map_key_clear(KEY_SLEEP);		break;
+		case 0x035: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
 		case 0x036: map_key_clear(BTN_MISC);		break;
 
-		case 0x040: map_key_clear(KEY_MENU);		break;
-		case 0x045: map_key_clear(KEY_RADIO);		break;
-
+		case 0x040: map_key_clear(KEY_MENU);		break; /* Menu */
+		case 0x041: map_key_clear(KEY_SELECT);		break; /* Menu Pick */
+		case 0x042: map_key_clear(KEY_UP);		break; /* Menu Up */
+		case 0x043: map_key_clear(KEY_DOWN);		break; /* Menu Down */
+		case 0x044: map_key_clear(KEY_LEFT);		break; /* Menu Left */
+		case 0x045: map_key_clear(KEY_RIGHT);		break; /* Menu Right */
+		case 0x046: map_key_clear(KEY_ESC);		break; /* Menu Escape */
+		case 0x047: map_key_clear(KEY_KPPLUS);		break; /* Menu Value Increase */
+		case 0x048: map_key_clear(KEY_KPMINUS);		break; /* Menu Value Decrease */
+
+		case 0x060: map_key_clear(KEY_INFO);		break; /* Data On Screen */
+		case 0x061: map_key_clear(KEY_SUBTITLE);	break; /* Closed Caption */
+		case 0x063: map_key_clear(KEY_VCR);		break; /* VCR/TV */
+		case 0x065: map_key_clear(KEY_CAMERA);		break; /* Snapshot */
+		case 0x069: map_key_clear(KEY_RED);		break;
+		case 0x06a: map_key_clear(KEY_GREEN);		break;
+		case 0x06b: map_key_clear(KEY_BLUE);		break;
+		case 0x06c: map_key_clear(KEY_YELLOW);		break;
+		case 0x06d: map_key_clear(KEY_ZOOM);		break;
+
+		case 0x082: map_key_clear(KEY_VIDEO_NEXT);	break;
 		case 0x083: map_key_clear(KEY_LAST);		break;
+		case 0x084: map_key_clear(KEY_ENTER);		break;
 		case 0x088: map_key_clear(KEY_PC);		break;
 		case 0x089: map_key_clear(KEY_TV);		break;
 		case 0x08a: map_key_clear(KEY_WWW);		break;
@@ -517,6 +552,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0b7: map_key_clear(KEY_STOPCD);		break;
 		case 0x0b8: map_key_clear(KEY_EJECTCD);		break;
 		case 0x0bc: map_key_clear(KEY_MEDIA_REPEAT);	break;
+		case 0x0b9: map_key_clear(KEY_SHUFFLE);		break;
+		case 0x0bf: map_key_clear(KEY_SLOW);		break;
 
 		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
 		case 0x0e0: map_abs_clear(ABS_VOLUME);		break;
@@ -524,6 +561,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
 		case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
 		case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
+		case 0x0f5: map_key_clear(KEY_SLOW);		break;
 
 		case 0x182: map_key_clear(KEY_BOOKMARKS);	break;
 		case 0x183: map_key_clear(KEY_CONFIG);		break;
@@ -540,6 +578,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x18e: map_key_clear(KEY_CALENDAR);	break;
 		case 0x191: map_key_clear(KEY_FINANCE);		break;
 		case 0x192: map_key_clear(KEY_CALC);		break;
+		case 0x193: map_key_clear(KEY_PLAYER);		break;
 		case 0x194: map_key_clear(KEY_FILE);		break;
 		case 0x196: map_key_clear(KEY_WWW);		break;
 		case 0x199: map_key_clear(KEY_CHAT);		break;
@@ -548,8 +587,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x1a6: map_key_clear(KEY_HELP);		break;
 		case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
 		case 0x1ab: map_key_clear(KEY_SPELLCHECK);	break;
-		case 0x1b6: map_key_clear(KEY_MEDIA);		break;
-		case 0x1b7: map_key_clear(KEY_SOUND);		break;
+		case 0x1ae: map_key_clear(KEY_KEYBOARD);	break;
+		case 0x1b6: map_key_clear(KEY_IMAGES);		break;
+		case 0x1b7: map_key_clear(KEY_AUDIO);		break;
+		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
 		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
 		case 0x1bd: map_key_clear(KEY_INFO);		break;
 		case 0x201: map_key_clear(KEY_NEW);		break;
@@ -578,7 +619,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
 		case 0x238: map_rel(REL_HWHEEL);		break;
+		case 0x23d: map_key_clear(KEY_EDIT);		break;
 		case 0x25f: map_key_clear(KEY_CANCEL);		break;
+		case 0x269: map_key_clear(KEY_INSERT);		break;
+		case 0x26a: map_key_clear(KEY_DELETE);		break;
 		case 0x279: map_key_clear(KEY_REDO);		break;
 
 		case 0x289: map_key_clear(KEY_REPLY);		break;
-- 
1.7.1

