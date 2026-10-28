Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193974;
	b=lG3TuSglFsQREPrOrIFO5LgHED7WRohnJcBb3EYyAr14UNIIV75zZvqpyPJ15Ypi430T
	 D+5EGXHF++2iYEQFzDiuMMu3SxBk0HtzonYLwiAAiYZOip4e9Gx+x+Nr4QAAhm+twdBJ+
	 H6fXXjqxNB8mfgzuXAAMZKIEWsZtNGxQBAvCpK/vR0i/8VGJrlPWiKjURm6MHZnkZDd2b
	 42CeQVjIaUDFRX26w1OlDzrnXz3us4hTZhI0dwNbPdj+omFPgs5KWRuA3rP2YaRfiJ3AC
	 XZ7dBIpBksinObYGBYNhU6fhhj+JFAMNqaen17a39MhM5hOt1oyyuW4rrzibJ1Vh7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8lGk7ecJbJY8uCu7oKsWi906u8BzDPDWd5oQV0tOkG0=;
	b=GcS/kC4YXi4czop+Nugi3rbxK5OBRmAfTVXV4xRc01ialdV0Y4aMp4UXeRv8HwqLg3gy
	 HX/MFWqw6Tgd3ECsxzrbA43ydDgtiH5yV3Kuj8fE/g6bbtfWnJylzJG/BgHUNpVBICZiF
	 +wHQRyyf+ruiwITcHf30H5mLuPHQwQbQKnn3zYAp5PgWJg65D/UG2nH9ubuI3FetPNj2s
	 y0JdRBSsx6GVUwqcnY1ng4Efe75+RBfOPD48Ub7oKR0NDiW6S9+NZbkLr8AbU2xchTptF
	 StUihU+llwHLa/54wEPdJ1ZkgLN1xZGmQN6tLJjYi2PJnkacTYgUh1Qp3j0cIDb10CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvmOyktS;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA5606A326
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90AA5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvmOyktS
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso1710767eec.0
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793193974; x=1793798774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lGk7ecJbJY8uCu7oKsWi906u8BzDPDWd5oQV0tOkG0=;
        b=FvmOyktS1q29kBO0PSFzhCQQ4fSCh+73Qzo8DDROfe2c39OvqnCOjD7C3prM2DQ+Uj
         AOhGfDjXapl2DoNUNBVSCaRHpOabol6kRewnRg3X6OzvvYaE1U+L39lJdQnR6P8iAGN2
         gLW94k0E/yGLh0LnSKLbpzfLMZQ/Cxx3zqOUbhvFUFriFc/UBA4oK+MEpOBvbjEZOc7M
         e9N7OlaUrwan+0v+33gj9srblm9CaNaX+hvSFwQYp6hwsNkUKPfBqaJuIWomu1cMERzc
         6pc+6eDvnFCK9NQbtsinuXYSEq6DYmnjI8uayP5DM8vpzxn7KMDRciU6m7RmKGwyCh3L
         vmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193974; x=1793798774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lGk7ecJbJY8uCu7oKsWi906u8BzDPDWd5oQV0tOkG0=;
        b=uhp7ftFvOAGci7CZRrpLxfhFtdNIzkjeIFJB5clkjOsMKDZQ0rIeFi8O5DpdH5UmgG
         iReI7mby3+OS4vOqiABor/emQgFb4U3gMghDZXfViHZxJoQ20Ef+wF+SZqmn+gEA1cMR
         I1De6aRX1F7wNbE+BIi49zCEG2aPL4WhrRMa4wVYMW6bSlc97Ud7oH4zkaj1EnYsL4xG
         T5C3K65cBhvvCLac5vrEJn7UM3ahuNFfQrFFg0D1CLQZYB8KmBXegzEwOF7LGyAebflB
         U8Cfp3Q3qF6vaZdwOXPRbD0lCOToQv95CPfwtGpFyU0vWpMRdm/OjRH/Wcj5ivImVzuP
         81tw==
X-Forwarded-Encrypted: i=1; AKwUvBx2waqCbZ9BBVnUGZ5AJYDlNOmR/JUz7DE9Ag/i4zpZa5EXEvEMmgeaDn4I0Z3LUVbFYFl0LylGLvrL/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOCmhhWipnFz9xQ7qy6WPHI7BttOg5BurqK/978voCFVzu5htK
	jP98DXqoVfs3rOZPEChyJrD61rOti1bexKBfH1iM5Zi33riFm2lymqEm
X-Gm-Gg: AYBFou11bz1OD8Sqo5NIuB/X/g0NAkz+Ou4fQ2/PDLoMCxDJ0V1YyKHTt/QWln15oPb
	Q1r+dVIAD9AHsyT+UQlNfpF9ZlYNVc1CMqhC/P/ik4pUB8yHbeFxqgi7LDmZfcMakNoDXF49TzU
	1tTIKrI1zJDT7sb3D3xRwiCsaxznFdKe/wxrkQJyBd6RBUkMa+8377AAI2k76ZI4fgrxOBfEYLy
	gQSlGeLCogkfW5gbTlxdfhG90ZtnGg5vb1ToKfnedEw9DQ8xaRACp+MnXButTHpcRFp45IlrkDl
	teXkIzhKNBS9aAf9+ckFI7LpjhXluzDNv2dMRTHz/KVaF1P6qEjLipYyFVe7ADKzz4NFCGj79GP
	45P+30oMzkhslk3YAcLayksARqRV1PcowRQahL1wYT8EDL5/lJDD04AYj17jgYy7haDeDmP7o5r
	Vdr7awPacFQJ6HMlIJPjQFajyldIcWKHk/s/WQPatZkUsJw8FX92r7oz2Fq7lHl/hGK3PZV06k9
	XYSYEpgcW70XbmYbXEZsa7TMziTOgjpxVTBNocbJkDlxFuriCGkMMXJTg2uibANbwhwifn5dnA+
	ePCYpWQV4lpVrSmoizTcvdxcmhvNHgPtICkyjNLjJ0PetI6FLqt6o1MnbHyUJQCHwTeX
X-Received: by 2002:a05:701b:4546:20b0:190:f24b:9491 with SMTP id a92af1059eb24-1a6cbe7ddb9mr3384162c88.12.1793193973628;
        Wed, 28 Oct 2026 06:26:13 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com. [2607:8700:5500:3d9a::3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c814aa1sm10708639c88.7.2026.10.28.06.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:26:13 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH 2/3] HID: quirks: Ignore Valkyrie USB LCD devices
Date: Wed, 28 Oct 2026 21:25:35 +0800
Message-ID: <20261028132536.375927-3-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028132536.375927-1-ziaowang2007@gmail.com>
References: <20261028132536.375927-1-ziaowang2007@gmail.com>
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

Valkyrie USB LCD devices (0x345f:0x9132) expose a HID interface
for vendor-specific display control commands and a separate USB
interface for bulk framebuffer transfers.

The HID interface is not intended for input and should be managed
by the dedicated USB display driver instead of the HID subsystem.

Add the device to the HID quirk table with HID_QUIRK_IGNORE to
prevent the HID driver from binding to it.

Signed-off-by: ZiAo Wang <ziaowang2007@gmail.com>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa651..d135ea8f06 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1704,4 +1704,7 @@
 #define USB_VENDOR_ID_HUAWEI			0x12d1
 #define USB_DEVICE_ID_HUAWEI_CD30KBD		0x109b
 
+#define USB_VENDOR_ID_VALKYRIE			0x345f
+#define USB_PRODUCT_ID_VALKYRIE_LCD		0x9132
+
 #endif
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 793db001a6..70ada7320c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -226,6 +226,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE),
 		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VALKYRIE, USB_PRODUCT_ID_VALKYRIE_LCD), HID_QUIRK_IGNORE },
 
 	{ 0 }
 };
-- 
2.56.0

