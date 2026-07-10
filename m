Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BED42DA27
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697735; cv=none; b=MyFcfuiCE/Arjwa8dtjKF1Up6sQthULKWwAME0rnEos+0rsjEd2n2dWe925KUkejh1qjazKB/oXoqTz1Wj8vK32dmxfsfOnl2ytkJBYXjN/xc204g1CMWVAxTqKLjHQCj77Azo2Hk5GfpCM6aW2q7W2Sy4YWXngXnR7irzRnU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697735; c=relaxed/simple;
	bh=ea7D29uoOqjOfB/f5TelSTMiblUe4yhbfwmKjKO39pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Khrho8kz5cDpYIBLvhxJLvKdQ2Obj0IjgY1ktcDWTrwqSdOa3/sZAJxPbCvHkPi/d4QU0cw5bFWsy4aNSUT4OH5JquLU5twCig+e+GbePyFpopZdjUSQU8WnqB91sk8vbajWNmnaJikhXVtpawiMQDIS7BYir9HQWWDq/PWJe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=IJVEgw6T; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gq+LmaCh; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="IJVEgw6T";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gq+LmaCh"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=IJVEgw6Twkp7u5K+4fwW7j7DHmp6+0ZGXp7XGjoCOH7sN3tK4hc0tYk3lvu0ltQo1KTfVEonbByExCWhuL8t+YhStI0hE91SIo80yRUH43LQwZKC4N4cF02/oNEayRPkFKPBoMHNJXpl1t8mcqx/0Bwss0d5HzWeETxuQZdn+HRh7nt08rz1sVdTwfiV/8TY4in5AY+OossOsKD5Tamyk+dW+FRdGm2+NfST+THDNAXZYfboypAkAGrGlFfBx9TctVkJ5D2LXavF0gTpBOJpZopE8xXDVC6DBF6Mmhc327Nqb8ymQK3hj5P4h/5pxi9Xv2lN/PTbn2Ah4Bs4WEVzNA==; s=purelymail1; d=rcpassos.me; v=1; bh=ea7D29uoOqjOfB/f5TelSTMiblUe4yhbfwmKjKO39pQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gq+LmaChf3q7QQTSsKHgMVGAJsg3CWNItrKapyYi+tqVs8MADCdAB1PvRFuE7YxnLKpcmyp+tSnpgJIUGhkzvVptA1gSfgKRz5FX3LNlGR2Q71AaF+wk4g19aX2Ef4mz6USssUDnKgsKTH74PvUcN2KAzSWjIGZt9Cl/CVH56FHNxXmoVQly/G565o2kUtssCmd5Ezp6zY9R4kbZkLYBMD3OwNo5jaTSO82dnl/jN5Kh1Qe2u0xXvM8I8GW37tvfQ/DSHm3tDBJ+Y5HuYz7eV8ZkDAHErtGCBAjiE6INFfnyiIqPf1doOxJ47qjBJu+QR92d+srWRVRY2a2jKz+Z9g==; s=purelymail1; d=purelymail.com; v=1; bh=ea7D29uoOqjOfB/f5TelSTMiblUe4yhbfwmKjKO39pQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 445827024;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 10 Jul 2026 15:35:21 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH 1/3] HID: wiimote: turn on the LEDs indicating the controller id
Date: Fri, 10 Jul 2026 12:32:09 -0300
Message-ID: <20260710153456.2093889-2-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710153456.2093889-1-rafael@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The behavior in a Wii/Wii U console is to have each controller turn on
a different LED indicating the controller id.
This commit implements the same behavior using the ida struct.
Unlike switch controllers, each ID only turns one LED (from 1 to 4).

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c | 46 +++++++++++++++++++++++++++++-----
 drivers/hid/hid-wiimote.h      |  8 ++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 63c4fa8fbb9b..0d36a38bdcda 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -671,6 +671,12 @@ static void wiimote_modules_load(struct wiimote_data *=
wdata,
 =09spin_lock_irq(&wdata->state.lock);
 =09wdata->state.devtype =3D devtype;
 =09spin_unlock_irq(&wdata->state.lock);
+
+=09/* after loading all modules, set the LED for the player ID cycling fro=
m 1 to 4*/
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wiiproto_req_leds(wdata, player_leds[(wdata->instance_id - 1) % 4]);
+=09}
+
 =09return;
=20
 error:
@@ -855,11 +861,11 @@ static void wiimote_init_set_type(struct wiimote_data=
 *wdata,
=20
 done:
 =09if (devtype =3D=3D WIIMOTE_DEV_GENERIC)
-=09=09hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID:=
 %04x EXT: %04x\n",
-=09=09=09name, vendor, product, exttype);
+=09=09hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID:=
 %04x EXT: %04x (%d)\n",
+=09=09=09name, vendor, product, exttype, wdata->instance_id);
 =09else
-=09=09hid_info(wdata->hdev, "detected device: %s\n",
-=09=09=09 wiimote_devtype_names[devtype]);
+=09=09hid_info(wdata->hdev, "detected device: %s (%d)\n",
+=09=09=09 wiimote_devtype_names[devtype], wdata->instance_id);
=20
 =09wiimote_modules_load(wdata, devtype);
 }
@@ -1786,11 +1792,15 @@ static void wiimote_destroy(struct wiimote_data *wd=
ata)
 =09kfree(wdata);
 }
=20
+/* Global id allocator for wii remotes */
+static DEFINE_IDA(wiimote_ida);
+
 static int wiimote_hid_probe(struct hid_device *hdev,
 =09=09=09=09const struct hid_device_id *id)
 {
 =09struct wiimote_data *wdata;
 =09int ret;
+=09int instance_id;
=20
 =09hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
=20
@@ -1834,7 +1844,15 @@ static int wiimote_hid_probe(struct hid_device *hdev=
,
 =09if (ret)
 =09=09goto err_free;
=20
-=09hid_info(hdev, "New device registered\n");
+=09instance_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
+=09if (!instance_id) {
+=09=09hid_err(hdev, "cannot allocate controller id, defaulting to 1\n");
+=09=09instance_id =3D 1;
+=09}
+
+=09wdata->instance_id =3D instance_id;
+
+=09hid_info(hdev, "New device registered (Wiimote %d)\n", instance_id);
=20
 =09/* schedule device detection */
 =09wiimote_schedule(wdata);
@@ -1862,6 +1880,8 @@ static void wiimote_hid_remove(struct hid_device *hde=
v)
 {
 =09struct wiimote_data *wdata =3D hid_get_drvdata(hdev);
=20
+=09ida_free(&wiimote_ida, wdata->instance_id);
+
 =09hid_info(hdev, "Device removed\n");
 =09wiimote_destroy(wdata);
 }
@@ -1887,7 +1907,21 @@ static struct hid_driver wiimote_hid_driver =3D {
 =09.remove =3D wiimote_hid_remove,
 =09.raw_event =3D wiimote_hid_event,
 };
-module_hid_driver(wiimote_hid_driver);
+
+
+static int __init wiimote_init(void)
+{
+=09return hid_register_driver(&wiimote_hid_driver);
+}
+
+static void __exit wiimote_exit(void)
+{
+=09hid_unregister_driver(&wiimote_hid_driver);
+=09ida_destroy(&wiimote_ida);
+}
+
+module_init(wiimote_init);
+module_exit(wiimote_exit);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 9c12f63f6dd2..639f67c24f15 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -50,6 +50,13 @@
 #define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT |=
 \
 =09=09=09=09=09=09=09WIIPROTO_FLAG_IR_FULL)
=20
+static const __u8 player_leds[] =3D {
+        WIIPROTO_FLAG_LED1,
+        WIIPROTO_FLAG_LED2,
+        WIIPROTO_FLAG_LED3,
+        WIIPROTO_FLAG_LED4
+};
+
 /* return flag for led \num */
 #define WIIPROTO_FLAG_LED(num) (WIIPROTO_FLAG_LED1 << (num - 1))
=20
@@ -153,6 +160,7 @@ struct wiimote_data {
 =09struct input_dev *mp;
 =09struct timer_list timer;
 =09struct wiimote_debug *debug;
+=09int instance_id;
=20
 =09union {
 =09=09struct input_dev *input;
--=20
2.53.0

