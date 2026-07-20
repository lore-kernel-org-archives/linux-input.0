Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A444998F
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570260; cv=none; b=ar8VL6+KuZI4jvL1PloxKI3KEN5Ha4mvnbcvflnyIhOYaQKLKiI/+KkzP4FSE5w80aKFgG2E9CleOaQOGmpf/dEYa5A5/J0bwEaRL9X/cVWv7e0S3u+vVztQH0hHzMXLDW3Iaejl05hA32XiMnrXYEddt3TUyc2JpzBEB26Wq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570260; c=relaxed/simple;
	bh=igEn42t4u12XoZyyxHoRRF8SirfiyUXGvMTBCAYh0i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAx+qNC2y+EyVw8a8qlwPpqPSQ8Kr3QrNwkpn1gl1DujVJQrJmSpv83/95ql4zW8GkffCv2WDW1xX0CF1GIKVxYsx1wMnyeT8GAQzDcJiwR/Mke/fpPLFvhsAe/pfhZ5ZAOdInkOKHbL1zo+m9FM/6Q6D4RHq2k3dL/Ph/aZGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjS3lZLH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjS3lZLH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso48631905ad.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784570257; x=1785175057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sf4KgT9VFB2e+kDyHcLEWPDoBriHI7/J1wTDSaYbA6M=;
        b=QjS3lZLHsBy3xohDRJlQpB/EKOqO4ftuHOlAMce2ANh51Ke0jxwEGyexI3c+NSxVR3
         4RBr41SHK/5QHAd1S+NslIwgF8pQQ4tTggFysEbvOHLkYxNVASsLXB16/RAiMQfSDf66
         57aH05tz7+evoRZmsZjyDsXSJm9FY+MFQp3yyplakrupCTGlRpPbOw9FemAnZhJCCnf8
         c8lbSrSMDpKy5jtCraQ+byDPdCZbRLE7WGecZyqXJ1/7x8gFP1wxVMqqmuLQeT2EmDl8
         oMQ/LQsDUyeNOlx+O3WSlIsLSGqSufUkvggJuggCYJZkwojCmqXTF6gcvIcbfgUbb4z1
         hVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570257; x=1785175057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sf4KgT9VFB2e+kDyHcLEWPDoBriHI7/J1wTDSaYbA6M=;
        b=ap/PtStl6oFl+NHTYwod4k0p50JNDaNsqEg8icyydx8mPPUo44BCIKtZpPvJf7I76j
         UbFsh49OGMI2LfLakujlNy0PxDUwfXkTBmnkFzlXzuImMAD6iWPAp/1n72jYg8SZ4RBU
         5SbKeuRe2iPrO3CgGa9fMZR5E7RQxi1l7XVpD3YoavoXbQcRLXRdvwwdN1qrtogM/AzB
         Rs/NlKx6Cl0r114WlhVnY6DJ7CJfAjUNztPqQfFtAydY6QRT3YXkvv9ROU4JLS9D8BPC
         c0WTtOxx9iFZQofDP3QPDYR2oDXbQSi809iPB4EJtkkgobwTlU6wmJ/rCqqQEMjZLVbw
         S7qg==
X-Gm-Message-State: AOJu0YwrM6CNZPgjV14xkmTGD4Z5c6VVDdZNuZsgozL57uj8uE2v6eMV
	oBxo9tQDM9nSsPNZYQQyRiQBnpl5xDCLT7zsREOa50d2N4MXrUlwvdGQWTeoNwn+mJqRPLUf
X-Gm-Gg: AR+sD10C4/RUt9rc4kYumHUlBIx0LdS++A+coKku/pYxQdOAlNotN5+e8PzH4gwLjMF
	fMWisvpTqghAa+MSnzvbzKVnG9wC7dzd5FYxFI201kbIAwLqzt0LPW9urxxsMUfzVCQoVOrlcl2
	wZ5KxGLPAXMWQOtEa+U5/zTXHRamdjtaoB5TINBKWPwSRWUDYJB6tAIAnbTZtff3eUQKNRuuPs4
	bbbOEulH20TYllD4l/dHPsEXTtkmgLe77rZuB9z2Js/UxZt32QsQjQBPP71jOrXRZV64Su8vEvg
	9N2JodTQNwb4V17nPGNyRCwnRmvftwjWt1ZFpXw46CqvoWTep9a0POxnSS09q9O+3aX2PD7Y04S
	TQIVcq3+Vi0vkqkH1ivXWpzbYn+eARkkzn9mtHUmFN40Mfk8knXNHiNkqHnSj6Ql4m3GRcPlr5P
	bbfyqI/mPT5WMBqJ3v706adP1PAYsZ/jpmSj5RqA==
X-Received: by 2002:a17:903:2ac6:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2cf1f2e71eamr211624465ad.11.1784570256871;
        Mon, 20 Jul 2026 10:57:36 -0700 (PDT)
Received: from anon-laptop ([103.147.239.155])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbaf6sm34943797eec.17.2026.07.20.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:57:36 -0700 (PDT)
From: Wahid7852 <wahidzk0091@gmail.com>
To: linux-input@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	jikos@kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Wahid Khan <wahidzk0091@gmail.com>
Subject: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware
Date: Mon, 20 Jul 2026 23:26:56 +0530
Message-ID: <20260720175656.559351-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260627224753.35075-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wahid Khan <wahidzk0091@gmail.com>

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

Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
v2: added proper sign off

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
