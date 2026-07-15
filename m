Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292833BB66C
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150826; cv=none; b=olkbeUL1OVke6LwmORjFfYiXX+70ZNa37sNW5p4pq0qChRx+L8GZdDLLCwG41PRRXlEjZ5+LlrP//SbxJLkiK5FtilBBoT/CBd6ewbmoEr07DuqsmFxTyutPcIfZdV//DckztBeqWV32THH4dnSAxJlUa/n/2qkrTn0rypNhaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150826; c=relaxed/simple;
	bh=nBmv6AYmJmUEW/e16ZrUmZpe11wyGo2MvEBsZkhk1Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cng62tzW6A29srIdXaXrBdTrQABYjEqTti2oiWcg1D6yg4AqXvscBHLD+RTkJtN4d8WJV2jyKYX0yAyySKELJvQi+N3rnAOw6dbiheNOl7RDeuax8FcK1njSC4rJDtu4Vm9CPA7mxT+tMmApJp03FIJ1E0tai/qivGFDu7vhHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=TN0zyYJU; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LKw711/d; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="TN0zyYJU";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LKw711/d"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=TN0zyYJUBnKE51n+0MbQR7MvokmPiFWZevZxf44o5zvYpw873iaQYDI+4tPRbk3a4mhCg0Myx5Wf2XBM0gwSgS20zLiAd2BG72Fian5kqSdPvz07yhN54jU0LpxrWY4FVsFJ3B871SIfC2+tdLGJvm9ZWWSgqLiTS91QWFfpQ8h4uYRc7ZcVgAIpyfOpufhdUl4xrMhp8QAJ6tNOhJuGUN5dE3r5pflEGn2PGktVL8wDU7QGm76ktuamVgAqoQFzjHINsWMGkhThiospb3jvrGVuyiPIE+6PPUrfrcl2VI4bJpVaoBvhbVx8hn16KvBnptGd44gqWt7sZjqBURoN3Q==; s=purelymail2; d=rcpassos.me; v=1; bh=nBmv6AYmJmUEW/e16ZrUmZpe11wyGo2MvEBsZkhk1Ac=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=LKw711/dLnNi/gAz5TJLRmeG9lUHEuw1WnN6lQZi78oo9D6VHMxei+S5ev6DpjVdtwcRAWapN9rqPXzAhNkOS0ZKuwxIcfEfAsGbOCCmTmgu02JAYgbBMKsyCXVmbcOv5jogVqTwY4JqjMEJteCGTJXXd+NV4a96tyUSUr6YPPBfxmbzAl2L2TFk5H1co+nqe9OlG3DmNEOSLboNLLiaV2w2OUH5toBHy9CP2TVrfKR/LnlJIoUP/e8Y9TpzfJp4twhwfGZwkKLTuyjh7hBYc3dpPVHFmz8IQJYM6qbu9/ghLoDo9Af0U38axK3g6oVj9a4Ae6K0iVxa9CH9r+0w9w==; s=purelymail2; d=purelymail.com; v=1; bh=nBmv6AYmJmUEW/e16ZrUmZpe11wyGo2MvEBsZkhk1Ac=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 471802508;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 21:26:54 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: jkoolstra@xs4all.nl,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 3/4] HID: wiimote: use scoped cleanup in wiimote and led probes
Date: Wed, 15 Jul 2026 18:24:55 -0300
Message-ID: <20260715212501.3920033-4-rafael@rcpassos.me>
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

Cleanup code in wiimote/led probe function, using the scoped cleanup.
This prevents mistakes in future changes to this function.

In wiimote_probe_clenaup, a few functions are safe to call without
checking. For the hid_hw calls, a new bit mask was introduced to track
probing state.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c    | 68 ++++++++++++++++++-------------
 drivers/hid/hid-wiimote-modules.c | 17 ++++----
 drivers/hid/hid-wiimote.h         |  1 +
 3 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index d37d740a7162..b549a7d58d51 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1774,16 +1774,40 @@ static void wiimote_destroy(struct wiimote_data *wd=
ata)
 /* Global id allocator for wii remotes */
 static DEFINE_IDA(wiimote_ida);
=20
+#define WIIMOTE_PROBE_HW_STARTED  BIT(0)  // hid_hw_start succeeded
+#define WIIMOTE_PROBE_HW_OPENED   BIT(1)  // hid_hw_open succeeded
+
+static void __wiimote_probe_cleanup(struct wiimote_data *wdata)
+{
+=09if (!wdata)
+=09=09return;
+
+=09if (wdata->player_id)
+=09=09ida_free(&wiimote_ida, wdata->player_id);
+
+=09// safe, debugfs checks IS_ERR_OR_NULL
+=09wiidebug_deinit(wdata);
+=09// safe, checks dev for NULL
+=09device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
+=09device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+=09if (wdata->probe_state & WIIMOTE_PROBE_HW_OPENED)
+=09=09hid_hw_close(wdata->hdev);
+=09if (wdata->probe_state & WIIMOTE_PROBE_HW_STARTED)
+=09=09hid_hw_stop(wdata->hdev);
+=09kfree(wdata);
+}
+
+DEFINE_FREE(wiimote_probe_cleanup, struct wiimote_data *,
+=09__wiimote_probe_cleanup(_T))
+
 static int wiimote_hid_probe(struct hid_device *hdev,
 =09=09=09=09const struct hid_device_id *id)
 {
-=09struct wiimote_data *wdata;
 =09int ret;
-=09int player_id;
=20
 =09hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
=20
-=09wdata =3D wiimote_create(hdev);
+=09struct wiimote_data *wdata __free(wiimote_probe_cleanup) =3D wiimote_cr=
eate(hdev);
 =09if (!wdata) {
 =09=09hid_err(hdev, "Can't alloc device\n");
 =09=09return -ENOMEM;
@@ -1792,68 +1816,54 @@ static int wiimote_hid_probe(struct hid_device *hde=
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
+=09wdata->probe_state |=3D WIIMOTE_PROBE_HW_STARTED;
=20
 =09ret =3D hid_hw_open(hdev);
 =09if (ret) {
 =09=09hid_err(hdev, "cannot start hardware I/O\n");
-=09=09goto err_stop;
+=09=09return ret;
 =09}
+=09wdata->probe_state |=3D WIIMOTE_PROBE_HW_OPENED;
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
-=09player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
+=09int player_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
 =09if (player_id < 1) {
 =09=09hid_err(hdev, "cannot allocate controller id\n");
 =09=09ret =3D player_id;
-=09=09goto err_free;
+=09=09return ret;
 =09}
-
 =09wdata->player_id =3D player_id;
=20
+
 =09hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);
=20
 =09/* schedule device detection */
 =09wiimote_schedule(wdata);
-
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
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-mo=
dules.c
index 3cd614466740..47fa6a8ecdae 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -341,11 +341,11 @@ static int wiimod_led_probe(const struct wiimod_ops *=
ops,
 {
 =09struct device *dev =3D &wdata->hdev->dev;
 =09size_t namesz =3D strlen(dev_name(dev)) + 9;
-=09struct led_classdev *led;
 =09char *name;
 =09int ret;
=20
-=09led =3D kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
+=09struct led_classdev *led __free(kfree) =3D
+=09=09kzalloc(sizeof(struct led_classdev) + namesz, GFP_KERNEL);
 =09if (!led)
 =09=09return -ENOMEM;
=20
@@ -359,8 +359,12 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
ps,
=20
 =09wdata->leds[ops->arg] =3D led;
 =09ret =3D led_classdev_register(dev, led);
-=09if (ret)
-=09=09goto err_free;
+=09if (ret) {
+=09=09wdata->leds[ops->arg] =3D NULL;
+=09=09return ret;
+=09}
+
+=09retain_and_null_ptr(led);
=20
 =09/* enable LED1 to stop initial LED-blinking */
 =09if (ops->arg =3D=3D 0) {
@@ -369,11 +373,6 @@ static int wiimod_led_probe(const struct wiimod_ops *o=
ps,
 =09}
=20
 =09return 0;
-
-err_free:
-=09wdata->leds[ops->arg] =3D NULL;
-=09kfree(led);
-=09return ret;
 }
=20
 static void wiimod_led_remove(const struct wiimod_ops *ops,
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index a53f72d5077e..6812efa589c9 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -154,6 +154,7 @@ struct wiimote_data {
 =09struct timer_list timer;
 =09struct wiimote_debug *debug;
 =09__u8 player_id;
+=09__u8 probe_state;
=20
 =09union {
 =09=09struct input_dev *input;
--=20
2.53.0

