Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD23BBFC9
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888041; cv=none; b=dPbP3SwQHdeCH7xQ4LdyjKJ472ZeWq/xJu4JXH2p6HzKr/rqKg7dtOw77tPE+PPmBEDA0wwQC0HnwARhi7mQBxOONseEdp3e+0aVmb3en7IRxbrcz+bOHQNvG/9wzFIG3FTGfCCRZEFJCEpPXw8Gv8JBx6bFpavb6SpjSbtM48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888041; c=relaxed/simple;
	bh=CkRsJ159TvaDsvquCPxKwJ6wdILNj5u3k2nbupL6rAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKwtLvU21V3/iRC7L+pYQA7DeY1vXL/8zXKXUbJYvdAjaP8Tii9HXDD6Lr45bxBKqDAmCKsBynEukX1200lG14FOBwwGsC3MFx/W9AMwCWXCVTzXTVuxNskD4s8UDGnMSyV7GTicd8HmbsCE6GohpRI70LotEyDWERohwJzf2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J50Xe8QR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J50Xe8QR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so3958135e9.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888038; x=1792492838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7KHR1iqY8VcX9IADGibYzOfCACxk2AXBdRyC6sfDr5Y=;
        b=J50Xe8QRU8waWzvmYjxmzT/KQbl0AonZ0Elu2nJW8wkS/5tfKzkLA3mBtItL8u4Nmw
         jzbwOd3aiGFYAh8Q6eVBfuRsAYJ5ksAcN+Wo/NiP+E4aeGRQY9NIuXxK6IyvX5CaqWbz
         Gp5Bmhpovs95txe9NNs2VYvBj3QFBUK4pFu9ocQzV9cAzVISfwzo7RI8frKQ6ZMcgBR1
         BL8sCA1nHADR+M1Is0ia6EWFRSEfjIuVv3wfcVBcnES/99zRHlYO+5tCuGBBBCc8WUVb
         EYIPjfE9nzkuejRt4HF+wm+LAObbt+gVsfeEAnikq8TR4lyNPhLA9kstZ/EBSQvlX7K+
         IDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888038; x=1792492838;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KHR1iqY8VcX9IADGibYzOfCACxk2AXBdRyC6sfDr5Y=;
        b=Mvu/MteIKtUnbv1DvgXs06/I1syL/t0rVx7q/hwE0ZVuc6x0QFFaiyvLYKb3zvUZAp
         fEeNB7UFyxzsMXjKp7AuPwSqS5h98hzaVra4x4uwuRfO9Xn9SK0sFt3rVKi5/yX+ASKz
         GiUmr2knGi1uouGHFkbZkiSy8bYDwm9cMEYBgDsl4mcDtjUNrwVymDzW4bAplTCK2ZlX
         Wbt+OHUJ7S1sgpy1cp4dIf21pVc+Urh7WJNLib8UMr3FCRY9QpdlKcGEb8NaJO3lVAa2
         arMJLXs8t+hYfGW/QPbOTSb9OTJZhB0njzfVNVyxbF2eAiZVD5NK7h+jVaH8P4733wBc
         M86A==
X-Forwarded-Encrypted: i=1; AKwUvBxQ1E9onfMncQ4JQvugrhY6XZfXNRGMx7kaixdK2YWX9j3Ulzm1TageQx4FihfO9fSrH6IlF1chrxrptQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJN889jp1i0f3hpJFwYT4r9K7jRVzH+qx3yDSM3pmBXU2IeasW/
	pzayJnHvpowrXajLfNcUbZ/voKBzIX5Bx8FIWfakk5skjbZANmgqq1UT
X-Gm-Gg: AYBFou0n471WSVJwAGBTdTYuJGzQvHp/TKQiNKG1t4kBPn2iLSyftiC+Z1m9+rEPUlK
	+kOo4kQ/6HYapyOuHwpwLBVBoI2Tg4KKV1AW5PZQofe3dHrpvhx6PfNEmNeeBQLifYgl0C5CsmK
	RjLEsdBHN0JtoKO0JTvMdf3eRmuJCaVFaZWeU9aAl6+zzojzF99Q3wiZJxfCmUnLXEizJ58VkVZ
	cRBA0fY+NTlA6ToTrdkAQ5UXUacyBOXBaLXhoZztbcBmUbYrKIOTnb7A1n4XeGIuiZAYwR4QrDc
	b/sFXfK92k/jkSG/40S71WYyLvniFCX/npZISxTcpDlb6NYSyXfcv1ai5CkNj9zX/ZqrASj9/aH
	gVGaH74RroHjTIErOWO3enZWaL2B8Y4bZ5CbhMiEGY0nR16dOiUagCtiQgSQminmCg89KnYF+wR
	iSo4ZMj8hr/xS2Hy8gnI4Jt0OAHuGKF69BWqu7u0QcuzVr+Xwp/f4sZYPqFwgBEa7+QAc4zPcYP
	UQ1LgLL+lcEex/chzYp5W2WZeeH5DKoo5dw+a6uQBHxb7uBydpPV1VuJQ==
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a18e4d6ac3mr234388855e9.26.1791888037890;
        Tue, 13 Oct 2026 03:40:37 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:e22b:cb88:4091:8aab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac3970sm4191952f8f.37.2026.10.13.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:37 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 3/7] HID: asus: Force hid-input to bind to the Zenbook Duo hotkey interface
Date: Tue, 13 Oct 2026 12:40:00 +0200
Message-ID: <20261013104033.36079-4-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104033.36079-1-p.pisati@gmail.com>
References: <20261013104033.36079-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

The Zenbook Duo USB keyboard reports its hotkeys on a dedicated
interface, separate from the keyboard and consumer control ones, that
only contains ASUS vendor usage collections. hid-input does not
consider those an input application and never binds to the interface,
so the hotkeys are never mapped.

Pass HID_CONNECT_HIDINPUT_FORCE for the interface of Zenbook Duo
keyboards that carries the ASUS vendor collection, which skips that
check, so the vendor usages go through asus_input_mapping() like on
any other ASUS keyboard. The other interfaces either have a proper
input application or nothing worth an input device.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: use HID_CONNECT_HIDINPUT_FORCE on the vendor interface instead
 of injecting a fake keyboard collection into its report descriptor]
Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
---
 drivers/hid/hid-asus.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 242e273e4cb3..d69431615c27 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1405,6 +1405,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct asus_drvdata *drvdata;
 	struct hid_report *rep;
 	bool is_vendor = false;
+	unsigned int connect_mask;
 	int ret;
 
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
@@ -1500,7 +1501,18 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	/*
+	 * The Zenbook Duo keyboard reports its hotkeys on a dedicated USB
+	 * interface that only has vendor usage collections, which hid-input
+	 * does not consider an input application. Make it bind to the
+	 * interface carrying the ASUS vendor collection anyway so the
+	 * hotkeys get mapped.
+	 */
+	connect_mask = HID_CONNECT_DEFAULT;
+	if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) && is_vendor)
+		connect_mask |= HID_CONNECT_HIDINPUT_FORCE;
+
+	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		asus_worker_stop(drvdata->worker);
 		hid_err(hdev, "Asus hw start failed: %d\n", ret);
-- 
2.43.0

