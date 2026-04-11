Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322A2D2488
	for <linux-input@vger.kernel.org>; Sat, 11 Apr 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925508; cv=none; b=jfkWw+5TMVPfIVRcaSWwUeFGJhfjJY0IQjzKTiwyb0IKEES9zbxXQY0CIiN9XpVs6AsfW7DGFsaGGsmHaeYEs+6BALYoHBjsBvKBqK1DYBiaYDM9p8uD3oAV/U4dsbL35rlkZRsQtvoTanj60eB+xYGxct/PuHau9hJkUCG9UaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925508; c=relaxed/simple;
	bh=fUGXwqY1yyZaVvCAbUuWWuKI/EMuRbyO15yBM/urh/A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZnToa4KKjuRIgzOSeeDI68bTtmEhEEByfMaSFA+Mjg/xtiwlOZITc8A4U7qQ7303uhIbq6KkYjy6RlE2Jp30Ik53YuczFBXwOjw/dWoubg6Or1YRYITUeCuwm+akWWEUhpk5Mo70hcODTEwgY++SA5Vt2Jw0vd0SjJTm/ZU9JHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=rdZKLQlq; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="rdZKLQlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1775925497; x=1776184697;
	bh=TCQowV2GRItMyxdByaCA0uSKrBbas2qpV318NezKUY8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rdZKLQlq/UtU4lQNpMdbjY52fPbT1h/IbImdHn8UmH2f6RdVpO0S2T7QbcmpJBWGu
	 eBaMcX76FJq9rBZb+0ItnPa9ogjENhlv/5I2myhf21ykTep3X+XedK98v9+VFJGFid
	 AiaXKDl/qLPRUzsW9U/chZkUVSvhtQEXTsTOWyZ/MubSlTbFlR2l7dYdUnZ4nuxmHu
	 9Flx308RN3xqX0Nitz5VKIOsFv2One7dx2fDxhEI0ilX7T4rRPIQliR6gpxzyV0HE7
	 NvhwF0UDqPMDdT7fXPN9IW06qd95ewHgTYLudHIcaGX1NzLwrbAhP9EcFe1OpxytWe
	 f2c+2xo2H1bnw==
Date: Sat, 11 Apr 2026 16:38:12 +0000
To: linux-input@vger.kernel.org
From: Dmitri Ollari <dmitri.ollari@protonmail.com>
Cc: jikos@kernel.org, Dmitri Ollari <dmitri.ollari@protonmail.com>
Subject: [PATCH] HID: magicmouse: enable battery polling for 2024 Magic Trackpad
Message-ID: <20260411163806.35759-1-dmitri.ollari@protonmail.com>
Feedback-ID: 26920991:user:proton
X-Pm-Message-ID: 6f3ae7bc0c58b5fe3562550e9577763e9efc319b
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------2c934431fac00728876d3dd09830ab205198cb6e4fc534c9b27b49cfe3d66913"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------2c934431fac00728876d3dd09830ab205198cb6e4fc534c9b27b49cfe3d66913
Content-Type: multipart/mixed;
 boundary=e33a7ae008b169df8a3c650fd8baccbb01a8a3f29526e63a0a7ffa709ab3
From: Dmitri Ollari <dmitri.ollari@protonmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	Dmitri Ollari <dmitri.ollari@protonmail.com>
Subject: [PATCH] HID: magicmouse: enable battery polling for 2024 Magic Trackpad
Date: Sat, 11 Apr 2026 18:38:06 +0200
Message-ID: <20260411163806.35759-1-dmitri.ollari@protonmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0

--e33a7ae008b169df8a3c650fd8baccbb01a8a3f29526e63a0a7ffa709ab3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 2024 Magic Trackpad USB-C (PID 0x0324) does not report battery
strength via HID descriptor fields over Bluetooth. Instead it requires
an explicit HID_REQ_GET_REPORT request to retrieve the battery level.

This patch makes the following changes:

1. Replace the battery_timer (timer_list) with battery_work (delayed_work)
   so that HID_REQ_GET_REPORT can be issued from a sleepable context.
   Timers run in atomic context and cannot block, which caused deadlocks
   on the Bluetooth transport path.

2. Extend the fetch guard and probe scheduling block to include the 2024
   Magic Trackpad USB-C when connected over Bluetooth (vendor 0x004C,
   product 0x0324 via BT_VENDOR_ID_APPLE).

3. Schedule battery_work immediately at probe (delay=0) instead of
   issuing a direct magicmouse_fetch_battery() call. The direct call
   bypassed the cold-start correction logic and could publish a stale
   value before the work handler had a chance to validate it.

4. Add a cold-start
 double-poll: the device may return a stale battery
   value (e.g. 4%) on the very first GET_REPORT after power-on. On the
   first successful poll battery_validated is set and a second poll is
   scheduled 3 seconds later to obtain the real value. Subsequent polls
   use the normal 60-second interval.

5. Remove the early-return guard that skipped polling when
   battery_capacity equalled battery_max. This prevented the second
   corrective poll from firing when the first stale response happened
   to equal 100.

Signed-off-by: Dmitri Ollari <dmitri.ollari@protonmail.com>
---
 hid-magicmouse.c | 55 +++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/hid-magicmouse.c b/hid-magicmouse.c
index 9eadf32..bc9c467 100644
--- a/hid-magicmouse.c
+++ b/hid-magicmouse.c
@@ -123,7 +123,10 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
  * @tracking_ids: Mapping of current touch 
input data to @touches.
  * @hdev: Pointer to the underlying HID device.
  * @work: Workqueue to handle initialization retry for quirky devices.
- * @battery_timer: Timer for obtaining battery level information.
+ * @battery_work: Delayed work for periodic battery level polling.
+ * @battery_validated: Set after the first successful poll; gates the
+ *	second poll that corrects the stale value the device may report
+ *	on cold start.
  */
 struct magicmouse_sc {
 	struct input_dev *input;
@@ -148,7 +151,8 @@ struct magicmouse_sc {
 
 	struct hid_device *hdev;
 	struct delayed_work work;
-	struct timer_list battery_timer;
+	struct delayed_work battery_work;
+	bool battery_validated;
 };
 
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
@@ -820,7 +824,8 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 
 	if (!hdev->battery ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->p
roduct)))
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product) &&
+	     hdev->product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC)) /* 2024 Magic Trackpad USB-C over Bluetooth */
 		return -1;
 
 	report_enum = &hdev->report_enum[hdev->battery_report_type];
@@ -829,9 +834,6 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	if (!report || report->maxfield < 1)
 		return -1;
 
-	if (hdev->battery_capacity == hdev->battery_max)
-		return -1;
-
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
 	return 0;
 #else
@@ -839,14 +841,23 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 #endif
 }
 
-static void magicmouse_battery_timer_tick(struct timer_list *t)
+static void magicmouse_battery_work(struct work_struct *work)
 {
-	struct magicmouse_sc *msc = timer_container_of(msc, t, battery_timer);
+	struct magicmouse_sc *msc = container_of(work, struct magicmouse_sc, battery_work.work);
 	struct hid_device *hdev = msc->hdev;
 
 	i
f (magicmouse_fetch_battery(hdev) == 0) {
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
+		if (!msc->battery_validated) {
+			/* The device may return a stale value (e.g. 4%) on the
+			 * first GET_REPORT after cold start. Schedule a second
+			 * poll shortly after to get the real value, then settle
+			 * into the normal 60s interval.
+			 */
+			msc->battery_validated = true;
+			schedule_delayed_work(&msc->battery_work, secs_to_jiffies(3));
+		} else {
+			schedule_delayed_work(&msc->battery_work, secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
+		}
 	}
 }
 
@@ -866,6 +877,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 	msc->hdev = hdev;
 	INIT_DEFERRABLE_WORK(&msc->work, magicmouse_enable_mt_work);
+	INIT_DELAYED_WORK(&msc->battery_work, magicmouse_battery_work);
 
 	msc->quirks = id->driver_data;
 	hid_set_drvdata(hdev, msc);
@@ -883,11 +895,13 @@ static int
 magicmouse_probe(struct hid_device *hdev,
 	}
 
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magictrackpad2(id->vendor, id->product)) {
-		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
-		mod_timer(&msc->battery_timer,
-			  jiffies + secs_to_jiffies(USB_BATTERY_TIMEOUT_SEC));
-		magicmouse_fetch_battery(hdev);
+	    is_usb_magictrackpad2(id->vendor, id->product) ||
+	    id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC) {
+		/* Schedule immediately so battery_work runs ASAP, sets battery_validated,
+		 * then reschedules every 60s. Avoids direct fetch which bypasses
+		 * battery_validated and would publish a stale startup value.
+		 */
+		schedule_delayed_work(&msc->battery_work, 0);
 	}
 
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
@@ -955,10 +969,8 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 	return 0;
 err_stop_hw:
-	if (is_usb_magicmouse2(id->vendor, id->product) ||
-	    is_usb_magi
ctrackpad2(id->vendor, id->product))
-		timer_delete_sync(&msc->battery_timer);
-
+	/* Clean up battery work on error */
+	cancel_delayed_work_sync(&msc->battery_work);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -969,9 +981,8 @@ static void magicmouse_remove(struct hid_device *hdev)
 
 	if (msc) {
 		cancel_delayed_work_sync(&msc->work);
-		if (is_usb_magicmouse2(hdev->vendor, hdev->product) ||
-		    is_usb_magictrackpad2(hdev->vendor, hdev->product))
-			timer_delete_sync(&msc->battery_timer);
+		/* Cancel battery polling on device removal */
+		cancel_delayed_work_sync(&msc->battery_work);
 	}
 
 	hid_hw_stop(hdev);
-- 
2.53.0


--e33a7ae008b169df8a3c650fd8baccbb01a8a3f29526e63a0a7ffa709ab3
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey -
 dmitri.ollari@protonmail.com - 0xF53BC391.asc"; name="publickey -
 dmitri.ollari@protonmail.com - 0xF53BC391.asc"
Content-Type: application/pgp-keys; filename="publickey -
 dmitri.ollari@protonmail.com - 0xF53BC391.asc"; name="publickey -
 dmitri.ollari@protonmail.com - 0xF53BC391.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FWllJT25SWUpLd1lCQkFIYVJ3
OEJBUWRBV0NBcDk1TU5YU3RBMmRlYWxGNFNJVW5Lc2tqTTZpNWZTU1hRCmRCZjlwUC9OTzJSdGFY
UnlhUzV2Ykd4aGNtbEFjSEp2ZEc5dWJXRnBiQzVqYjIwZ1BHUnRhWFJ5YVM1dmJHeGgKY21sQWNI
SnZkRzl1YldGcGJDNWpiMjArd29zRUVCWUtBRDRGZ21XQ0RwMEVDd2tIQ0FtUXlaTnc5UVlQalRB
RApGUWdLQkJZQUFnRUNHUUVDbXdNQ0hnRVdJUVQxTzhPUmJ3RU9qbjB3ZmZQSmszRDFCZytOTUFB
QXdrWUErSzY1CnA2bnM1R2hVaWcvNEdvblhmSFdBS3R0Qzl2OVR3cDJocE1GQXdnTUJBTTlOMCtI
ZHJxNy9zdUJCK0FuV2txeWcKSDhaR3VrV3ZqZGZxTk5Odk5VRUJ6amdFWllJT25SSUtLd1lCQkFH
WFZRRUZBUUVIUUhYanl0Q01zK282clV4SgpCemFtRjQ3MDJ4OEczZTR1bE45dkRvbE94L1k4QXdF
SUI4SjRCQmdXQ2dBcUJZSmxnZzZkQ1pESmszRDFCZytOCk1BS2JEQlloQlBVN3c1RnZBUTZPZlRC
OTg4bVRjUFVHRDQwd0FBQUswQUVBb3BqdTF1Rm9nUGo4OU9Na0hGenQKSm5rTlV0ZFhPVXo5ZWM3
SlVCdWNsZjhBLzNLdU9EamtJa2F1SW1WMEN5Ly9xZW1KS2ZScmhJNklzamIramNibQpMVTRCCj1E
cG54Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0=
--e33a7ae008b169df8a3c650fd8baccbb01a8a3f29526e63a0a7ffa709ab3--

--------2c934431fac00728876d3dd09830ab205198cb6e4fc534c9b27b49cfe3d66913
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmnaePMJEMmTcPUGD40wNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcR7j3GlP8Lwjq+0bauqx8DFiEE9TvDkW8BDo59
MH3zyZNw9QYPjTAAAEa2AP4zaiFYte0+2rplsGhQRob3tSdwFuOPp6v76nJ2
lGxLWQEArwAVfY1+4zusM5EzCL9zj1S50MreV9NwEEkWdoyy3AQ=
=NyBX
-----END PGP SIGNATURE-----


--------2c934431fac00728876d3dd09830ab205198cb6e4fc534c9b27b49cfe3d66913--

