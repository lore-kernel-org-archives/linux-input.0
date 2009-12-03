From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Thu,  3 Dec 2009 08:45:16 +0100
Message-ID: <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-23-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-25-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This keycode could be used in a lot of platform specific drivers.
For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
drivers (bt/wl: off/off, on/off, off/on, on/on).

Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
are rarely used.

Cc: linux-input@vger.kernel.org
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 include/linux/input.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index c2b1a7d..c961908 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -376,6 +376,7 @@ struct input_absinfo {
 #define KEY_DISPLAY_OFF		245	/* display device to off state */
 
 #define KEY_WIMAX		246
+#define KEY_WIRELESS_CYCLE	247
 
 /* Range 248 - 255 is reserved for special needs of AT keyboard driver */
 
-- 
1.6.5.3

