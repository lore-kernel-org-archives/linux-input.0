Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E347357D0B
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512972; cv=none; b=ukmu59vv/rqF9eBIPLUs2A8MsO/BnFSIYQBOErh6xIzYX6PE8blgDJ33oybLjQVMdsGDkvDMefnGCW224kL7yzrHPMbc8zLSHCG3d8YJaE9EgIpHMQTZuy4T5bgTfUJhopwNXQY9HUSNb0lqLoEau9Msy8rtxtwRRPKkH5Z7tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512972; c=relaxed/simple;
	bh=a5+ZIkTUKRw03eYwSF4tI2DVN57Yx1nLK24GhEOXKKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5HG9fQhtfDmdGC2IUs9KAryNHXclBJaEXoU0IeEiyHYVFpjKBVy6SsQBve7p6YBFK1KdPUOblG5poGtdKi44ln/EyLeS6999oX6vS2We74wbb1JlYNTDVdJ+/e4EGH4bXbGxmbLlGb+gSMrZ7jZFYd7qiN+E+WBiEAHqWGU248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=USkd123t; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Tl2muRfE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="USkd123t";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Tl2muRfE"
DKIM-Signature: a=rsa-sha256; b=USkd123tW5q8J5/rG0cEn5fyv0k+kQSWPVPrcrrhNgDD/m873eiBgfDP2bJtB1u3K4lUkulUZjQIL503prUp3LS/8yuMUgoN+AMfcjT5XToGCRlq41fh4WyVvBkKJJDomF8Qeq/DnHqR53UDcc1qAYygQLhQtJlOICnv3Guq+fFxoxchKlhMp5l9EVxQJvz6xfm4MvMAz2CRszsEx+PyuodhFq43Q1MzG/BTELVwiB2bMmiapc6Rl+UA422MK7FCDtbnR1+xasycJoY4PG9gao1paWCbFd7MveEW2cKKNXeitw6/IJV7K5tA82qgBDgg4SId/KiJ8Z+dCF+icKydIQ==; s=purelymail2; d=rcpassos.me; v=1; bh=a5+ZIkTUKRw03eYwSF4tI2DVN57Yx1nLK24GhEOXKKg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Tl2muRfEiy6MLJf4LWDJpO1+Unjl7RzJDmGl4XqZr2o8MGCHKTQDpR3zS9iyE9NwLzlyE43vZqTiqLbvA3ZrSd2e1v+ApsfyflnTHpR84fkUdWgsY/B4Q9mYPpfyINA88D0KaliyB+vtmQPcWdxsvoR7V+VcKWEOtnHjIJY7sCd27fFCw1J1UVoJEarZfq+dKqeCCp1sg96ftbOI3/0uUOJBYtHASVUuh083S3l7xMbyB/aDgD8cikede6mrr7pnJ3jGAigHqCL2DCCv3Ush1ixdcw+Ix4hgcYPGwBPAxXAGxt5rBwghzpYdPy7wGLGHD2MAUsLBMqbSlvyI5YFPCw==; s=purelymail2; d=purelymail.com; v=1; bh=a5+ZIkTUKRw03eYwSF4tI2DVN57Yx1nLK24GhEOXKKg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 703998172;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 09 Oct 2026 02:29:11 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v5 1/3] HID: wiimote: turn on the LEDs indicating the controller id
Date: Thu,  8 Oct 2026 23:27:59 -0300
Message-ID: <20261009022844.2790778-2-rafael@rcpassos.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009022844.2790778-1-rafael@rcpassos.me>
References: <20261009022844.2790778-1-rafael@rcpassos.me>
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
Reviewed-by: David Rheinsberg <david@readahead.eu>
---
 drivers/hid/hid-wiimote-core.c    | 50 +++++++++++++++++++++++++++----
 drivers/hid/hid-wiimote-debug.c   |  5 +++-
 drivers/hid/hid-wiimote-modules.c |  7 -----
 drivers/hid/hid-wiimote.h         |  1 +
 4 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 63c4fa8fbb9b6..d86ddcdb240ba 100644
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
@@ -670,7 +677,10 @@ static void wiimote_modules_load(struct wiimote_data *=
wdata,
=20
 =09spin_lock_irq(&wdata->state.lock);
 =09wdata->state.devtype =3D devtype;
+=09/* after loading modules, set the Player ID LED cycling the available L=
EDs*/
+=09wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1U) % ARRAY_SI=
ZE(player_leds)]);
 =09spin_unlock_irq(&wdata->state.lock);
+
 =09return;
=20
 error:
@@ -855,11 +865,11 @@ static void wiimote_init_set_type(struct wiimote_data=
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
@@ -1752,6 +1762,7 @@ static struct wiimote_data *wiimote_create(struct hid=
_device *hdev)
 =09mutex_init(&wdata->state.sync);
 =09wdata->state.drm =3D WIIPROTO_REQ_DRM_K;
 =09wdata->state.cmd_battery =3D 0xff;
+=09wdata->player_id =3D 0; // min 1, u8 0 is unassigned id
=20
 =09INIT_WORK(&wdata->init_worker, wiimote_init_worker);
 =09timer_setup(&wdata->timer, wiimote_init_timeout, 0);
@@ -1759,12 +1770,18 @@ static struct wiimote_data *wiimote_create(struct h=
id_device *hdev)
 =09return wdata;
 }
=20
+/* Global id allocator for wii remotes */
+static DEFINE_IDA(wiimote_ida);
+
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
 =09unsigned long flags;
=20
 =09wiidebug_deinit(wdata);
=20
+=09if (wdata->player_id > 0)
+=09=09ida_free(&wiimote_ida, wdata->player_id);
+
 =09/* prevent init_worker from being scheduled again */
 =09spin_lock_irqsave(&wdata->state.lock, flags);
 =09wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
@@ -1834,7 +1851,14 @@ static int wiimote_hid_probe(struct hid_device *hdev=
,
 =09if (ret)
 =09=09goto err_free;
=20
-=09hid_info(hdev, "New device registered\n");
+=09ret =3D ida_alloc_range(&wiimote_ida, 1, 255, GFP_KERNEL);
+=09if (ret < 1) {
+=09=09hid_err(hdev, "cannot allocate controller id\n");
+=09=09goto err_free;
+=09}
+
+=09wdata->player_id =3D ret;
+=09hid_info(hdev, "New device registered (Wiimote %d)\n", wdata->player_id=
);
=20
 =09/* schedule device detection */
 =09wiimote_schedule(wdata);
@@ -1887,7 +1911,21 @@ static struct hid_driver wiimote_hid_driver =3D {
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
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debu=
g.c
index 5f74917781f28..fc847c2a1c1f1 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -186,12 +186,14 @@ int wiidebug_init(struct wiimote_data *wdata)
 =09dbg->drm =3D debugfs_create_file("drm", S_IRUSR,
 =09=09=09dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
=20
+=09debugfs_create_u8("player_id", S_IRUSR,
+=09=09   dbg->wdata->hdev->debug_dir, &wdata->player_id);
+
 =09spin_lock_irqsave(&wdata->state.lock, flags);
 =09wdata->debug =3D dbg;
 =09spin_unlock_irqrestore(&wdata->state.lock, flags);
=20
 =09return 0;
-
 }
=20
 void wiidebug_deinit(struct wiimote_data *wdata)
@@ -208,5 +210,6 @@ void wiidebug_deinit(struct wiimote_data *wdata)
=20
 =09debugfs_remove(dbg->drm);
 =09debugfs_remove(dbg->eeprom);
+=09debugfs_lookup_and_remove("player_id", dbg->wdata->hdev->debug_dir);
 =09kfree(dbg);
 }
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-mo=
dules.c
index dccb78bb3afd6..a3d3fda9703dc 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -362,13 +362,6 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
ps,
 =09if (ret)
 =09=09goto err_free;
=20
-=09/* enable LED1 to stop initial LED-blinking */
-=09if (ops->arg =3D=3D 0) {
-=09=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09=09wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
-=09=09spin_unlock_irqrestore(&wdata->state.lock, flags);
-=09}
-
 =09return 0;
=20
 err_free:
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 9c12f63f6dd2d..8e5002f515e24 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -153,6 +153,7 @@ struct wiimote_data {
 =09struct input_dev *mp;
 =09struct timer_list timer;
 =09struct wiimote_debug *debug;
+=09u8 player_id;
=20
 =09union {
 =09=09struct input_dev *input;
--=20
2.55.0

