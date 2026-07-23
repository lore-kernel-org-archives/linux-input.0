Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BE46EF81;
	Thu, 23 Jul 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806030; cv=none; b=KdkleTPjqa8BpbZa0XgAVOBw9wPBjZVs/Zl+7HzylP4MOvmHISTftHGlAtsbcEcY8uJDQWKXOKarOm8hgkQ2dC3oG+Jhs04UmCjD7DH2yq1YbPrJtRV81bmXsABB6xBvDD6DcBGPqeQOrGUvjSabb1k6zQukoLInNSWsbVopqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806030; c=relaxed/simple;
	bh=ODeGx9cxPdGjmXdph8GFdfMVSd4giqicWH6znncxKws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0cMb+V2es2pfm0UIdJHuBYGSBRAzk3LJ6TUUH9nGzeFhdmYImX83nwBgz+XXw5gSjRa+vyt8xZtv379j91liYFamyypqyH9U6pTI3GKYE3dnWD5nyDh0m1RW0vbvXqmWzr4hrjqWleuvSwW2lZgpxIMTDDdFMo1vK1FB8X+A2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr5hjqVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr5hjqVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ABD9C2BCC7;
	Thu, 23 Jul 2026 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784806030;
	bh=ODeGx9cxPdGjmXdph8GFdfMVSd4giqicWH6znncxKws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nr5hjqVJTCLtNtg/fquLaE597DgRDC3vmA8VBOzkzsiJsUjr6cqYxZxJxdzxj7kEH
	 9pQtI0xaU3gQMh7j2cHX9AM4c304lTBUxXQHd364/sBtPLSHct3aoaCkerF3RmKjcK
	 mCGjzi5CnbtQeQkoUUIS03tuUoi31L0zca3KP6dWcgp2xq7TiVVZ0Yy+5UQv+eCWR/
	 tJKYJxd9zU/4sramP+LKhsOg12baEkWbpMtmY5Ojoe0pRKSPctN0SXkqypbcxnJBN8
	 wDthhE+GhyOjjnece80xujeN9QDRof93dywT3rOe+3+aLX/NgfoCs1hk1vv5VOytC8
	 N07lHK0pLLjJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864BC531CB;
	Thu, 23 Jul 2026 11:27:10 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Date: Thu, 23 Jul 2026 18:27:10 +0700
Subject: [PATCH 3/4] Input: edt-ft5x06 - allow reading the touch frame one
 register at a time
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-ft5426-v1-3-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
In-Reply-To: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Alexandre Hamamdjian <azkali.limited@gmail.com>, 
 Teguh Sobirin <teguh@sobir.in>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784806028; l=3201;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=/kaGFdHU8xM8Uq6yxPXvl4M3ZEPYoY2WUk9xAjehqNs=;
 b=bFJymW0Lwb9/tVbTBZZmejp1iA5i0JTyYdsXw5zot/D2NvYcilOHZlzNroDe6yl9cUyu92Wio
 DxGLEO7K12CA99RMH5aJ0e2C3BpGkkttZH0gV2vw4YWcNkPEEzFaFGL
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

From: Teguh Sobirin <teguh@sobir.in>

Every touch interrupt reads the whole touch frame in a single i2c block
read via regmap_bulk_read(). On some boards the i2c controller the panel
is wired to cannot sustain that multi-byte transfer: on the AYANEO Pocket
DS the FocalTech FT5426 sits on a marginal Qualcomm GENI bus that
intermittently aborts a long read with -EAGAIN or -ETIMEDOUT, and the
GENI controller has no bus recovery, so the block read fails on nearly
every interrupt and the panel is unusable.

Honour the "no-regmap-bulk-read" property. When set, the driver reads the
frame one register at a time with a short retry on the transient bus
errors, keeping each transfer small enough to complete. Boards on a
healthy bus keep using the single bulk transfer and are unaffected.

Signed-off-by: Teguh Sobirin <teguh@sobir.in>
Co-developed-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d6c3d033b83d..ac61ac44fd64 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -146,6 +146,7 @@ struct edt_ft5x06_ts_data {
 	enum edt_ver version;
 	unsigned int crc_errors;
 	unsigned int header_errors;
+	bool no_regmap_bulk_read;
 };
 
 struct edt_i2c_chip_data {
@@ -295,6 +296,31 @@ static const struct regmap_config edt_M06_i2c_regmap_config = {
 	.write = edt_M06_i2c_write,
 };
 
+static int edt_ft5x06_bulk_read(struct regmap *map, unsigned int start,
+				void *val, size_t len)
+{
+	u8 *dst = val;
+	size_t off;
+
+	for (off = 0; off < len; off++) {
+		unsigned int v;
+		int ret, tries;
+
+		for (tries = 0; tries < 3; tries++) {
+			ret = regmap_read(map, start + off, &v);
+			if (!ret)
+				break;
+			if (ret == -ETIMEDOUT || ret == -EAGAIN)
+				usleep_range(2000, 4000);
+		}
+		if (ret)
+			return ret;
+		dst[off] = v;
+	}
+
+	return 0;
+}
+
 static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 {
 	struct edt_ft5x06_ts_data *tsdata = dev_id;
@@ -304,8 +330,12 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	int error;
 
 	memset(rdbuf, 0, sizeof(rdbuf));
-	error = regmap_bulk_read(tsdata->regmap, tsdata->tdata_cmd, rdbuf,
-				 tsdata->tdata_len);
+	if (tsdata->no_regmap_bulk_read)
+		error = edt_ft5x06_bulk_read(tsdata->regmap, tsdata->tdata_cmd,
+					     rdbuf, tsdata->tdata_len);
+	else
+		error = regmap_bulk_read(tsdata->regmap, tsdata->tdata_cmd,
+					 rdbuf, tsdata->tdata_len);
 	if (error) {
 		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
 				    error);
@@ -1212,6 +1242,9 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	tsdata->no_regmap_bulk_read =
+		device_property_read_bool(&client->dev, "no-regmap-bulk-read");
+
 	/*
 	 * Check which sleep modes we can support. Power-off requires the
 	 * reset-pin to ensure correct power-down/power-up behaviour. Start with

-- 
2.55.0


