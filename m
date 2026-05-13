Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F24C9010
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689976; cv=none; b=DP/k4eFd5RKxk9nxVsRQWtzlUml7yCY4qOaEyMunk/S+ZNXnLWLsnpzsNapCbeg2raqVgRLkEOXc1WK/h15dvQhTR2gmlKEWRzuI9MMNN3Ru/S9pHyZys9asfeS2XYTe3Y9u/iSs8UxTp4w8ORkmSG09crYvKgcIa0phfaekFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689976; c=relaxed/simple;
	bh=ajvzT3FAJABP6lnU7t27s0cl34JEfwHPD9klcrKUD0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP0JZ0MKBh0uO9+QadCvfvVvGntJ5Hlh4hq1zPEHOZOQ6Gwkg/QVLvKMYwsAABtdyVghs7T65hztFsWBlFI9LuDNxB52h5r3RA5vPg68p+HDXfnRE7oirvBcqehEiRbBwzy4neDy4anXhGR99JR3BJ34N7t36SHpqwK+eamUBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUWKIAGA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUWKIAGA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so117553465e9.2
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689974; x=1779294774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lCs7KvKBdu6w6gmhm5f5iVTLTQ1eSZ/20K9FMIpChA=;
        b=nUWKIAGAYP2X3xQWLVeWup/nEp8UALAUFy98wusCsHy11JXLzHD+0Zc/g9MNO7n/Da
         bZaEi+wJKbqGOYBVFPLmhvXJ5blEm935/Jvgd1xzO2iknqW+v+EoQSqI9IBM/xpUcAed
         +xv1MkPweTRBR7GyDy5lQqNRc1sPrPm9Uv5zdirSF7v7x4itMMokNJfoO8Ih7k6x4cRH
         Ky24a8DqvnTKpX1gIHV/4CT2wTubuvF99gJ6d5mcP9/4yie//D5/f06xPS5yd4kqPVjA
         R2KPOi4CqeisDWJG5GjxbXtd03+B+GvZW7HrLUZfg73r3pNkRsZCF+Z65Q92IuvKgkEA
         rDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689974; x=1779294774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5lCs7KvKBdu6w6gmhm5f5iVTLTQ1eSZ/20K9FMIpChA=;
        b=j1mCfyjJYLqWSGWE20uN5WXHYgk8S1g74MiSxKI9UryVBtmyosMP49oPw8CE7XCkTO
         GynnNuSzxl12bU598brnD8GRF53IxtoTBDslp1hIIOMrdCvu/qSN2abzgd/D07wxXvb9
         Td1Fj8sUBBbfqXTdjIYCKfXRZF5bzlydLx0uFhQ7k45yxDPnYvnRAKZrVuihNdGJlfMf
         8mXfyYmlEa1xJjcqwFp/gA8HMikwPORTn7WGxy6GrPk543gF9ge19oQDXD5WDk/uZMKF
         gXm5+HuRzQHexmdC58B5YW8I9X9hNNfv7caKqqbM080ELfeklk81or2Y14+9s32otykH
         Mwig==
X-Forwarded-Encrypted: i=1; AFNElJ9o+sxBk4NJ8INoIdrL4fMPASA7xz56r8z4isZ1XKq9CuFy+RHdfli0xKuGJswElZdm053TVz7Ru3Ha4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4GIe7/ivccbq5oYUHkWtF7uB9zZ3I1wUXrv7Q+Mq4jTepmH2O
	kDPEAEo7QpdUY0Q5cLlm47R9pBd2YpbqV5CZQs0MxT8wFFcqfH35LSXm
X-Gm-Gg: Acq92OHoLFPJTsWlHHfmIsm0S0wgwzF8TaN8J19LxicDlZXzK4c3oMTcyLREweIq3pT
	9iT9zo/PhZTZAek8hiU4jS0aNMiXfJvr6ID4j6exKesnw9Sm0t1jzd7CGyzvwA+zluzFQX38E9c
	C1ize9hiY6u6Nv9LCiTy/6xtpTUzmDzlY3dGfCfO0VyZ+f8HlLojUbvXjEie6k4D2lUYW7YPc9T
	xcbu0vcWToQ36szVqIWOZgBDL6gE4ZyfTT372h9O2qT73qnqhv6d8rugftV/Qm4xivDiCEZ8lEd
	JAgQlMwerFl3XqVIeAqW6pIjv7LbtNPJyOQnAPdzURRvLPK6u+35y5lwKig7uLdukHmnbBa4a/t
	aWWJD+Yda2M2p3lCPsl/tZIrfRNDNcVg9iU5YswHE8q6/MhA+zdTrLl733ERcJxZddfJ8XBvjwt
	CZ21sAdh6n4p8TdAcjIEoCmyWZ6H6BPDEuirGblzJ8lZtfZwG5V9seOgl3DELzchMZCI+Wq5hY3
	ak6qNwVk9GaFQiIAG2yhxekU+jB
X-Received: by 2002:a05:600c:474a:b0:48e:6db3:ff3a with SMTP id 5b1f17b1804b1-48fce9ef211mr54399785e9.16.1778689973756;
        Wed, 13 May 2026 09:32:53 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm47492f8f.9.2026.05.13.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:53 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 3/7] hid-asus: Add report descriptor fixup offsets for UX8406MA USB keyboard
Date: Wed, 13 May 2026 18:32:44 +0200
Message-ID: <20260513163248.16483-4-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index cba638b19465f..2a88ce695489d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1410,8 +1410,13 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rsize_orig = 306;
 			offs = 291;
 		} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
-			rsize_orig = 257;
-			offs = 176;
+			if (hid_is_usb(hdev)) {
+				rsize_orig = 90;
+				offs = 66;
+			} else /* Bluetooth */ {
+				rsize_orig = 257;
+				offs = 176;
+			}
 		}
 
 		/*
-- 
2.53.0

