Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8428DB46;
	Sat, 23 May 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549840; cv=none; b=Htm8+i/3akooxWXnZC2epYfqj8F3nQBLEKgAm3qztr5dq/URhRAanZ31ix4Bux1+6Og/ALjf2KHEVKm8eLDk+nd/fpXcTrIRrbvstG7oo6CUj9ZhEwFxwbjKp8gEeRz4GSNmDsI09OrptorM+MMOm6ntZ6fMJuL4YfRt239B1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549840; c=relaxed/simple;
	bh=Yl9VE6dQe8nPTUMHEsMNO6FKDzhcBLUeWG7yz1/dztQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCrPUElpaWlt9ZaPlVB+Q4nqLfBB7ll22/O4/z3sAHa6d3nB5kEjjRITAa9dxhutTWm7Ons6x4wS0v0tIncz7hMkwpF5dcOWHxVHyuP7rkSqp9r8rLRJ+vtzSGiQ2APK5COvyCVnYkcUd9BQEw7BAchXij2Plpzjm9PU+y714tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=d5IeUI8/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="d5IeUI8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779549836; x=1780154636; i=hendrik-noack@gmx.de;
	bh=KMH1mmEG/7FXE7SB9r7ZkYVKvK+CgGfFfDrVEWZIl6k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d5IeUI8/YGIdvPZ9XG5X0aa0eRPWD5zT/bZkHH1Mo4WI2eZVGxgDT8orRjFap6ig
	 HW9e3k7M8Qy4+LqZpjciUEZoO7jxYBdsdADSy8nyu6sQgrdVWZC1JgEEql28Wi29X
	 x1z0JHd09xgjATZc4wvMrtuMdoEtaRp1BO34GimJoggwNAidHVkoVI4F22xEQJ9YQ
	 FNuyLF/QaobEkvIlOOVXtzAb33XSqJtUhLoGKg6V2XfPqF7se/DWLA0LyOQ1RgjIh
	 Fq2Ao51tij9tHZchUMFozVvil0Pp1beFSmCgMSZjm40xyHC6LVqG0NwiWqIL3fLSq
	 m4f/GCA3SIzWP1qiRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1wU73Q0okW-005yHL; Sat, 23
 May 2026 17:23:56 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Nick Dyer <nick@shmanahar.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Input: atmel_mxt_ts: Fix async config use-after-free
Date: Sat, 23 May 2026 17:23:31 +0200
Message-ID: <20260523152332.86864-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h+/3fVg4sAV9tXcmMgBmdPyj8xjhg1l+LwuHtLE5eXUuDe04hFB
 LgHLlKjv/CCwroFpF2MvzquW+LtKW8p3PQ4K42PgtdpIgmJ4eq+K6mnVJk1o/28izqydvwk
 zd2VdTBAgu7GDek6ZPVP6pwwWo/p1GfEvG+cOZEGzIUsrU6eZts/R7RJeDvRQVaO8mTGuZC
 OOxe7jzA5I2AsqkdzdwcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:auzAUseORsc=;5rRN+nXu0Czq4VZ/D+HyT8bZNtV
 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
 kg8NIxi6WaXYyKkH1VhRO34ggPUrHvvA/LB97Xa

The Atmel maXTouch driver starts asynchronous config loading from both
probe and a sysfs trigger via request_firmware_nowait() and passes the
devm-managed struct mxt_data as the callback context. If the driver is
removed while an asynchronous request is still pending, devres will free
mxt_data before the firmware callback runs. When the callback eventually
executes, it dereferences the freed mxt_data pointer, leading to a
use-after-free.

This is resolved by introducing a lock and a completion that serialise the
request_firmware_nowait() and remove():

Before calling request_firmware_nowait(), a mutex guards the waiting and
reinitialisation of the completion. If remove() has started, the
asynchronous loading will no longer be started. The completion is
completed at the end of the callback or if request_firmware_nowait()
fails.

In mxt_remove(), the same mutex guards the start of remove(). Afterwards,
the completion of pending request_firmware_nowait() is awaited.

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
Changes in v2:
- this fix is added to the patch series (thanks sashiko.dev)
=2D--
 drivers/input/touchscreen/atmel_mxt_ts.c | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touc=
hscreen/atmel_mxt_ts.c
index a9e86ad7ed5e..07690c3bff06 100644
=2D-- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -347,6 +347,11 @@ struct mxt_data {
 	/* for config update handling */
 	struct completion crc_completion;
=20
+	/* for loading config */
+	struct completion config_completion;
+	struct mutex config_lock;
+	bool shutting_down;
+
 	u32 *t19_keymap;
 	unsigned int t19_num_keys;
=20
@@ -2221,8 +2226,11 @@ static int mxt_configure_objects(struct mxt_data *d=
ata,
=20
 static void mxt_config_cb(const struct firmware *cfg, void *ctx)
 {
-	mxt_configure_objects(ctx, cfg);
+	struct mxt_data *data =3D ctx;
+
+	mxt_configure_objects(data, cfg);
 	release_firmware(cfg);
+	complete(&data->config_completion);
 }
=20
 static int mxt_initialize(struct mxt_data *data)
@@ -2271,12 +2279,22 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
=20
+	scoped_guard(mutex, &data->config_lock) {
+		wait_for_completion(&data->config_completion);
+
+		if (data->shutting_down)
+			return -EBUSY;
+
+		reinit_completion(&data->config_completion);
+	}
+
 	error =3D request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
 					&client->dev, GFP_KERNEL, data,
 					mxt_config_cb);
 	if (error) {
 		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
 			error);
+		complete(&data->config_completion);
 		return error;
 	}
=20
@@ -3237,6 +3255,9 @@ static int mxt_probe(struct i2c_client *client)
 	init_completion(&data->bl_completion);
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
+	init_completion(&data->config_completion);
+	complete(&data->config_completion);
+	data->shutting_down =3D false;
=20
 	data->suspend_mode =3D dmi_check_system(chromebook_T9_suspend_dmi) ?
 		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
@@ -3342,6 +3363,12 @@ static void mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data =3D i2c_get_clientdata(client);
=20
+	scoped_guard(mutex, &data->config_lock) {
+		data->shutting_down =3D true;
+	}
+
+	wait_for_completion(&data->config_completion);
+
 	disable_irq(data->irq);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
=2D-=20
2.43.0

