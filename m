Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA43346B4
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791012621; cv=none; b=gp3uzeD22RKzdObLXuM4zW+ZnaEmx+CdSximQwG/H4mm12cawi8f9UJb5BQ1FlQ/HRQq8VzBvqm0jhvnL6XGBzJBm5O9Yh7H/5YTexk0ZkE721QmdQpNsVcVikMjXW1vYHFCoo97lSkxB2waiSuPZWV6Jmi8hQdpplEr5NKwERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791012621; c=relaxed/simple;
	bh=LnxEf66efq5ClvHb8mJ8XP6ctEeYvZYYAThQ0YvTz/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5eGLLC6NjuIkolHN040t9CKuTz79zPcKey2wQ1C+iRI+kD1W3k9daL5cv+PZcHNWOhqaezeHV1iUQ93AaH2ZKp3mHUSvjDgTcJ7VOwR4jYrSpQlWmnnftB9DgP30aAL+E9X6bH7y3hM21COQVqFw9w6u4oqH110q91cYUIi1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNtkdzJK; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNtkdzJK"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-34ef736eee2so45964eec.0
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791012619; x=1791617419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNX8WzPm1xbL15gYTvgsxtiYlRVrGYOY+Ynh0OU8gUA=;
        b=YNtkdzJKh+CTHdYmHTMSq0tCqHTF47XwBrL+EWaAxEL1WFmgGaJSpRxUlMcRRhiyax
         N29AY1L7isIVDVqBJaH/HB+MRr+L0mbzc1dd7ZnbSi30eOQWIbldyvt0EE4qkBSt5Xjx
         E3EaR+efjB01XiaXAoDYuwDL/2RcPZdJNeb6iWxeLGMC9NptpVVrtqtPlVst46oHrFpu
         JNEA3pwwDJGCtgufBhLoJXGtxJy00zmQqHeHjuVYow+yRplhuDZdIlaKO2/5Sk4RKyiv
         ailhI2ZzwLo0lVVzT2OLY0J2mFYxT7h3sTi+bzon8ufpc+8d5oYaHyMrt+Fweo7HddaK
         FVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791012619; x=1791617419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNX8WzPm1xbL15gYTvgsxtiYlRVrGYOY+Ynh0OU8gUA=;
        b=20M6Ces+dTTw2CaXY5OqsiTDRz+U0AlaJM87BHboCRwBqxOODuoP2sfhjPDc5JmcDd
         5fUbEuTcWk/zjmrRza02NGSIazRqV0ttv3eiZMBk3OGEhKUdGRjb+lG7JP7714doRq2x
         rsonT8T4nlCg2EWmNQ4fVm9jYfuwFf55qiLODXwRmFDTpvI5fvMeAccpNmtRTx6B+I5D
         ABjC2mcm4b5GHnAlcS2zNCFuWJKhq/rI2DwJf+NZ0+E47FL43Px4xbEbA5NLvCEGAVYi
         ddUnWVz3DPJZsMviqhamQtPLxld2quMKEieIZWT1UHTFs9YD8M/oISnm7FNhHWMTIp2V
         opxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGPslf2cqLFblKr0/7ND/lPoS66Gxmi/1MFn062XKznbaKRnDxoEcoDQJLhvq3RScdP+Fp5+5zCX692Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJslVrY5TMhmy9NF/HWhaUNXLa4WoWM24EjvYTcMy3oi0gtL/2O
	/pHgQrjVayUtyerXb81rOtPhdjnbLBuD8ep5bRSUFKfqF2vXATwocY/a
X-Gm-Gg: AYBFou22NhCniHSFYftuCpLF6jvscEPbnGVfUUMGcnoDFdqqMMWikhLuDL6t6i8opkV
	r2H0sMF8IjX0npKdQCvuPZ3cpxKTKl0sFJYrmuEOOs6pUTMN8bSbPKoydOWRIO8wQWlvtD4eJnj
	3mxPh9/xNvdsfTJF5IVkIs7ZcXrZz1X9Txx3j7HMga8u7B8irc4MYWRf8RS16sfZay1hdytEAOu
	xV2s4Qruv5en6A+pOe+HqG5EuOeHuPBXFRto5rM2ZVlP0gO70nV+DdLzu1gJ61C0vAvZXIdymwI
	PANohP0F7gznAiJvz74/XjNcwQCxMMVC8/H7Cu3ySaxxgd8Es5g9t1J1AZMQdg1oA7mqevFlNos
	GJH3/T2kcPlozDNRayjqtfCssfGLIOR6L/5aohF133cLd04hjKj1pfMF+P3sOHeWtl/hBOWI3OJ
	d5EI+Z663QLrDG0RZFk7q+KlwdZ59EyCVJ+Mg8Bw6FE/N9Uzjh2Ad76nDqVOyv+MrEQGdzkWYnH
	hPMU6QXAA==
X-Received: by 2002:a05:7301:9e08:b0:34b:401a:4648 with SMTP id 5a478bee46e88-34f150e388cmr5276725eec.20.1791012618690;
        Sat, 03 Oct 2026 00:30:18 -0700 (PDT)
Received: from linuxmint.. ([2802:8010:9a2c:8801:3f96:aa95:7a0d:7d89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm10911097eec.29.2026.10.03.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 00:30:18 -0700 (PDT)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Aditya Garg <aditya.garg@linux.dev>,
	linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>,
	syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: magicmouse: fix null pointer dereference in magicmouse_event()
Date: Sat,  3 Oct 2026 04:29:59 -0300
Message-ID: <20261003072959.388811-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003011820.1295672-1-nehuenlian.kernel@gmail.com>
References: <20261003011820.1295672-1-nehuenlian.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a guard clause to check if 'msc' and 'msc->input' is NULL
before attempting to access its fields, preventing a general
protection fault.

Fixes: b8d56ef91cc3 ("HID: magicmouse: Apple Magic Mouse 2 USB-C support")
Reported-by: syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5ad4fc9c8360b68e353f
Signed-off-by: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
---
Changes in v2:
 - Also check msc->input before dereferencing it, not just msc

 drivers/hid/hid-magicmouse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d637c0477379..e6d4d4930526 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -553,6 +553,10 @@ static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	if (!msc || !msc->input)
+		return 0;
+
 	if ((msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
 	     msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC) &&
 	    field->report->id == MOUSE2_REPORT_ID) {
-- 
2.43.0

