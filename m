Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF172F6577
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451088; cv=none; b=ud0cU+3w8CCB1jmCUGGJEZ3/EjWGhg4hY+QeCBfjWhpYEVquXM3EF4MO2WPSkUX9gSgW9ncCSSP8fvmA5xGiLTKiqijewYxps2NTLurw6ZBguMorLrDNB68gwBviwd+M20xmrlu7ZNkzQ4AOHM5YkWQHYi/PlNvZk5WI+TVnHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451088; c=relaxed/simple;
	bh=I6ywcvU0qgxYw4mz0/EU2EY3eWlSEgHBFxkPAYQzJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkMsKtIkVmLBYLbe4+2eN15rW3BC61IXtjudoh+jxToWGKi1YS5nD4urMPoJZgdpIpv92A8DoictORojDOKf0mUCJKUISf6i6yaWBrUehoyZghNtEmbIOE7x2estmGkFRzzt/99DH6jYS0SuD1thHeyMpuMQwsV2ku94P7oAius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8DEIoNh; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8DEIoNh"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30c944aacbaso873890eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451087; x=1783055887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cLX/dU3BOyjaBvtaeDIxgiaeXykFIfqTUE3z5v9c3w=;
        b=J8DEIoNhxzGKe9/2W0f6zlX2Y1PN59vqKRDBf1+doV2JvLuH9zYlgxuPkz6AyuKff/
         gLC2pUfcLXanfWXCwu5XMv1NPYy4xwg1Ad+/xVfAJqm7NjDYqIoJgTCX24Rbya/TTGaA
         C/aO8RPGJpjuV8elVwg2hqnCR2wNtKf4PRcHT8pyqOGTLqi1Z4hSKvHSprxfEAWsXoKb
         fkP4rOY88Jgjd5ZfL7Gc3EIkoBtIIBQO+9FECqKGCEJ22EHWZKWjQ3Q39jnSWqZgccPS
         Pa+V3QzTo3n4L4uY7rnbnhW3CueMR5DVoY2/izNLVD4XhxDBN477hdWAiwUZ3Csu0w5T
         Ua0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451087; x=1783055887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cLX/dU3BOyjaBvtaeDIxgiaeXykFIfqTUE3z5v9c3w=;
        b=cFFchovO4FOo6g9Z16BLxrDcaMm93hCof7V+cpgI2PM+9wg3uGV7wjrWQtTLZ9CZ90
         jBBX1N+0so5STnO5kEvrXMmwgHz/hMEzGMeaJNTv4mUGxJdV0njamyOpbRfq/d4obHSM
         DLRVZXRG9wsPmC7kbfcStZQelHXi3qMI8hh2mA6v8EnMhNXZpi7P1RKwH4PsukcwUSq2
         y+soNE6UyA4zf9Xs0pU9ng/oINOgZsM4MIe47i2PaacVeLWF2I7yx3ZHFA2IXfxZ2sUh
         DH9H81uUXx5tldvUrpHtQf1kU1WfsVpsaNcMl0+H/R8tcqrBfLOoV4NRF39Y+CpC/4ju
         50hg==
X-Gm-Message-State: AOJu0YwfWLD6TopaX3OW0NsDNdeY8xN4V0mRsZrFcQUmixFbUNA4zUKz
	aHx0+5PPXMxww0mbh4z3N7XLlhZm5rvMDkUg+SKh2HBmFGpDQ2KK3QMM
X-Gm-Gg: AfdE7cmqhmO3Wzvc7HV5BTD6q0Q/1qtiIVo7RtfxFR8Oom2jl+o5SH8UdbtOu89zBKf
	i1ycELTpWREq1c4uRXQuHbFy6ZBXQmnpBkhu9r1UcyhGD+V0Hp0muPCrzGCxP89e5uZ0mArcZ9Q
	SjGKechBCDINF05qSFmK+ZhYrDjSYlet1qSEQmAf3IjCPGdSAG0IhA1zVE16ELWflSj+GooXqBP
	rxzx09ukQLtpuGR/y//IqSywy9m+Uy0PTvjYwkHu66mA4CzOagRwovnFv2KH8etm2GLqiUfE3q0
	JkrrPKkHfIFwO/pPeqDMdC2/LRtDllHROJgtW/yH//vaOSl3hzNWxrgUnnhqc+JJ4Cp/Rug2yI3
	pG2RAoOtmF65uW+91vN7JJuYq85D7odxEJ0ytJAAg3xwNxs0AJWSsWnovEd9O5y0UwruCzIkooJ
	/Ju7Rhz6c+/W74r3yMQFMKChXcXI3UmyC5J+WhW9sOMWsRf9PLsI9SWi0o9xdtXC1dP7W/RwCJw
	qeimSTr1UQK8Kg=
X-Received: by 2002:a05:693c:3945:b0:304:e566:e000 with SMTP id 5a478bee46e88-30c850a8f7cmr5878370eec.31.1782451086712;
        Thu, 25 Jun 2026 22:18:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] Input: synaptics-rmi4 - fix F55 transmitter electrode count typo
Date: Thu, 25 Jun 2026 22:17:50 -0700
Message-ID: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During F55 sensor detection, the transmitter (TX) electrode count was
incorrectly assigned the value of the receiver (RX) electrode count
due to copy-paste typos.

This incorrect value was then propagated to the driver data and used
by F54 to determine the diagnostics report size. On devices with more
RX than TX electrodes, this inflated the perceived TX count, leading
to incorrect report size calculations and potential out-of-bounds
buffer accesses.

Fix the typos by correctly assigning the TX electrode counts.

Fixes: 6adba43fd222 ("Input: synaptics-rmi4 - add support for F55 sensor tuning")
Fixes: c762cc68b6a1 ("Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54")
Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f55.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
index 488adaca4dd0..a0877d32a914 100644
--- a/drivers/input/rmi4/rmi_f55.c
+++ b/drivers/input/rmi4/rmi_f55.c
@@ -54,10 +54,10 @@ static int rmi_f55_detect(struct rmi_function *fn)
 	f55->num_tx_electrodes = f55->qry[F55_NUM_TX_OFFSET];
 
 	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
-	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;
+	f55->cfg_num_tx_electrodes = f55->num_tx_electrodes;
 
 	drv_data->num_rx_electrodes = f55->cfg_num_rx_electrodes;
-	drv_data->num_tx_electrodes = f55->cfg_num_rx_electrodes;
+	drv_data->num_tx_electrodes = f55->cfg_num_tx_electrodes;
 
 	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
 		int i, total;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

