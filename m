Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794153320;
	b=NgJFajSH6X4TqwDXTK6tKFLhyLSybKGQ75PvJPB94h45QqRUZsDMtejqFsAmyTRcuALN
	 Xvv4kxYwASr8vY/3SOus6dBizCQtBGJfavk2bFeb8HuP5j6qIpUtVUKbB0Cp+fCu06fGG
	 3fAyT4P+sNP8pHFNDIaB5w6+fGlaQFtdusl4TsULN/HmO+yvUB6OpNW59rAwQgBR9+hVE
	 ZJ99ZBaLJYe5KMAOHDQAhI7ay1iQQbqo39NZnznJPFcaIph/shnpEeqX5MFp6r2VgmwGF
	 i0eE/9qOOOscbv6REnXw2zFu3NsOQb1EGy+/MAJBTYCZub+XkjozVCWKE6paOnxyOgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153320;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gNkya1AuRn4fcfMiMJOWLee8zEFRuyl9LsWqYK8oBaM=;
	b=AYOdJzV3l0mpt30x7zjUerJSvPFvvNYXNJrb+W9SKzjM3uWKp8U3W++CZuWYozZgqDoI
	 RjDmdzIPyyN9OQquDCfCpeukrbfIKgnpiECxje0Y9V9EB51Kj/6Y5yFlDPeTN+mYvFjys
	 DljW6YiQCc6O918o81QmbErOdX6VLIKJXqndXaguGevN3ps7YjxCan1BjC8dsGZac3fFD
	 oC5BmxwdwIBFe0t9JjwL+4oJYsjA5VCrL3EUuZV9N6gN0y1mIUTNkyjhbEW41t2CJoohR
	 oEZss1/9KKD6IS0d2l1TwdvTsSW2KLo/nz3+AhAnt3B8b3/OsjCgwY4luWxks895vjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7xl7eUm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC759606A321;
	Sun,  8 Nov 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7xl7eUm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794153319;
	b=VwAWUVKIUZg7OiWTNopd1W3gNUpteUQDzIR+dd4RuQE4in/1w39XXZSLUmb3QN/fEgDR
	 V55M8tbcAbtrh6kuDL2H6Ya3GFMdIAbHF5RR7XJ4M7WxvoJ6GHjCg7dycQJPTs6dumQXA
	 +bW+dxZnV2V+DI4VHyWveD9WIfgs/oUay5pSqCdK+YSfjf6ubwgidYrGuVaRzDdQq7uba
	 G8TE6Nq/4Pjun4AMrX5XtYTnN0s+9HAHUcdN/RIG+wi86agHXqAl598l7RnsOCDZ89I38
	 jwCAnrs2Q+ks2RPdqChO5fXKIAnzlCzRtvOEUsvbUD25vLX0JoxEUAigRzu5Aa4L/Mg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153319;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gNkya1AuRn4fcfMiMJOWLee8zEFRuyl9LsWqYK8oBaM=;
	b=dHFcZVV8B1hNqKqZf8VfBMGrnGiER5iFLW1q109RJ3FiyhOUc2sz2SsEoTrRH8p6Wu1H
	 FD2Y3vsooL5kI0A/O0BAySpwsbB5SsScCRN+2rhpL6hwg6lFOuyr65Wgj60ezVRIkspGw
	 lF46gZpQ37rfTwAmwoc6PBOaCvjNcEm20FzkEeZlR5VMh4M6uu3iFLPnYNdbzkCSNb6hU
	 PmFZRWIcgpf5QHZ22AxOmj++V8rFyKD7eNucNQ177SWX9XttPEuV7NodqNM6r6S+X2+bW
	 16aSpYm9sc1DpEDeUOvt2AflhJHQ8VqVjPArDiSurTplI0bGZfLatBFpvrGweWeWAPg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF6801F008A2;
	Sun,  8 Nov 2026 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153319;
	bh=gNkya1AuRn4fcfMiMJOWLee8zEFRuyl9LsWqYK8oBaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=R7xl7eUm15qyO+0XbI3CyWzBz7FiOVYGtYVLZ67guwZ/6q403ocKYxAwdbn7EFAnE
	 4zIYYm6pCsye8QIKsOSJ6PIsv9j/2ruQ7s+aHLMsNocGrcsb4XE5xGhQuIR/6V/Xy6
	 A0qKIsViRMEsycDMcbyoGnEYg8uvDK2JXQG2NuEAg82urjtczE1Gjl9mR0CPurrRWb
	 6+3Hezg2WXznAJb3qt1oHpeDGvt6rTuZ9uiPBuZKGVWOU+73fNf/KQDY5H/az8LHXN
	 ha4ZroRG2xXfwZNZo71sosMzLgkAVWPdJf3xjiKztfGpvwpdm779Nlf7d/It6mUOUW
	 Ph3Q0tsfm8Z0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 67EA847FE8;
	Sun,  8 Nov 2026 15:55:18 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 16:55:18 +0100
Subject: [PATCH 2/2] Input: wacom_w9000 - add support for Wacom WEZ01
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
Message-Id: <20261108-b4-wacom-w9000-wez01-v1-2-c2b5e3466187@dxdmail.cc>
References: <20261108-b4-wacom-w9000-wez01-v1-0-c2b5e3466187@dxdmail.cc>
In-Reply-To: <20261108-b4-wacom-w9000-wez01-v1-0-c2b5e3466187@dxdmail.cc>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794153317; l=5466;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=uHsNPsSVjwZ9k3pBmLEr4EVDJPo0qTTh5VfrkgYYpvk=;
 b=euTrEclM8hhUEUb7FkaNgmpgDthAZmc2mpblWZTNJleNRJzRkOihJ29I5KKJ6YBH/mjsU6VmV
 9u+Tz54jIsZDqjzTc19SnmakRFDeVAqplryWMPyHW9oWlmpvBHaiYRD
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

The WEZ01 uses the W9000 query and coordinate layout, but it is queried
with a plain 32-byte read that returns the query at offset 16. Its
messages are 17 bytes long, with the packet type in the low nibble of
the first byte, and only coordinate messages (type 1) are handled.
Pressure is 12 bits wide.

The protocol comes from Samsung's GPL driver for the Galaxy Tab S9.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 drivers/input/touchscreen/Kconfig       |  2 +-
 drivers/input/touchscreen/wacom_w9000.c | 53 ++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..3c55362cf0d0 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -615,7 +615,7 @@ config TOUCHSCREEN_WACOM_W9000
 	depends on I2C
 	help
 	  Say Y here if you have a Wacom W9000-series penabled I2C touchscreen.
-	  This driver supports models W9002 and W9007A.
+	  This driver supports models W9002, W9007A and WEZ01.
 
 	  If unsure, say N.
 
diff --git a/drivers/input/touchscreen/wacom_w9000.c b/drivers/input/touchscreen/wacom_w9000.c
index 4a2629a54167..af319fc3de73 100644
--- a/drivers/input/touchscreen/wacom_w9000.c
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -22,8 +22,8 @@
 #define CMD_QUERY_RETRIES	8
 
 /* Message length */
-#define CMD_QUERY_NUM_MAX	9
-#define MSG_COORD_NUM_MAX	12
+#define CMD_QUERY_NUM_MAX	32
+#define MSG_COORD_NUM_MAX	17
 
 /* Commands */
 #define CMD_QUERY		0x2a
@@ -31,6 +31,10 @@
 struct wacom_w9000_variant {
 	const u8 cmd_query_num;
 	const u8 msg_coord_num;
+	/* If set, the query is a plain read and starts at this offset */
+	const u8 query_offset;
+	const u8 msg_coord_type;
+	const u16 pressure_mask;
 	const char *name;
 };
 
@@ -81,18 +85,33 @@ static int wacom_w9000_read(struct i2c_client *client, u8 command, u8 len, u8 *d
 	return 0;
 }
 
-static int wacom_w9000_query(struct wacom_w9000_data *wacom_data)
+static int wacom_w9000_read_query(struct wacom_w9000_data *wacom_data, u8 *buf)
 {
+	const struct wacom_w9000_variant *variant = wacom_data->variant;
 	struct i2c_client *client = wacom_data->client;
+	int len = variant->query_offset + variant->cmd_query_num;
+	int error;
+
+	if (!variant->query_offset)
+		return wacom_w9000_read(client, CMD_QUERY, len, buf);
+
+	error = i2c_master_recv(client, buf, len);
+	if (error != len)
+		return error < 0 ? error : -EIO;
+
+	return 0;
+}
+
+static int wacom_w9000_query(struct wacom_w9000_data *wacom_data)
+{
 	struct device *dev = &wacom_data->client->dev;
-	u8 data[CMD_QUERY_NUM_MAX];
+	u8 buf[CMD_QUERY_NUM_MAX];
+	const u8 *data = &buf[wacom_data->variant->query_offset];
 	int retry;
 	int error;
 
 	for (retry = 0; retry < CMD_QUERY_RETRIES; retry++) {
-		error = wacom_w9000_read(client, CMD_QUERY,
-					 wacom_data->variant->cmd_query_num,
-					 data);
+		error = wacom_w9000_read_query(wacom_data, buf);
 		if (!error && data[0] == 0x0f)
 			break;
 	}
@@ -169,6 +188,10 @@ static void wacom_w9000_coord(struct wacom_w9000_data *wacom_data)
 
 	dev_dbg(dev, "data: %*ph\n", wacom_data->variant->msg_coord_num, data);
 
+	if (wacom_data->variant->msg_coord_type &&
+	    (data[0] & GENMASK(3, 0)) != wacom_data->variant->msg_coord_type)
+		return;
+
 	if (data[0] & BIT(7)) {
 		wacom_data->pen_proximity = true;
 
@@ -179,6 +202,8 @@ static void wacom_w9000_coord(struct wacom_w9000_data *wacom_data)
 		x = get_unaligned_be16(&data[1]);
 		y = get_unaligned_be16(&data[3]);
 		pressure = get_unaligned_be16(&data[5]);
+		if (wacom_data->variant->pressure_mask)
+			pressure &= wacom_data->variant->pressure_mask;
 
 		if (wacom_data->variant->msg_coord_num > 7)
 			distance = data[7];
@@ -266,7 +291,8 @@ static int wacom_w9000_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	if (wacom_data->variant->cmd_query_num > CMD_QUERY_NUM_MAX ||
+	if (wacom_data->variant->query_offset +
+	    wacom_data->variant->cmd_query_num > CMD_QUERY_NUM_MAX ||
 	    wacom_data->variant->msg_coord_num > MSG_COORD_NUM_MAX) {
 		dev_err(dev, "Length of message for %s exceeds the maximum\n",
 			wacom_data->variant->name);
@@ -412,10 +438,20 @@ static const struct wacom_w9000_variant w9007a_v1 = {
 	.name = "Wacom W9007A V1 Digitizer",
 };
 
+static const struct wacom_w9000_variant wez01_gts9 = {
+	.cmd_query_num	= 16,
+	.msg_coord_num	= 17,
+	.query_offset	= 16,
+	.msg_coord_type	= 1,
+	.pressure_mask	= GENMASK(11, 0),
+	.name = "Wacom WEZ01 GTS9 Digitizer",
+};
+
 static const struct of_device_id wacom_w9000_of_match[] = {
 	{ .compatible = "wacom,w9002", .data = &w9002 },
 	{ .compatible = "wacom,w9007a-lt03", .data = &w9007a_lt03, },
 	{ .compatible = "wacom,w9007a-v1", .data = &w9007a_v1, },
+	{ .compatible = "wacom,wez01-gts9", .data = &wez01_gts9 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, wacom_w9000_of_match);
@@ -424,6 +460,7 @@ static const struct i2c_device_id wacom_w9000_id[] = {
 	{ .name = "w9002", .driver_data = (kernel_ulong_t)&w9002 },
 	{ .name = "w9007a-lt03", .driver_data = (kernel_ulong_t)&w9007a_lt03 },
 	{ .name = "w9007a-v1", .driver_data = (kernel_ulong_t)&w9007a_v1 },
+	{ .name = "wez01-gts9", .driver_data = (kernel_ulong_t)&wez01_gts9 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wacom_w9000_id);

-- 
2.56.0


