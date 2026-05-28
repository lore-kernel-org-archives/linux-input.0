Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD55348C7D;
	Thu, 28 May 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954206; cv=none; b=RvSeMqVRKl7BDZdQ5YLqdNeyTKS5F9pjloJijmyewWUMVLz3tgSY9auZGFOuTLy57N4+wWzXfQ0Q8wsUnys7SeT8uf6/OmFG9RNQi0rTy8kcdmK1LoWxmh+BdUwkEaOp2XxamdQDc2eWlqYsrbqoE25LXPtOndXtdNvXTYeB0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954206; c=relaxed/simple;
	bh=6SMjw5Z2XJLrglbZFc5c+QG++BMEct7yJdWK8AkL/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LujDnW925pOZQVb3EzCpS4p4qO1AIVU0i0vAAQikSkbIJOKHvpN43Zw5ZMjrmweT7/KyVyYizuM8ltyqmskH9xuWzso6AWdOCX/z+ExEjWXzl6KRG/iJ1GU6domOfWjU0ZwwjbzKM1f0KKUNLBM6abtnebaA1fwoEI2TP2MTTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=FulYK4Q2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="FulYK4Q2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779954201; x=1780559001; i=hendrik-noack@gmx.de;
	bh=2cN6AeR/4OS7qCCN2UAFOZSbUznVg3KYZs2EsrIlJlY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FulYK4Q2atZdmLaAW6j45r0mgzhG/a7bZ484hMBJKjX1E1kgwnGyQcQWvOBcKh3n
	 fRFQoLEWAho+ab5LOnMrOLtwxaZec+LrG/xKlwLF2fJvAJuBL4R8vnC89LsVy+hxa
	 ql+fUQtXZrtHb48+zUA0+FS+anh8oktnY1cz7vfEt2lQjPEbVcYaTUiME88tMW3yl
	 2dA9rQnUsCSjXu08PU5YhI2sSPwFokgsXo8Ds9H/EN+KxAGChAhB/a5zdyFxsyAhR
	 05K+liVDTFgHJJ0ObdGHxfTd6CIX5bx6GN/9BTD/Xfe9/IJlZ1s03hZ+ECETOzNeC
	 HbfGkLIhSACDLWfCSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzOm-1wgjQL1nEy-00Xt2O; Thu, 28
 May 2026 09:43:21 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Nick Dyer <nick@shmanahar.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Input: atmel_mxt_ts: Fix async config use-after-free
Date: Thu, 28 May 2026 09:43:16 +0200
Message-ID: <20260528074317.9604-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HqKMXge8pd3H33eoZEKUkcJ8IMHMrOgdD/NFLqy9WgN5IZe4OZf
 K+zkCSHGu3xNUpDEPis4FKFVQkdVOcVENQWquJDnP1wot8W3kvXORvHLACJxlzE0HqRXM/k
 gxxJg8BWeocKRI7uMy6+OAlUuEyZGGs5mowzLX12R+eavgL1Pl78U5XQFdt+QKCS3n9eKKm
 TZk3QnrEHLeey4vP2UoYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dAnSpMDij9k=;8iXuvv+/1L9Hvfer2lKQ1KAR8N+
 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

The Atmel maXTouch driver starts asynchronous config loading from both
probe and a sysfs trigger via request_firmware_nowait() and passes the
devm-managed struct mxt_data as the callback context. If the driver is
removed while an asynchronous request is still pending, devres will free
mxt_data before the firmware callback runs. When the callback eventually
executes, it dereferences the freed mxt_data pointer, leading to a
use-after-free.

This is resolved by introducing a completion that serialises the
request_firmware_nowait() and remove():

Before calling request_firmware_nowait(), a completion serialises the
calls. If remove() has started, the asynchronous loading will no longer be
started and all waiters will be signaled. The completion is completed at
the end of the callback or if request_firmware_nowait() fails.

In mxt_remove(), the completion of pending request_firmware_nowait() is
awaited and all waiters will be signaled.

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
Changes in v2:
- this fix is added to the patch series (thanks sashiko.dev)

=2D--
Changes in v3:
- remove unnecessary lock

=2D--
 drivers/input/touchscreen/atmel_mxt_ts.c | 34 +++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touc=
hscreen/atmel_mxt_ts.c
index a9e86ad7ed5e..a88dc7e6827c 100644
=2D-- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -347,6 +347,10 @@ struct mxt_data {
 	/* for config update handling */
 	struct completion crc_completion;
=20
+	/* for loading config */
+	struct completion config_completion;
+	bool shutting_down;
+
 	u32 *t19_keymap;
 	unsigned int t19_num_keys;
=20
@@ -2221,8 +2225,11 @@ static int mxt_configure_objects(struct mxt_data *d=
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
@@ -2271,12 +2278,26 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
=20
+	wait_for_completion(&data->config_completion);
+
+	if (data->shutting_down) {
+		/* complete() only signals one waiter, signal all waiters once during s=
hutdown */
+		if (!completion_done(&data->config_completion)) {
+			complete_all(&data->config_completion);
+			dev_info(&client->dev, "Shutting down, not loading new config: %d\n",
+				 error);
+		}
+
+		return -EBUSY;
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
@@ -3237,6 +3258,9 @@ static int mxt_probe(struct i2c_client *client)
 	init_completion(&data->bl_completion);
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
+	init_completion(&data->config_completion);
+	complete(&data->config_completion);
+	data->shutting_down =3D false;
=20
 	data->suspend_mode =3D dmi_check_system(chromebook_T9_suspend_dmi) ?
 		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
@@ -3342,6 +3366,14 @@ static void mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data =3D i2c_get_clientdata(client);
=20
+	data->shutting_down =3D true;
+
+	wait_for_completion(&data->config_completion);
+
+	/* complete() only signals one waiter, signal all waiters once during sh=
utdown */
+	if (!completion_done(&data->config_completion))
+		complete_all(&data->config_completion);
+
 	disable_irq(data->irq);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
=2D-=20
2.43.0

