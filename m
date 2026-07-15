Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5D3BB66C
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150795; cv=none; b=VwG3y4piYhhDGa7E8TlCeK+/m96o1CCoSd0T3J63ke0CtYo7WZXrHEBdsk89mIR+Fv+jzHUdvfmhvYKHankHGR+eewDddTOe9wSWw/O6IkgzDFR45ity9eIzEzd1OlqUlN74e59zD2g/161IPaEaQXVTlpZYTiBJX9776Dku2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150795; c=relaxed/simple;
	bh=6HDeyOm6Rxl69QhtlH0SXyraybnfMlhuXgj7VGCzcxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP4LCzYyijHllkBEJ75oXfzS5fFLnkh4mqUg6SUJc3JFAJK2LUvb9kUTB+5zPA+nbONJZRk41XH0RGR1DFoH8XqD7HNQ5H0GCUld0ZK9Mo1IeqE6DMoD/h8t/Pf048fxuzLJptxZq8h/CeZDCd0NXRaH/atA8Xt6EDeLkPh8T4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=N95ayz6J; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FdTydHdz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="N95ayz6J";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FdTydHdz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=N95ayz6JoJ2/5pK/rvIo01uH3HXzOcBd03Nxfidd57MFM08r3GrVab4RlV4/VpKn1NgPQ79eqNEA2NLjrlM7qwOF+mwm0Rk9cHym495Jty29BaQe16Tqsg5yJ1uVmREpF9Plc1Dsr6HwFNor5jzUH7B5hZkkuU0JEq5GY7SIWJH0vAi2zWZLBcdRR+/W/wOZvsUsS7k+TWosY5GF+IaNHWe4/Ggcmn4m30798OEWNsnyFTG9hoQpVKCtoYI1nvkl4i36p0RTSGByIwIBRICRDupe8xpAlr2gI6fj3HvueolIwws9BWNdIZSghQPYT+mlqLNP8ywWCSSd/YPWzZg76Q==; s=purelymail2; d=rcpassos.me; v=1; bh=6HDeyOm6Rxl69QhtlH0SXyraybnfMlhuXgj7VGCzcxM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=FdTydHdzCeK1+u07T7tlLjUcMv+2yvGAlndDkuc21XwwLIMUsn2Prq8BoQt3XLOMam72khIWxyEZdL0rVHx2c2f5Qn88qsHOttW+tMD8+faOECdVpL3HCSqoc5FdgE9Czh2JDuAJ4/Ndhitd718jmyOa8lkkQ8yXT0tSU+p1R1zWTeDVjSerQ3R9Hz7Gjv9zeA46zgeBLArC1bMQMR4cUA06lhQoCe9rf1kTcJ/M3cVmQ2kriSmiESRm+vk7yyHUqPTWviNWgz8Vr9dGtWDTyCtITiDM/zGtPM6IrurphCDVm2VFXA/KbVTJzeNUOMezP6Ax9QjCjFCqL0oAstSF5A==; s=purelymail2; d=purelymail.com; v=1; bh=6HDeyOm6Rxl69QhtlH0SXyraybnfMlhuXgj7VGCzcxM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 471802508;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 21:26:25 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: jkoolstra@xs4all.nl,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 1/4] HID: wiimote: turn on the LEDs indicating the controller id
Date: Wed, 15 Jul 2026 18:24:53 -0300
Message-ID: <20260715212501.3920033-2-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715212501.3920033-1-rafael@rcpassos.me>
References: <20260715212501.3920033-1-rafael@rcpassos.me>
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
 drivers/hid/hid-wiimote-core.c | 54 ++++++++++++++++++++++++++++++----
 drivers/hid/hid-wiimote.h      |  1 +
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 63c4fa8fbb9b..91c2cec35f6e 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -621,6 +621,13 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE=
_DEV_NUM] =3D {
 =09},
 };
=20
+static const __u8 player_leds[] =3D {
+=09WIIPROTO_FLAG_LED1,
+=09WIIPROTO_FLAG_LED2,
+=09WIIPROTO_FLAG_LED3,
+=09WIIPROTO_FLAG_LED4
+};
+
 static void wiimote_modules_load(struct wiimote_data *wdata,
 =09=09=09=09 unsigned int devtype)
 {
@@ -671,6 +678,12 @@ static void wiimote_modules_load(struct wiimote_data *=
wdata,
 =09spin_lock_irq(&wdata->state.lock);
 =09wdata->state.devtype =3D devtype;
 =09spin_unlock_irq(&wdata->state.lock);
+
+=09/* after loading all modules, set the LED for the player ID cycling fro=
m 1 to 4*/
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
+=09}
+
 =09return;
=20
 error:
@@ -855,11 +868,11 @@ static void wiimote_init_set_type(struct wiimote_data=
 *wdata,
=20
 done:
 =09if (devtype =3D=3D WIIMOTE_DEV_GENERIC)
-=09=09hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID:=
 %04x EXT: %04x\n",
-=09=09=09name, vendor, product, exttype);
+=09=09hid_info(wdata->hdev, "cannot detect device; NAME: %s VID: %04x PID:=
 %04x EXT: %04x (%d)\n",
+=09=09=09name, vendor, product, exttype, wdata->player_id);
 =09else
-=09=09hid_info(wdata->hdev, "detected device: %s\n",
-=09=09=09 wiimote_devtype_names[devtype]);
+=09=09hid_info(wdata->hdev, "detected device: %s (%d)\n",
+=09=09=09 wiimote_devtype_names[devtype], wdata->player_id);
=20
 =09wiimote_modules_load(wdata, devtype);
 }
@@ -1786,11 +1799,15 @@ static void wiimote_destroy(struct wiimote_data *wd=
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
+=09int player_id;
=20
 =09hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
=20
@@ -1834,7 +1851,16 @@ static int wiimote_hid_probe(struct hid_device *hdev=
,
 =09if (ret)
 =09=09goto err_free;
=20
-=09hid_info(hdev, "New device registered\n");
+=09player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
+=09if (player_id < 1) {
+=09=09hid_err(hdev, "cannot allocate controller id\n");
+=09=09ret =3D player_id;
+=09=09goto err_free;
+=09}
+
+=09wdata->player_id =3D player_id;
+
+=09hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);
=20
 =09/* schedule device detection */
 =09wiimote_schedule(wdata);
@@ -1862,6 +1888,8 @@ static void wiimote_hid_remove(struct hid_device *hde=
v)
 {
 =09struct wiimote_data *wdata =3D hid_get_drvdata(hdev);
=20
+=09ida_free(&wiimote_ida, wdata->player_id);
+
 =09hid_info(hdev, "Device removed\n");
 =09wiimote_destroy(wdata);
 }
@@ -1887,7 +1915,21 @@ static struct hid_driver wiimote_hid_driver =3D {
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
index 9c12f63f6dd2..a53f72d5077e 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -153,6 +153,7 @@ struct wiimote_data {
 =09struct input_dev *mp;
 =09struct timer_list timer;
 =09struct wiimote_debug *debug;
+=09__u8 player_id;
=20
 =09union {
 =09=09struct input_dev *input;
--=20
2.53.0

