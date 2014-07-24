From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 04/10] Input - wacom: use a uniq name for the battery device
Date: Thu, 24 Jul 2014 14:13:59 -0400
Message-ID: <1406225645-32141-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Przemo Firszt <przemo@firszt.eu>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The current implementation uses "wacom_battery" as a generic name for
batteries. This prevents us to have two Wacom devices with a battery
attached as the power system will complain about the name which is already
registered.

Use an incremental name for each battery attached.

Related bug:
https://sourceforge.net/p/linuxwacom/bugs/248/

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

changes in v2:
- do not use the name of the tablet (which removes the need of the check for
  spaces), but use instead a simple counter to get a uniq name.

 drivers/hid/wacom_sys.c | 6 +++++-
 drivers/hid/wacom_wac.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f0ee7ff..eb8705d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -809,12 +809,16 @@ static int wacom_battery_get_property(struct power_supply *psy,
 static int wacom_initialize_battery(struct wacom *wacom)
 {
 	int error = 0;
+	static atomic_t battery_no = ATOMIC_INIT(0);
+	unsigned long n;
 
 	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) {
+		n = atomic_inc_return(&battery_no) - 1;
 		wacom->battery.properties = wacom_battery_props;
 		wacom->battery.num_properties = ARRAY_SIZE(wacom_battery_props);
 		wacom->battery.get_property = wacom_battery_get_property;
-		wacom->battery.name = "wacom_battery";
+		sprintf(wacom->wacom_wac.bat_name, "wacom_battery_%ld", n);
+		wacom->battery.name = wacom->wacom_wac.bat_name;
 		wacom->battery.type = POWER_SUPPLY_TYPE_BATTERY;
 		wacom->battery.use_for_apm = 0;
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 8a042ac..6cdf707 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -154,6 +154,7 @@ struct wacom_shared {
 struct wacom_wac {
 	char name[WACOM_NAME_MAX];
 	char pad_name[WACOM_NAME_MAX];
+	char bat_name[WACOM_NAME_MAX];
 	unsigned char data[WACOM_PKGLEN_MAX];
 	int tool[2];
 	int id[2];
-- 
2.0.1
