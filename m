Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969385;
	b=wCQ4KaYjThwsgkcawONPu4RJ2L37oGAWj+Aq5qLfam5iv/iBguOIfeegIfPVJaWtJfIH
	 ZQ50ojU8l/gl6TcN71dS2rAy8/BJAWVXNJbubUtSay/UUThD4n3udZpRjhmUvCU4Pufr7
	 389nWHDTWId0BXgijPuMzY//MTMG3FHODbG7JWNLwN3C6YJe6ZskBNJXCf0rp//l+raIA
	 eyj0uufdSn0/7ZK34hnN5o+0E/bzGFn/zcFCkv36Yuo99XpUoi0wLhrpD10SKm/j/0b0r
	 vyNLbZAGdvdaSnFU8swKZXlOWyzAoNY1+5r48l7aiLo16SFGPkHF0vKHwvH9FfnzEuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969385;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NnFWZkOAnsgQPTTolwXS1k63Q1BWZHfbbZSuGjUAzbA=;
	b=AHC9Wh89rGW9WYPPV1715P/UPBsWg8qoPD3D7EuLx41QotpuubqH27tCexLa3jTSfIkz
	 zOg4VYuWJJE/gwldbp9SZbm3ZracnFB2eTRBIATdc2ASN8/dDwVs3dyRr+wnSrJut8z2k
	 IRhPA465yhmtnRSkUkHEezV3MhQB8DihCMu9LO/rMOAKO7TfzHpCf2D2ftq0nfRPnJibs
	 dJsS9YiytFwQ5yzdrrfB6UPtSw8Qjj4586TMXYT242LXBHBcTqZjLDpyGXqDzuUDm4/qP
	 YRY1J+gcSZwYH20iVVAk/w1v2iwSB/Mulob3gRuc0s/9eKB2C2h26+KDTMP/Oj9FLDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Cov7D9TS;
	arc=none smtp.remote-ip=109.224.244.20
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021D606A32C;
	Fri,  6 Nov 2026 12:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C021D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Cov7D9TS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1793969381; x=1794228581;
	bh=NnFWZkOAnsgQPTTolwXS1k63Q1BWZHfbbZSuGjUAzbA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Cov7D9TSmR+mp31tjjE7ROcnmDhzllu+eCC+Yfi+qbtsZGrwefeTfxwWeSUsb7GAI
	 xSLSFF1xpFo5kdQIiu3JbM7RFTRzP/W70HW3Q2GrhpRA85VX1VOTzaaJKyDbcmKssr
	 3bgv24jpkqvjlSJKT70bTM8QMseZlMw3nY6T3ItBPAkLWPdSKviLq3Fbf7mAz8YiYl
	 KLTQtySAIxY4i+wOYKjnIfhXUm7VmllAvO5UtjmSRR/y9PFdVuicGjNxkNgZPmWT7O
	 npbE+BGR9H3UW7p9mbKO43Lzjz0uA4hWv+SVqnTjBPeHvFSm2qkwaX71Q8St6S2Lop
	 3zZaC4d+SIhBg==
Date: Fri, 06 Nov 2026 12:49:36 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: sensor: custom: Fix use-after-free when the node is open across removal
Message-ID: <20261106124914.2892604-1-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 343f02be2ee98220aec2d65d13821eafb5a217eb
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hid_sensor_custom_probe() allocates its state, which embeds the
miscdevice, with devm_kzalloc(). When the sensor hub goes away, for
example on USB disconnect, remove() deregisters the miscdevice and
devres frees the state, but a file that is still open keeps
file->private_data pointing into it: release() then writes the freed
misc_opened bit, and a reader blocked in read() is woken by remove()
but finds the kfifo empty and goes back to sleep on a wait queue that
devres then frees.

Reference count the state: probe and every open hold a reference, and
the last one frees the kfifo and the state. remove() marks the state
removed before waking readers, so a blocked or later read returns
-ENODEV and poll() reports EPOLLHUP, and the kfifo is no longer freed
before the hub callback is unregistered.

Found with a coccinelle check for device nodes embedded in devm_
memory. Reproduced in QEMU with a uhid program that creates a sensor
hub with one custom-sensor collection, opens the misc node, blocks a
reader in read(), destroys the uhid device and closes the node. Before
this change KASAN reports nine slab-use-after-frees: eight in
hid_sensor_custom_read() and the wait-queue code when the stuck reader
is finally killed, and a write in hid_sensor_custom_release(). The
reader stays blocked until killed. After it there are no reports and
the blocked read() returns -ENODEV. Not tested on real sensor hub
hardware, and the known-custom-sensor path that registers a separate
platform device was not exercised.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
 drivers/hid/hid-sensor-custom.c | 45 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custo=
m.c
index c2b425afd9..47800efdaf 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -15,6 +15,7 @@
 #include <linux/wait.h>
 #include <linux/poll.h>
 #include <linux/bsearch.h>
+#include <linux/kref.h>
 #include <linux/platform_device.h>
 #include <linux/hid-sensor-hub.h>
=20
@@ -54,8 +55,25 @@ struct hid_sensor_custom {
 =09unsigned long misc_opened;
 =09wait_queue_head_t wait;
 =09struct platform_device *custom_pdev;
+=09/* Held by the driver binding and by each open file. */
+=09struct kref kref;
+=09bool removed;
 };
=20
+static void hid_sensor_custom_free(struct kref *kref)
+{
+=09struct hid_sensor_custom *sensor_inst =3D
+=09=09container_of(kref, struct hid_sensor_custom, kref);
+
+=09kfifo_free(&sensor_inst->data_fifo);
+=09kfree(sensor_inst);
+}
+
+static void hid_sensor_custom_put(struct hid_sensor_custom *sensor_inst)
+{
+=09kref_put(&sensor_inst->kref, hid_sensor_custom_free);
+}
+
 /* Header for each sample to user space via dev interface */
 struct hid_sensor_sample {
 =09u32 usage_id;
@@ -658,11 +676,14 @@ static ssize_t hid_sensor_custom_read(struct file *fi=
le, char __user *buf,
=20
 =09do {
 =09=09if (kfifo_is_empty(&sensor_inst->data_fifo)) {
+=09=09=09if (READ_ONCE(sensor_inst->removed))
+=09=09=09=09return -ENODEV;
 =09=09=09if (file->f_flags & O_NONBLOCK)
 =09=09=09=09return -EAGAIN;
=20
 =09=09=09ret =3D wait_event_interruptible(sensor_inst->wait,
-=09=09=09=09!kfifo_is_empty(&sensor_inst->data_fifo));
+=09=09=09=09!kfifo_is_empty(&sensor_inst->data_fifo) ||
+=09=09=09=09READ_ONCE(sensor_inst->removed));
 =09=09=09if (ret)
 =09=09=09=09return ret;
 =09=09}
@@ -684,6 +705,7 @@ static int hid_sensor_custom_release(struct inode *inod=
e, struct file *file)
 =09=09=09=09   struct hid_sensor_custom, custom_dev);
=20
 =09clear_bit(0, &sensor_inst->misc_opened);
+=09hid_sensor_custom_put(sensor_inst);
=20
 =09return 0;
 }
@@ -698,6 +720,8 @@ static int hid_sensor_custom_open(struct inode *inode, =
struct file *file)
 =09if (test_and_set_bit(0, &sensor_inst->misc_opened))
 =09=09return -EBUSY;
=20
+=09kref_get(&sensor_inst->kref);
+
 =09return stream_open(inode, file);
 }
=20
@@ -714,6 +738,8 @@ static __poll_t hid_sensor_custom_poll(struct file *fil=
e,
=20
 =09if (!kfifo_is_empty(&sensor_inst->data_fifo))
 =09=09mask =3D EPOLLIN | EPOLLRDNORM;
+=09else if (READ_ONCE(sensor_inst->removed))
+=09=09mask =3D EPOLLHUP | EPOLLERR;
=20
 =09return mask;
 }
@@ -751,10 +777,9 @@ static int hid_sensor_custom_dev_if_add(struct hid_sen=
sor_custom *sensor_inst)
 static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
 =09=09=09=09=09=09=09=09*sensor_inst)
 {
+=09WRITE_ONCE(sensor_inst->removed, true);
 =09wake_up(&sensor_inst->wait);
 =09misc_deregister(&sensor_inst->custom_dev);
-=09kfifo_free(&sensor_inst->data_fifo);
-
 }
=20
 /*
@@ -977,11 +1002,12 @@ static int hid_sensor_custom_probe(struct platform_d=
evice *pdev)
 =09int ret;
 =09const struct hid_sensor_custom_match *match;
=20
-=09sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
-=09=09=09=09   GFP_KERNEL);
+=09sensor_inst =3D kzalloc_obj(*sensor_inst);
 =09if (!sensor_inst)
 =09=09return -ENOMEM;
=20
+=09kref_init(&sensor_inst->kref);
+
 =09sensor_inst->callbacks.capture_sample =3D hid_sensor_capture_sample;
 =09sensor_inst->callbacks.send_event =3D hid_sensor_send_event;
 =09sensor_inst->callbacks.pdev =3D pdev;
@@ -999,7 +1025,7 @@ static int hid_sensor_custom_probe(struct platform_dev=
ice *pdev)
 =09=09if (ret) {
 =09=09=09dev_err(&pdev->dev,
 =09=09=09=09"register_platform_device failed\n");
-=09=09=09return ret;
+=09=09=09goto err_put;
 =09=09}
=20
 =09=09return 0;
@@ -1009,7 +1035,7 @@ static int hid_sensor_custom_probe(struct platform_de=
vice *pdev)
 =09=09=09=09=09   &sensor_inst->callbacks);
 =09if (ret < 0) {
 =09=09dev_err(&pdev->dev, "callback reg failed\n");
-=09=09return ret;
+=09=09goto err_put;
 =09}
=20
 =09ret =3D hid_sensor_custom_add_attributes(sensor_inst);
@@ -1034,6 +1060,8 @@ static int hid_sensor_custom_probe(struct platform_de=
vice *pdev)
 =09hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 =09sensor_hub_remove_callback(hsdev, hsdev->usage);
+err_put:
+=09hid_sensor_custom_put(sensor_inst);
=20
 =09return ret;
 }
@@ -1045,6 +1073,7 @@ static void hid_sensor_custom_remove(struct platform_=
device *pdev)
=20
 =09if (sensor_inst->custom_pdev) {
 =09=09platform_device_unregister(sensor_inst->custom_pdev);
+=09=09hid_sensor_custom_put(sensor_inst);
 =09=09return;
 =09}
=20
@@ -1054,6 +1083,8 @@ static void hid_sensor_custom_remove(struct platform_=
device *pdev)
 =09=09=09   &enable_sensor_attr_group);
 =09hid_sensor_custom_remove_attributes(sensor_inst);
 =09sensor_hub_remove_callback(hsdev, hsdev->usage);
+=09/* An open file may still hold the last reference. */
+=09hid_sensor_custom_put(sensor_inst);
 }
=20
 static const struct platform_device_id hid_sensor_custom_ids[] =3D {
--=20
2.43.0


