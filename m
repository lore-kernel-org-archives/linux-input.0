Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52B1F4634;
	Sat,  7 Mar 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772875649; cv=none; b=XEjBHy/IFeXhFFQySSFoGJv61Ig385cHD3VrChWRUXH9nRypZIDpRsEmRfGUP5r4N/wyzILtZjLth1PO1iuJ613uB7D0XB/RXya2JTWEr3Dg6une9iyRqXV9cSbG7sTeHqPYh9lrbE5mlQFO3e9srshhYWC3h03gHwzLb2YC0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772875649; c=relaxed/simple;
	bh=EPZmcAKRFS2ahT2F7FNIUpfn4CqU5Pm213uanHZglfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORtGbqfXHJ/EU/4t4X/it85SxZooOIUd1UMSZZBV7UNQ+6erqKAbUxW6awS7pFFTaV0HhsnaimDB0ZNN5geEhRAzroZSvzWP2/fVJGuF863BJWSsi9ZZ9LTHRl0hANLxuBjFKB1A+ZmXG2pYK4nrjEL/2fob7iE8tVqpjB5K9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=cm4RyNph; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="cm4RyNph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772875643; x=1773480443; i=hendrik-noack@gmx.de;
	bh=CRewjuzcYdzSQjglNrHs67/cfBWmll+ioL7hbH2y/qk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cm4RyNphuBkxo93ksCsPyfGhkcj+qml9+8e/xQJ63osS8Wi94hmrs3hJpDczD1p/
	 lE+YGeqRK7yU3iJUiKi3jkADeLqGsFi3vSTxrfhSuqw1X8PHACX1VpAL8cJX+LGtK
	 sFYecMtRC1Fs4peDeOTLyatMdBOYJsD28vvYsHan+PgDNjQZRqrletgtF+IAAxO36
	 MXf0FwtxNR/ywbGygxcONULYPxqSzKdSQGQhAsfNKjYxW6mcWS2OPT9Wmfu9Q/gZ4
	 exhYybwhn5Zmr4FCvXjaszFO+SJwWRlEu54FTXBXteURNWpHPivSrFYjg2nDl4IAs
	 BiUFTrkLGi50Wv/ivQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1wG3g21n6H-00WGMK; Sat, 07
 Mar 2026 10:27:23 +0100
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Nick Dyer <nick@shmanahar.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: atmel_mxt_ts: Allow per-board device config
Date: Sat,  7 Mar 2026 10:26:05 +0100
Message-ID: <20260307092641.21623-1-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iiWp5cJ5xua77LyvF89/XKzmsJJ0PYzA7rlVIQdX0+Sa19fqihC
 81WIYp8ccZJk4gzeC5amC7DnmNxC2Ddb7b6NqWysGenhRRkOxUErPNOXkMwnat04Wqk9RMb
 Bii99lo1YLEIyp03leYn6EG5ZLHdx6XtasqysbryNUrjnPCddk5Mj0dnmE/3NRKpetMSxct
 z3hkMgJPqWBKKMx+nJTXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i9k29FVegBw=;h6vR6js1Nv0m0xABvehMJD8AnkQ
 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

The device config can be device dependent.

Rewrite the code to be able to get a per-board suffixed device config as
well. If this does not exist, fall back to the standard device config.

Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 drivers/input/touchscreen/atmel_mxt_ts.c | 64 ++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touc=
hscreen/atmel_mxt_ts.c
index dd0544cc1bc1..0d3921482d9f 100644
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
@@ -2248,6 +2250,60 @@ static void mxt_config_cb(const struct firmware *cf=
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
@@ -2294,11 +2350,9 @@ static int mxt_initialize(struct mxt_data *data)
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

