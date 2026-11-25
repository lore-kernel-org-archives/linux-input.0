Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625261;
	b=XRV9x0IzDhKLpiQc43so/8C1d+dLdwUXB5jeZgzMMyZYybctGIA4b9YsHdBWjFSfASrg
	 2EQEFK6BD59l3STNEhzvwPe9L3fPh+aruyZB9nDRY+ga8a1XofZOuXkS1OrUKM9QsbiZo
	 Cz6bRTw6xAx2Bv63qlDoLMxbwnLoQvm6kKjc2gWi+6akgg+2ejY1tjVZjXIOeZ2tgBohF
	 7tZmlYoVoynS9otB0XwO9tOFT+qMwmV8r20EIT3gXfwmSmmWINkvRU6ntQAgzexijyRFI
	 0v163nGHt0UH9gWnfY3khky92ksiFquhQnxGH38ufk9Zcj0I73EuCYAUw+YEyg+2S2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
	b=E3tclYCj1k4S4PaiGV9w0XipaT2Pbjzudvx9Px+dbjPyjGO/Nb/xYsFEcfax06PdwS51
	 1RWRuh2BLY49hIJ/2mzf2I4pfi91UDBxJJkoqj65RoFNYjHpeRt1dqlIcKnLrF/Pb5r0A
	 PLVBtemjNiWDv7hjj6sopE3GeEeaUmmR6uR/ckYmUMsdzfXryapraI/vlAeSsJXNyjpWc
	 NR7+Ezr3HGiHTIqXrxXxgjYO7/etp26K0NLqWJrVbUez8Y3fKkxMibeVuC6UpCXULxnL8
	 1uuvM5ncjotcooUpKCEXD71Sm/T5/2k/aRt0yRGSTw8nLUvCKRHQZ1A8bsxvRQf87fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB4+0FqZ;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212F606A326
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 16:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E212F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB4+0FqZ
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f04bea9a93so53039145ad.3
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625260; x=1796230060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
        b=rB4+0FqZ1CZz21tsa67voyk2x6NXgq81CuBWayyF4UYmvBgatYBVaNcj/3ozmZ/iiM
         Da08/9XHKbYf1SubiB0vnwwEfpk0cUM6dbMszpNggH1KM4iTht9Y2Qycao7aHdIFLIKO
         weAIxXq1I4sRGtOJxXW6XFU1Pw5oqUyb1tCMu+Ks6RdklZBC+nzotf/WNkFKsIIP6tuW
         OPAGrBEDHx/2Gu/lquPrKXhMrcQ7fanP0jl1JoF0T7kOJ1o6zExCytCUu+WanrH6GsCi
         z2AxidbqRuqhFKtm8Q1IWm3dnCt8cAQGcfSJx5r2wEdC1HmXbDPeSnpuFWgG1WWF2lCb
         e18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625260; x=1796230060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1C78Uc1W59p66k/nD/Zj6PrIT29VxqTwRjxHQ+aiV4=;
        b=YYSMNOUz+xsa/TQc/u6+86K8R5NPHX8kP5MPWRPsxmTI/1TdPbKXYYlclBxnn862Dc
         cx2Yd0lKTaRgvcB76u8JP3R+YkF7qRMqgtt0eErP7HH20At+aVAGXqCtyDBuyTKnew8D
         PEDWICovzsGmHGlqIG7Sr+YYcQsPFBtk0lqlxf6RU2nhY2HxIWt7L3tJqmnEW01kaM/j
         dWqFoElbpzzvkX4lVLZVSKsaI7EBvhEwHK6hXy3fWKPAZB3rJ02RQfylBuruYi2m9qVl
         jtDQc9DIpyFZ4pLBJ7nfIo6xC/Fm+YiOBTOrWt/7lzzZbNSrP3vrDP2BHCXO/b/m/Rmn
         rGiQ==
X-Gm-Message-State: APuU4Z8ImpCVKGsAV547RSeLGEXq5iYf8O1KiwzTHx9G19Ng04ZaYJfN
	xonFW3IOM+wJJAU28r4Z+9RBdpzJMsYwM2x9Y8g4vf0wgRnLXwZ7u6CO9zS/yA==
X-Gm-Gg: AZFdTZd8AIqUdh78b7acET3wo1zllgKLI9Ge1zXBp3eNC4TenpjaleLxFr4rit57Of6
	AFxLhrRGA58X8hYlNT7MI3aKkoSVg2a2faiY2rzXmsEN2DNCWzQRnjM705vhfaelYHfe+3oz5ep
	mACyVLl6vRdrM1KdtF81YivZMXRvOPjbvhq3Bu1LGorK09lzTlfAaTRhqq6LDS1sfWfZZiJMZds
	8YomL5s0ik/8xZIFLgbCT6+YY8wSB64RqFK16nOVd191X4dZw2qbepMovRmyBDYPxCEJOOSkPVl
	wiHpZw1Ya+ILbVwQgMUdgUJQm1Rvx/GcDa9ssFEYfc/T0/BiF+HR88IkRkIRBBHnHJ1zNOWsSwA
	9IMw21uVCLSPMKqiBgbHlT+nZGbLbGcqSh/EPSZNU2mZADHriUL6SAk/VMm5kuYhjPbxXhYSRjn
	rp2/RufMm66g0EMwTLgns4FAK5h0b7md6O3ziu5K9tCx4IH+lA3RnfnZBg1KxaxC7AZ1q+5pMJ+
	Dk4ytK75CVdGtG4nvyqkWv7pC00AOkSbf6IyUQHaDmoXmarCmLnlI45ZZNwc9K74HHcaiSaMiY+
	ZoMAKe9eK6MWmiAIznWGwHlChu8a1y6crm64Eb+k+/hvGvWArmcpCoFbi8kqpd08
X-Received: by 2002:a17:902:ce85:b0:2f0:3e44:4761 with SMTP id d9443c01a7336-2f03f25e801mr192769945ad.54.1795625260030;
        Wed, 25 Nov 2026 08:47:40 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm89876535ad.28.2026.11.25.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:47:39 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Shen Yongchao <grayhat@foxmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: bpf: fix use-after-free in hid_bpf_reg()
Date: Wed, 25 Nov 2026 16:47:18 +0000
Message-ID: <20261125164728.24914-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

hid_bpf_reg() keeps the reference from hid_get_device() in ops->hdev
and adds ops to prog_list. After prog_list_lock is dropped, a concurrent
hid_destroy_device() can put that reference and free the device. With
hid_rdesc_fixup set, hid_bpf_reconnect() then runs on a freed device:

  BUG: KASAN: use-after-free in device_reprobe+0x111/0x1c0
  Call Trace:
   device_reprobe+0x111/0x1c0
   hid_bpf_reg+0x3ce/0x420
   bpf_struct_ops_link_create+0x39b/0x4e0
   __sys_bpf+0xaca/0xc30

Hold an extra device reference until hid_bpf_reg() returns.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index c90b68956cb3..e2512bd6e6b2 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -198,6 +198,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 		return PTR_ERR(hdev);
 
 	ops->hdev = hdev;
+	get_device(&hdev->dev);
 
 	mutex_lock(&hdev->bpf.prog_list_lock);
 
@@ -239,6 +240,7 @@ static int hid_bpf_reg(void *kdata, struct bpf_link *link)
 		hid_bpf_reconnect(hdev);
 	}
 
+	put_device(&hdev->dev);
 	return err;
 }
 
-- 
2.56.1

