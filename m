Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812663;
	b=a6+uw5WXpwMPmVEGq2914hNpFW3tzBQ4YjWi/a3s+eMkcdlitHdDslKY9aOjX750mZ2h
	 STAk5UssxLI3dsCJLGi8jbanH9RMBnq2Ig0LJegQ+SriW8L9TVLJYk8D8U3C2TWagKQvl
	 vFvNtXi/bwoeT0Esd6rZuXWZE/XFnCwsTxO+eSfInTd4F7lo3yQVFiyHi//OJI/SpjVTh
	 x503NNYXAuCREgSkXKi0SHv8NUOffSNKX9SL3ytsZfdUFHzf2c16T19kVJgu52ZjJZomk
	 DcvANFtXSkFJKj2v+lPMNtxkWEU+nYUt3If5LQLRBFggMzvaXF7kPsqBdkZtr8gTxFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n3H//P2Xt+SFt1vuWW61mGplc2uJXCj0F7tBueU0V+E=;
	b=Szwr4LAFdxt0dkqmq8GSEtaFnexcHHv9TnKOPqUfPLsVSA//wpzMWm4NLzUdhfLSM0t9
	 l0U/JC8lzy/8Bpgg1dGCJkjmhQgJ/KoiET3XC9EB4PbL8+i5LvKVMuuPPgOaEsdeLUvS7
	 OkmL6VzZQ0ol31FUfq7CKZtCDrG+8BZ+przSwok/3JrqxlzJp1e59q3V/6SY5HfpZHWm5
	 U+34Y6U9xtQHBzBaCeGpACewPmaiOo2XFD7IKxBKi9I40APwXuDKsMcJgyQQckDkaWPXD
	 /AgsZBuENZc56ARGNlACRH4Gad2hJp6LxZOP7UWVLpQ9UaGYwMltdvN/FfUYVNpOmYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O9zeuA8P;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A7606A325
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 03:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A5A7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O9zeuA8P
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-368581df789so1658112eec.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812662; x=1793417462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3H//P2Xt+SFt1vuWW61mGplc2uJXCj0F7tBueU0V+E=;
        b=O9zeuA8PpjKR/mNeICZ72Ke+3eAhqwzD/YRJmTXJV8Zg4sN0tU6IOIBLWiIHESCH5M
         9kFIIWVp3YFzP0PlfpdiXW0MRcER10Tz5Xx7mFdWbHeZdx2BekiAcEVAK46VQXtyiBxh
         F0JB3FGAQnTAQ2pkrEZwul06jv1vheD+Dz2zn9RQSPIzR4shLjcD5B1irWqyuog2GkXa
         PF9S+RAwu4G+uQdbUjBmDhVjtQ2opsaEKTyjFDtytP1nRRDrxM+FPMqV1EgyLvl/F9Ne
         QcVRS49rnc3w+GCGj3zQo9VMTKnn4oShM7/B3KBIfE0h+ILFQirgTs42CvsbJlOwrJ55
         TlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812662; x=1793417462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3H//P2Xt+SFt1vuWW61mGplc2uJXCj0F7tBueU0V+E=;
        b=o/h8VEjF47gYSSekFa2DCLBLCoPAFmWjJxRjbwLPzwPkFnPy7LfbzS67JC5VXHwR6s
         yrd56GbfcEq9prazAAZ0nfLrNAOGpgmg/bRIqAuXah08lbCGgC3dU+mLo9RoMeT2cgW3
         td9CJWRLjTzM0JCX8tw573erWe1zA0DFOmsLub56+ZU+kuMg3tgjCk4TTqUp8XFnSy5b
         zL6cxTVj3P1o87mz7VVEBZX2ndbDBDbppjogx9nuklKqd4o8b0PTAzuHpuMUuCj6jzbr
         XQnx+fZYSDOG6vIEeObMFrPP42vsZJg1Bb5F6uZfIgzt9YVn7dUqSVNDMts/GNAJGhrw
         RHKA==
X-Forwarded-Encrypted: i=1; AKwUvBw6ajeB5xjhcC5in9Uae5GCvkMWVkH3Xdbfsam/NOPYG8pweKyORV0Yc3wTOFKbTP2rR44s0IlsbMbdFw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLwnE7SRJSgqfdpwHWDaT23vrPpBFTfHBS4oMmUL4r8AZed0ZP1
	/7px8vfcoGuy7Il/tANbFZrmfJ5bjLlIQZJvxnzK+Yx14x8mjWFZladn
X-Gm-Gg: AYBFou2dmCK2eh+lsA+x4lQjCcOiGJ1PnRBCR+67kUfzTGIwaiP/zpyqOKMyWguDHgk
	MXONu/aVwncVyYPdpztBam0Jt0G6SZDf2DiWSBvfPMavTC2tlSTbXgHMmj1/lkH6AKDC1WuhzrH
	3zsd+8kCU4hEXMzOAeeMHwfPx/zBFkaCs9QDg1op3f/cKKf1W4wV6TUTitlxktlXizIkUwczj8o
	sA++omVZLxZMa3k/c/RyirgO4cdKASBO7SQzVPZZyG1GM+XO+vZPyxtT+VHuTNtW6GaiXYHB7SW
	Llo7ZNxss3NXYPQBM0/cuTzV8IDA7UBMYPhKCAz1+rFtR1+/NR0Qol4mQ1swvJpsoBrTxs6YAqp
	ux9fAIO+loBEl+Ztdri922QDDoxKUz9ieqbl4G/hagg/Cy0owcnaTf6QoJCR63iWqn/5J6IPRGa
	zu7bl9qN/1YYx8DmI8Cnxs30TI87gdnaFuTAFHCI/g/MR+L7wizlJyIhdRSp+vh+Vb4/yMkC4Wt
	ZZ70ldL4SOyX1lCU5KFX0fLcEn+QpVybAeIDbNEfmKRoXkvVFizjQ3W7KveGEl/dQYk3lQcBDIa
	JCoazHxfLSYBwW3cFpGIdH36dFuL
X-Received: by 2002:a05:7301:1a05:b0:361:2a55:b94e with SMTP id 5a478bee46e88-369e84d35e0mr1251819eec.15.1792812662302;
        Fri, 23 Oct 2026 20:31:02 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:31:01 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 6/6] HID: wacom: add NULL touch_input guards to remaining touch handlers
Date: Sat, 24 Oct 2026 12:30:40 +0900
Message-ID: <20261024033040.316652-7-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
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

wacom_24hdt_irq() (also handles WACOM_27QHDT), wacom_intuos_pro2_bt_touch(),
and wacom_bamboo_pad_touch_event() dereference wacom->touch_input without
checking it.

As with the other handlers in this series, touch_input can be NULL when
wacom_setup_touch_input_capabilities() returns -ENODEV during an
otherwise successful probe.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4d6295f57c9..38003e0b8083 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1489,6 +1489,12 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 	int num_contacts_left = 5;
 	int i, j;
 
+	if (!touch_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < finger_frames; i++) {
 		unsigned char *frame = &data[i*finger_frame_len + 109];
 		int current_num_contacts = frame[0] & 0x7F;
@@ -1660,6 +1666,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (touch_is_muted(wacom) && !wacom->shared->touch_down)
 		return 0;
 
@@ -3430,6 +3442,12 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 	int x, y;
 	bool valid;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	prefix = data[0];
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
-- 
2.53.0

