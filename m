Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633672;
	b=MLCmyESic1+Emw+as2LUNGWqzLcEn4r0qAQFIHvMtd5OhEUGNIMdCBkec1a9GQojcjuc
	 HAbNNuqvCJieVByNn0QeWnGMqZKgNQfVlh4C8n+tS1gqAf0APEHiTAnV11hgw2PClSDRq
	 yqazCvAQZU51H2ky3XEFUAkYld9T27H1kgPnZQbVMvBVPH6AKnOf6O7R6VuXTVFb686wH
	 2KSaF8ojCbFFC7FNpLiMmCRMgJY++DNb9UBWLkv/y83SjsXk5jkpFtVYZK/8S4jQ2V6OP
	 bTXGKkvjcbh9moXvLXY1ugNh8a034pifBmbQT9b7c/fKdutzsPQY+Hsc9C0K641o8yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z7oO1+idE1YuSoFAPc2/i5u2CikChDsikplJrvQUM+4=;
	b=Fz7gALLN8ZJ5ob3Y40IXtRvlfDCbkBupbDgt/KCa/lKpQ2quKEUKekjtPHik0sWDiRMt
	 +24OsPZfAqAY8ICAg2Jh0blvnBJIaQdImws/4N9G5uT7B3JwKuQYf00FpYY1hMqV6N3K7
	 /Tvmw1GmDBySZIy68Wk38vITjSZXzO5oYqNtQGZbdqzITSj2aQDjCOfP28pBuO9ynYUAp
	 jWGmbtArCV3iaalt8Y7dFAscPWo9oIYwrtMRMtdAN/d5PIBqXLuVIEFOx+QMsOgVQOieC
	 HeIkfSvnr0v/OmKKE5zE+pThc671j4IsZTS1TP2Oyf8G2f+EJNEVH3wmLckVdl4IOvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IPZENFQ8;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB52606A334
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 19:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB52606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IPZENFQ8
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b5786e099cso4572654c88.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633671; x=1796238471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7oO1+idE1YuSoFAPc2/i5u2CikChDsikplJrvQUM+4=;
        b=IPZENFQ8+nUfUPdU5/BAlejZdB21DpJJ9TBHmw1H3RyPgU9CH7UK7dfJp17y4rm6sb
         oQhEgNUkXKkhqklAF48CSxETEkYxf9IuenME0V1c1IsGwsJlRdAs6NumOPv16JHLJoRg
         8uwj8QmzErb6jz4NYbIZAPZSIgwgIFXy7iWuwQNS3ZabBlnkyzOWzouuw8DVkkfW+6tq
         5g0yos4Ioz7P/mJqFaHMOs6QOl0rEeSTKS9vY7ZBZarPDkfBzIeoJiAAfBJOeNYBd50a
         BGQfoDsEE8y2rGY81xZKBt+KDUpvDCH1FW4rLjH3IviTzt0DCXRY0TKYp6s636IW2JcO
         ni+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633671; x=1796238471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7oO1+idE1YuSoFAPc2/i5u2CikChDsikplJrvQUM+4=;
        b=pSMiNic8eYJiljHHX2pKUiCzJVFWg81koYRKvws+5W5qwDOe5bLtntckPdaMYC5CGf
         e89p3MBBgYkPI7I2J7YXkyNldawrg0rS2Fb5EJbdNqZRxKzGvOF4+6oWo38q1nibloDh
         cf4lC7bvceNLCmARn/qGf6PttJKU16Vc6CwjlDbb1wUg9YMHfRBVwIGRZ1fwo1DxyINF
         6HCyZQNv3z4gPKynfd0eATmWjfAljuy3CRNKYAsfnMbi7gCJs+iNeoVmG6dDl/onZ30U
         KM3LXFc4sRsLzXdTT9AJxMJKA22HAnPaGkbN/i4v4kaKkup+4JM0cuCfjz/i8CpWdxbN
         2BcQ==
X-Forwarded-Encrypted: i=1; AL+hErEYDfYc2cJ/xqRF5T4E6R31YenuZiiH/OgpDcpByq/ueQ19PZwwsVqWRxB050Z4muILIWGZUn+CS2uxsg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9LC2QdvXw6qUOINbn1do7qvpAewO60w7Z5+sgVS+XCjKJ1GJNV
	xA0OaFgbhuZl5b2+ysNiVWU29BuTg35LJZX0BKuS/UmJTlqEyBaMq3om
X-Gm-Gg: AZFdTZd+uEAtNtwuPxW2HA/ssTBs6hsk57kZeo8CNh1iPKUd5Z891BrrI9rG/Hj24vW
	LweOEF+jbGQlNAv58+dON5ssIy9VFo5kLhhNGseLLPbRBKGkdq2BV9WajV080swhpgAcZnwLs8f
	nTK2SJeqvE/pnhoTWZrLCleRH0Bti30iuoMAPm7+TKGFCifBwr5jUPbctF3umDNgeEbo7d9vOPC
	ybIq+q3qCbKEHmL9X3cfruz/kW4rV2QUam+2aIWwZRZoewJCRG89zpTnI2ePIXshSGo2NzqGc/I
	rdFZKHG92ybFT1kFgzhlLvs9EUKajIOgOS4bevTJwdIOLq309M2dkXm+Zak6s6W1YP9Agfb9R7O
	tpn9KDmKhpjN4ClP53jf0WQ5kgkSmbiujtRtT5o0w+8cOc64z8T6l90p/5zfDQmlU5ncvJEORwk
	xkvwAZH1RPTgq500kXiv2/Dr9XMwEWvYsG/DuDoonRUI/mC/AXAF5D2ZuHuyaqp7O6rMudHVrkr
	fA03h0HpRYXCuX6ekajevUvvyIGPguUcnDu8Jz/D5ge7ovl/ieARathu/Kt8tXcRh7JpbiDgx5P
	cJeZDCjl65EvQiIEH9+D
X-Received: by 2002:a05:7023:a8b:b0:1b0:430d:d81c with SMTP id a92af1059eb24-1b5568feb77mr18978686c88.25.1795633671181;
        Wed, 25 Nov 2026 11:07:51 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm42584510c88.2.2026.11.25.11.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:07:50 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 3/3] docs: ABI: mlxreg-io: Drop the second shutdown_unlock entry
Date: Wed, 25 Nov 2026 19:07:42 +0000
Message-ID: <20261125190742.2420486-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125190742.2420486-1-takano32@gmail.com>
References: <20261125190742.2420486-1-takano32@gmail.com>
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

Commit 4e29dd3821df ("Documentation/ABI: Add new attribute for
mlxreg-io sysfs interfaces") added shutdown_unlock as a new attribute,
but sysfs-driver-mlxreg-io already described it in the October 2021
block.  The tree ended up with two entries for the same file, and with
two different defaults: the older one says "Default is 1", the newer
one says "Default value is 0".

Keep the entry that came first, which documents the behaviour in full
and carries the kernel version the attribute appeared in, and drop the
later copy.

Verification: get_abi.py --dir Documentation/ABI validate no longer
reports shutdown_unlock twice.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index f59461111221..00cff8965b22 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -741,18 +741,6 @@ Description:	This file, when set 1, indicates that access to protected
 
 		The file is read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/shutdown_unlock
-Date:		May 2025
-KernelVersion:	6.16
-Contact:	Vadim Pasternak <vadimp@nvidia.com>
-Description:	When ASICs are getting overheated, system protection
-		hardware mechanism enforces system reboot. After system
-		reboot ASICs come up in locked state. To unlock ASICs,
-		this file should be written 1
-		Default value is 0.
-
-		The file is read/write.
-
 What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/*-00**/mlxreg-io.*/hwmon/hwmon*/boot_progress
 Date:		May 2025
 KernelVersion:	6.16
-- 
2.53.0

