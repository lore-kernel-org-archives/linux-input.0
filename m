Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BD235045
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002911; cv=none; b=JnDBwz/mxPrPjRmE+sUSpREig4Q0BdeSed8syeJ58vdA11jmnpsJ0LrPszO+IzybY5alLONBjtyzDj7gH9OVlARNaSY/c1mnyFaMHOXdn6hLL+D+fg5eOUIWx5mEECwVPuCh8lR9a9Jvf7ITzJHkpFpD70Icworg5jiqruDkOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002911; c=relaxed/simple;
	bh=yWarL+5InJhHKVXgaTdqSG8RICIjAqtL5uvToEj4C3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC/PhW+jztWPW58kYl7EciwZAluU/latbIeoVrHZjZEhlQCh27Oe8aFvsyzb9t9sHgzq9p7K0iBZ2HaoFuy35RI7ccN97kPLhv43rMnDSjDe8Awk23Ux4fEcv0omBviLcqeNHGgrJarr7ZfB42JCOe6liH01CJQV92/Xr/wZWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=XaSzDMg9; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=PdYTH2YE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="XaSzDMg9";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="PdYTH2YE"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=XaSzDMg9ICqwvMwz8m3XXV5WUq5iIoYPzD1IczkZMmULKyXqVgrtZeD4rHcbjYesKyrSSDGNpiZH/zLMvYxaf+ATuZH3247OjfYO+A76ShZhH4NGcghDfYP+UsYLM3VcdbgT+HN2Zu9xPMsDPe1D2JcSzx4+1ezpwamnmqp9fS2QgsjzHK5a4HW2MwJPC+aQdlYGMllm+GxMSQTdNdkeMrY5qoKmdle9dzqKRibfLswcvgz8yMtDFWi81ucUicGKqPitCrMwwnVKQGmvHSMqQwkDSK//Ki6yI6c3BpXmPNS+tPIeA0edlNaXGOIKw1jKRZiITjb5JxDgNPEzO6DnDg==; s=purelymail3; d=rcpassos.me; v=1; bh=yWarL+5InJhHKVXgaTdqSG8RICIjAqtL5uvToEj4C3c=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=PdYTH2YEFzUmCQU0au0ODuvaDvAu400b3bYzdWYFQ4EQs5mUzW8GQBBL6wfkIOeacDgwPgrFpghlCEhbuTF/vlGLFgwc6o+V1fnXmcGpJT3LzL5Yr9yKja5NIv4d8lSbtBCZmiROj4MkL6Kz/X6iUThtHbOhKtZurcT5y6GyRzmeyCh8dSIW2olR3KGqf26pFGF0+Q8r9Vw2BFkBfkSOpvo+9Ddg8HR5wdbfi2B319MCYDdq8XpUVI9rdCy6/Yb5F0w/1yQEU9VQ6yoBGq1o7+Cm1kfzM+HkYkbW+3nx83lXQnTGeRSIXfqnhWbnkR+Do4OBYmaHoiAc9fNf+CprkQ==; s=purelymail3; d=purelymail.com; v=1; bh=yWarL+5InJhHKVXgaTdqSG8RICIjAqtL5uvToEj4C3c=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1866441726;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 21:41:39 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 4/4] HID: wiimote: wiimote_probe with scoped cleanup
Date: Mon, 17 Aug 2026 18:38:24 -0300
Message-ID: <20260817213840.1053216-5-rafael@rcpassos.me>
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

Use the safer scoped cleanup with a single destroy function.
A new bitmask was introduced to track probing state.
This is needed because the hid_hw calls cannot be made with null.

A few other functions are safe to call without checking.
These cases are annotated with comments above them.

Also, a new debugfs entry was added tracking this new state (bitmask).

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c  | 78 +++++++++++++++++++--------------
 drivers/hid/hid-wiimote-debug.c |  4 ++
 drivers/hid/hid-wiimote.h       |  9 ++++
 3 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 05f8ddb7909b..044da4daa010 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -679,6 +679,8 @@ static void wiimote_modules_load(struct wiimote_data *w=
data,
 =09=09wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
 =09}
=20
+
+=09wdata->init_state |=3D WIIMOTE_MODULES_LOADED;
 =09return;
=20
 error:
@@ -742,6 +744,8 @@ static void wiimote_ext_load(struct wiimote_data *wdata=
, unsigned int ext)
=20
 =09scoped_guard(spinlock_irqsave, &wdata->state.lock)
 =09=09wdata->state.exttype =3D ext;
+
+=09wdata->init_state |=3D WIIMOTE_EXT_LOADED;
 }
=20
 static void wiimote_ext_unload(struct wiimote_data *wdata)
@@ -774,6 +778,8 @@ static void wiimote_mp_load(struct wiimote_data *wdata)
=20
 =09scoped_guard(spinlock_irqsave, &wdata->state.lock)
 =09=09wdata->state.mp =3D mode;
+
+=09wdata->init_state |=3D WIIMOTE_MP_LOADED;
 }
=20
 static void wiimote_mp_unload(struct wiimote_data *wdata)
@@ -1751,39 +1757,56 @@ static DEFINE_IDA(wiimote_ida);
=20
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+=09if (!wdata)
+=09=09return;
+
+=09// safe, debugfs checks IS_ERR_OR_NULL
 =09wiidebug_deinit(wdata);
=20
-=09ida_free(&wiimote_ida, wdata->player_id);
+=09if (wdata->player_id)
+=09=09ida_free(&wiimote_ida, wdata->player_id);
=20
 =09/* prevent init_worker from being scheduled again */
 =09scoped_guard(spinlock_irqsave, &wdata->state.lock)
 =09=09wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
=20
-=09cancel_work_sync(&wdata->init_worker);
-=09timer_shutdown_sync(&wdata->timer);
+=09if (wdata->init_state & WIIMOTE_PROBE_READY) {
+=09=09cancel_work_sync(&wdata->init_worker);
+=09=09timer_shutdown_sync(&wdata->timer);
+=09}
=20
+=09// safe, checks dev for NULL
 =09device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
 =09device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
=20
-=09wiimote_mp_unload(wdata);
-=09wiimote_ext_unload(wdata);
-=09wiimote_modules_unload(wdata);
+=09if (wdata->init_state & WIIMOTE_MP_LOADED)
+=09=09wiimote_mp_unload(wdata);
+=09if (wdata->init_state & WIIMOTE_EXT_LOADED)
+=09=09wiimote_ext_unload(wdata);
+=09if (wdata->init_state & WIIMOTE_MODULES_LOADED)
+=09=09wiimote_modules_unload(wdata);
+
 =09cancel_work_sync(&wdata->queue.worker);
-=09hid_hw_close(wdata->hdev);
-=09hid_hw_stop(wdata->hdev);
+
+=09if (wdata->init_state & WIIMOTE_PROBE_HW_OPENED)
+=09=09hid_hw_close(wdata->hdev);
+=09if (wdata->init_state & WIIMOTE_PROBE_HW_STARTED)
+=09=09hid_hw_stop(wdata->hdev);
=20
 =09kfree(wdata);
 }
=20
+DEFINE_FREE(wiimote_probe_cleanup, struct wiimote_data *,
+=09wiimote_destroy(_T))
+
 static int wiimote_hid_probe(struct hid_device *hdev,
 =09=09=09=09const struct hid_device_id *id)
 {
-=09struct wiimote_data *wdata;
 =09int ret;
=20
 =09hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
=20
-=09wdata =3D wiimote_create(hdev);
+=09struct wiimote_data *wdata __free(wiimote_probe_cleanup) =3D wiimote_cr=
eate(hdev);
 =09if (!wdata) {
 =09=09hid_err(hdev, "Can't alloc device\n");
 =09=09return -ENOMEM;
@@ -1792,41 +1815,43 @@ static int wiimote_hid_probe(struct hid_device *hde=
v,
 =09ret =3D hid_parse(hdev);
 =09if (ret) {
 =09=09hid_err(hdev, "HID parse failed\n");
-=09=09goto err;
+=09=09return ret;
 =09}
=20
 =09ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 =09if (ret) {
 =09=09hid_err(hdev, "HW start failed\n");
-=09=09goto err;
+=09=09return ret;
 =09}
+=09wdata->init_state |=3D WIIMOTE_PROBE_HW_STARTED;
=20
 =09ret =3D hid_hw_open(hdev);
 =09if (ret) {
 =09=09hid_err(hdev, "cannot start hardware I/O\n");
-=09=09goto err_stop;
+=09=09return ret;
 =09}
+=09wdata->init_state |=3D WIIMOTE_PROBE_HW_OPENED;
=20
 =09ret =3D device_create_file(&hdev->dev, &dev_attr_extension);
 =09if (ret) {
 =09=09hid_err(hdev, "cannot create sysfs attribute\n");
-=09=09goto err_close;
+=09=09return ret;
 =09}
=20
 =09ret =3D device_create_file(&hdev->dev, &dev_attr_devtype);
 =09if (ret) {
 =09=09hid_err(hdev, "cannot create sysfs attribute\n");
-=09=09goto err_ext;
+=09=09return ret;
 =09}
=20
 =09ret =3D wiidebug_init(wdata);
 =09if (ret)
-=09=09goto err_free;
+=09=09return ret;
=20
 =09ret =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
 =09if (ret < 1) {
 =09=09hid_err(hdev, "cannot allocate controller id\n");
-=09=09goto err_free;
+=09=09return ret;
 =09}
=20
 =09wdata->player_id =3D ret;
@@ -1834,24 +1859,10 @@ static int wiimote_hid_probe(struct hid_device *hde=
v,
=20
 =09/* schedule device detection */
 =09wiimote_schedule(wdata);
+=09wdata->init_state |=3D WIIMOTE_PROBE_READY;
=20
+=09retain_and_null_ptr(wdata);
 =09return 0;
-
-err_free:
-=09wiimote_destroy(wdata);
-=09return ret;
-
-err_ext:
-=09device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
-err_close:
-=09hid_hw_close(hdev);
-err_stop:
-=09hid_hw_stop(hdev);
-err:
-=09input_free_device(wdata->ir);
-=09input_free_device(wdata->accel);
-=09kfree(wdata);
-=09return ret;
 }
=20
 static void wiimote_hid_remove(struct hid_device *hdev)
@@ -1902,3 +1913,4 @@ module_exit(wiimote_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Herrmann <dh.herrmann@gmail.com>");
 MODULE_DESCRIPTION("Driver for Nintendo Wii / Wii U peripherals");
+
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debu=
g.c
index b8027bb23608..1353ab022acb 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -184,6 +184,9 @@ int wiidebug_init(struct wiimote_data *wdata)
 =09debugfs_create_u8("player_id", S_IRUSR,
 =09=09   dbg->wdata->hdev->debug_dir, &wdata->player_id);
=20
+=09debugfs_create_u8("init_state", S_IRUSR,
+=09=09   dbg->wdata->hdev->debug_dir, &wdata->init_state);
+
 =09scoped_guard(spinlock_irqsave, &wdata->state.lock)
 =09=09wdata->debug =3D dbg;
=20
@@ -203,5 +206,6 @@ void wiidebug_deinit(struct wiimote_data *wdata)
 =09debugfs_remove(dbg->drm);
 =09debugfs_remove(dbg->eeprom);
 =09debugfs_lookup_and_remove("player_id", dbg->wdata->hdev->debug_dir);
+=09debugfs_lookup_and_remove("init_state", dbg->wdata->hdev->debug_dir);
 =09kfree(dbg);
 }
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 8e5002f515e2..147751973702 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -154,6 +154,7 @@ struct wiimote_data {
 =09struct timer_list timer;
 =09struct wiimote_debug *debug;
 =09u8 player_id;
+=09u8 init_state;
=20
 =09union {
 =09=09struct input_dev *input;
@@ -376,4 +377,12 @@ static inline int wiimote_cmd_wait_noint(struct wiimot=
e_data *wdata)
 =09=09return 0;
 }
=20
+/* controller initialization tracker bits */
+#define WIIMOTE_PROBE_HW_STARTED  BIT(0)  // hid_hw_start succeeded
+#define WIIMOTE_PROBE_HW_OPENED   BIT(1)  // hid_hw_open succeeded
+#define WIIMOTE_PROBE_READY       BIT(2)  // wiimote_schedule succeeded
+#define WIIMOTE_MP_LOADED         BIT(3)  // wiimote_mp_load succeeded
+#define WIIMOTE_EXT_LOADED        BIT(4)  // wiimote_ext_load succeeded
+#define WIIMOTE_MODULES_LOADED    BIT(5)  // wiimote_modules_load succeede=
d
+
 #endif
--=20
2.55.0

