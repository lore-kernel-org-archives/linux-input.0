Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397237E2EC
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002775; cv=none; b=lwlcgNUUSA1M73UK621CfFY37ne3Vi9Zgk3ptveMuEutNueWqn+VaT9UC06YxApffShto5o/jHcmZKo2U4pR1LkF9xWkjRB5Xigq/p4v1lRGodE2BUTChlnuc/e7g0a6fg+YKUM2tE3QoY4lWKFU0MD94E3Ss3g2D9rnLpYbnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002775; c=relaxed/simple;
	bh=drCY7iD3lQsw26B9FjJSJPqxFEOTS5tLXUhMLlyDTTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwRNED7NZVGZjNReydamfinwKUYhjPaQTrzlvff5D6syzMCOMLLBdIRkVF1d5pOr8BJ/ISBGKaW6NPpj0na9IyVqevK6NRGshKNohMl2Z/MV2jX3DiwxGzmV+q5tvh6dYDR4BgTYKpi8VaqyzhMp1tU6D+Rha6sL+TuE88Rs5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=bcBM0WNB; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VOdN8KX8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="bcBM0WNB";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VOdN8KX8"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bcBM0WNBEhv7C1fkjoZD9B7al+k8YI68GboNwpQST6+IjpRS/TbnLqm52NFbBg0Huv8XmoJCYeu/qYYDEUhB+uSOomgDP8ec5MsThQzl9zje3P6t+7BTkeL6uDGRlvX2pvPyoTZHaMRgQzrrlPpY0yuytYaheHjuDydv+GtrFQPeGe7rDxqiA2CdmOumfy9SYDl4vpUbq20hypF5glkLUxKNPZetXZzPTpD3UucNeUzipGwuuTFMLkQq5zZzaguNzkU+IsrzvCoF9AZDoejjZF33RkRqYKcHS1uDU805hdgDKJG56/6C53GB2rDVfgRC1WDZ4Opq0duDAO2R4GhKsg==; s=purelymail3; d=rcpassos.me; v=1; bh=drCY7iD3lQsw26B9FjJSJPqxFEOTS5tLXUhMLlyDTTU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=VOdN8KX8GJSNt027XOJ44ZrLmeaQCrVzHTXzpB8dmCGyZqdDsB5yq5EGC8AqTEa4G9wMeKRWB66DipxcYf6FhuBbEMpw/7rx+XPpkmqF2s+tZ95y6kUSbSX0Vhtq6xtnwn1UjqCS2Ob/AbDYwLyyFeH8Xbj8hET6ztaR++XvmQAOQ0kOshCBesrjmiCYTqtwE5lQGxDl5B9d18+vyF2CEy4IUW0V+CVxAvkUAwiYP+9qsF+ZozLQzBQPEzQU+if3ejGYmj77OZh3DUUxezLhVrL2xXrSZZnIR7okCMjLbtF2fuyVRZ+2uy8QxNsb7/URBvcTLtBWFMmopy4kq7xYYg==; s=purelymail3; d=purelymail.com; v=1; bh=drCY7iD3lQsw26B9FjJSJPqxFEOTS5tLXUhMLlyDTTU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1866441726;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 21:39:23 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 1/4] HID: wiimote: turn on the LEDs indicating the controller id
Date: Mon, 17 Aug 2026 18:38:21 -0300
Message-ID: <20260817213840.1053216-2-rafael@rcpassos.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817213840.1053216-1-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
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
 drivers/hid/hid-wiimote-core.c  | 52 +++++++++++++++++++++++++++++----
 drivers/hid/hid-wiimote-debug.c |  5 +++-
 drivers/hid/hid-wiimote.h       |  1 +
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 63c4fa8fbb9b..acf31d8b6991 100644
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
@@ -1752,6 +1765,7 @@ static struct wiimote_data *wiimote_create(struct hid=
_device *hdev)
 =09mutex_init(&wdata->state.sync);
 =09wdata->state.drm =3D WIIPROTO_REQ_DRM_K;
 =09wdata->state.cmd_battery =3D 0xff;
+=09wdata->player_id =3D 0; // min 1, u8 0 is unasigned id
=20
 =09INIT_WORK(&wdata->init_worker, wiimote_init_worker);
 =09timer_setup(&wdata->timer, wiimote_init_timeout, 0);
@@ -1759,12 +1773,17 @@ static struct wiimote_data *wiimote_create(struct h=
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
+=09ida_free(&wiimote_ida, wdata->player_id);
+
 =09/* prevent init_worker from being scheduled again */
 =09spin_lock_irqsave(&wdata->state.lock, flags);
 =09wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
@@ -1834,7 +1853,14 @@ static int wiimote_hid_probe(struct hid_device *hdev=
,
 =09if (ret)
 =09=09goto err_free;
=20
-=09hid_info(hdev, "New device registered\n");
+=09ret =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
+=09if (ret < 1) {
+=09=09hid_err(hdev, "cannot allocate controller id\n");
+=09=09goto err_free;
+=09}
+
+=09wdata->player_id =3D ret;
+=09hid_info(hdev, "New device registered (Wiimote %d)\n", ret);
=20
 =09/* schedule device detection */
 =09wiimote_schedule(wdata);
@@ -1887,7 +1913,21 @@ static struct hid_driver wiimote_hid_driver =3D {
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
index 5f74917781f2..fc847c2a1c1f 100644
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
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 9c12f63f6dd2..8e5002f515e2 100644
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

