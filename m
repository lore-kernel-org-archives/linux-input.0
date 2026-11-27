Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775674;
	b=GmrQSyMP/uS1sCa9sFq/jgGICPIPlnCJO0HebmY0JMnYgOdEkFalXHQEjrojQgxfAstk
	 9T5jmQzPIrlVQleMiiHTmqDmZb3vsDUrc9bF6B5aZFqpRB4XggBKYz6q6UbyqJURjBBE6
	 NxMZul2A0zyU7eaiqVYfGKH12cVG94KkxMxutAwJRzHUrJvVRhunsuCWSYiGV2+lex+ot
	 elOyjAIGUNz80pff2joqbCqlDZiiV6XFjY6diSLR1nAk6tZ73MJvRjCKmWWwyjl15OWT0
	 QZReTGWkmXcNz58T22LdZqS5O7qV+t/hYhYuj3ANDayss1VhGG6o01I+Kye0bIznrJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775674;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8p6xzVo8sXoon4TOd4T37ryPQTSud56CfBcRxMZ8ogM=;
	b=crVAeWQu2lDvItQUUPrn/mZPooSl9J0CLI1c2ZM6cOf9Co6LIBFiJzt6POKBK1z4cJlI
	 mWWub7e3m/8JDa4TWBk417SfhF8foXKgoXt2xP/Bpwu0tFZGynxUI8JdTc3pcwdKctkLT
	 kZiriRsAOtGQJqYql9ZWBZ84M/gcIOf13FXEcQD4XbeWTQSUH779hgj5/GceQJ3xdAazB
	 /r8BikPzz4tpHLnxvxj4ICFANMGyaVDBHvr33WRBhPg9Ij1tLblisiq2GrYzSuzU5kMe3
	 QEnqODkkdE+502HxeEGioQU+Q7C9Sd7DdOpMKj8/FL+rp5S3ZiY2RaoPVsvGyI8mLDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSkiMymI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF99606A68B;
	Fri, 27 Nov 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSkiMymI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775674;
	b=SStqp1NlXoahA4Ujh7ZVYzRV2Ke7635pjGzYfvWscLUbwYJ4Pi6LzYN4yklDPvG4yQZo
	 vtvpSDkSM6hajWXYziQzva58TnzvtX10rTo8jYysflX7txK9Gdip2jZO+aggHq536Tpq9
	 ypJZD3JgxoaRjgkv9cgnWCl/1xdw/DhgJsif8t4cuUSEExUy19tkWJshw5eDaxbWhcmnw
	 hbmXPM84csTjGb0Jdb2QpyPYLDCI54I5NvrlXF4UOa/jVL4u7OwAVhmW+976Lkdyc2pJz
	 jxxC35e9yllgKLsmxNdAE3nxb891Jn2GxHeMymORpT+Th7rDzWGYdrCjrN+C7tcYgOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775674;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8p6xzVo8sXoon4TOd4T37ryPQTSud56CfBcRxMZ8ogM=;
	b=rQQNR3fAz9NVdWVbVimcZXKiihxiO+eHgBGvsqQ6uPSfGWovhyw/FK9wvTUQUVdyLPPg
	 lLu3lsVO/iGOYhURI4wDVIU/iZukQB8UlD65g89rt0njChknRazegnZXvKYG2x1sGYHZr
	 KefrwIfN8M3w2xeH0hm20odWSWmvq9gYoquS6qMHbFvDzJK976zNg5oEfIzaCmgjFK+vC
	 jCRfA/xEB/klnkP0O9I9iap3UWDkRGq91luOv9yF8zAbveLwsN8uO7IsEmkR1XxMCOhjU
	 RjakuA0Fe1SHtSLB7tjDwtItLPFc63tnGEoHuru4RxItRRLv0tyEKX9u2i+xFzzlNxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B25461F00924;
	Fri, 27 Nov 2026 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775674;
	bh=8p6xzVo8sXoon4TOd4T37ryPQTSud56CfBcRxMZ8ogM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CSkiMymIiFQhz7y0NzItOCn87N+MaNkHGNBhUKv6d0uWkUP/Tf0qPe40/X9wG/pQN
	 keXp8qeKKvtCfqxzm6+EG5knBC38XNMDO3gkOZoyuraxzw8pAynnS1e1LL3prwtGia
	 OD213EstiadtK8Vr/6QAjSVB2h9WjYzuQXYOsUZ3zF5sNjsT7kNZdEzZiBVwAiKiTA
	 wHweUeNZ4tOsz+tR1RueesZlriMp7EMGO8cecuTHnfp5N8MR3Yj7WIjRae0M8GuzmH
	 8bi9/aMl4XWJJBONMPF9//VRjN4IH75CDcEW1U/hML5WT1VS5+ISj9TKildBzfPRKQ
	 I521dwu1yNYCA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9DDF74B73F;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:04:01 +0530
Subject: [PATCH v2 6/7] iio: Simplify trigger setup error checks
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-6-3f476fe1a940@gmail.com>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
In-Reply-To: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=3522;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=pmCyyi/Q00a7W06XN+DdDqeCpGYAnLZhG3rV6Fd81Co=;
 b=VGrql/2ZZGijcxbJbKqbMEwcZ+cchfxxNM4xVRamqubMcJhGGLic7cLWpJmh/jpaTI5XR4LN9
 coRr998xlC9B/2d8MN+ZOpzgNwpiu4ZoxyAA01ZeQtwqhK7J8ZIwQ8z
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

devm_hid_sensor_setup_trigger() returns 0 on success and a
negative error code on failure. Replace open-coded error checks
using:
	if (ret < 0)
with:
	if (ret)
across HID sensor drivers using the helper.

This simplifies the code and aligns it with common kernel
error-handling style without changing behavior.

Suggested-by: Joshua Crofts <crofts@kernel.org>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
 drivers/iio/light/hid-sensor-als.c                   | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 2 +-
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 414d62d2249f..d75ee16b8f45 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -372,7 +372,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &accel_state->common_attributes);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	accel_state->callbacks.send_event = accel_3d_proc_event;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index cc81ac2ccdd1..d5acb38268af 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -308,7 +308,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &gyro_state->common_attributes);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index ef864a2ba4b6..9b3c8d8345b9 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -409,7 +409,7 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &als_state->common_attributes);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	als_state->callbacks.send_event = als_proc_event;
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 3a8fbe1655dd..c179fcd364b9 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -484,7 +484,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
 					    &magn_state->magn_flux_attributes);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	magn_state->callbacks.send_event = magn_3d_proc_event;
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 4c59d8a0e7cd..9bc0262b27c4 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -309,7 +309,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	atomic_set(&st->common_attributes.data_ready, 0);
 	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, indio_dev->name,
 					    &st->common_attributes);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	st->callbacks.send_event = hinge_proc_event;

-- 
2.34.1


