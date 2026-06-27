Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19689463
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600481; cv=none; b=Gyrs5EqiU8OHjcnZeD91TvJuqJxIlg9ZG0ESVDSS9H2Js7UKA4CpNb/QEeBgYQPM7qNL5QFPTv+5owF581yHlt4N7o1UBquzeY4Zuy13mTUmi/EKhzcks4BsgsCOGq98NHcaoQJrAVh7nuFEXlsjndhA20gaCUiHdX3twGZsbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600481; c=relaxed/simple;
	bh=EbpW8tnGx+bK883zGTF/bUzmXB/dqVfMYkGpGNpcQTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVgg1uNg48w8HbfemictbNz/sDhyGHYCQy3Z9+QHmfuVH6bd+XoyWy+pGtQJZjPrqn7CIAXv+VtzCYIDQt6Z5z2sg5lacAiQMmhJvctQAtlSqKczAtJtKQEgxmiM+jT2urLQeHEM38PcMMHlIrHXFCR5jJ4KoxNF4JbF1aVVmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEkSS2EC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEkSS2EC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7ee3952ebso24168055ad.0
        for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 15:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782600479; x=1783205279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0bTyMlPjrEJesPmUmZMuO3nUd1+lewMLRUQO61GhVE=;
        b=gEkSS2ECh9HSPRBkkihWk/Xzk6hz2V4EmOBUL7fY7+XuaXNnqMbMObfIGp92z05oWQ
         JOh9X6ln7eLrAt4Qrlb3C/lUwwegp0Y8emtflKmpMc2JbdndN7lX1NlDI5ixQvZIedhg
         ugxbgTsTdpydBJsk8RLGzUTXeS6dlIW7HTMvbj6itxDDxlZtkyYxbJv3avIvqmMKXdpq
         +buGYISeyZh/zZii+1r0RYgvckQZHaHrGx1L3UlsfepeZ0Mn/3sxjVmz0ClYgaz6YM2T
         8KwaXo6zj9Q25T8WbONiEUxSG/xAkv6i5Fq2dv9fKfp3c1LsKMUnS2uYDCIQfDoHeCbz
         l5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782600479; x=1783205279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0bTyMlPjrEJesPmUmZMuO3nUd1+lewMLRUQO61GhVE=;
        b=chnIcoJU6nfw70AULXNSusBIw5sqdPnwWXGVVtJccQSqxRsDPepsxXix/psEBI0pk7
         cfRgNZWIVrlAYuzsv8lVDyPm0M48LjhG74/Qo03KMLo7MKJTTGlzfetpQrcnnfq79kDs
         ne5WOCL/HiFRSG2YHiQdqv/bI9dGvxeO+AUmnHO9KvhvI6ftxVU4ujtRCCgYlMSMmE+P
         6ld9EsyarUwDSqpS05BWPSgcUFoDowKq7XHwzI42I/66+oUZiYCCPljF+Nd7G04MSBX2
         JphOE7o6HOtWBLVcgabFIi3tSbxODdf7d+wE9dVPx2ezYUnLOwQkMCnEU4QjzZY9ozCb
         Lcnw==
X-Gm-Message-State: AOJu0YyYsYaTX+6SzsLc2cTSscQzZnzS8wrVkDhQds+dLKlBQ+yoc1/N
	EPVci8MfJ6aLPilD5XiPJTtngTuUhC/DJBgWrAKY3HpKC/8ivONcvtgiAvalyduQ+TU=
X-Gm-Gg: AfdE7cmnSNr7htHcPZGDrkUKVkHm7AOSHwXWDqz/hGJT2zNOai4JT3NrTWAg6Kr+fQi
	qh9veJiHeHAsI9IEUo0xTaN19vSdTc8Z6dsGkXlNFmB0zAm7s/RcuXsZpCySnCP/nv+H3e3qp+x
	ifhD7FXytw84loLMRdfM9gi53i6zBMFrSWaW5QiCle+lYAkwq5ueCURwGEqaMCSAQuvwPd8IBr9
	eZzdp4sRjWsw2dhmZELaSoGDG7qoaaLTyaLBx9jkmQrnvr1odSrNJ8ta2wuFD+H02IgEZ25YgMB
	xEj0g66hv8yiIvKI1i4iPiYXwLMc6yGCUgFq9XqNXZ7LwqXGt1nZfuvdjb6vjMcBmYbVIDt3fUs
	gU+TV5KNZWy05Dsmp5Ex+l/6n/ufXNWLP6r7lfpFu5JmZ8pjekLBPrCGgV5IPALcxUHSNPTqRXY
	LD36dgFybyPexzkYYiUzo7Kd0JK7zbAc4/AzL6VWWm+R4tGA9C
X-Received: by 2002:a17:902:ec91:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c7fc37cb4amr102259475ad.0.1782600479022;
        Sat, 27 Jun 2026 15:47:59 -0700 (PDT)
Received: from anon-laptop ([103.147.239.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9e28d8129sm1504435ad.80.2026.06.27.15.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 15:47:58 -0700 (PDT)
From: Wahid7852 <wahidzk0091@gmail.com>
To: linux-input@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	jikos@kernel.org,
	Wahid7852 <wahidzk0091@gmail.com>
Subject: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware
Date: Sun, 28 Jun 2026 04:17:53 +0530
Message-ID: <20260627224753.35075-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ISH firmware versions (observed on Tiger Lake LP, 8086:a0fc,
GUID {33AECD58-B679-4E54-9BD9-A04D34F0C226}) periodically re-send an
unsolicited HOSTIF_DM_ENUM_DEVICES response roughly every 79 seconds.

The current guard collapses two distinct cases into one condition:

  if (!(response_flag) || init_done)  ->  bad packet + ish_hw_reset

This incorrectly treats a valid post-init firmware announcement as a
corrupted packet, triggering an ISH soft-reset and a full ISHTP
re-initialisation cycle on each occurrence (~1100 times per day on
affected hardware).

Split the check: reject messages with no response flag as before, but
simply discard valid ENUM_DEVICES messages that arrive after init is
complete.

Signed-off-by: Wahid <wahidzk0091@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 6d64008f2..ec5e8afe7 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -113,8 +113,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 
 		switch (recv_msg->hdr.command & CMD_MASK) {
 		case HOSTIF_DM_ENUM_DEVICES:
-			if ((!(recv_msg->hdr.command & ~CMD_MASK) ||
-					client_data->init_done)) {
+			if (!(recv_msg->hdr.command & ~CMD_MASK)) {
 				++client_data->bad_recv_cnt;
 				report_bad_packet(hid_ishtp_cl, recv_msg,
 						  cur_pos,
@@ -122,6 +121,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
+			if (client_data->init_done)
+				break;
 			client_data->hid_dev_count = (unsigned int)*payload;
 			if (!client_data->hid_devices)
 				client_data->hid_devices = devm_kcalloc(
-- 
2.54.0

