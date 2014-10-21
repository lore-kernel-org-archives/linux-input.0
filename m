From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] hid-input: Map unknown consumer page codes to KEY_UNKNOWN
Date: Tue, 21 Oct 2014 23:11:00 +0200
Message-ID: <1413925860-3441-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998AbaJUVLH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2014 17:11:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Currently unknown consumer page codes are ignored, which means that they
cannot later be mapped from userspace using udev / hwdb. Map them to
KEY_UNKNOWN, so that userspace can remap them for keyboards which
make up their own consumer page codes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--
Changes in v2: Use key_map_clear rather then key_map
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2619f7f..a6e33d3 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -856,7 +856,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 		case 0x28c: map_key_clear(KEY_SEND);		break;
 
-		default:    goto ignore;
+		default: map_key_clear(KEY_UNKNOWN);
 		}
 		break;
 
-- 
2.1.0

