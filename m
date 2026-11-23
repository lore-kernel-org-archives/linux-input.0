Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407658;
	b=gsJqL8Pcwmh2QNqMa05NRiEcg9TTbyO1+MEa61NTO4qrbCzmyUOIE1sxBGKLs6WU0Puu
	 us5HA9Yc5VGHQxMzCD9Huan3P+a5tzQsOGUUM2N3RIFiMxSsj6aCOfdMHApK0co1PNMiw
	 kilcIhQvRv+GoMQtn9wKTykXkCX5MG2NyetzRiQllJQP2ui0yj2cMv98DAJoTl23nLqYQ
	 ow9VkQwV5Aoz/7OlpMzNnjTUa7qjtFjcUcoHb9ICck8wXeF87ccrnW4FDgk0emMasg90I
	 jNQ1Z2nG4gsViAuX90RP8xazFo7bQOgTdnrHNCxhnnZag4mMOmJh3w6uAzsuBwgehgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SBlO8WiYE16ry24fdhtgDeDZYmJlQt9SgDlhyOT3gxU=;
	b=WK25E2g9TQxiqcPBk+y/KUUeH0A3PFWxOGKhYNoKaGH+8cs/0X8UhaPXbcTqqmNbElCq
	 SAUPIvWaITb9zSoiP/omf65LnQYGAa3f/271+W9MF1w9S+ByVkQCG5i2IB3qLXci96yav
	 sBdzhkgxTZxX5j8Vw+pTfg/XH28sOB36tyC2JZVS4+JeujLoqNQ7xeeIx4Ql4B1rczGmW
	 gvA+H7r0R4LZFRzfvnmU0MSIP776ie7XLE4Lik9dlO7Mg/frQovDlIRk3pB89JtINkLgz
	 gMMv48fl7hwjfb2RlSYdmSEvpMlnfnqPKoQTaFKz8mX1n5mZVvoe/UMTJR7YijY+RUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GJpFjVGh;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306B606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9306B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GJpFjVGh
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3863db981d4so3740195eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407658; x=1796012458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBlO8WiYE16ry24fdhtgDeDZYmJlQt9SgDlhyOT3gxU=;
        b=GJpFjVGh7Y1wAb8Ca49dog1kFLv501YKpUcwcVLLwrAU9OYyA5GjbZdpPMIl2O6Zq6
         AMRUHYfnzVvQEFhkvrF87fbEUouSSbOsOA6Dhkt0UF6fzWi1AmVTkgsK/CBF2a885qva
         9qzCp4Uw65sTLrbNrn5vvhnIkaFrGzfNchqudYkcLcLPpbOBZ6yadNvhN5uKO/qwTb57
         gB8PYrXGFtx4SCX+fcjIUMMu1bSWRbaMwURS5uwgCxQAvZ4s/6LzI2kksPtB366LhoDT
         0LcCRbK1lbvrOvNtWOCgy5rTRX4xpINnimliItugWGZ657UZC4SZ9hmjNPxtdBuJiD+L
         lWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407658; x=1796012458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBlO8WiYE16ry24fdhtgDeDZYmJlQt9SgDlhyOT3gxU=;
        b=EjgZV7w+eQUhuaN7Ybu+hSsWCyOSrf2NYrB99FG5iIUw6oW78ce7T695cAm2sjRl9Z
         N7/W2Cl+H+DOiLPI+PPzhVgOzAdbs17INhb9L/b57sC+xDGP+eUcKIweSZFHtnnh/M2B
         joXKznr60oIuPYty5UQAnCrQJIYl1f0hBpN6nHNxj06fVPeS86X7LL0QAy6olzVDj8lo
         F0tXl5VKmqzhqhb7S6/Codv3SSWu06QQaVBDAMO8ykSqKwGC7l8sHAyZyHvdZCmrkERA
         PfKUrTRxKlnPKRUZSpIuGV0wHZx0EJ7kF8KKVNi5Yvvj8G4KMgJvboitx2rc8k7PbfHM
         jwTQ==
X-Forwarded-Encrypted: i=1; AL+hErE/cI8tB/z6t5qt27ksLLnO8FYuaNwdl5x/S2J+jeoYcD9TF6eSXe2gwdXBpWqO0WcKeXwWC5z5b437nA==@vger.kernel.org
X-Gm-Message-State: APuU4Z886VFEVHh13thVeZ8Ef1pHiMfrjyq1OrH3Mv9bw1084qg/KEHP
	9GYIfzd8v/snKfWCJIeAP+P9mLyCsqIsIL0zRdP6didx2Q6a0nFKcjze
X-Gm-Gg: AZFdTZdJhlNaWAhGWt2COx71qe1pfBc3KOzZMlrb3at0BMiMpNeSrvrBnqf/eEX7OCp
	auY2rWKt1EzuNLPttCGOn0aMnvtYrsERa59rz6D0d8FNmj9RTXZkqmvOwHJGpV1goxe+7sGJS+J
	myFc3PPzTqvyLnAnF63/ARjYMFohX9G1019iwcjNCiVLiA5o6IO0hHe0C9YeM28v6qHaHkYgjl4
	eEabz5mghM9F+K6vimgKItWM9nur/RhRAulqZyjWVWlIvQSS/OAfCCSsIF+iy/O6Q+kS1TxZfEu
	C1AWBwPjgHVnzpVjd+lMt7o79lILP6wC/x6VVHg7Lq8vi7HHNGpUB9+AVaSznBYlBqT5vd8Tiiz
	RSmTjh+3hpc/vgZuKyYnA9jOmOzs0d8pdFAgTVN8ZlCgJCHPLPX0plxKXNizIAedQFIRP7+Y3yX
	169qYFDIfMbrxLjBfUyiMu0S/yD6jWPbdIkU+JVQwAzLwWscZ9ZjRUQEOV3M89lSKdvuPuYZ5eA
	iKgFs0jz1NVW5y51EGYnNL/xFgA1iolZaNkGfAu8TM/qyAV6x3mx2u2AslfdxFI4S8HIruG5PJT
	33fuh0CRFOGMuTDKPb1rY0DTRWIoo/Aj5wE6cwT5dt4ukMVjG24YwqO9C/OaG26Id+xboQ0YMal
	Zns2Jnl1sZ0SruObXDPYrrkUg1tQfd2GfomzQ0PFpxcFlNrH0
X-Received: by 2002:a05:693c:41c3:10b0:386:acf5:b4b5 with SMTP id 5a478bee46e88-386acf5b7c7mr2495884eec.23.1795407657520;
        Sun, 22 Nov 2026 20:20:57 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:20:57 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v5 0/6] HID: wacom: guard against NULL input devices on successful probe
Date: Mon, 23 Nov 2026 04:20:09 +0000
Message-ID: <cover.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
the corresponding input pointer is set to NULL but probe still succeeds.
Subsequent irq handlers dereference those pointers unconditionally,
causing NULL-pointer dereferences reachable from a spoofed HID device.

This series adds per-function NULL guards across all affected handlers.

v4 was generated against a tree that predates commit 2f985de0afbe
("HID: wacom: fix wacom_intuos_irq NULL pen_input deref"), so patch 3/6
no longer applied and was dropped.  This respin is against
hid.git#for-7.4/upstream-fixes (10bc1d627c29).

Jason's Reviewed-by from v4 is carried on the five patches that are
unchanged.  It is not carried on 3/6, which was reworked.

Changes in v5:
  - Rebased onto hid.git#for-7.4/upstream-fixes (Jiri).
  - Reworked 3/6.  Commit 2f985de0afbe removed the 'input' local and the
    dev_dbg(input->dev.parent, ...) deref from wacom_intuos_irq(), so the
    pen_input guard there now exists solely to protect
    wacom_intuos_inout() and wacom_intuos_general(), which are its only
    callers.  The guard therefore reads wacom_wac->pen_input and uses the
    struct wacom that 2f985de0afbe made a local, and it now sits below
    the pad block rather than at the top of the function, so a device
    with a valid pad but no pen keeps reporting pad events.
  - No functional change to 1/6, 2/6, 4/6, 5/6 or 6/6.

Changes in v4:
  - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
    NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
    suppressing the spurious input_sync() the old "return 1" would
    trigger (Jason).
  - Added pen_input NULL guard at the top of wacom_intuos_irq() to
    protect its helpers wacom_intuos_inout() and
    wacom_intuos_general() (Jason).
  - Added pen_input NULL guard to wacom_bpt_pen() (Jason).

Changes in v3:
  - Fixed wacom_dtus_irq(): DTUSX is pen-only, so do not require
    pad_input for it (sashiko-bot).
  - Added patch 6: touch_input guards for wacom_intuos_pro2_bt_touch(),
    wacom_24hdt_irq(), and wacom_bamboo_pad_touch_event().

Changes in v2:
  - Restructured per Jason's review: per-function checks for dtus_irq,
    graphire_irq, and the Bamboo handlers.
  - wacom_intuos_pad() returns non-zero when pad_input is NULL so the
    report does not fall through to wacom_intuos_inout() (sashiko-bot).
  - wacom_intuos_bt_irq() guards both pen_input and pad_input (Jason).
  - Added dev_warn_once at every guard (Jason).
  - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).

Jinmo Yang (6):
  HID: wacom: check the input device in the shared report helpers
  HID: wacom: check the input devices in the legacy irq handlers
  HID: wacom: add NULL input guards to wacom_intuos_irq() and its
    helpers
  HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
  HID: wacom: add NULL input guards to Bamboo handlers
  HID: wacom: add NULL touch_input guards to remaining touch handlers

 drivers/hid/wacom_wac.c | 127 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)


base-commit: 10bc1d627c297097cfdc099377f8a13efdfffd86
-- 
2.43.0

