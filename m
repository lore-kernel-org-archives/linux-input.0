From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC V2 4/4] power_supply: add "powers" links to self-powered HID devices
Date: Fri,  9 Dec 2011 14:43:19 -0800
Message-ID: <35b4c01e29bdd9632dabf9784ed3486333f00427.1323454016.git.jeremy@goop.org>
References: <cover.1323454016.git.jeremy@goop.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1323454016.git.jeremy@goop.org>
In-Reply-To: <cover.1323454016.git.jeremy@goop.org>
References: <cover.1323454016.git.jeremy@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Hughes <hughsient@gmail.com>, Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: linux-input@vger.kernel.org

Make the relationship between the Wiimote and Wacom self-powered HID
devices and their power supply explicit by adding a "powers" link.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-wacom.c   |    4 ++++
 drivers/hid/hid-wiimote.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index ad39777..3d28e49 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -397,6 +397,8 @@ static int wacom_probe(struct hid_device *hdev,
 	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
 	wdata->battery.use_for_apm = 0;
 
+	power_supply_powers(&wdata->battery, &hdev->dev);
+
 	ret = power_supply_register(&hdev->dev, &wdata->battery);
 	if (ret) {
 		hid_warn(hdev, "can't create sysfs battery attribute, err: %d\n",
@@ -411,6 +413,8 @@ static int wacom_probe(struct hid_device *hdev,
 	wdata->ac.type = POWER_SUPPLY_TYPE_MAINS;
 	wdata->ac.use_for_apm = 0;
 
+	power_supply_powers(&wdata->battery, &hdev->dev);
+
 	ret = power_supply_register(&hdev->dev, &wdata->ac);
 	if (ret) {
 		hid_warn(hdev,
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 98e4828..fc0b4db 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -1263,6 +1263,8 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	wdata->battery.type = POWER_SUPPLY_TYPE_BATTERY;
 	wdata->battery.use_for_apm = 0;
 
+	power_supply_powers(&wdata->battery, &hdev->dev);
+
 	ret = power_supply_register(&wdata->hdev->dev, &wdata->battery);
 	if (ret) {
 		hid_err(hdev, "Cannot register battery device\n");
-- 
1.7.7.3
