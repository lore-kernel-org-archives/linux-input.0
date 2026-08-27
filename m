Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485F3DAAA0
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818614; cv=none; b=fs9EXfLqlu4YUf5lkrn0KSz7wId0h8Qy4Fc5Wc1pa4eNx0fjN5sOCI68QeVy/+/010/UuvCvRl5xoVCYcJ1aTg+jzPoGFgUmSBZ11JgRkYN+bEPGildgmAfXouGWDD0x0eNH6enX8oEjrqzlfWymueA3Lzm1lqbwsYnTopD3OaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818614; c=relaxed/simple;
	bh=Wa7EMNtS/SBStCyHa0wWvJVG0R2Xdy1a2EIB8SPizDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlv7y/7o+eGpwHn2zPnNh2chqw5OjJVpJh6XipP5UI3koAKN0zqd2OhpRNzPuEf+JBU2R0FilDwEL5gNSl57AhSCsoFyYeORZsj5JOS6Oakc6vNkl0gEUxSJlU7/kRjgMdQf0Wp+w6ARDSf94q1S1FgevhDcEmRGkfJPwGxvzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKooWkvH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKooWkvH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1360946a91.2
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787818612; x=1788423412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvUOAOKXuBQHrhv/+0psbsiL2fO8oAFnkMuF5lJmkVc=;
        b=mKooWkvHIue0C1aY3KZJijANtpHuFWEfvOY1RPCxRb5myPsWV/cBHu/FnN+jqJU4Nt
         N8ETBSCZKUtNs2lDpiKU/lUZUnrphkST1iAXfMo7sAH1gGc+KkYbTnSQ3hxN9r+hajRM
         3J6dQ+Ut3EbK55WsyyOFWwkS0NrK4A6W6T6s4/keSmpjcQOUtNDK2oz1dvF4LnCxtcWf
         tCNDo1+JsqFgQarJPNXu/0pvJ7JY+Gkdw/KIP/wSyfdKFz6pCi1X/TFTV1ZQhz3ZvlOl
         h6ksG5tCLPVVT0NnLCdSMGF0n9/+O2CnqaKg/8Dm6a8eI/ygZa8t2iM32TRak7wN5puW
         uLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818612; x=1788423412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvUOAOKXuBQHrhv/+0psbsiL2fO8oAFnkMuF5lJmkVc=;
        b=P/yVloOJKWPrg4eNIgBnXSRv1QmwNicNZPx3h4tn8cwtezjDzb1z14L9L0UA3V9JwV
         N9+Z76XUSKXt72n7XDgve9NQ7Gg59V62FpAFLv1VP9T8wf5ry8wBzyQCiqESsoMSYUhm
         kQLZxanqV7y1gYWyifR+L9qZaZflLHifufrjmh8MFkm4GVC7UIheSsx6Bg/87iUfHD2Q
         zWYWnY0asjDZUB8Vndn4ouXi7kmI0yfcwu1xbnWVEwTFejbzMwN/y7KVt7ttCE963BEB
         cqfV5ezfhnXp3Lv3b/X81YxNP/HdUc2MzUUWKAAHs/6qfOMxoQKF2IE8kPZd38RFTQKx
         7Emw==
X-Gm-Message-State: AFuF++mQtZJxcfpvPMTnZ5oGhOBTEPC9wWdF9TTiDkJr6CO522dBFU2e
	ea39oj8T+zpYXjn2P+29vSanbV1eVFeCwYG2NmW0en+ubk3Hx3xb1UXl
X-Gm-Gg: AR+sD13eTTdCyafSRiBfvD1tUGd4dOJHLDAnudQE6rF5aY75ud9x0vh277QCwc/bX14
	DjQhrHGaP6iM2aZzzpDg2kj3YrVg2PEMjkUUD/NECwjtm/FvFAmK2Xa6PLIT8oxPNx1At1ZEtjO
	bTMPjCUhrx9bqsjbdnWyiVXHQpYMIxrXeYoaBHhpqNNhx4H5s0aptCMWNRdkhJzmgDo0AWHy/mu
	+YN3LsD8Pzj9iUHl7L1qAsaLXrBqp1z+lmEiMEMyA/+IJ/V8mpbZtyLRn6CWBVkCL9mqE3eJoPO
	omXXjOvhmyDVkIy59NanvjzCWoDI1YxVJlfpUXF5+SOwb2rDmYU0YwckgwXblXmjL5sqwva+2G8
	DXnfVrBEy89ZYNNxQgM7N8b8jR6hmCFnqgJUrZBtf0Eo6x0gNIWiIS9iHBttnBuFhE6d/z554nO
	7mF5rxpeOFyEAZxOSUQpIXUEpHEf7XL1y7HvngVJ41E2KN02CQFbKTVBj+MQj2AOgxZYpPwBQfM
	fYL
X-Received: by 2002:a17:90b:4a50:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-3966d48c3e9mr24352683a91.14.1787818612187;
        Thu, 27 Aug 2026 01:16:52 -0700 (PDT)
Received: from Default ([2409:40f4:1015:7531:12c9:ad3b:96d3:4379])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm26865924c88.3.2026.08.27.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:16:51 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: KASAN: slab-use-after-free Read in roccat_open
Date: Thu, 27 Aug 2026 13:46:39 +0530
Message-ID: <20260827081639.17185-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a8fd9c8.50659fcc.60cd.000e.GAE@google.com>
References: <6a8fd9c8.50659fcc.60cd.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream 903c1cf6dff9

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 4f15eb951039..505844890ed3 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -236,6 +236,7 @@ static int roccat_release(struct inode *inode, struct file *file)
                        hid_hw_close(device->hid);
                } else {
                        roccat_free_device(device);
+                       devices[minor] = NULL;
                }
        }
 
