Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73945C6F2
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343908; cv=none; b=N9HU7MOU0Eu5rvWohq/TgMf4Q+u5+g+qW4OSiCxNL/htWc+fILAACL5Cx6rxF7gRjTHXHDh6KIOVIb7UoeoxaHu/YNKnBVqURwQ38q/6q0LB1vsxSTxKM04OY607+k+qdyxdd/3C7KGB4lcc7NVSFo0tG3EFSegYSs4RQOhSDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343908; c=relaxed/simple;
	bh=DPSxqD4stQtCYVrRcPEe3crNEdzdFaTpCsX+KmIeTrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fd8FPHjVWgEYm5OcniBYALHK6kHkp2YeZXytSLUH7sMG+DvaSuolcj50TN3bI+YGshDaAxa4COS//uB6aB4xHh141WEBdOJ3cC82414OdgwRDvNxdkU+luP/8bDQnKnfyQ/fLZ8Gg1xTdVnA7L66jSwPcsLQyMxGS3Fu1UzCmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=nubeV5wk; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jqySyFd/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="nubeV5wk";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jqySyFd/"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=nubeV5wkr4BCQzA0QYvHoAeJ2bGlL57aK4iTTZmC+VJeGd6+uOmJrsvmJBBrHgI4N6IXWM5uI5tOEMtr0j7G6jOH60hIXOrgXlrNf4x7jAZiqDxxkcvjwsub8xuh7CsTL9m9FzjT2wxyoRETy6IO/9pnWkIg58qk5Zmlra7Sjc/HuaH6iHz46WxAlmR15CUH144KSOT4D2JULgDrEDeZQ0FK+I8OQgxQRMw6psx+dcSBxgSeHdoZ7UD+GVOUmEYZ1wHi7cs62hdZs6i6KWokrnQkS7mKR6Bl/pWKjjOSWOwD3c1M4oKSr3V0xNdOUiDPcioX5e3ow4s6Sgna32UkhQ==; s=purelymail3; d=rcpassos.me; v=1; bh=DPSxqD4stQtCYVrRcPEe3crNEdzdFaTpCsX+KmIeTrw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jqySyFd/mf60pGIJB9aqsNVAk1arnNrT/HBJdGN7o4fK91TaDC0fTHLA4G8jE7hhB440mORlU9HcR/yrOm2ZsM48A6WRFVmVr3CEbmrjJKyhcl0WrnY6mney5uVKFDLu6l4l23AOQOKEwbaGveJtHmu0G7C6AcAIIPSQiFszDx1r+kCUFDt6s8wZ5ooTr18k01Cex8PiAF1yuSBZdBVn4f1Ds715aWRpcbd0z1EPuQd945UvuSyUqNTG1h3Y8Tu2aDyHe2pM6MAYYa5CGh7vPKq4kbjg9vI/S/YEyLjCKG/kYXEj8+QlBm+2JZQALiGEG0LokKyO86v/c8vXwZDx4g==; s=purelymail3; d=purelymail.com; v=1; bh=DPSxqD4stQtCYVrRcPEe3crNEdzdFaTpCsX+KmIeTrw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2129648507;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 29 Jul 2026 16:51:33 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v3 1/4] HID: wiimote: turn on the LEDs indicating the controller id
Date: Wed, 29 Jul 2026 13:49:12 -0300
Message-ID: <20260729164928.1138468-2-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729164928.1138468-1-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
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
index 63c4fa8fbb9b6..48830f2ffcb50 100644
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
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09/* after loading modules, set the Player ID LED cycling from 1 to 4*=
/
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
index 9c12f63f6dd2d..a53f72d5077ef 100644
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

