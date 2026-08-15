Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F527442
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786796393; cv=none; b=D6fDKcrRSmc7kZEo15Tlzv9JDfTXOOrW3JSnu79Sg6o7Yd0pKTIOU3cAVsxxhgubbOlGywgX8o6dwC7y+ay8qVB3qNVduv3JAssOCdtH1bjISNBrPsXwP6ytn/ShqorvpR1YwUZuK54jihf4HTRVa0oXnJ5/TvOZoww5bLdYvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786796393; c=relaxed/simple;
	bh=7i+/3TcBf6avYUiAp4t6U4j/bmQDZJteti4icqAN1sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSyeuiw3uydn7cR3fE6HkrOrWDbmVLmZ85lJkSpAk/mkxfllcokBHGUZBTFHfC29k6V6Er7Jzir0l9dwwigUU4pUnb/KXiyE4zgKXjaOYvOO7+DODKpI78e0BDCZku+YLCXYJEwIx9XV1liNAcZ93hkgT+LhLjCGvJZXGa70baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWzhidFL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWzhidFL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc61541f8cso37036835ad.0
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786796392; x=1787401192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYKiND/4yRTYGLH8sZB7cPGenJ7H4gCyioObMoQH0I0=;
        b=kWzhidFLmMgaDCGcDG1JUonkBoxggbfivZFkgumycA2MHtvsdUC+vx/T38QZMBDVrv
         Kww3tEBcA1tWA6hnpIw17E3BKUrx4RmmwXP5UorFHKhYIFkCuzXK3BZqK8tGGWnGjjTt
         /VRNaaPmYsBie9Sacvj6KVbIbCX6xy7KYAdF48q0S2bgf51CwD/R/iQcK6ahtnuMKL6n
         amUnh6Q0IDKXVJoTHPqLFbVcUn7+9Wy7ElE2V31fwapg9zX8CHbtOlpiGlCdjY7ENsO0
         kEoHZDvNtrH8LTs/SKAGg9edwlwoQ2lbz1DE1n6EaoXmJcXv4kSVCeaW1IPcsjMdHJ/B
         zweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786796392; x=1787401192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYKiND/4yRTYGLH8sZB7cPGenJ7H4gCyioObMoQH0I0=;
        b=QpXw+q1Gd+2OEBjW9uDzWjeWIJ7UHz9DPjwcN2w3Zr+P38Pc5KPPe9X6yfczL6kPzq
         ivDvpImYvRc3DBRpRKz5z1dZ+uZSYSjqOP2luQQFGzN8MQtcPJFUeGnxNTIHjFSbl3QC
         OLR5Z5UrTXleN9pj7UUK/NqSX56TvpuHhHnx4brhuNNDSPahz6+uXefG0sxKcUF9xIIT
         4qYUMBOKe0VMk6as1+s4ApBU1VW7/7Q/qeQrO/HHl5fi709o5lndhF+/8CyxcFFdluI7
         OLWjfjlT2PTWEb/Ii+VQ5wRndubn9WXU3j/m2YkafdqHxTgiWdp5Gn60/uDETPF5Igwx
         GZcw==
X-Forwarded-Encrypted: i=1; AHgh+RqaW8tF/w64UQB145B3I8it+7SA8wn2QVeUmBeebmcVesItW16YyB+1NOec5LhO7d3gCCk1GyRLbrS4+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0UHKjWF7Tu9S9VKlavUXrv6Otb6KT3BfyNJs27s4ppRJEvbat
	Vi6+9big8NFJouoRNvIie1VZ5l68f0/SVTRu24dkj6X5oQPWGL358Ydc
X-Gm-Gg: AR+sD10gaFyyy47ZeFACNV/nm+NndTHzmm73056enfVrb5IRE0Pjq5WoSU+iL9X6vQX
	DfwtSMTj1LPnpgHS9GvDM0/9SwcsgxuDloaT4Dm+uXpx9gB2M2lwp3u2fdSiTV4Um8cJ916PnKG
	Z+n7qVzPGZisc+DvprkIV0p1rpCFTtmNz/L5sgc5xb23c6f+YNiDxNuTioyo67/0np6xpvVtLcc
	QtCsLXnc7skRlsWD2PVQGPf9rz/SQ5L3VmatnKKUKg0fMDT4kAb3stqiOFkmIXRt2S7z5TZW76H
	5rEoRaouSq9bEmEOu4QjhDYGWJMlW+dE3LhaA50CJ6dFPRzTyDaitwU41PkZXNXO3OOz/1V4n+P
	p28skdMZZ9C3HXMqBkIAfiwDolKUhuFjvu0RQ1UEcANa9w1zQdTmxURMuYWyBVbLqi5kwjtWI/e
	koVSHoat2jXEHgPb23RDfEt8m5/m4lTCEVNaNH/oOiSLmVwRjHfMnWy61kzcyjTGuKoFGiP0lmR
	CvS1237Lhy3VltYxW0jTZ8UwQ==
X-Received: by 2002:a17:903:1a0d:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d37f7b7ca7mr220930955ad.13.1786796391866;
        Sat, 15 Aug 2026 05:19:51 -0700 (PDT)
Received: from jets-psd.. ([2401:4900:c309:67d5:3081:64c9:1433:3be0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320c6be7f6fsm16961474eec.0.2026.08.15.05.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 05:19:51 -0700 (PDT)
From: Preetam Sundar Das <daspreetam4@gmail.com>
To: basavaraj.natikar@amd.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: sandeep.singh@amd.com,
	Nehal-bakulchandra.Shah@amd.com,
	skhan@linuxfoundation.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Preetam Sundar Das <daspreetam4@gmail.com>,
	syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com
Subject: [PATCH] HID: amd_sfh: Validate BAR 2 as memory-mapped I/O in probe
Date: Sat, 15 Aug 2026 17:49:38 +0530
Message-ID: <20260815121938.1337631-1-daspreetam4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a page fault in amd_mp2_pci_probe(). The fuzzer creates
a malicious PCI device where BAR 2 is defined as an I/O port rather
than a memory-mapped I/O (MMIO) region.

The driver previously assumed BAR 2 would always be MMIO and blindly
passed the I/O port address to readl(), causing a fatal page fault
when the CPU attempted to read from restricted memory.

Fix this by explicitly checking the PCI resource flags after waking
the device. If BAR 2 is not an IORESOURCE_MEM region, safely reject
the device with -EINVAL to prevent the panic.

Fixes: 4f567b9f8141 ("SFH: PCIe driver to add support of AMD sensor fusion hub")
Reported-by: syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=227a9acbe565367eb7a1277b47115df8706d9a12

Signed-off-by: Preetam Sundar Das <daspreetam4@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b81cebdc335..aef105a81570 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -451,6 +451,9 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (rc)
 		return rc;
 
+	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM))
+		return -EINVAL;
+
 	rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
 	if (rc)
 		return rc;
-- 
2.43.0

