Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681237;
	b=2CBDPWM1qYjG3fq27iHhFOfx+A9Y2h3JsjiVLcPKLJlBrqgY3VreLtjqWXXcFVebXjil
	 3MrFU5rPM7idnrQgDAXbSk3SpdlaiOcYlJIJt6IGcIOBeR+aYzMOzl1nraJZz5Q7lq/Wd
	 QB5eKyAA3mpZpKyruwaeUdR+seKulVjpe5E2vRQpjKqdbwTub5+cbzh+EJt+KnanK+mrm
	 yclrhmNwK22EPRIXEoKpQmrP0xMm8e5sCvxVgtRLg8bZdaeqk4C06PU0Osz2EtSkbLE4P
	 16yg0dt6U1to8hkhwdS6ZclYH7JmAW2GSMC4qrsqyTa/ZTAO0bdBKuRXhyleTViI22Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TNcXC8FQ4AQIGuVcbVq3SDd9KqNKYfDqhTIYzFzJ4J8=;
	b=Fs/8RfnN+LZ/U9JBAJ7WNtouQHnA2YXR/8iYQlCu4KkIQk4yPUOsIQxnzirEDUnUg1zx
	 ICfSW6X86xTcMp6zL1/cbCcHdnCLA1ZiMyT67Ra5ltQeWjWjpPV46lKVcUFQQy+ZVbqAj
	 XKoWVwVpEZAJjSGWzI24K8PNe9laGIKCAKvXQO46S/OkjqahXIx9OdiMVtSnDe7vhs8s4
	 WI4UQNe7pr4LJvpc2wt/F6iWWtyr2r4+TFxMqXYOB55+3Or6WrKN6lb/l4IvE+wSQ7XZk
	 b7DtFzsn4nOri8RxFGFkvhWo6mSKDDQSWygq+eX7mAaJOioif1tXsqQ981fIdEK+d1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xpdWMr4C;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546D606D802
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2546D606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xpdWMr4C
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a17a332ecso5784491eec.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793681236; x=1794286036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNcXC8FQ4AQIGuVcbVq3SDd9KqNKYfDqhTIYzFzJ4J8=;
        b=xpdWMr4CCEXBgU+jpBv5B4Ec+3/7vWOt8kMfm/QVRgLr2EBsLjpzV6YyWrGhEn9FIF
         VU9eHKvMPM03dp6mavZcfNe4k7IAfTLbkzuI9croxWobp4/sJzRaM4E9rgcvIHRH48VD
         +GrO4MoR6WDSMCng9G+Go0/O31OCkwVW9R9Ys/KnuiAmpFBqIFeg95TqqEhk3SKsKP9/
         bJCoM+ntwFNBVweLhQIdhqeuVeuvwD6HsqkCSceqkpOhS9hZ2mTqnB57KKSMYh5v0dD4
         WalXV87IPZevVcj4QZwlxWYtUzfe96ZVGFlzSjof7PufSpiTnxL+9TZfgweOFKMGG6ae
         WIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681236; x=1794286036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TNcXC8FQ4AQIGuVcbVq3SDd9KqNKYfDqhTIYzFzJ4J8=;
        b=xWxUH8GmWx4jB0BRM5l/le1EbrC/TGaIS4z+VDaTyg8EiI/1g9sKVI2Lr4virISIX5
         APXt+S26mHzMO+unbBubwXNyvqEKFUkYsRXtCa5wW6iwOhdwT0cxUN/SRQbHWb+OEMuR
         BVMAAJ69GG3tgHllqSY2Fftm0VJmoKQJO804HFY+j/9nFWyqQqmH2/uFVWUCba3sxspB
         ZgsCt3RlVBDpxrJ3jkOXlyDCIxu422qEWUv7nLWArgn2J7Ocl18L+wmH/U6XhpQVomvW
         Ic1RwPy5VDQtt4qlniBu3PKig/CUsjeotHtfcmjdk87eOD3MFcBhnfO1r+/vBT3NO7g9
         OW2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgfQa8cJDYatNCoviLq57ZQSxhPjgJt1kIlXmVbr9N+wIg87dbJWJzXc2crJkFfjZIrdGiivV77Rdxew==@vger.kernel.org
X-Gm-Message-State: APuU4Z9VOaHGWs4+cDQWZtiSkaeZRm2wAt4LRVGkc5G7Iv1i44XQfynh
	TIC/6jtNSgXK5z7e4Z5ohxTR8LPKXAK/q55JAiFr6K8JJj/ToaenHC3s
X-Gm-Gg: AYBFou24GKd6Wp3v9t0YkPqnsagog5gJXPNr2qmEXjFEmyrFK0XtVN5/ybM5FL3jOd2
	H9spRxLL3eL68dSamtkO4UKYT4Mo2GV9y1Oe4HYHhycqk3o7GRrMMnvk5QQOPLegH6bZBZPYCH4
	3FViu2+CauVytYoAIYkXXO1FYygfBmedfnDVAKB+r1WENabiVaoJpvl3cJgTZTQgtNimnPGhYmR
	endjVvs+eFN85IUF7sjA7te4+7T8Ehvy7ewcGHPhmCUJQ6hAMH2xtvgP2I6SV5Lft/RIIC2Cav4
	6h8UZ2NEhqSaEP1sPCe88zTRzcIOsDBZbtp5Tpx0Ep5zfvMqgnyqd8cgnKZnoGZK/R+d1ssN7IM
	+fPFR+PWnFs7RUs792keIjHbrsiYe83xk6cqrVlMrRwyTMZe49TwN2Hkvy+zQSXrQciltHbOePz
	/LaBTXJ7HFhl1K6zcdGN/2WnpcXBSFlTDVH0tbTG1PDi4hSZKgYzp9v/iyTXxBd9jwKPIYO0jdV
	e934DF8j/ASJkkOqTvakAxyn9kj0QIxJJHCVTwlS9+VVXtoKiUNLys8v+RSfZLpiJe9fcO8j3KP
	u9Zda3T8gf/8UwhhPKztffYaMYdxcTXQODHHhx9AxtGIXQi+duCO7wKKaN8QiXgSk0R8vy2ddli
	VoKWGL1csKX/9XfReIQ==
X-Received: by 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id 5a478bee46e88-36a424988abmr21088734eec.41.1793681236195;
        Mon, 02 Nov 2026 20:47:16 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm48385807eec.11.2026.11.02.20.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:47:15 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Val Packett <val@packett.cool>,
	Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Jeff LaBundy <jeff@labundy.com>,
	linux-input@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Input: wacom_w9000 - rely on touchscreen_parse_properties() for resolution
Date: Mon,  2 Nov 2026 20:47:05 -0800
Message-ID: <20261103044708.2461481-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
References: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input core's touchscreen_parse_properties() helper now parses the
touchscreen-x-mm and touchscreen-y-mm properties and calculates axis
resolution in units per millimeter automatically, including handling
axis swapping.

Rely on touchscreen_parse_properties() to configure axis resolutions and
remove the manual property parsing and resolution assignment block in
wacom_w9000_probe(), along with the now-unused local variable.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wacom_w9000.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w9000.c b/drivers/input/touchscreen/wacom_w9000.c
index 4a2629a54167..51c5301262d3 100644
--- a/drivers/input/touchscreen/wacom_w9000.c
+++ b/drivers/input/touchscreen/wacom_w9000.c
@@ -249,7 +249,6 @@ static int wacom_w9000_probe(struct i2c_client *client)
 	struct wacom_w9000_data *wacom_data;
 	struct input_dev *input_dev;
 	int error;
-	u32 val;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(dev, "i2c_check_functionality error\n");
@@ -350,15 +349,6 @@ static int wacom_w9000_probe(struct i2c_client *client)
 	dev_info(dev, "%s size X%uY%u\n", wacom_data->variant->name,
 		 wacom_data->prop.max_x, wacom_data->prop.max_y);
 
-	error = device_property_read_u32(dev, "touchscreen-x-mm", &val);
-	if (!error && val)
-		input_abs_set_res(input_dev, wacom_data->prop.swap_x_y ? ABS_Y : ABS_X,
-				  wacom_data->prop.max_x / val);
-	error = device_property_read_u32(dev, "touchscreen-y-mm", &val);
-	if (!error && val)
-		input_abs_set_res(input_dev, wacom_data->prop.swap_x_y ? ABS_X : ABS_Y,
-				  wacom_data->prop.max_y / val);
-
 	error = input_register_device(wacom_data->input_dev);
 	if (error)
 		return dev_err_probe(dev, error, "Failed to register input device\n");
-- 
2.56.0.385.gac671c819a-goog

