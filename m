From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 1/3] HID: wacom: Remove CONFIG_HID_WACOM_POWER_SUPPLY option
Date: Mon, 19 Mar 2012 19:08:32 +0000
Message-ID: <1332184114-30354-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:58404 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032598Ab2CSTJJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 15:09:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pinglinux@gmail.com, jkosina@suse.cz, chris@cnpbagwell.com
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

This option was ment as a safety mechanism in case the system treats the wacom
tablet battery as the main power supply. It's no longer required as now we can
distinguish between system power supply and device power supply.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/hid/Kconfig     |    8 +-------
 drivers/hid/hid-wacom.c |   14 --------------
 2 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a421abd..8011d77 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -620,16 +620,10 @@ config THRUSTMASTER_FF
 config HID_WACOM
 	tristate "Wacom Bluetooth devices support"
 	depends on BT_HIDP
-	---help---
-	Support for Wacom Graphire Bluetooth tablet.
-
-config HID_WACOM_POWER_SUPPLY
-	bool "Wacom Bluetooth devices power supply status support"
 	depends on HID_WACOM
 	select POWER_SUPPLY
 	---help---
-	  Say Y here if you want to enable power supply status monitoring for
-	  Wacom Bluetooth devices.
+	Support for Wacom Graphire Bluetooth tablet.
 
 config HID_WIIMOTE
 	tristate "Nintendo Wii Remote support"
diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 067e296..09d102c 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -41,14 +41,11 @@ struct wacom_data {
 	__u32 id;
 	__u32 serial;
 	unsigned char high_speed;
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	int battery_capacity;
 	struct power_supply battery;
 	struct power_supply ac;
-#endif
 };
 
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 /*percent of battery capacity, 0 means AC online*/
 static unsigned short batcap[8] = { 1, 15, 25, 35, 50, 70, 100, 0 };
 
@@ -120,7 +117,6 @@ static int wacom_ac_get_property(struct power_supply *psy,
 	}
 	return ret;
 }
-#endif
 
 static void wacom_set_features(struct hid_device *hdev)
 {
@@ -310,12 +306,10 @@ static int wacom_gr_parse_report(struct hid_device *hdev,
 		input_sync(input);
 	}
 
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	/* Store current battery capacity */
 	rw = (data[7] >> 2 & 0x07);
 	if (rw != wdata->battery_capacity)
 		wdata->battery_capacity = rw;
-#endif
 	return 1;
 }
 
@@ -596,7 +590,6 @@ static int wacom_probe(struct hid_device *hdev,
 		break;
 	}
 
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	wdata->battery.properties = wacom_battery_props;
 	wdata->battery.num_properties = ARRAY_SIZE(wacom_battery_props);
 	wdata->battery.get_property = wacom_battery_get_property;
@@ -629,16 +622,13 @@ static int wacom_probe(struct hid_device *hdev,
 	}
 
 	power_supply_powers(&wdata->ac, &hdev->dev);
-#endif
 	return 0;
 
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 err_ac:
 	power_supply_unregister(&wdata->battery);
 err_battery:
 	device_remove_file(&hdev->dev, &dev_attr_speed);
 	hid_hw_stop(hdev);
-#endif
 err_free:
 	kfree(wdata);
 	return ret;
@@ -646,16 +636,12 @@ err_free:
 
 static void wacom_remove(struct hid_device *hdev)
 {
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	struct wacom_data *wdata = hid_get_drvdata(hdev);
-#endif
 	device_remove_file(&hdev->dev, &dev_attr_speed);
 	hid_hw_stop(hdev);
 
-#ifdef CONFIG_HID_WACOM_POWER_SUPPLY
 	power_supply_unregister(&wdata->battery);
 	power_supply_unregister(&wdata->ac);
-#endif
 	kfree(hid_get_drvdata(hdev));
 }
 
-- 
1.7.6.4

