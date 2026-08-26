Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809A42317C
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750545; cv=none; b=t/jCr55hpjVyjpDoX0RNV2L4Oa7eMHE48v92mEteveJsz1+iKDUQY05F2Bh2wyxiBLpGLtGuoYzXMKV2TcTViC5484c1LY9izt+4tRJvoVn/p8RbT3oez3+dDf1utaDTagslNcgTzHyBphPrm6z8RxsmfuG1lnROmhRFMZpaf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750545; c=relaxed/simple;
	bh=nvrucR+AkADZ4+yG4rq9BJde654t4Sf6aZRf6pLCLLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acHjc38NKxkJZF5YY5OL8ktxgnCrzoBkL+f/G9LRKdLgJI5V2l7urSJqt9EkuZQIayTxDBwnWPlcvQNGfrXIwaLLS+9lQRvuB9qyoKwiNv86/scD4WrkEfhlranc9cIBihZWfZ5JZ1ZrLXTVqgX9WNAjahWLzx+jxlAnpaXrZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1yVas+C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1yVas+C"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so884290a12.0
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787750540; x=1788355340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qvp7s9Z0ISxqdwUp6/xNiXsA+oD1adl5c2ELLa5CjIk=;
        b=S1yVas+CS0t5rZ0AkYJnyS+7W5wq5zQioLEtMhe7e8BT2hic++oIj5MoY2sCOD1ZeB
         SghL4QXySyQEk36nNxbDbl1VksmNFiEXrbnCgKB4vb5++L61jbmbHJg6eZf04WA/Djq2
         tHmVRDtHd/y0srgKlAHqL1ZZGnCTVkGkZuoOmJn6jWghiEl1Op73HEyaXI5KsIo7FlMH
         pxtZbg+P+9TGu8ixTD47flSDzXXkye8Z+RX1QWZxV17EciYhd2u6owFwHHh9SB2//vhY
         9tkBzN0JooxrmO/fP7QKkeaGkUNd7NcxNCJh+koAFdD0NDB2vOQpA1ke9I3Dv4iQN1In
         xaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750540; x=1788355340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qvp7s9Z0ISxqdwUp6/xNiXsA+oD1adl5c2ELLa5CjIk=;
        b=aFc317e2ndHPLAjpWM4V3UFINnPSo5iz/O4jwod95tvVia7pCsqDkh2XLsFY4CNOAb
         ffgTLK/IMWYTk7iMSBq+ALLG6AjNtT/oyMDvCvSf4ouit/skP1mBkYbl03+FM0PhJ3yM
         BRanlouRUkGRGijSq2XqJiPRdrkTfowAXXVtP8Z6KrG5wn5n1fKVEyDQsQfIOG6Q+rzU
         eofBbXGGerVV7SUO0zaUitOMW6U3p7uQLDCdMMoC0RmPlxHiB5Ws5fFX+M8X7sWNfDNf
         YhD0MN9jkZBXYbuBKD1Bn2/ZGqtIeNxsmVB8Qk+VB1FhqFRtTb59xol/eI6oVXajC3q2
         DVAg==
X-Gm-Message-State: AFuF++kMZGttUIjgO7Q1tHi1afxOamqgGpFccAGDZJ3Roy4cHS1Q/l0G
	7xZ356xvh+nlMXlLmthb2lQE+N/veX35grSfWaoSfPUkekjW6VuS/CCd
X-Gm-Gg: AR+sD12In5oH/jvpvrB7z2glNoIso4miOqv9GKnZY4cqemepYtpNuynkrFuIaecADM7
	YBjGkYHM/QYGW4vxAIKJmG+2hNG8RzFdEEwACnM24ZME+JqEoUQaA6qKEkvDWb7Wt5Pt9qwj9Lt
	mLAS51jeaRln3XC7vFPRuV/DXRaQ2Eo0q7VOqnk3jQo0I6GnjJc3XMU13l0PfGJqbRXKL5BeExr
	Z7UUB8YN3mrS9K87EwY0qQ5Zvn6A78sZFD1/+WQtQdQfUkD4sC7cNvyNtpNW7h13vpgtKLGeCJe
	vVBYCNBBFUwSN5h6wBzVnG7ChnUe8C0KHInEoKVgT3kNSgelx8BAb5vpQ8Qb+3bttJwNsbitD6T
	l+Jy0B15ZG5VHvblD1PYBHsxyY4OJSOWjWVOF76oHx9x5RBxREAJ0xRibfXO7WFdcfW/xuHeUtN
	t8StBB66N2AqdohJMIE8+aJq5ME7sAIPM5OspurOb3xhxI+Ui5Z7HiJ1mAVPmU+8xk5hXNMz3Tn
	k7LUUg4lGdx3xAjYAm7MwWfiuhgLKg30YScVRaN1Is=
X-Received: by 2002:a17:906:ee85:b0:c20:fd32:d9f5 with SMTP id a640c23a62f3a-c24e2e41c3dmr1619891466b.13.1787750539767;
        Wed, 26 Aug 2026 06:22:19 -0700 (PDT)
Received: from 1Z10 ([37.163.238.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a72d6dbsm435905466b.24.2026.08.26.06.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:22:19 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: [PATCH 0/2] Input: Add ACPI support needed by Yoga Book DRV2604
Date: Wed, 26 Aug 2026 15:22:09 +0200
Message-ID: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Yoga Book YB1-X91F/L contains two ACPI-enumerated DRV2604
haptic controllers.  ACPI does not describe a controllable vbat supply
or provide a _DSD function mapping for the enable GPIO, so the existing
driver cannot initialize the devices reliably.

Make the vbat regulator optional while preserving the existing behavior
when a supply is described, then map the first ACPI GPIO resource as the
enable line before requesting it.

Tested on a Lenovo Yoga Book YB1-X91L with both controllers probing and
direct per-device force-feedback playback.  A separately posted
platform/x86 series supplies the device mode and waveform properties.

Maurizio Casciano (2):
  Input: drv260x: Make vbat supply optional
  Input: drv260x: Map ACPI enable GPIO

 drivers/input/misc/drv260x.c | 72 ++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 24 deletions(-)


base-commit: 9a29ee801f525bcad71fea021bfe2a030885c8df
-- 
2.53.0
