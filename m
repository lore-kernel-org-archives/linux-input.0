Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBA1C5499
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002787; cv=none; b=f+LCHyoBO+E/GCT8MIcx+CQKj+bxp6AgO1MOpaT3mzOlftTYwJw8YLQmLvuO0LO9ZxhRUyDMhxplLi4UVvJ227h/jVmx50a8FcsWKpmiygPyDIh4Hbz7z1R53cfQOb5wDpYAARSk1CBIkbiSbc87mEfYPRDxofUyLQV28IoUiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002787; c=relaxed/simple;
	bh=QhHF64jUMIoio/txz0GPjOkqKMwGTDot103IYWKYOtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7/fmt4jexEK7k08rqtNoOiMxwg0pqn6lCp4yqhJFsr2bm3wHFrP05ACP6/UWJgcRRgKgZ2gUpHbGZFlJ756eZrzqr1qLykTWFGCyWF/Dau8W/8iFmqVyKXjrnwg5C/y7+KQjmFjEq0Ue04zTvFKakp3PuN9xAKfpa92TyAe19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=jcDZIY/c; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jDGYqvi+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="jcDZIY/c";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jDGYqvi+"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jcDZIY/cRryh755zuJOZNc53HmezzsoTCjGf9mSzBR9ADnwLgAP0h21fDUKn3ZNjiOa4XjYVIdA5bh0dOn7hC8cOstIkFp648cVasG0Jh84a1lvB9ZaDSQ2Ws3oedgdzj7k0SgENss6Ukg/t8x3jGWAoYZD3ueDQMi2sNoYOxsMPy4dfNDXzn1oJm5IPOpJAT22G7ZbA8wMpwzRi58fzSM/oL58OjCCxPR5ft3A759VyfOW+tkNuIRV4+byQg9kSKTiMBulbeDj2JRAw6x7b+SrMZeosetbang2NXCmsZFDNY/Q79geydqufumgH2iX2CH/1A/fCHu7m9AmctSb2tA==; s=purelymail3; d=rcpassos.me; v=1; bh=QhHF64jUMIoio/txz0GPjOkqKMwGTDot103IYWKYOtg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jDGYqvi+dNoIp8YWUjDo0t5UEN3blrERH24Pd45SKBcUWVvjMkSSQ+cFX41lu3xanaKmqBbMIyzTaQAcXyqucViiQAtg1q16Ykt1E+gBmPxH8JbMWG6MMax2HXneLHa93dMf2oZZLBiVHVQkXpcNnl6am8/ZWrcXfpCxv6Gu+pOPsiqsyBIQwQ+mzMU48JL7vvfkEMkEaB1oOJuMbuCY9xhfuCS3kS527nuERgE57GVgYbC/iCPj1c4yEx099tqQLI4GT6Dzpg6DJf9iqJMqEc9ZyQWw740hku0vBJ7Cgpy5+kZOXZd8Uc+TVRmEZETm3lfEEC1HKZ5wcBpGMc2vrg==; s=purelymail3; d=purelymail.com; v=1; bh=QhHF64jUMIoio/txz0GPjOkqKMwGTDot103IYWKYOtg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1866441726;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 21:39:32 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 2/4] HID: wiimote: replace spinlock pairs with scoped_guard
Date: Mon, 17 Aug 2026 18:38:22 -0300
Message-ID: <20260817213840.1053216-3-rafael@rcpassos.me>
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

Cleanup code replacing manual lock/unlock with scoped guards.
This does not change any behavior, but makes it safer to modify.

The multi line spinlock blocks were replaced by braced scoped_guard,
and one-liners by a scoped_guard without braces nor indentation.

There are two cases left in this driver using lock/unlock, because
guard would make the code more complex than current implementation.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c    | 224 +++++++++++++-----------------
 drivers/hid/hid-wiimote-debug.c   |  62 ++++-----
 drivers/hid/hid-wiimote-modules.c |   7 +-
 3 files changed, 127 insertions(+), 166 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index acf31d8b6991..05f8ddb7909b 100644
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
@@ -675,11 +673,8 @@ static void wiimote_modules_load(struct wiimote_data *=
wdata,
 =09=09=09goto error;
 =09}
=20
-=09spin_lock_irq(&wdata->state.lock);
-=09wdata->state.devtype =3D devtype;
-=09spin_unlock_irq(&wdata->state.lock);
-
 =09scoped_guard(spinlock_irqsave, &wdata->state.lock) {
+=09=09wdata->state.devtype =3D devtype;
 =09=09/* after loading modules, set the Player ID LED cycling from 1 to 4*=
/
 =09=09wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
 =09}
@@ -703,13 +698,11 @@ static void wiimote_modules_unload(struct wiimote_dat=
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
@@ -736,7 +729,6 @@ static void wiimote_modules_unload(struct wiimote_data =
*wdata)
=20
 static void wiimote_ext_load(struct wiimote_data *wdata, unsigned int ext)
 {
-=09unsigned long flags;
 =09const struct wiimod_ops *ops;
 =09int ret;
=20
@@ -748,22 +740,20 @@ static void wiimote_ext_load(struct wiimote_data *wda=
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
@@ -771,7 +761,6 @@ static void wiimote_ext_unload(struct wiimote_data *wda=
ta)
=20
 static void wiimote_mp_load(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
 =09const struct wiimod_ops *ops;
 =09int ret;
 =09__u8 mode =3D 2;
@@ -783,14 +772,12 @@ static void wiimote_mp_load(struct wiimote_data *wdat=
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
@@ -798,10 +785,10 @@ static void wiimote_mp_unload(struct wiimote_data *wd=
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
@@ -885,19 +872,19 @@ static void wiimote_init_detect(struct wiimote_data *=
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
@@ -910,11 +897,11 @@ static void wiimote_init_detect(struct wiimote_data *=
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
@@ -962,9 +949,8 @@ static bool wiimote_init_check(struct wiimote_data *wda=
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
@@ -980,11 +966,11 @@ static bool wiimote_init_check(struct wiimote_data *w=
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
@@ -1005,10 +991,10 @@ static bool wiimote_init_check(struct wiimote_data *=
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
@@ -1031,11 +1017,11 @@ static bool wiimote_init_check(struct wiimote_data =
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
@@ -1061,11 +1047,11 @@ static bool wiimote_init_check(struct wiimote_data =
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
@@ -1120,16 +1106,15 @@ static void wiimote_init_hotplug(struct wiimote_dat=
a *wdata)
=20
 =09wiimote_cmd_acquire_noint(wdata);
=20
-=09spin_lock_irq(&wdata->state.lock);
+=09scoped_guard(spinlock_irq, &wdata->state.lock) {
=20
-=09/* get state snapshot that we will then work on */
-=09flags =3D wdata->state.flags;
+=09    /* get state snapshot that we will then work on */
+=09    flags =3D wdata->state.flags;
=20
-=09/* disable event forwarding temporarily */
-=09wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
-=09wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
-
-=09spin_unlock_irq(&wdata->state.lock);
+=09    /* disable event forwarding temporarily */
+=09    wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
+=09    wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
+=09}
=20
 =09/* init extension and MP (deactivates current extension or MP) */
 =09wiimote_cmd_init_ext(wdata);
@@ -1152,9 +1137,8 @@ static void wiimote_init_hotplug(struct wiimote_data =
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
@@ -1192,28 +1176,26 @@ static void wiimote_init_hotplug(struct wiimote_dat=
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
+
+=09=09/* request status report for hotplug state updates */
+=09=09wiiproto_req_status(wdata);
 =09}
=20
-=09/* request status report for hotplug state updates */
-=09wiiproto_req_status(wdata);
-
-=09spin_unlock_irq(&wdata->state.lock);
-
 =09hid_dbg(wdata->hdev, "detected extensions: MP: %d EXT: %d\n",
 =09=09wdata->state.mp, wdata->state.exttype);
 }
@@ -1244,11 +1226,8 @@ void __wiimote_schedule(struct wiimote_data *wdata)
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
@@ -1638,7 +1617,6 @@ static int wiimote_hid_event(struct hid_device *hdev,=
 struct hid_report *report,
 =09struct wiimote_data *wdata =3D hid_get_drvdata(hdev);
 =09const struct wiiproto_handler *h;
 =09int i;
-=09unsigned long flags;
=20
 =09if (size < 1)
 =09=09return -EINVAL;
@@ -1646,9 +1624,8 @@ static int wiimote_hid_event(struct hid_device *hdev,=
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
@@ -1666,11 +1643,9 @@ static ssize_t wiimote_ext_show(struct device *dev,
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
@@ -1719,11 +1694,9 @@ static ssize_t wiimote_dev_show(struct device *dev,
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
@@ -1778,16 +1751,13 @@ static DEFINE_IDA(wiimote_ida);
=20
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
-=09unsigned long flags;
-
 =09wiidebug_deinit(wdata);
=20
 =09ida_free(&wiimote_ida, wdata->player_id);
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
index fc847c2a1c1f..b8027bb23608 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -7,12 +7,13 @@
 /*
  */
=20
-#include <linux/debugfs.h>
-#include <linux/module.h>
-#include <linux/seq_file.h>
-#include <linux/spinlock.h>
-#include <linux/uaccess.h>
-#include "hid-wiimote.h"
+ #include <linux/cleanup.h>
+ #include <linux/debugfs.h>
+ #include <linux/module.h>
+ #include <linux/seq_file.h>
+ #include <linux/spinlock.h>
+ #include <linux/uaccess.h>
+ #include "hid-wiimote.h"
=20
 struct wiimote_debug {
 =09struct wiimote_data *wdata;
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
@@ -189,9 +184,8 @@ int wiidebug_init(struct wiimote_data *wdata)
 =09debugfs_create_u8("player_id", S_IRUSR,
 =09=09   dbg->wdata->hdev->debug_dir, &wdata->player_id);
=20
-=09spin_lock_irqsave(&wdata->state.lock, flags);
-=09wdata->debug =3D dbg;
-=09spin_unlock_irqrestore(&wdata->state.lock, flags);
+=09scoped_guard(spinlock_irqsave, &wdata->state.lock)
+=09=09wdata->debug =3D dbg;
=20
 =09return 0;
 }
@@ -199,14 +193,12 @@ int wiidebug_init(struct wiimote_data *wdata)
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
2.55.0

