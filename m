Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D34E8DF5
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560109; cv=none; b=rwGUGTLrkRlKmV7WqnNpoIgYBY/Zl65pU2U9ULb6fxzTf04PfUgeyGt6ukLfrNrNuKUAM9Y09TgoY3b52YZPRVf3zlJ6nz8gGH0OpddX/gjZ4ySFOBv7vB/3m/UeTN1El6V7pzEoo+Cv6pL3L2IGo2gYq0JV0YqPaTuDelIP0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560109; c=relaxed/simple;
	bh=6mFCwhjj4lLgVxFOGYyVz0Ywa2oAv29KTcc8q/GGdqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4fHuKj+kicNh2dkO5y9FEBju3n/djqPQPm6lNDpPmmUw4VxOs3fCFiBfa2X+Q2cn8qTR2kJB/7T454OB7jcVXxxSfWG0PtC8/YjiYQJyz/JrbnZEQsUcd3oPvzOX8iq/fU1WiWqe166OdfKPFPyzsJvidPhGEqHqlilIKnRAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8qKoNgV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8qKoNgV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso68074085e9.3
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791560105; x=1792164905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4HQvrELlaRt1QYL+yhHv5Fz7QH7G1n2sAWj2/3Cyao=;
        b=Q8qKoNgVPo9WA2scNwacU/H5u3w6QkKYDkspZo+L6v2sIpgdO7/t8UJNjF5UlE6FS1
         qC8DiVMtP/GH8cotFKunWJE8v2ljmTZPrhx6snQCVdLvKtAhxn7yBkkCQIfJGhAQ9fGh
         KoEDgT1iurll33u1W+poTsxpuhrE3YelYrJAjS89fPQW+h83E9UoxOnlBnP5/zLo5GOQ
         F4NI3tRrrcOBX+SIMmrSb5QUBDU/O3UUpGYFmFPtDbu8xBC3m1HO4iTdvqdnRDzy4SVr
         Xe+AXZfwNstyXdcPbDPcBpnAeri0e0AauuGfPqE+s0Q5k2WRgZ8JRL0AAW8kmWnsM4v6
         eijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791560105; x=1792164905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4HQvrELlaRt1QYL+yhHv5Fz7QH7G1n2sAWj2/3Cyao=;
        b=YhTu4REPJYij9aUXqgQQVprSIe0h/6edHQlYmn7381X4pydaJ+DmIzPcll1iCik+iB
         AYlqPdjNG6ir3qPl1vZGEyPUBfoTDGf0ApdLifDdsU+ZuEcI9Yzz/k0zyF+paXPuevmn
         3qJr/3NZZXSJICLGhNUvT85oojywxn5yDZXIYvUO7ZjvBlY0z5Wwl8OAm5a+F+KA4+V7
         xnzvNMp4tOonio2CxBtVslBkGfLiInyvCugtbDWUEQm/0qjVDbPY/ybIgI3ToX+PWgm4
         2/uUhrBMN7BZ/s9fvq3Ay++9aRuw1stiPu6cFVerbSKIxoIsBRGRaLNEAQJOqLE52i2j
         yhdg==
X-Forwarded-Encrypted: i=1; AKwUvBzgIYYCdMsC9LwUslQH3+GJSEmo7lZueH95C9FKi9Q1FLLg0Bh8t3c46lmXFk0f2+YHEfQEUNkL3voVeA==@vger.kernel.org
X-Gm-Message-State: AFuF++k/LUexUUy5qlrioleU3Va6MTxUvZcNba+ntfOT/SsZE610m7GF
	XqCTs6x6YS7zuZxUD5kB99yNmmWdryhleKlT9+aHieT3oDrojhEP4ZmPyxcZvJvXnU4=
X-Gm-Gg: AYBFou1DG9egchP3+QaGJSvtfF8ISYResSiGsXDKUlwn1VMzc0bcM66VDJVm/ZB1nKi
	QrLBwfoeRyO/I0Ti3wqBlmIDdnDe+djVaAeAjg/kI46e5a3kEc7g6ZGit+ZH0pQi8IVG5jwwMY1
	ECBDTJ9m8qg4DNXUQ74G5nBI1nSbYFexcvH4FnTP38o7nSMPpXG0Mm3rgIkQTPAuerIlgCaO14P
	fB8lM/FplVEGseWG9TGpAlu0rwOy2vk9et1W1q1cBC2vfqipnXbV4QYGYGI0nKtUsm/8w4lrv+5
	R3UO0U2so8uVZiPDrSlzWdAM3O5+kzSC3zVtauRfnIXVcqjLDsX1psF2iYD1mK4gO+CQcf12s4h
	xzBkWPsQce6D1N0hlxeJmO1VzHcj75w7W1TJFBDmhktxY4ceTmn27xvc4kL3Vc79T5Pkcu86hlX
	ag1tm46utIiKeh1AevK4tNcf3K751xCUHQHdk5RVW24NLBH1ncLnU4+t6R9INiIfNX8rhEqJn25
	yYZzjoDtuJ5NDtKxeZ+C7f19uJd6pqHMesYmPWT5B3C54HveYtSeQkeWkezLZozlG/E
X-Received: by 2002:a05:600c:620b:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-4a18e4d12e7mr41345105e9.31.1791560104710;
        Fri, 09 Oct 2026 08:35:04 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:8516:411c:ea75:bb84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm4244831f8f.22.2026.10.09.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:35:04 -0700 (PDT)
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
Subject: [PATCH v2 3/7] HID: asus: Force hid-input to bind to the Zenbook Duo hotkey interface
Date: Fri,  9 Oct 2026 17:34:30 +0200
Message-ID: <20261009153459.124752-4-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009153459.124752-1-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

