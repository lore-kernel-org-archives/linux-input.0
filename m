Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC67392C4F
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630731; cv=none; b=Fzrvx5Y0758WszSX3L+BQEmZBuUVVJys1TiCzRbaPSNuQJDdnadDYDnRQmdH8FqmW7XkpeAyayJpW5EhUB3F/WzQLFBI+HqT3ZOwwRi89QCODYiy1azAjYYHESg2C/LtuWlvhTl1ahfox8Z+jpHHX99BayGP8WRF7WpZXrjGOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630731; c=relaxed/simple;
	bh=ZgbH/mYUb/Nhi5/awpSI/okcaOUUQIeFVWLGt9Vv3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8d/HuXiNtBs9OOQDlRlIW5nb5ZTbc8ppwi5tt9LguGnGAdAUspiPyfEIZU1FdKAoWX8+nsk7JTh2Cngd/xYnHIb+VO3uM/wGy6Mk8A5YG3OdVD651F2ao6lXTZdZufT5DJZboqR4riK78xBxHYLZ4zDYfT3XnoZpnvZDst8NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyY+gvSV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyY+gvSV"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so7990203a91.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779630730; x=1780235530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDBQfFLHNH4Mc08Xf81Bh0XesibRVNF/v0oW8QDjjcY=;
        b=GyY+gvSV2MWdyLkCMLNrPgL5l+9X3MT/lCy5Gj5rIYWufcjttEoU4txXApyV/pLGIy
         eg7s4Vd5zp7CFz+1d4PwFJzb7PuxvnKg+T9lMT6IKjsZZj34FKzTeJ3Gm6JM9tJPyix6
         dVa+Pnr4bz1VpJ9rVR14rDmp7kpm5zEM0UIwLI4fK+e9iwCbirdJUkhn+v4zRiO1w8tL
         b77n9HpQ1z447urws8H2EBemvGLe2b4BhmejFjcAnjQbwIFTS8cjitgGB3xSkP/03Fpv
         qO/sicmX/D5Ag0fC8IIUWlZvQoIabW2GxPsE1KZUgj5pC3rj3THBbU3BN3t0/1/jpAJM
         SyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630730; x=1780235530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDBQfFLHNH4Mc08Xf81Bh0XesibRVNF/v0oW8QDjjcY=;
        b=Aux4+NL+AGwrS/LidhMKuUc/9vJddVnw7N4rsutX1FxggLg59QpMG4Hzw2UhaCSnzz
         AWlF+/zNzRSjCbcWUcTcsF4Vkhz3N6UjBUMMwRORFUM4MGhTiGiuqfzyzaWGxwC3phGc
         dL/3CF5YbK7XdyuSYNHr3sKDbr+uKrR0Ib/4485qNaNVquUYn8fq9F2J39a6cK+PIQya
         sBPmAOWRHNLPVwBzG+voiLaGkmCnzI6rvUtPs+qufexyj3lMzv7UiW1wrCOEALaW8ex2
         ME8NurNdqaShAM23cvNE0klwHQSIHdcTRNRdcWqqpYikKE/CdovT3RXKyT6VjBLQ0zTv
         UMbw==
X-Forwarded-Encrypted: i=1; AFNElJ+AvteK9Eoa071KhIodQUSwfQEXHikqDEStbKyKG7IiT5SApTmO1/j7DmC4oh45XcwdLFdcygZbYYHduA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNtFYf5PB/1KBrYAt7iP4Otdtbdbpz0kf8pQlqxV+GMNkVLHx
	xHcrDp6SlyIXBYORnQcqY0cHcb2PbjGdbnxILrKknuKPqCbUDICkFn1D
X-Gm-Gg: Acq92OHMY5znhKQkGUTOSxG9H8WdsSTufKdrWu2viz6Tmq0JWzQq9J+KBAf52M/nW1Y
	WFzdH96F4HqmnrxC74Ai7kycD7dqFM8Nj32dkg7/v64koBTYzS1biWG/qbuv1a23sNYiM1hMefi
	KmcBzi0KqWImNar3pRvZqrZsTGISTjMq+dkTh2hyxBUEcVOqle+K3YYX7d4D1+BH7H/Y/uh3uON
	dBzr+WgWoJ0AGMZtVe74QnJ8yhuet6cdMRH8rwdEMwiNeg+TcE8v4zSSTKCkUR/klGnrz7t8Lu7
	DgztJHLEh8iirW7NzQeizApIKtnwWeE5ti5Knk1lR2IKInhirYJ/EZ//PeJngC/7rEqfuA1omPG
	s6/Tcuh9tZm4gFgN0QjGEMjQxEWFIsnQUHuBXVbr3VXFcjs+jGI3jZ7W13UBr72zUNyJk+9rzyI
	kr0OTJHyc4E5c9HxX4wHt8tFHLh2YiS0HT2OUwSW2ox+oy3+aO
X-Received: by 2002:a17:90a:c110:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36a67616959mr11020845a91.23.1779630729720;
        Sun, 24 May 2026 06:52:09 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm7073833a91.9.2026.05.24.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:52:09 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jason Gerecke <jason.gerecke@wacom.com>,
	Ping Cheng <ping.cheng@wacom.com>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] HID: wacom: validate report size before kfifo insert
Date: Sun, 24 May 2026 22:52:03 +0900
Message-ID: <20260524135203.1996265-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_wac_queue_insert() passes the report size directly to kfifo_in()
without checking whether the report fits in the kfifo buffer.

Since commit 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX
limit"), the kfifo is sized dynamically as min(PAGE_SIZE, 10 * pktlen),
which can be as small as 256 bytes. However, reports received via
UHID_INPUT2 can be up to UHID_DATA_MAX (4096) bytes. When such an
oversized report reaches wacom_wac_queue_insert(), the existing
kfifo_avail() loop cannot make room for a record larger than the total
buffer, causing kfifo_copy_in() to memcpy up to 3840 bytes past the
slab allocation.

Add a size check at the top of wacom_wac_queue_insert() to reject
reports that exceed the kfifo capacity.

Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_sys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b..cc82c6f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -54,6 +54,12 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 {
 	bool warned = false;
 
+	if (size > kfifo_size(fifo)) {
+		hid_warn(hdev, "%s: report too large (%d > %u) for kfifo\n",
+			 __func__, size, kfifo_size(fifo));
+		return;
+	}
+
 	while (kfifo_avail(fifo) < size) {
 		if (!warned)
 			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
-- 
2.53.0

