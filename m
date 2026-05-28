Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD410348866;
	Thu, 28 May 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954206; cv=none; b=lxBdAYS7uTEzF2rpbJtvEg35arkD6Y0SOlXKLVjkkTHBa1Ad1BVdMX0LQab+S7tda7lcEdCXqDjE2dHJGoZ2vqCZciF5GpfAqM5ywlSxdaLqU/pOfGfe9YwsNPy4hpPSn5aD1Vd1zZTrlj8sTUYWBmvQuHm/2BFS9J6HeoDvJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954206; c=relaxed/simple;
	bh=muw7wXy++ietUI08m8k4FgBGWwgAyXKQpzthQvz/LkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UH+A45pNP91MLY8roh/RVjmmmkPoVshTheHx7W6nVNrEPtCSBlYa/5yc0Uy0et471G5Vf/wh1xKMa+yoB41cfq+MH+/zN6gxB+Bon4jHRFthz2DcgxrVO+h8D6PnKOcZqbYVVJ7ESs8nPvykgKP/y4vOC0rvjSHTef8GPvJUSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=Cx8xiS4b; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="Cx8xiS4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779954202; x=1780559002; i=hendrik-noack@gmx.de;
	bh=oodft1en3oKtE1HTQBotWCE8sT3bYL5LTOwsGvbwKkQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cx8xiS4bgbA0CxiuXdGJeoobe9/qN+8Lfhe/CBJPJbFMgoFZNm9OgD6eeBCB2iKR
	 j0vNbhzwTHQFWjlE9kYTN3vOhXSdz1UuoX5IKFsIPIBUWY/qO1xSArDaiD1K/u2+s
	 8W3qVCXOKw3/CjlvHCpPY9ENy8fi2F6jDIChH5XihkBwvaTJbOXLiFzL/4k5bq8pw
	 bpITmS39LDvYtjwK+hhr5DB4OvEryYeuzCE14ovYIVW5jvZshxYZ1mQ0otMEVK/qi
	 GJUcbH8Pvzi9KekY0ShEyscq8N1eEc3GEJqKW4uJSWYf1Av1mm/cbBhmYxXwCX8Gf
	 +DLm6HeNNcId/bGHWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1wi78o3Ffr-00QRJz; Thu, 28
 May 2026 09:43:21 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Nick Dyer <nick@shmanahar.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Input: atmel_mxt_ts: Allow per-machine config via DT compatible
Date: Thu, 28 May 2026 09:43:17 +0200
Message-ID: <20260528074317.9604-2-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528074317.9604-1-hendrik-noack@gmx.de>
References: <20260528074317.9604-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AqufNXXbgivjdVK27IvShlwifMTv5YqVnp5qHa9b7G+NGtYwjgc
 oBIrKfsP1SOR5jvg6ITR8eTi+oFcGkIl2SJRgQWGWa375m/x46SfKQlkBCXySk8WH2f62si
 rcS5XvvJHQzzTpF10HF6nPidHce4EnrvlEfU5I5gsqxX5EwOfBJW2Sci3O2Km3yph0ihAiZ
 kLpqi/t8kip/B/CSpSlLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QVaN2IXlXeM=;OlE51z+7qQsEs4k1UFXuRK/B8aD
 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
 MBPOAKMk4=

The Atmel maXTouch config is machine-dependent, different panels and
layouts require different configs even when the same controller and
firmware is used.

Extend the driver to support per-machine config files keyed by the device
tree compatible prop. For DT-based systems, the driver now looks up the
primary compatible of the machine and searches for a config file named:

  atmel/maxtouch.<compatible>.cfg

If such a file exists, it is used as the machine-specific config. If the
system is not DT-based or if the per-machine file is not present, the
driver reverts to the original behaviour and searches for a config file
named:

  maxtouch.cfg

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
Changes in v2:
- fix leak of fw_name (thanks sashiko.dev)
- adopt to added patch

=2D--
Changes in v3:
- fix bypass of of_node_put (thanks sashiko.dev)

=2D--
 drivers/input/touchscreen/atmel_mxt_ts.c | 69 +++++++++++++++++++++---
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touc=
hscreen/atmel_mxt_ts.c
index a88dc7e6827c..0081fa5c7802 100644
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
@@ -2232,6 +2234,64 @@ static void mxt_config_cb(const struct firmware *cf=
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
+	/* Get first string of the machine compatible prop */
+	root =3D of_find_node_by_path("/");
+	if (device_specific && root) {
+		const char *tmp;
+
+		if (!of_property_read_string_index(root, "compatible", 0, &tmp))
+			board_type =3D kstrdup(tmp, GFP_KERNEL);
+	}
+	of_node_put(root);
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
@@ -2291,12 +2351,9 @@ static int mxt_initialize(struct mxt_data *data)
 		return -EBUSY;
 	}
=20
-	error =3D request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
-					&client->dev, GFP_KERNEL, data,
-					mxt_config_cb);
+	error =3D mxt_invoke_config_loader(data, true);
 	if (error) {
-		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
-			error);
+		dev_err(&client->dev, "Failed to invoke config loader: %d\n", error);
 		complete(&data->config_completion);
 		return error;
 	}
=2D-=20
2.43.0

