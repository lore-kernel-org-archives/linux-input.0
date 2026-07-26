Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B734B410
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048632; cv=none; b=Hqs4cLyFRgLsUqz7gadiknCtfntxnHZOG0QY+csTpCbwQ3iqwwxRQ7O2oJ2mTn7HeC0Z6ZzoRW2Gb+gNX0IbMEvYSSNprTyPKo0QZZMvoW1EG4RZ+xZBcUduo/R6jtSu65MoUOqq2mmQasUFh2A4v6KqjhQ8PxiLQcBzV8bYO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048632; c=relaxed/simple;
	bh=cDWpLzDkKE+OR1F5V9sOaFAX1o4taHbt/RG5bvZp3xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NE5xLwWcHeM9dzM7CeAczmE/qPZezOM+0nUuU99IpuPJFWPLnRf+PMWi03fRR8xqShK849rxnrrorYMYCY0JmDIce22q2q0UJIiiFMabhVMNcGvJNqljLs/jpLJXaRy2REJvFFW0l2PopdINhD20xORXY+J6gdN7Wdt9URJiC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=KbyaYqdZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="KbyaYqdZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so21709265ad.1
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785048630; x=1785653430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhTM04DOXiDdofL3yenMY0XdGkR+wDC1veYQUjrGAdE=;
        b=KbyaYqdZ2stwei+BE4wuEKW7/ly3EdHmvTPAPySxX4EfJ0TcPIy5yJ3W9z+oC40C1v
         xWJUeeZoJZgS6HmKmUFOGi1RIKtGzYgKhZj4vD9jICr31GBpKIClumVMs9IdF001dUyp
         opc7bBu6jDzY77JMdjzOsujFsObRs2v2GV7sm0Hjgo6roUJMTE6R50kQ1bUdDX7HKMQT
         rPPtcqg4pDvpCEEPCq8kkferodkiCy++KGuiC7rSvPCxCntmkZbPQrT6Gsbb/PNCCPyn
         p5jusT8mM+dPkuGF9r6fQm1BH1YzGzuDOqzq0BXQZGTJIvtPV1YGutxUfzPcZWljJbOW
         Dcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048630; x=1785653430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhTM04DOXiDdofL3yenMY0XdGkR+wDC1veYQUjrGAdE=;
        b=OipH91B63MG4eCcTxMOkbSJIN+4dlyPn6aX7TvA1sWc6q4A/KaSDhNln87RdpG0/83
         SqRW6X27fuhuubUpdY2dCPsrREB6oJ5hxX06OVOo3IrxBMuR+RKX4Vgt0JyoP+4Ez3ux
         9rE0C97RDp5jOL/DOZpvu2MpDXUvA5+K5d+KDea4b3HqTJm5Ps2B/kb1iWFGViRQByLN
         UMcHCAgzsIdx6/S0ws+GPMBCDl4f38IMeJbIDhDDPRhpqmqCwgWnfSyiyZsdoIfjLR4K
         pv7iAPa0C1LxldcRayVM7fsaywyQJ/uVUiYFIkBzh12g1m80zxuljJSn778UMKkAlNvv
         bm/A==
X-Gm-Message-State: AOJu0Yz6hZPTfJDoIdtzsxNKfz12hz8Knn40TwvKYmDwJZ+n+2A+crJ7
	7JD4TMZeeXxGp2LEJTdeIssAzwMbnlyKZP9NivQaL9sFswRELBH4CapgU8iu1QgaiAtVMmdUIW5
	vgpfTtiY=
X-Gm-Gg: AR+sD12Bo0IqUGsmd0wAgqvujLJyhNTI6iIIAm3GGXAlwf2BiUA2bI8vGBf3WEwpqSd
	6P41Tv2s9d/Tsnkx6cAwfvJ1QakydyF6mPXmP3T4TwaF3LAyRevmh0Dg1Ku6K3VP6JP+LRRbNm+
	TTfHDOyDKtgYEYhtI54ULFG8J60U3FNDzVJ1pB9Iu4JYxYR/5WQ4QWn76K1rib2b/VEbafPr3Hg
	NdxvWw62ZcnZbi0WZVzr4occ+tiR+BJ6FMnR9HFSc7Ff2ClYGdjHCX727R2cUWQ+aPuRgd24BuR
	noFnSvvZ+nQSrLvaUy4QS5S2+7t/BgbzYV1NYOecFiZwIPe8CML4CVNC12cuhjkSMjiZStsBSSD
	Pq6V6ehTUH+tbBnX3mqn0Pn6m7eK2d1dOFvyvjEVK3jJcwy2PeFLZRgsVizFmCYR5y5j/finncV
	jnaaou5zz/ijNnpfzHypn4tNMxpZ8EjC4xUB93WYfGxxY7CGXba3o5AHN+z8jW
X-Received: by 2002:a17:902:c951:b0:2cf:b69a:8f58 with SMTP id d9443c01a7336-2cfde884a9cmr43824255ad.37.1785048630279;
        Sat, 25 Jul 2026 23:50:30 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7eea52sm17331635ad.61.2026.07.25.23.50.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:50:30 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: core: fix OOB read of field->usage in hid_set_field()
Date: Sun, 26 Jul 2026 15:50:24 +0900
Message-ID: <20260726065024.46088-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_set_field() hands field->usage + offset to hid_dump_input() before
the guard that bounds offset:

	hid_dump_input(field->report->device, field->usage + offset, value);

	if (offset >= field->report_count) {
		hid_err(...);
		return -1;
	}

Under CONFIG_DEBUG_FS hid_dump_input() dereferences that pointer, with
buf = hid_resolv_usage(usage->hid, NULL).  The usage[] array is
allocated inline with the hid_field in hid_register_field() and holds
field->maxusage entries, so an offset past it reads off the end of the
kvzalloc()ed allocation and into a neighbouring object.  Had the guard
run first, offset < report_count <= maxusage would already have confined
the pointer to the array.

A caller supplies such an offset today.  picolcd_fb_send_tile()
validates only report->maxfield before issuing
hid_set_field(report->field[0], 11 + i, ...) for i = 0..31, so its
offsets are fixed at 11..42 and are never checked against the bound
field.  When the device registers that field with fewer usages, the
framebuffer deferred-io work drives the read on every tile.  KASAN
reports a 4-byte slab-out-of-bounds read in hid_dump_input() below
hid_set_field(), and the same boot logs "offset (1) exceeds
report_count (1)" from the guard that runs only afterwards.

Move the hid_dump_input() call below the guard.  Because
field->maxusage >= field->report_count, the guard then establishes that
field->usage + offset lies inside the array before it is dereferenced,
for every caller and without changing behaviour on the valid path.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/hid/hid-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f107f5103b35..c3035414109d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1933,13 +1933,14 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 
 	size = field->report_size;
 
-	hid_dump_input(field->report->device, field->usage + offset, value);
-
 	if (offset >= field->report_count) {
 		hid_err(field->report->device, "offset (%d) exceeds report_count (%d)\n",
 				offset, field->report_count);
 		return -1;
 	}
+
+	hid_dump_input(field->report->device, field->usage + offset, value);
+
 	if (field->logical_minimum < 0) {
 		if (value != snto32(s32ton(value, size), size)) {
 			hid_err(field->report->device, "value %d is out of range\n", value);
-- 
2.50.1 (Apple Git-155)

