Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1B3BB66C
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150812; cv=none; b=gcD+K6Z/K9tNyNHXAlZS9gpvXGTFCQoOCCnPv0w7bwIhU+S6m0cdhk0h6H8y2OmfpeKAdmqIyPF4DaLSSX/jMfNTb+YhCE2rf3J18zhPpPErEpM0nur+BT/gXWb22Vb/ECwWobXvTNBw42jS9CQIvRL6ew+e7NlS6TZtVgjz/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150812; c=relaxed/simple;
	bh=2FZOY06fL8UfOeRgeuI7mtyEy3rUMl7t2vdzMzQMGZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEBHJ92CwrltAvmPxXgzWAn9TxvCEdbLJZX05QbfvErwy1qdFpzEEivyvepaSz5NFjDfy6Ksr4kGVp89Dv11dnYxSu7+Kc+qpEti25pE8nATE70HYRIeTwgITJX9qSxbPOMN5J/6b8tGY/djPY4WCy+nvKpr4Ykolu4oNJF6HMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=a1g8Qp2M; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=rArJ2cEY; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="a1g8Qp2M";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="rArJ2cEY"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=a1g8Qp2M9Pswgl3IQxB2CjUUM6nazfemAaQLu2ApWaAiimBX4FU9UgKMS9qf9mzk74bJcoYsAAw+r+BCpzEChg/yEW81zOG8ZBwHrz5QebdnNIJ/yMY5d9L/aBy+WwAAIIGcU3PlbLqk/6yDsDzpOjy0Z+tSPhf0nwns3+k2ur5Fb/0qL7I+DTihl52b6XkTsS4E9wwzA+KvEOd3TqF9SnFhLV1nzeWoEEfOaXgZgtF/EnJXPLyu/pdzGMvgawDu7CK5uKbp+kTgEm/glKvRCQkTqEG7xje76F16MyG+p/MVKxQ0/qOSkqToSjr4dcQG2HD6Bhtg9M04t8W6dyu2zA==; s=purelymail2; d=rcpassos.me; v=1; bh=2FZOY06fL8UfOeRgeuI7mtyEy3rUMl7t2vdzMzQMGZI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=rArJ2cEYdbyGDAaaNokhqHNzdhYcxA7E3ej2JAepKDbf8sJ8zTRzmCu/y/QKyxGG3zt0Au8DyT2JOb0jn5yElJEk4IjafyXkNxxe1CXrSA+29WkLRhbtERBqbpqpBqjvvHSfwjUSsG0ml0L22wUSIn9qnayqpRXv7QJdU65Ev1XBeM1neizzLyO5wVR2QDnGl4/MWivOqbnZBR7z89/OJQyUg2Z7oVXwUiDFQo+SD7VUadMOasMlZI6dpMl/SZjAqg9fuVUfraHMItpNY6vDTysY7bgdd0A9LK/3iqGtSvPZyP8qsFkz8szWW9Yi0nq4os73qSK1nBxm75babxUZrw==; s=purelymail2; d=purelymail.com; v=1; bh=2FZOY06fL8UfOeRgeuI7mtyEy3rUMl7t2vdzMzQMGZI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 471802508;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 21:26:38 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: jkoolstra@xs4all.nl,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 2/4] HID: wiimote: replace spinlock pairs with scoped_guard
Date: Wed, 15 Jul 2026 18:24:54 -0300
Message-ID: <20260715212501.3920033-3-rafael@rcpassos.me>
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

Cleanup code replacing manual lock/unlock with scoped guards.
This does not change any behavior, but makes it safer to modify.

The multi line spinlock blocks were replaced by braced scoped_guard,
and one-liners by a scoped_guard without braces nor indentation.

There are two cases left in this driver using lock/unlock, because
guard would make the code more complex than current implementation.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c    | 222 +++++++++++++-----------------
 drivers/hid/hid-wiimote-debug.c   |  50 +++----
 drivers/hid/hid-wiimote-modules.c |   7 +-
 3 files changed, 121 insertions(+), 158 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 91c2cec35f6e..d37d740a7162 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -7,6 +7,7 @@
 /*
  */
=20
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/hid.h>
@@ -362,13 +363,12 @@ void wiiproto_req_rmem(struct wiimote_data *wdata, bo=
ol eeprom, __u32 offset,
 int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 =09=09=09=09=09=09const __u8 *wmem, __u8 size)
 {
-=09unsigned long flags;
 =09int ret;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
-=09wiiproto_req_wreg(wdata, offset, wmem, size);
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09    wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
+=09    wiiproto_req_wreg(wdata, offset, wmem, size);
+=09}
=20
 =09ret =3D wiimote_cmd_wait(wdata);
 =09if (!ret && wdata->state.cmd_err)
@@ -381,21 +381,19 @@ int wiimote_cmd_write(struct wiimote_data *wdata, __u=
32 offset,
 ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset, __u8 *r=
mem,
 =09=09=09=09=09=09=09=09__u8 size)
 {
-=09unsigned long flags;
 =09ssize_t ret;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.cmd_read_size =3D size;
-=09wdata->state.cmd_read_buf =3D rmem;
-=09wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, offset & 0xffff);
-=09wiiproto_req_rreg(wdata, offset, size);
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wdata->state.cmd_read_size =3D size;
+=09=09wdata->state.cmd_read_buf =3D rmem;
+=09=09wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, offset & 0xffff);
+=09=09wiiproto_req_rreg(wdata, offset, size);
+=09}
=20
 =09ret =3D wiimote_cmd_wait(wdata);
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.cmd_read_buf =3D NULL;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->state.cmd_read_buf =3D NULL;
=20
 =09if (!ret) {
 =09=09if (wdata->state.cmd_read_size =3D=3D 0)
@@ -680,9 +678,8 @@ static void wiimote_modules_load(struct wiimote_data *w=
data,
 =09spin_unlock_irq(&wdata->state.lock);
=20
 =09/* after loading all modules, set the LED for the player ID cycling fro=
m 1 to 4*/
-=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
 =09=09wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
-=09}
=20
 =09return;
=20
@@ -703,13 +700,11 @@ static void wiimote_modules_unload(struct wiimote_dat=
a *wdata)
 {
 =09const __u8 *mods, *iter;
 =09const struct wiimod_ops *ops;
-=09unsigned long flags;
=20
 =09mods =3D wiimote_devtype_mods[wdata->state.devtype];
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.devtype =3D WIIMOTE_DEV_UNKNOWN;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->state.devtype =3D WIIMOTE_DEV_UNKNOWN;
=20
 =09/* find end of list */
 =09for (iter =3D mods; *iter !=3D WIIMOD_NULL; ++iter)
@@ -736,7 +731,6 @@ static void wiimote_modules_unload(struct wiimote_data =
*wdata)
=20
 static void wiimote_ext_load(struct wiimote_data *wdata, unsigned int ext)
 {
-=09unsigned long flags;
 =09const struct wiimod_ops *ops;
 =09int ret;
=20
@@ -748,22 +742,20 @@ static void wiimote_ext_load(struct wiimote_data *wda=
ta, unsigned int ext)
 =09=09=09ext =3D WIIMOTE_EXT_UNKNOWN;
 =09}
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.exttype =3D ext;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->state.exttype =3D ext;
 }
=20
 static void wiimote_ext_unload(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
 =09const struct wiimod_ops *ops;
=20
 =09ops =3D wiimod_ext_table[wdata->state.exttype];
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.exttype =3D WIIMOTE_EXT_UNKNOWN;
-=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_USED;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wdata->state.exttype =3D WIIMOTE_EXT_UNKNOWN;
+=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_USED;
+=09}
=20
 =09if (ops->remove)
 =09=09ops->remove(ops, wdata);
@@ -771,7 +763,6 @@ static void wiimote_ext_unload(struct wiimote_data *wda=
ta)
=20
 static void wiimote_mp_load(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
 =09const struct wiimod_ops *ops;
 =09int ret;
 =09__u8 mode =3D 2;
@@ -783,14 +774,12 @@ static void wiimote_mp_load(struct wiimote_data *wdat=
a)
 =09=09=09mode =3D 1;
 =09}
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.mp =3D mode;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->state.mp =3D mode;
 }
=20
 static void wiimote_mp_unload(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
 =09const struct wiimod_ops *ops;
=20
 =09if (wdata->state.mp < 2)
@@ -798,10 +787,10 @@ static void wiimote_mp_unload(struct wiimote_data *wd=
ata)
=20
 =09ops =3D &wiimod_mp;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.mp =3D 0;
-=09wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_USED;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wdata->state.mp =3D 0;
+=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_USED;
+=09}
=20
 =09if (ops->remove)
 =09=09ops->remove(ops, wdata);
@@ -885,19 +874,19 @@ static void wiimote_init_detect(struct wiimote_data *=
wdata)
=20
 =09wiimote_cmd_acquire_noint(wdata);
=20
-=09spin_lock_irq(&wdata->state.lock);
-=09wdata->state.devtype =3D WIIMOTE_DEV_UNKNOWN;
-=09wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
-=09wiiproto_req_status(wdata);
-=09spin_unlock_irq(&wdata->state.lock);
+=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09wdata->state.devtype =3D WIIMOTE_DEV_UNKNOWN;
+=09=09wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
+=09=09wiiproto_req_status(wdata);
+=09}
+
=20
 =09ret =3D wiimote_cmd_wait_noint(wdata);
 =09if (ret)
 =09=09goto out_release;
=20
-=09spin_lock_irq(&wdata->state.lock);
-=09ext =3D wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED;
-=09spin_unlock_irq(&wdata->state.lock);
+=09scoped_guard(spinlock_irq, &wdata->state.lock)
+=09=09ext =3D wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED;
=20
 =09if (!ext)
 =09=09goto out_release;
@@ -910,11 +899,11 @@ static void wiimote_init_detect(struct wiimote_data *=
wdata)
 =09wiimote_init_set_type(wdata, exttype);
=20
 =09/* schedule MP timer */
-=09spin_lock_irq(&wdata->state.lock);
-=09if (!(wdata->state.flags & WIIPROTO_FLAG_BUILTIN_MP) &&
-=09    !(wdata->state.flags & WIIPROTO_FLAG_NO_MP))
-=09=09mod_timer(&wdata->timer, jiffies + HZ * 4);
-=09spin_unlock_irq(&wdata->state.lock);
+=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09if (!(wdata->state.flags & WIIPROTO_FLAG_BUILTIN_MP) &&
+=09=09!(wdata->state.flags & WIIPROTO_FLAG_NO_MP))
+=09=09=09mod_timer(&wdata->timer, jiffies + HZ * 4);
+=09}
 }
=20
 /*
@@ -962,9 +951,8 @@ static bool wiimote_init_check(struct wiimote_data *wda=
ta)
 =09__u8 type, data[6];
 =09bool ret, poll_mp;
=20
-=09spin_lock_irq(&wdata->state.lock);
-=09flags =3D wdata->state.flags;
-=09spin_unlock_irq(&wdata->state.lock);
+=09scoped_guard(spinlock_irq, &wdata->state.lock)
+=09=09flags =3D wdata->state.flags;
=20
 =09wiimote_cmd_acquire_noint(wdata);
=20
@@ -980,11 +968,11 @@ static bool wiimote_init_check(struct wiimote_data *w=
data)
 =09=09type =3D wiimote_cmd_read_mp_mapped(wdata);
 =09=09ret =3D type =3D=3D WIIMOTE_MP_SINGLE;
=20
-=09=09spin_lock_irq(&wdata->state.lock);
-=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
-=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED);
-=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
-=09=09spin_unlock_irq(&wdata->state.lock);
+=09=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+=09=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED);
+=09=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+=09=09}
=20
 =09=09if (!ret)
 =09=09=09hid_dbg(wdata->hdev, "state left: !EXT && MP\n");
@@ -1005,10 +993,10 @@ static bool wiimote_init_check(struct wiimote_data *=
wdata)
 =09=09type =3D wiimote_cmd_read_ext(wdata, data);
 =09=09ret =3D type =3D=3D wdata->state.exttype;
=20
-=09=09spin_lock_irq(&wdata->state.lock);
-=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
-=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
-=09=09spin_unlock_irq(&wdata->state.lock);
+=09=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+=09=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+=09=09}
=20
 =09=09if (!ret)
 =09=09=09hid_dbg(wdata->hdev, "state left: EXT && !MP\n");
@@ -1031,11 +1019,11 @@ static bool wiimote_init_check(struct wiimote_data =
*wdata)
 =09=09type =3D wiimote_cmd_read_ext(wdata, data);
 =09=09ret =3D type =3D=3D wdata->state.exttype;
=20
-=09=09spin_lock_irq(&wdata->state.lock);
-=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
-=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
-=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
-=09=09spin_unlock_irq(&wdata->state.lock);
+=09=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+=09=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+=09=09=09ret =3D ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
+=09=09}
=20
 =09=09if (!ret)
 =09=09=09hid_dbg(wdata->hdev, "state left: !EXT && !MP\n");
@@ -1061,11 +1049,11 @@ static bool wiimote_init_check(struct wiimote_data =
*wdata)
 =09=09ret =3D ret && type !=3D WIIMOTE_MP_UNKNOWN;
 =09=09ret =3D ret && type !=3D WIIMOTE_MP_SINGLE;
=20
-=09=09spin_lock_irq(&wdata->state.lock);
-=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
-=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
-=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
-=09=09spin_unlock_irq(&wdata->state.lock);
+=09=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
+=09=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+=09=09=09ret =3D ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+=09=09}
=20
 =09=09if (!ret)
 =09=09=09hid_dbg(wdata->hdev, "state left: EXT && MP\n");
@@ -1120,16 +1108,15 @@ static void wiimote_init_hotplug(struct wiimote_dat=
a *wdata)
=20
 =09wiimote_cmd_acquire_noint(wdata);
=20
-=09spin_lock_irq(&wdata->state.lock);
-
-=09/* get state snapshot that we will then work on */
-=09flags =3D wdata->state.flags;
+=09scoped_guard(spinlock_irq, &wdata->state.lock) {
=20
-=09/* disable event forwarding temporarily */
-=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
-=09wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
+=09    /* get state snapshot that we will then work on */
+=09    flags =3D wdata->state.flags;
=20
-=09spin_unlock_irq(&wdata->state.lock);
+=09    /* disable event forwarding temporarily */
+=09    wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
+=09    wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
+=09}
=20
 =09/* init extension and MP (deactivates current extension or MP) */
 =09wiimote_cmd_init_ext(wdata);
@@ -1152,9 +1139,8 @@ static void wiimote_init_hotplug(struct wiimote_data =
*wdata)
 =09=09=09hid_info(wdata->hdev, "cannot detect extension; %6phC\n",
 =09=09=09=09 extdata);
 =09=09} else if (exttype =3D=3D WIIMOTE_EXT_NONE) {
-=09=09=09spin_lock_irq(&wdata->state.lock);
-=09=09=09wdata->state.exttype =3D WIIMOTE_EXT_NONE;
-=09=09=09spin_unlock_irq(&wdata->state.lock);
+=09=09=09scoped_guard(spinlock_irq, &wdata->state.lock)
+=09=09=09=09wdata->state.exttype =3D WIIMOTE_EXT_NONE;
 =09=09} else {
 =09=09=09hid_info(wdata->hdev, "detected extension: %s\n",
 =09=09=09=09 wiimote_exttype_names[exttype]);
@@ -1192,27 +1178,25 @@ static void wiimote_init_hotplug(struct wiimote_dat=
a *wdata)
 =09=09=09mod_timer(&wdata->timer, jiffies + HZ * 4);
 =09}
=20
-=09spin_lock_irq(&wdata->state.lock);
-
-=09/* enable data forwarding again and set expected hotplug state */
-=09if (mp) {
-=09=09wdata->state.flags |=3D WIIPROTO_FLAG_MP_ACTIVE;
-=09=09if (wdata->state.exttype =3D=3D WIIMOTE_EXT_NONE) {
-=09=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_PLUGGED;
-=09=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_PLUGGED;
-=09=09} else {
-=09=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_PLUGGED;
-=09=09=09wdata->state.flags |=3D WIIPROTO_FLAG_MP_PLUGGED;
+=09scoped_guard(spinlock_irq, &wdata->state.lock) {
+=09=09/* enable data forwarding again and set expected hotplug state */
+=09=09if (mp) {
+=09=09=09wdata->state.flags |=3D WIIPROTO_FLAG_MP_ACTIVE;
+=09=09=09if (wdata->state.exttype =3D=3D WIIMOTE_EXT_NONE) {
+=09=09=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_PLUGGED;
+=09=09=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_PLUGGED;
+=09=09=09} else {
+=09=09=09=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_PLUGGED;
+=09=09=09=09wdata->state.flags |=3D WIIPROTO_FLAG_MP_PLUGGED;
+=09=09=09=09wdata->state.flags |=3D WIIPROTO_FLAG_EXT_ACTIVE;
+=09=09=09}
+=09=09} else if (wdata->state.exttype !=3D WIIMOTE_EXT_NONE) {
 =09=09=09wdata->state.flags |=3D WIIPROTO_FLAG_EXT_ACTIVE;
 =09=09}
-=09} else if (wdata->state.exttype !=3D WIIMOTE_EXT_NONE) {
-=09=09wdata->state.flags |=3D WIIPROTO_FLAG_EXT_ACTIVE;
-=09}
-
-=09/* request status report for hotplug state updates */
-=09wiiproto_req_status(wdata);
=20
-=09spin_unlock_irq(&wdata->state.lock);
+=09=09/* request status report for hotplug state updates */
+=09=09wiiproto_req_status(wdata);
+=09}
=20
 =09hid_dbg(wdata->hdev, "detected extensions: MP: %d EXT: %d\n",
 =09=09wdata->state.mp, wdata->state.exttype);
@@ -1244,11 +1228,8 @@ void __wiimote_schedule(struct wiimote_data *wdata)
=20
 static void wiimote_schedule(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
-
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09__wiimote_schedule(wdata);
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09__wiimote_schedule(wdata);
 }
=20
 static void wiimote_init_timeout(struct timer_list *t)
@@ -1638,7 +1619,6 @@ static int wiimote_hid_event(struct hid_device *hdev,=
 struct hid_report *report,
 =09struct wiimote_data *wdata =3D hid_get_drvdata(hdev);
 =09const struct wiiproto_handler *h;
 =09int i;
-=09unsigned long flags;
=20
 =09if (size < 1)
 =09=09return -EINVAL;
@@ -1646,9 +1626,8 @@ static int wiimote_hid_event(struct hid_device *hdev,=
 struct hid_report *report,
 =09for (i =3D 0; handlers[i].id; ++i) {
 =09=09h =3D &handlers[i];
 =09=09if (h->id =3D=3D raw_data[0] && h->size < size) {
-=09=09=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09=09=09h->func(wdata, &raw_data[1]);
-=09=09=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09=09=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09=09=09h->func(wdata, &raw_data[1]);
 =09=09=09break;
 =09=09}
 =09}
@@ -1666,11 +1645,9 @@ static ssize_t wiimote_ext_show(struct device *dev,
 {
 =09struct wiimote_data *wdata =3D dev_to_wii(dev);
 =09__u8 type;
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09type =3D wdata->state.exttype;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09type =3D wdata->state.exttype;
=20
 =09switch (type) {
 =09case WIIMOTE_EXT_NONE:
@@ -1719,11 +1696,9 @@ static ssize_t wiimote_dev_show(struct device *dev,
 {
 =09struct wiimote_data *wdata =3D dev_to_wii(dev);
 =09__u8 type;
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09type =3D wdata->state.devtype;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09type =3D wdata->state.devtype;
=20
 =09switch (type) {
 =09case WIIMOTE_DEV_GENERIC:
@@ -1774,14 +1749,11 @@ static struct wiimote_data *wiimote_create(struct h=
id_device *hdev)
=20
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
-
 =09wiidebug_deinit(wdata);
=20
 =09/* prevent init_worker from being scheduled again */
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
=20
 =09cancel_work_sync(&wdata->init_worker);
 =09timer_shutdown_sync(&wdata->timer);
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debu=
g.c
index 5f74917781f2..df6f830ee791 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -7,6 +7,7 @@
 /*
  */
=20
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
@@ -25,7 +26,6 @@ static ssize_t wiidebug_eeprom_read(struct file *f, char =
__user *u, size_t s,
 {
 =09struct wiimote_debug *dbg =3D f->private_data;
 =09struct wiimote_data *wdata =3D dbg->wdata;
-=09unsigned long flags;
 =09ssize_t ret;
 =09char buf[16];
 =09__u16 size =3D 0;
@@ -41,20 +41,19 @@ static ssize_t wiidebug_eeprom_read(struct file *f, cha=
r __user *u, size_t s,
 =09if (ret)
 =09=09return ret;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.cmd_read_size =3D s;
-=09wdata->state.cmd_read_buf =3D buf;
-=09wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, *off & 0xffff);
-=09wiiproto_req_reeprom(wdata, *off, s);
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wdata->state.cmd_read_size =3D s;
+=09=09wdata->state.cmd_read_buf =3D buf;
+=09=09wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, *off & 0xffff);
+=09=09wiiproto_req_reeprom(wdata, *off, s);
+=09}
=20
 =09ret =3D wiimote_cmd_wait(wdata);
 =09if (!ret)
 =09=09size =3D wdata->state.cmd_read_size;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->state.cmd_read_buf =3D NULL;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->state.cmd_read_buf =3D NULL;
=20
 =09wiimote_cmd_release(wdata);
=20
@@ -99,12 +98,10 @@ static int wiidebug_drm_show(struct seq_file *f, void *=
p)
 {
 =09struct wiimote_debug *dbg =3D f->private;
 =09const char *str =3D NULL;
-=09unsigned long flags;
 =09__u8 drm;
=20
-=09spin_lock_irqsave(&dbg->wdata->state.lock, flags);
-=09drm =3D dbg->wdata->state.drm;
-=09spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &dbg->wdata->state.lock)
+=09=09drm =3D dbg->wdata->state.drm;
=20
 =09if (drm < WIIPROTO_REQ_MAX)
 =09=09str =3D wiidebug_drmmap[drm];
@@ -126,7 +123,6 @@ static ssize_t wiidebug_drm_write(struct file *f, const=
 char __user *u,
 {
 =09struct seq_file *sf =3D f->private_data;
 =09struct wiimote_debug *dbg =3D sf->private;
-=09unsigned long flags;
 =09char buf[16];
 =09ssize_t len;
 =09int i;
@@ -150,12 +146,12 @@ static ssize_t wiidebug_drm_write(struct file *f, con=
st char __user *u,
 =09if (i =3D=3D WIIPROTO_REQ_MAX)
 =09=09i =3D simple_strtoul(buf, NULL, 16);
=20
-=09spin_lock_irqsave(&dbg->wdata->state.lock, flags);
-=09dbg->wdata->state.flags &=3D ~WIIPROTO_FLAG_DRM_LOCKED;
-=09wiiproto_req_drm(dbg->wdata, (__u8) i);
-=09if (i !=3D WIIPROTO_REQ_NULL)
-=09=09dbg->wdata->state.flags |=3D WIIPROTO_FLAG_DRM_LOCKED;
-=09spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &dbg->wdata->state.lock) {
+=09=09dbg->wdata->state.flags &=3D ~WIIPROTO_FLAG_DRM_LOCKED;
+=09=09wiiproto_req_drm(dbg->wdata, (__u8) i);
+=09=09if (i !=3D WIIPROTO_REQ_NULL)
+=09=09=09dbg->wdata->state.flags |=3D WIIPROTO_FLAG_DRM_LOCKED;
+=09}
=20
 =09return len;
 }
@@ -172,7 +168,6 @@ static const struct file_operations wiidebug_drm_fops =
=3D {
 int wiidebug_init(struct wiimote_data *wdata)
 {
 =09struct wiimote_debug *dbg;
-=09unsigned long flags;
=20
 =09dbg =3D kzalloc_obj(*dbg);
 =09if (!dbg)
@@ -186,9 +181,8 @@ int wiidebug_init(struct wiimote_data *wdata)
 =09dbg->drm =3D debugfs_create_file("drm", S_IRUSR,
 =09=09=09dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->debug =3D dbg;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->debug =3D dbg;
=20
 =09return 0;
=20
@@ -197,14 +191,12 @@ int wiidebug_init(struct wiimote_data *wdata)
 void wiidebug_deinit(struct wiimote_data *wdata)
 {
 =09struct wiimote_debug *dbg =3D wdata->debug;
-=09unsigned long flags;
=20
 =09if (!dbg)
 =09=09return;
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->debug =3D NULL;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->debug =3D NULL;
=20
 =09debugfs_remove(dbg->drm);
 =09debugfs_remove(dbg->eeprom);
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-mo=
dules.c
index dccb78bb3afd..3cd614466740 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -30,6 +30,7 @@
  * input devices.
  */
=20
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
@@ -341,7 +342,6 @@ static int wiimod_led_probe(const struct wiimod_ops *op=
s,
 =09struct device *dev =3D &wdata->hdev->dev;
 =09size_t namesz =3D strlen(dev_name(dev)) + 9;
 =09struct led_classdev *led;
-=09unsigned long flags;
 =09char *name;
 =09int ret;
=20
@@ -364,9 +364,8 @@ static int wiimod_led_probe(const struct wiimod_ops *op=
s,
=20
 =09/* enable LED1 to stop initial LED-blinking */
 =09if (ops->arg =3D=3D 0) {
-=09=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09=09wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
-=09=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09=09wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
 =09}
=20
 =09return 0;
--=20
2.53.0

