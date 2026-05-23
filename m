Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E930BF4F;
	Sat, 23 May 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549843; cv=none; b=gwOivx7B9Oj3+mBuz2eChBPim6uVy0Z65Dep4K+aaEGBVKUIiCprjKGLhVAj9h4eK0WTCqFSNyFdV1q6pIrspBllnWKEOK+h99/JGOpeQjiZKVvovQLDDRFkiFe02C8vnBb3e7JEjhzNwRob7y/s0d2M3UovrAJnrYcrMwpdLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549843; c=relaxed/simple;
	bh=hiwl02EWDEaOsbZqQQNdu94Evi7iz/2YAA/hKP/sPOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL+VUugmvJLeZBVWA8ccasLTrWpQ3H+1rlQmM87FnEmttCOw8Eo8NG2DqALsfXpjYQTaaiE1RYLhPKz+n8t/s3RkVOEOR6KEehYSDdN/Z4XKwc8NFXx1+nZxEA6L2kCiteOB1ZwO15thZy1rtPxPCFN7LqW2gN1sXcW7qnv1zVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=CsYhi4oA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="CsYhi4oA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779549839; x=1780154639; i=hendrik-noack@gmx.de;
	bh=OMHZtrW+EbZf3W0Lvr9felh+4kSEjESiNdubeWOy/oQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CsYhi4oATr7S2iAqJdS9keFJ0dTGd5/be0G8IUE0C0ROaUyOPKJf6Tp/vwNfeK4Q
	 ofHgf0BWDDpxxmmxNLAHeCf2EtLutLiFNZ39w1x0x5OmU+OYcIVUfeOnDIUn1ElhG
	 Psin8Sqe4PIQI2zz3p3KJYasNkSKb2OvhU5oKZ7bM/A+TOLJpdM8xXTjMMz5xfriu
	 WYhdXO+i6TMbvK6S0HBJYq4XQBCFQEt9n/wCBh7g5qe1q1XFJ2cEJ5/2uw1lOt9Kj
	 Ziu7hEpZhC5AjsoVXg65ynpXK03ExLvu41QcJ6J27cSWmU7SbEyw2XKztYyxZgTBd
	 4hAmKbG3ZTtF7/KCtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1wmBu500oo-00OBcP; Sat, 23
 May 2026 17:23:59 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Nick Dyer <nick@shmanahar.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Input: atmel_mxt_ts: Allow per-board config via DT compatible
Date: Sat, 23 May 2026 17:23:32 +0200
Message-ID: <20260523152332.86864-2-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523152332.86864-1-hendrik-noack@gmx.de>
References: <20260523152332.86864-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6mJtK62F61u5kP8U7Pav0x7ymo/YI/2AVtoIoqbtuuuYzqsZp/W
 snAbf8+ufD57/AZR6dJESfB6tvtnD9wosWKOQCYzM4+odDroEyWBa32hHjytHtzxtjR0RGF
 1zo8sVuiLfx779jUB0grquLx1Exlc1dUGxZz1IT7UT7ac38UxuCgcunN6euJ6MCW1CQ0rgP
 BbHYIkREfr6spcxkPWE5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LBSYqdcNh8c=;ROpXDbWwcZn58pxjOQGv2Cbv+EO
 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
 W8tFDj9GQ=

The Atmel maXTouch config is board-dependent: different panels and layouts
require different configs even when the same controller and firmware is
used.

Extend the driver to support per-board config files keyed by the device
tree compatible string. For DT-based systems, the driver now looks up the
primary compatible of the board and searches for a config file named:

  atmel/maxtouch,<compatible>.cfg

If such a file exists, it is used as the board-specific config. If the
system is not DT-based or if the per-board file is not present, the driver
reverts to the original behaviour and searches for a config file named:

  maxtouch.cfg

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
Changes in v2:
- fix leak of fw_name (thanks sashiko.dev)
- adopt to added patch
=2D--
 drivers/input/touchscreen/atmel_mxt_ts.c | 68 ++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touc=
hscreen/atmel_mxt_ts.c
index 07690c3bff06..a9e9f151d042 100644
=2D-- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -36,7 +36,9 @@
=20
 /* Firmware files */
 #define MXT_FW_NAME		"maxtouch.fw"
-#define MXT_CFG_NAME		"maxtouch.cfg"
+#define MXT_CFG_FOLDER		"atmel"
+#define MXT_CFG_NAME		"maxtouch"
+#define MXT_CFG_EXTENSION	".cfg"
 #define MXT_CFG_MAGIC		"OBP_RAW V1"
=20
 /* Registers */
@@ -2233,6 +2235,64 @@ static void mxt_config_cb(const struct firmware *cf=
g, void *ctx)
 	complete(&data->config_completion);
 }
=20
+static int mxt_invoke_config_loader(struct mxt_data *data, bool device_sp=
ecific);
+
+static void mxt_board_config_cb(const struct firmware *cfg, void *ctx)
+{
+	if (!cfg) {
+		struct mxt_data *data =3D ctx;
+		int error;
+
+		error =3D mxt_invoke_config_loader(data, false);
+		/* request_firmware_nowait() succeeded and mxt_config_cb() will be call=
ed at end */
+		if (!error)
+			return;
+
+		dev_err(&data->client->dev, "Failed to invoke general config loader: %d=
\n", error);
+	}
+
+	mxt_config_cb(cfg, ctx);
+}
+
+static int mxt_invoke_config_loader(struct mxt_data *data, bool device_sp=
ecific)
+{
+	struct device_node *root;
+	char *board_type =3D NULL;
+	char *fw_name;
+	void (*cb)(const struct firmware *fw, void *context);
+	int error;
+
+	root =3D of_find_node_by_path("/");
+	if (device_specific && root) {
+		const char *tmp;
+
+		if (!of_property_read_string_index(root, "compatible", 0, &tmp))
+			board_type =3D kstrdup(tmp, GFP_KERNEL);
+
+		of_node_put(root);
+	}
+
+	if (board_type) {
+		/* get rid of '/' in the compatible string to be able to find the FW */
+		strreplace(board_type, '/', '-');
+
+		fw_name =3D kasprintf(GFP_KERNEL, "%s/%s.%s%s", MXT_CFG_FOLDER, MXT_CFG=
_NAME,
+				    board_type, MXT_CFG_EXTENSION);
+		cb =3D mxt_board_config_cb;
+		kfree(board_type);
+	} else {
+		fw_name =3D kasprintf(GFP_KERNEL, "%s%s", MXT_CFG_NAME, MXT_CFG_EXTENSI=
ON);
+		cb =3D mxt_config_cb;
+	}
+	if (!fw_name)
+		return -ENOMEM;
+
+	error =3D request_firmware_nowait(THIS_MODULE, true, fw_name, &data->cli=
ent->dev, GFP_KERNEL,
+					data, cb);
+	kfree(fw_name);
+	return error;
+}
+
 static int mxt_initialize(struct mxt_data *data)
 {
 	struct i2c_client *client =3D data->client;
@@ -2288,11 +2348,9 @@ static int mxt_initialize(struct mxt_data *data)
 		reinit_completion(&data->config_completion);
 	}
=20
-	error =3D request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
-					&client->dev, GFP_KERNEL, data,
-					mxt_config_cb);
+	error =3D mxt_invoke_config_loader(data, true);
 	if (error) {
-		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
+		dev_err(&client->dev, "Failed to invoke config loader: %d\n",
 			error);
 		complete(&data->config_completion);
 		return error;
=2D-=20
2.43.0

