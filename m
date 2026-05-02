Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C6BA34;
	Sat,  2 May 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777713940; cv=none; b=fOmd2eileLYwbd92X5WengTw7GfOw45NHS1S+JEpWLtUm3Vi4p2d3fgYmJZafDzflHulM9B50lOa7a6b4NrzkcVPJZxGdArWBGpTiNjG3K6LmbrK1mQjW/pQFDnjsr+ZbEuEmxGS3E2NddlZm05dJlKllNi1MA+hNMTyq/4hBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777713940; c=relaxed/simple;
	bh=H2gmk5RGo8UAEapvCu1enschTnRCi6duT15b9hzNHfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W50QRl1lQH09P5gi2BlbFLG4zHIVgC/WtLfStT+0HoIBr5wdifSrejujxkwUhV25xCHYmuSmViOOk6NQgcNZRuKfCRLAjlFE9ccrOISCqQgxk88++ZHNTpMfR/l2ghfe8l1+GOMvo2h93zSpbdaiodPoOvh1bLg0QVeHfniR9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=FEl4ZFuy; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="FEl4ZFuy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777713934; x=1778318734; i=hendrik-noack@gmx.de;
	bh=ELU8aYJQezFZLC/UYV3mmsbawST7hDYQBOiJ/UQfvO8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FEl4ZFuyITtOe8Z6GFLdECssohoDFxeLo/2x5XSQR0YWCKiSAYSLLu2qY73ztOKh
	 81O9bmq/dgvpYlfd7P8zX6AQDMSav+RQJnbD7nplVIiWkOpHmrKeSelWw2c3wqXNp
	 g18DiPNi+1pVjZZc2F+I0i1Bf+3KEjR97uyiCVFwYnxQgTPGk1oU+Xts5cd56I3KD
	 yZ7TnWeQ0TyODLfWSN9gQhrPLNPNPiIbZ8Cz8KJdsMzdaQmrrxCmJfTqkAFjU6JW/
	 v5qAkyi+fj6b1Xtxo32sIahzX43p8NKMEgcEKFWZbbyRY/XFD9ONw0clJfM5WFXbd
	 1bNX1b355LH/vfHjIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1w6nL91ygf-003sHd; Sat, 02
 May 2026 11:25:34 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Nick Dyer <nick@shmanahar.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Input: atmel_mxt_ts: Allow per-board device config
Date: Sat,  2 May 2026 11:24:00 +0200
Message-ID: <20260502092419.5932-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307092641.21623-1-hendrik-noack@gmx.de>
References: <20260307092641.21623-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nQyWA0gGZHe5nXKmcZn4ddaKcsgcs8XiCze0rkzgoWjxnhIZqgO
 8LR4MhZ79csxzrqmON1g6nXrd4uJ9oFaXdyKbeh3pZEFJAR0wjImER/BPa/K1mN0Slk6fO7
 mzwGFiW7audoENX0uwfY5vehuTvSu9dXQUIVmkw9Pc6wsOVygRxI60ERm/GdFFM+C4shPB0
 D2L9+wMM2afGGPjo9qJpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yqYEt5A4pSo=;6KVMTmqI6xvQ03EibBedeMuJDum
 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
 Z7hQOQ==

The device config can be device dependent.

Rewrite the code to be able to get a per-board suffixed device config as
well. If this does not exist, fall back to the standard device config.

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/atmel_mxt_ts.c | 64 ++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touc=
hscreen/atmel_mxt_ts.c
index 87c6a10381f2..2fe0f17f475b 100644
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
@@ -2224,6 +2226,60 @@ static void mxt_config_cb(const struct firmware *cf=
g, void *ctx)
 	release_firmware(cfg);
 }
=20
+static void mxt_board_config_cb(const struct firmware *cfg, void *ctx)
+{
+	if (cfg) {
+		mxt_config_cb(cfg, ctx);
+	} else {
+		struct mxt_data *data =3D ctx;
+		char *fw_name;
+
+		fw_name =3D kasprintf(GFP_KERNEL, "%s%s", MXT_CFG_NAME, MXT_CFG_EXTENSI=
ON);
+		if (!fw_name)
+			return;
+
+		request_firmware_nowait(THIS_MODULE, true, fw_name, &data->client->dev,=
 GFP_KERNEL,
+					data, mxt_config_cb);
+	}
+}
+
+static int mxt_invoke_config_loader(struct mxt_data *data)
+{
+	struct device_node *root;
+	char *board_type =3D NULL;
+	char *fw_name;
+	void (*cb)(const struct firmware *fw, void *context);
+
+	root =3D of_find_node_by_path("/");
+	if (root) {
+		const char *tmp;
+
+		if (!of_property_read_string_index(root, "compatible", 0, &tmp)) {
+			board_type =3D kstrdup(tmp, GFP_KERNEL);
+
+			/* get rid of '/' in the compatible string to be able to find the FW *=
/
+			if (board_type)
+				strreplace(board_type, '/', '-');
+		}
+		of_node_put(root);
+	}
+
+	if (board_type) {
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
+	return request_firmware_nowait(THIS_MODULE, true, fw_name, &data->client=
->dev, GFP_KERNEL,
+				       data, cb);
+}
+
 static int mxt_initialize(struct mxt_data *data)
 {
 	struct i2c_client *client =3D data->client;
@@ -2270,11 +2326,9 @@ static int mxt_initialize(struct mxt_data *data)
 	if (error)
 		return error;
=20
-	error =3D request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
-					&client->dev, GFP_KERNEL, data,
-					mxt_config_cb);
+	error =3D mxt_invoke_config_loader(data);
 	if (error) {
-		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
+		dev_err(&client->dev, "Failed to invoke config loader: %d\n",
 			error);
 		return error;
 	}
=2D-=20
2.43.0

