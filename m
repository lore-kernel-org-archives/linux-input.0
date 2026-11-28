Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863984;
	b=qJvy1wFfcEM9Td3zqSO5w+W0upAatu+JLBxvMqyvxTRTVlpBI0j1wPFNYYIAnkEWRSPY
	 sJJyqQKHgZjQ8AwHCc2GTTdjcvrV9m3Azoj2lU0gXo/LBrIsVMPR0x5TLmb7oht57l8Lu
	 q6po3Ee33p0zVYBSHY9HmseJVh4prUUvxAY8q26ehTATZX0whn7d0Rnf9+ev+nN6NUVMk
	 fM5Zp2vGuoMGYqDMKuQmDv8ike513T/5uC9qEgftfkiWSuz2jQuOgRhPL9ihfbxQc7fm3
	 BQz6/heEGMYrak1NTkbxf2aSK1tEqO1BtzuiLqM1ZYSBS45MRrZrQB+X0/ouoTqEZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vuzWgEZTt/vmNk3O06RvjcsX2Xv/+otg2TVx6cWLcEg=;
	b=xHfvNQYoRb7E5FG6jvaA4ldLOtckSDhAdiah7WT8UNVYQskQjDeNUbngSjY1L/hi0h/f
	 Bl17R3HGFcJkc+J7jOn0OP5Rr8VohdEhrclGpvYQisDZK/scwCWAPm1y+qmsLeDnmKFPp
	 RFmsM3yny0d18fIUk+jWqkghZire9YHjvWWvsBbKg8S2CbdUXB9yIchluIhie/nWh2LqX
	 K3IgJnvX1AnU6J0WWfQIBFzSlnm5HGPWJBvkjmgIce5j0g3RQ48tri0CCD6m7tH3a+l/Y
	 nLkvlfAkiHVStTAxMkpseSbsHrEBMGSM+5FVytuTis6DnKC+YllEN4BArqBrpSOuZRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R0Cy/C4J";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A249606A333
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 11:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A249606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R0Cy/C4J
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385d8a00598so14228435eec.1
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795863983; x=1796468783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vuzWgEZTt/vmNk3O06RvjcsX2Xv/+otg2TVx6cWLcEg=;
        b=R0Cy/C4J+RnRpAmOs/2fep2ZWq42rV/Oqwxx4XB7c892508px5ck8ev3P1mgyCa7P+
         bndsTrIt1ntW1pY3SFqYsF/4D/eCoHMo0ZLk9m8xrJgJDx9YMUhka74k7vods6mwCxYj
         c2JXpg3+ReoAlwsC+XZQfTjZx68fwf4RlmLGovn3cxUQU58YPDPt73WbWwT3o6AKSS+E
         8adoI2anZBAMVbvmlnW2a5OmJh1mLT2pEzqLcyqiUnZ+cbRqBcyQdWB7ceEJG/tBOcfG
         QmxPPMF0aBiV4Swooa0PMBE9w+J8obPs+O9HCiRX9MNvMDzLQk0VCU6DolAfhoThhceE
         QnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795863983; x=1796468783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuzWgEZTt/vmNk3O06RvjcsX2Xv/+otg2TVx6cWLcEg=;
        b=LAV6oD5madY0GdK8lj9TsHYJ87zjG+KtljQvTTHtZWYzho1SgVYdLUnWpo985ajfdK
         RuZXdf9PDToe5Q+4s39ZBSv/7Zv22IauwI+aFCJeq9CR1uqwczghZ9dljO07b37QJamU
         vqTnE9As0ejqyNhUpAPhXiAlag5xO26gwAVDrQW+19lNUR8vFnnSy5/TRd1zQmrPVtwi
         OLJIpjD9FJ0bmvfpwMMQcrwF2FqZw8fCFSfZ46dPLqb9cqkL66baEhTwt8x/4DIe2RzR
         HN01VEEks+Sfgt37ar3CTaXtgmKbL2VBjYTGVjKcj9L4KFSn4eTkDy5WhrIpETyI2pS2
         OqeA==
X-Forwarded-Encrypted: i=1; AL+hErGn3IoEj5eZgzWBUdWECKtKvuqGJxq0v1j5HdaBx6KhkZlWJPpFb+7SfUGm/Iho2q3AOGH97W6dH2x3Dg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CHUq6aPTcsvKCzUc0zaqVZ91SMmUk0oUgj9MydTnuJmbRtpgX
	roGS9UBZ8ldeNkpU3v0srQaZtSUOcJD8T4u1CIDQCg50CVR1gumvJEy2
X-Gm-Gg: AZFdTZeRJpVUoOP9cr2WPILtjc1GFHzmjowUe2VxAMxblb6E8U6UdXWiofrBDhePzxJ
	95cZxlYhUwOI/3qyPZtSXMIxwf75kolsv9uaaElCWMBWrIY51+hmiIzBkiomFOyOV0gOTatzMSZ
	uybvxAGMqNmXRHT3U6xDZLRMZqrudGxvrJDYzCYYaz+9DB6hL40xKq1qis2TO+McCAmasN/TR31
	OSeuLMoxBHySwMinmBGX4M4e4+S+iaUSupit1NHVoYXE5YWrs8J5aCsHMJIvGkBC2DP2U37xtBp
	li+VC7MBD+kDu6VNAhUSr8y48eVQG/wgQoHe2wiliTSNWfXqzLfVfjG3hOBiH2adLDKyzy7huGw
	/ZBCuvnixZOXnyFS2ltB9Y9KXrlPwYqBf5bbcsCK1FzHsBYMPzkyx9B2F+hMd6Kq3s+XbP2mXmH
	LhFvIMdWWu9AsrW57JkLQqz86pOR42BJbrtmBGWSdgv4wyjNRbLD3fchGTU8p7EwwR90jfr6gBj
	5Nni4JoVT2PE9FUMR/3PXlzjlBVWQY53GVTwzzwYSm4+jH3yolO0joAnGbiLuIby5XSQ09X4kB2
	/l1R5SKY4wmIYsE+w93nn4AEnLDxnOf04Y9XsWGYxup1r/OyEIaTweAghGDqkT/05LL8uoTFZuU
	3gyzhCF9J3f0L1gZ6nnMS8eB2m86ZIAQg8KX8+2Kph6h+uoVY+NqKuoyj5R1bWOLk3GSz7thP7s
	dAey5oOFiKwL9oPlSu2gySAUdaS+px58VAwA7c6IVDtCxK1w==
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id 5a478bee46e88-3856f8519ecmr28552530eec.19.1795863983358;
        Sat, 28 Nov 2026 03:06:23 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm40958970eec.17.2026.11.28.03.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:06:22 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Filipe Lains <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: HID: logitech-dj: shared receiver keeps unreferenced HID devices
Date: Sat, 28 Nov 2026 11:04:07 +0000
Message-ID: <20261128110415.772810-5-jinmo44.yang@gmail.com>
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

Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid.
No patch is attached; I am reporting the lifetime issue first and can test
candidate fixes with the standalone reproducer.

Kernel: mainline 7.2.0-ge46c86b19f4b (arm64, KASAN)
File:   drivers/hid/hid-logitech-dj.c
Impact: use-after-free read and NULL/wild pointer dereferences
Repro:  standalone C, approximately 57 seconds

## Report

  BUG: KASAN: slab-use-after-free in __dev_printk
  Read of size 8
   dev_driver_string
   __dev_printk
   hid_err
   logi_dj_recv_switch_to_dj_mode
   logi_dj_probe
   hid_device_probe
   uhid_device_add_worker

The freed object was a struct hid_device allocated by uhid_dev_create2() and
released through hid_device_release() by a different task.

## Analysis

dj_receiver_dev is shared by interfaces whose phys paths have the same
prefix.  It stores raw mouse, keyboard and hidpp hid_device pointers without
taking references.  During concurrent probes, one interface can overwrite a
shared pointer that another interface later latches.

The reproduced order is:

  1. receiver A begins probing;
  2. receiver B overwrites the shared hidpp pointer;
  3. A latches B's hdev and enters switch_to_dj_mode();
  4. A's hid_hw_raw_request blocks waiting for uhid userspace;
  5. B is destroyed and its hid_device is freed;
  6. A's request returns and hid_err() dereferences B's freed hdev.

cancel_work_sync() in B's destruction does not help because the stale pointer
is held by A's worker.  The existing remove path clears current back-pointers
under dj_hdev_list_lock, but that does not protect a pointer already latched
by another probe and held across the blocking raw request.

The shared pointer needs an object reference or exclusion that remains valid
for the complete operation, not only while finding or clearing the receiver
entry.

## Upstream status

Rechecked against mainline, linux-next, HID maintainer branches, and lore
through 2026-11-28.  The defect remains unpatched and I found no matching
submission.
