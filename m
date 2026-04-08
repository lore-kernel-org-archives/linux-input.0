Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620523D75CB;
	Wed,  8 Apr 2026 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670631; cv=pass; b=uwYsg5drdIz5K8EP+aAnkwQ2wfLjJgjtZDCjmYwfc5FRh24ygx+wLO6gI4UD12Yj1yQyb4IMrsU5nFnODpsb1xqUb0TxW3DdGlSlzi8FLnrTxKYTBNwfH2Ln1M1F3U4Xev6hoFLL8vmhTiW3rr9+Yemqlo+useC2mQTDUR2Ufak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670631; c=relaxed/simple;
	bh=wY8RgB9/IerJvvQhaknNyjjb0ZkJTWqfHiwu8j51bj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpcsPiMeyJEJv2RIY8FI4kNqgNdrfUeIBtrOv5knRucRuAk0zjwR75yoX2hr7KwmowNLc7Wy5HCQ1KNmW5T5iLbZ6780rxnUhrHIRvIPcy5WLH4FM6XAInrPCAuZQq9DUak3k+MZV7knmCYr38nTYADnFFi0Kozm177v9tyVUDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Qcjw+u42; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Qcjw+u42"
ARC-Seal: i=1; a=rsa-sha256; t=1775670612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=msnMU6CtuMwia0pzGds7EVTUmiREFufzlTqP92bc1iinCX8D1HJDXRWTWqyjPmO01hqIHdSPxI9zyFxK8XMDvEtjbiz5TN3ZV34xSFkV+PtaE5fP4S6ZD3xjMydM99gDcqDqlwl9UqsvcUzKnaT+1NRfB4Fsa2B3tn6tBZ/KLJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775670612; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7V/o+SJsmu7dHHUNuEvEIYQZFByWX+W5rNEJiWbh4qg=; 
	b=IaSO8ags8oTXENKUZEepG9ofqYW5NFDpIuOtkRhYjy8fRO00mWeiOZHodbFcHFIkfr9A5DwkCifWtPNBXftZZFlfC1yZrH6ZQo8cSjXkdFqheDOIm3E/PKQv4Qz6ATC/SEYOicbEMomgdAGXV4u77z7IjsbaNsVd+ouRjPXORvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775670612;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7V/o+SJsmu7dHHUNuEvEIYQZFByWX+W5rNEJiWbh4qg=;
	b=Qcjw+u42vq0YiwAHbg1DgGITUjNikXNkWV+Sef07sDPKc20tz5E9xsxvpm0cxoxp
	LZm9t3vTtfuMLLKk4J2f0a8aVXvxE1Ippe/fgAwh565KjPLwh3CPRojbjD246vSSXa/
	06KpfohEC/CV3vhqPgjMcjB+fD5m6N/HJUeNb18w=
Received: by mx.zohomail.com with SMTPS id 17756706102001005.8838527087476;
	Wed, 8 Apr 2026 10:50:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 08 Apr 2026 19:49:40 +0200
Subject: [PATCH v3 2/4] Input: adc-keys - support EV_SW as well, not just
 EV_KEY.
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rock4d-audio-v3-2-49e43c3c2a68@collabora.com>
References: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
In-Reply-To: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.1

Instead of doing something like what gpio-keys is doing, adc-keys
hardcodes that all keycodes must be of type EV_KEY.

This limits the usefulness of adc-keys, and overcomplicates the code
with manual bit-setting logic.

Instead, refactor the code to read the linux,input-type fwnode property,
and get rid of the custom bit setting logic, replacing it with
input_set_capability instead. input_report_key is replaced with
input_event, which allows us to explicitly pass the type.

Only EV_KEY and EV_SW is allowed at this stage.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/input/keyboard/adc-keys.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index f1753207429d..62376f34f7d0 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -18,13 +18,15 @@
 
 struct adc_keys_button {
 	u32 voltage;
-	u32 keycode;
+	u32 code;
+	u32 type;
 };
 
 struct adc_keys_state {
 	struct iio_channel *channel;
 	u32 num_keys;
 	u32 last_key;
+	u32 last_type;
 	u32 keyup_voltage;
 	const struct adc_keys_button *map;
 };
@@ -34,7 +36,8 @@ static void adc_keys_poll(struct input_dev *input)
 	struct adc_keys_state *st = input_get_drvdata(input);
 	int i, value, ret;
 	u32 diff, closest = 0xffffffff;
-	int keycode = 0;
+	u32 code = 0;
+	u32 type = EV_KEY;
 
 	ret = iio_read_channel_processed(st->channel, &value);
 	if (unlikely(ret < 0)) {
@@ -45,22 +48,24 @@ static void adc_keys_poll(struct input_dev *input)
 			diff = abs(st->map[i].voltage - value);
 			if (diff < closest) {
 				closest = diff;
-				keycode = st->map[i].keycode;
+				code = st->map[i].code;
+				type = st->map[i].type;
 			}
 		}
 	}
 
 	if (abs(st->keyup_voltage - value) < closest)
-		keycode = 0;
+		code = 0;
 
-	if (st->last_key && st->last_key != keycode)
-		input_report_key(input, st->last_key, 0);
+	if (st->last_key && st->last_key != code)
+		input_event(input, st->last_type, st->last_key, 0);
 
-	if (keycode)
-		input_report_key(input, keycode, 1);
+	if (code)
+		input_event(input, type, code, 1);
 
 	input_sync(input);
-	st->last_key = keycode;
+	st->last_key = code;
+	st->last_type = type;
 }
 
 static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
@@ -88,11 +93,20 @@ static int adc_keys_load_keymap(struct device *dev, struct adc_keys_state *st)
 		map[i].voltage /= 1000;
 
 		if (fwnode_property_read_u32(child, "linux,code",
-					     &map[i].keycode)) {
+					     &map[i].code)) {
 			dev_err(dev, "Key with invalid or missing linux,code\n");
 			return -EINVAL;
 		}
 
+		if (fwnode_property_read_u32(child, "linux,input-type",
+					     &map[i].type))
+			map[i].type = EV_KEY;
+
+		if (map[i].type != EV_KEY && map[i].type != EV_SW)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid linux,input-type: 0x%x\n",
+					     map[i].type);
+
 		i++;
 	}
 
@@ -156,9 +170,8 @@ static int adc_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
-	__set_bit(EV_KEY, input->evbit);
 	for (i = 0; i < st->num_keys; i++)
-		__set_bit(st->map[i].keycode, input->keybit);
+		input_set_capability(input, st->map[i].type, st->map[i].code);
 
 	if (device_property_read_bool(dev, "autorepeat"))
 		__set_bit(EV_REP, input->evbit);

-- 
2.53.0

