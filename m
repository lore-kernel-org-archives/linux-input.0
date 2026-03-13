Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6614F9D6
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409176; cv=none; b=kYoKI18UGDKHDSUNotCmQSc/JrPGalMkgNS1/IIY58C7zHPxTcwjMC+mHQAtwGvu+WXCMhrnYDjuKKimRYHwsfIYqaa66pMhYiO2uikbnWuuezuTyf6GCNNbb0Q0TFCEH6w6k50hnfyxpDWQyhs96PIwGkhotvs8eVMsUdQj5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409176; c=relaxed/simple;
	bh=PQhEwzE7EvyN8oXqDy+OMcg59+4LiutEYZ/D/l29a5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOocWBC+gMpswmHWjIuiT9H3cj5KFhoEgi6tDnSvWHigjw+NtzP3gbIGgN3b13YzyryIsFMcvpyIRIt9XdGGpHZtvdHB8wwadyeOeUEAIXcRFrcO7phsMN4wTvtPz4itIPDf5oJpZkmu0UGlXVXgbj79/Re7wIihj/UFfLroa6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=danielschaefer.me; spf=pass smtp.mailfrom=danielschaefer.me; dkim=pass (2048-bit key) header.d=danielschaefer.me header.i=@danielschaefer.me header.b=LfDufuwu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBYokwWS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=danielschaefer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielschaefer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielschaefer.me header.i=@danielschaefer.me header.b="LfDufuwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBYokwWS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF1C37A01EA;
	Fri, 13 Mar 2026 09:39:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 09:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	danielschaefer.me; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1773409173; x=1773495573; bh=bdQLuqH7d6/HNAC5EMtFWY3QB7MGS6gBDvA
	0wOxsb2I=; b=LfDufuwuRrqJQ/MqjBk9nYsBIOHWdm0p8WTResRG9hJ602zC1j1
	jsbnLaU65C8r+h2rxMiFRWQuu71BrO16biTOWvN7K1LnQUNm1L5yfT42rUNfS93P
	SD6xKe8tiaByxM7/K43d3jMgM0HD/56TFaDta/6FNMUOOqNr46Fhjz7faBG8s8Lk
	PhYlFXSKzJ/tbn/daBnYoanEHpzl+mudUXtyZa0v9G6wFC9etshY+3fgdMc1f/51
	pWQX+TUr8lIqXFVBxu8+qJsyxDlKkluN17487KhLNIQB5nEAXyeZj/d3j2iEljAS
	VyRWeEcNlIDePsfaMF8xE6cyH/FTB/FqB8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773409173; x=1773495573; bh=bdQLuqH7d6/HNAC5EMtFWY3QB7MGS6gBDvA
	0wOxsb2I=; b=IBYokwWSsr6Isx9G73TVQsEd9Q4PGiOv/QEh4vSHVRE1+5YmH+Y
	cKpx/3pPJVUXEoT9iDuLB6ttcDlrprYtJS4jjtErkH29+cf13jZhWH+qeM/RUeGb
	TDcW9MIJyxDR9kWeQzJYA7tSc+r+j1x4zgaAcP511OqMOsgKB5Rka1ZIVKoBJuxG
	4v9e7iUys0xct3utvpWkFIofJDAIW4Upx2eq891wFd3I/aiap502I/6wZI6O2C8a
	t8VJ0S/7YY11DonyCgNML5iC810DrnAQMxWTaknbGlxgBGAzg92iMV13qUURcKAI
	AeT3SAYObcw6qhQJObd+O8vHNc5e6Fm/9Aw==
X-ME-Sender: <xms:lBO0ae_eGpmwVm66N5ckrrZASSil4aiRSEE23_NXKlVXh8wBiv_BtQ>
    <xme:lBO0afYTv6lF6e1klREdOvGTqfgJqOKH0Rk-xv4q_F1SDoteqc0H63L3lIAirKI95
    tjbSAojJ16ckh7jcjWc5OmoAU4o38fmC3rTCBUiRLwG7c9QFlqDhpvO>
X-ME-Received: <xmr:lBO0aSNYx_QQFi_wi2bcYjJb6x92W0y8yVkGX7BI30CgQKQ6WTFaSPaxKHuI0qsznoofMubK0uCDZCnZ0a8CM52RYw8q_aiozkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucfu
    tghhrggvfhgvrhcuoehgihhtsegurghnihgvlhhstghhrggvfhgvrhdrmhgvqeenucggtf
    frrghtthgvrhhnpeefveffudetvdehjeehvdelheejffevhfdtuefhgeetlefhgffghfej
    ueffudegudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithesuggrnhhivghlshgthhgr
    vghfvghrrdhmvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtsegurghnihgvlhhstghhrggvfhgvrhdrmhgvpdhrtghpthhtohepvg
    hvvghnrdiguhesihhnthgvlhdrtghomhdprhgtphhtthhopeigihhnphgvnhhgrdhsuhhn
    sehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    khgrrhhirdgrihhluhhssehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:lBO0abBYoT73yI670p-VMJBChDkxv3DNWSYTFzktMpgPp5Iod60pww>
    <xmx:lBO0aZI-e3Zqt9DUPX9uBvsajEmrtOJKjwksSKaYme8dRAci_bd-hw>
    <xmx:lBO0aUPLsQXKxnxISMT_qj6pnU3-wdzh_sRslw1FLyLT-sN4ItgTXw>
    <xmx:lBO0aX57oji3N36jYHFHZNcszbV3wbzbsylhFhpfVW3ZCpZN2FccUw>
    <xmx:lRO0aU7f_PEEZPP8HWtwPEwbPTnV6lca4h4nDjZxlna2uRIKg2qvq2gO>
Feedback-ID: ica794672:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 09:39:29 -0400 (EDT)
From: Daniel Schaefer <git@danielschaefer.me>
To: linux-input@vger.kernel.org
Cc: Daniel Schaefer <git@danielschaefer.me>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] HID: intel-thc-hid: Set HID_PHYS with PCI BDF
Date: Fri, 13 Mar 2026 21:39:25 +0800
Message-ID: <20260313133925.35740-1-git@danielschaefer.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently HID_PHYS is empty, which means userspace tools (e.g. fwupd)
that depend on it for distinguishing the devices, are unable to do so.
Other drivers like i2c-hid, usbhid, surface-hid, all populate it.

With this change it's set to, for example: HID_PHYS=0000:00:10.0

Each function has just a single HID device, as far as I can tell, so
there is no need to add a suffix.

Tested with fwupd 2.1.1, can avoid https://github.com/fwupd/fwupd/pull/9995

Cc: Even Xu <even.xu@intel.com>
Cc: Xinpeng Sun <xinpeng.sun@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Daniel Schaefer <git@danielschaefer.me>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c | 1 +
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
index f9fcb398673b..8075992e8732 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
@@ -127,6 +127,7 @@ int quicki2c_hid_probe(struct quicki2c_device *qcdev)
 	hid->product = le16_to_cpu(qcdev->dev_desc.product_id);
 	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "quicki2c-hid",
 		 hid->vendor, hid->product);
+	strscpy(hid->phys, dev_name(qcdev->dev), sizeof(hid->phys));
 
 	ret = hid_add_device(hid);
 	if (ret) {
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
index 82c72bfa2795..91d5807b4a83 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
@@ -118,6 +118,7 @@ int quickspi_hid_probe(struct quickspi_device *qsdev)
 	hid->product = le16_to_cpu(qsdev->dev_desc.product_id);
 	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "quickspi-hid",
 		 hid->vendor, hid->product);
+	strscpy(hid->phys, dev_name(qsdev->dev), sizeof(hid->phys));
 
 	ret = hid_add_device(hid);
 	if (ret) {
-- 
2.52.0

