From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] input: Add KEY_RFKILL_ALL
Date: Sat,  1 Aug 2009 19:54:18 +0100
Message-ID: <1249152859-14769-1-git-send-email-mjg@redhat.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Most laptops have keys that are intended to toggle all device state, not
just wifi. These are currently generally mapped to KEY_WLAN. As a result,
rfkill will only kill or enable wifi in response to the key press. This
confuses users and can make it difficult for them to enable bluetooth
and wwan devices.

This patch adds a new keycode, KEY_RFKILL_ALL. It indicates that the
system should toggle the state of all rfkillable devices.

Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 include/linux/input.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 8b3bc3e..0eff8ff 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -595,6 +595,8 @@ struct input_absinfo {
 #define KEY_NUMERIC_STAR	0x20a
 #define KEY_NUMERIC_POUND	0x20b
 
+#define KEY_RFKILL_ALL		0x20c
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
