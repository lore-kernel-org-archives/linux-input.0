From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] rfkill: Add support for KEY_RFKILL_ALL
Date: Sat,  1 Aug 2009 19:54:19 +0100
Message-ID: <1249152859-14769-2-git-send-email-mjg@redhat.com>
References: <1249152859-14769-1-git-send-email-mjg@redhat.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1249152859-14769-1-git-send-email-mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add support for handling KEY_RFKILL_ALL in the rfkill input module. This
simply toggles the state of all rfkill devices.

Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 net/rfkill/input.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/net/rfkill/input.c b/net/rfkill/input.c
index a7295ad..5517089 100644
--- a/net/rfkill/input.c
+++ b/net/rfkill/input.c
@@ -212,6 +212,12 @@ static void rfkill_event(struct input_handle *handle, unsigned int type,
 		case KEY_WIMAX:
 			rfkill_schedule_toggle(RFKILL_TYPE_WIMAX);
 			break;
+		case KEY_RFKILL_ALL:
+			rfkill_schedule_toggle(RFKILL_TYPE_WLAN);
+			rfkill_schedule_toggle(RFKILL_TYPE_BLUETOOTH);
+			rfkill_schedule_toggle(RFKILL_TYPE_UWB);
+			rfkill_schedule_toggle(RFKILL_TYPE_WIMAX);
+			break;
 		}
 	} else if (type == EV_SW && code == SW_RFKILL_ALL)
 		rfkill_schedule_evsw_rfkillall(data);
@@ -295,6 +301,11 @@ static const struct input_device_id rfkill_ids[] = {
 		.keybit = { [BIT_WORD(KEY_WIMAX)] = BIT_MASK(KEY_WIMAX) },
 	},
 	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(KEY_RFKILL_ALL)] = BIT_MASK(KEY_RFKILL_ALL) },
+	},
+	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT,
 		.evbit = { BIT(EV_SW) },
 		.swbit = { [BIT_WORD(SW_RFKILL_ALL)] = BIT_MASK(SW_RFKILL_ALL) },
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
