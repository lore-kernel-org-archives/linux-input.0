Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466284;
	b=q59l4q0JqmvAVBuvzY5lqGKPRBE/gJVq5TeKY/RvKCOiFNn3igpqmpXNW2/s2DCTJ062
	 OuOn+YXNivZBWsR6cioZE3wxXz8YfV0vSyMRc+X6Zgvy1hnPJT6n+tgoZo4ZoS3aCauD9
	 A3yPGaSlc6icUXpyGPOtzs69WkwlR0V9IfpkOdnsYSuLKVedjkF/s3Nh9E7OTFKxi5daP
	 8aOEIRAZ0+F/Rip1DAmq0TqxsV55VvLWwt3rlNnwaWdn+Om3hJgxtKlp5wesFE3y2zWMv
	 mpSuPN/c30k8CisjOe5R03GH++G5k+bauz8ZeiIUACsU/q58FURLjr1qMPG4JmUF8Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S6vHQHJISvLttOPVGmxf1RIVPLKenvgKFyjyMf1hrow=;
	b=ACBoisY/J9znyvmOfP43ttirrF4DAxFOMv1VGL4SFtT7QYt0lnM+Zd2V5Y6Z0c1xHPzV
	 bt3CpbOpTWb+cOwp1ZzrRZSRXEyEYiLfAuHvPLCPLUpdCmWk12oIIKlEiTzi95KaDhtH8
	 QguCJvNCVa9iEO9hb6LpVdRGWw+ztLGXdZV2dcSUWWve0lXENVKCDcjpS/4nQQmIrVfqK
	 I9NMizsId66jD5angV30p316VBjbcqFPGqlIhgQoe/toQ8mGwsVjSVQcB4+wdFo6dNMmm
	 BALCP5pU51KcnJez8EPM3IDlq8zmhnkLnJomucYmaL3CaYaXyoZ2WGvZ3gb2A5LF1EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L9o/XV7a";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B560A3838
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3B560A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9o/XV7a
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3720addb068so7040910eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466282; x=1795071082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6vHQHJISvLttOPVGmxf1RIVPLKenvgKFyjyMf1hrow=;
        b=L9o/XV7aP/sRDlIO4NymG0vbdEhk/qY2z2okt0Ybn/kuQZmIuPEC9cPaGxuM7HxnQO
         +48CPWG5n8OcpG/7GHR5YehtxW0eNIW5qbSGB6FMOeQXR1yTDaUAFguyFrFBi1/FiBzA
         QMhYd+Yl9ZAekrl0p9qELxxnYpy05qnq+uWwK2gBAxJ9j4kiXSAYxy+Wo07v9J2p2Nwn
         iNBBvygKSVV2Ej7iHNou9RLIgELFxA6a3feApnhZMBfFa/Vas0G3TnGtj+4Be3HdoR1/
         WYX+q8kUUjit5Mlt5iLML0bT+WQt7bqCsiNGGGEluImYbtUtoCtVDKREy/tAfJq8jqIW
         V9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466282; x=1795071082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6vHQHJISvLttOPVGmxf1RIVPLKenvgKFyjyMf1hrow=;
        b=R+jipEGOwhnUUvq1i4DZqy8BHhejdpU44iiJdY9vjFB580IuCCq9feBO7ZrwHrSMcI
         BkiJsR43UaUpPwTXwhk/8JEZ62CEUdycpeNLCxk2KXs3T3DPTvJuZO+EhYzf+M33htWi
         qELHIHM8t0wK7lzRaXfsuDYfE4tm058TYZSRYhyUoQHoqGAHITLSMXXjvjqR3JeBW3oI
         6Ftnoc5lnxUAqmSqctrQw/+1TcueLUZRK/BcqAMNkJcRxeRDLSsaKWUvyNDhsTLs9OGu
         v1+0u93O0BLnBFIcMmEePOCDFl1MYs/KEJeoJQQFI6BLduyZJ9ri8oC/B9GRvxyMfGvk
         jKEg==
X-Forwarded-Encrypted: i=1; AL+hErHGXfIWOnjAVQudxqmflr/xrMH7rPIYXbpIAzjmQ7kRtrsHJ6qNRUxjsO9kE4RXubMnQVPvbxC+MsGIPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8S9YLGbFSkHDN6K7FtPq6yHz0YLufpnbOetrw1jgdSbxRIrKDy
	Jb9spUvdBvnj09spGTftU0TTMlWWJfMlGvjr1U1MPJaQbrt4DDru8VTC
X-Gm-Gg: AYBFou38Ic/Z2GZaVtlqP4/ineOhvOds7biHDf7kr1XriS7eGCEJ1cxMOs1cFwiV8Pi
	AQRZr/DUcaehHWGYETtXB/KeIN5bc5icVmtM2bH+EirFVGJ+KAdOxSkA7xFnDzKY3jYdWqmELy4
	vHj/4TTFVPNlaG/NHUfzLxuIt8HAEamAIz7WVSTr4E/WNPP9mPA1IYWRqFOPDPazQLAvXpwgt/m
	jRJOpS+Zlyaxme7UYSrvom4bsk9/gz5o45QphOvMwTzFycGZ8KKlAWc1g+A8LwT9FmXzMet3Lwr
	oHqUNTCcqZ9/m/eVhqkTYYpzD7kzPjkro5EuTl5XltlxdEctiAFh6BZZz652Q/pxvgOiOzHma7V
	4AWv288iLeZYkkz3eC6XHelSnNpWzA1481QOhNxSdhmwK0+6t4PUwDCi0tuzjUz4ehtFrHBX1ni
	YsW9OzbqQtKxFm4391HRpbZBx5Mj+EzWPh9nqmSNnCXczZbzfVrTyr8RK9plcS4+pxwfRl8KHWf
	mu9vC35UwUfcaL6hIYj2dGqmzwZVH24MIBifJjJt3aJnaH6fEI978oM5FYPL+bXjxgidqPZMmHB
	jyFeFLAM9b9ot0skEvo6HghS7uJCw7vXkCAACO0EQLvAxkziM70dgfOK5kiBzKPiqDrzZEsgyyo
	uMJ/gXBNK9BZN/94t
X-Received: by 2002:a05:7301:d810:b0:376:5b99:a7e3 with SMTP id 5a478bee46e88-3768327e817mr4203057eec.3.1794466281758;
        Wed, 11 Nov 2026 22:51:21 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm24547205eec.27.2026.11.11.22.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:51:21 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jaewon Kim <jaewon02.kim@samsung.com>,
	Hyunhee Kim <hyunhee.kim@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: regulator-haptic - fix coding style issues
Date: Wed, 11 Nov 2026 22:51:15 -0800
Message-ID: <20261112065115.1803973-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>
References: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>
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

Fix minor coding style issues across the driver: add a comment
explaining mutex purpose, drop an unnecessary blank line after an open
brace, align function arguments with the open parenthesis, fix
whitespace in conditional checks, and use a space instead of a tab in
a return statement.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/regulator-haptic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index d99f716ef44b..4ede90195366 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -23,7 +23,7 @@ struct regulator_haptic {
 	struct regulator *regulator;
 
 	struct work_struct work;
-	struct mutex mutex;
+	struct mutex mutex; /* serializes voltage updates and suspend/resume */
 
 	bool active;
 	bool suspended;
@@ -38,7 +38,6 @@ static int regulator_haptic_toggle(struct regulator_haptic *haptic, bool on)
 	int error;
 
 	if (haptic->active != on) {
-
 		error = on ? regulator_enable(haptic->regulator) :
 			     regulator_disable(haptic->regulator);
 		if (error) {
@@ -55,7 +54,7 @@ static int regulator_haptic_toggle(struct regulator_haptic *haptic, bool on)
 }
 
 static int regulator_haptic_set_voltage(struct regulator_haptic *haptic,
-					 unsigned int magnitude)
+					unsigned int magnitude)
 {
 	u64 volt_mag_multi;
 	unsigned int intensity;
@@ -118,7 +117,7 @@ static int regulator_haptic_parse_dt(struct device *dev,
 	int error;
 
 	node = dev->of_node;
-	if(!node) {
+	if (!node) {
 		dev_err(dev, "Missing device tree data\n");
 		return -EINVAL;
 	}
@@ -165,7 +164,7 @@ static int regulator_haptic_probe(struct platform_device *pdev)
 
 	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev)
-		return	-ENOMEM;
+		return -ENOMEM;
 
 	haptic->input_dev = input_dev;
 	haptic->input_dev->name = "regulator-haptic";
-- 
2.56.0.567.gdb80ae8cd5-goog

