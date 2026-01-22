Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CD35B65F
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097331; cv=none; b=WwSZ1D7s3/JT8By8sYkOhcRA6WY3YwPl94dnPtlGtsd57tItrkeBFus7nr3lnDy81jEylgzm+c3aiXPfaquvdiQWI9U1j4sMmH9Irtmz5NNh0BF3BX/rGkB4V8KjJbNYQuiUaiCd4a3C6B3TE1AfW5A73g+760tNLS/oFq+z9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097331; c=relaxed/simple;
	bh=V5b8HegB8GRX/lAVl+vWtZpAiWhKdfd1I/+Cxli1x/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbkquxAn1Qd1GxFb2IUytweCoix6SRpbDkArcsyJCL5kSMyP75henMUtB+W5Ci/ITcCL5P5MQR+7DOKDm7v6PgMtTjOyIAmdTlxlcbr7lsPzfPc09JbYH6WdFUPxLd4xuD9JS1oGd/LZhMdIeHKcl2KHnwv4A3zMLYV/cs//JJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br7FI+Z/; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br7FI+Z/"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b714f30461so1039055eec.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097323; x=1769702123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT7sxUlCTKBw+bxvJar1XKrjKbpL37hYJb8bo9j5S5g=;
        b=Br7FI+Z/RvxaX4t2XCZthxCvicYRTqC8KliAR2khFB9LAapxggZUTiyREzzFL3AHOh
         n9TCgAnr0VSLmZoJJkstjmjkB2/ZoMlwP2v4z7z8ib1v2w1EsuQKCuB7d2EAtsUTJMgQ
         h8uxgitbSqb28MuhMdyXIaB7whECT/EFDvws0cyqN6UvWCR8LzE2abIgBDpKuLtLp/0s
         lfE2hSCzpVTMBzM8LK7jFSLpoT5EA1FmOxxO9P6aYrAAlzo5IGV+j6CsvWSLM3pjNOj1
         zjf4h3uEC16heozXI8hq945rXIxaasheBVIUgg9AXfCKRPfp8AVyxV5krlqcxt/tkHxD
         SGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097323; x=1769702123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sT7sxUlCTKBw+bxvJar1XKrjKbpL37hYJb8bo9j5S5g=;
        b=uJ8Iy1iPDkGGZ1jazN4atEjEG0JPuzvSW3z0Q9YQwW5QEidKusP3cZmOg16Eg1yxGk
         w9d4PYFIpDdfL6PW8tNazdXJOQHtfUa+/d9/3Z2aY1fGgdcLg1i2qztf78GC9pw1StDW
         7gr51jhZaDFAlwTsbdgLVE2DvBR2FPwryyaoJu7WztgAlcnkmpu/EjrCn/Aq3kj+VkJF
         IKC0g2g5Eoh5qWYk+Dy1tGhjaDprcUFeIMLgdhvmBZCQelxOKc/r2sGH7aA25WY5CXkH
         7zrDf+be6/sIANo+MntWpzG7v0CwcV//zDwGir3w3v9v3jk/oADfC6yQZBx+rPX/cjLD
         fwMA==
X-Forwarded-Encrypted: i=1; AJvYcCU42/fatMvTVRkwaJdC8/czEhpAwRXHChJaJC4NvNJlGHRiSegu8tJqXPxYU7+etqhqd0vUM0vXqBdi/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6/CX3P94jjDVck/jGXVNf+pfDURLlNR2PnmF+j7rPwEA2wpN
	I1ePm+tfuEghPRQRD3psnc5tlihIhxnmvqSVzFKs7H1q6wE4Yt8IF0xv
X-Gm-Gg: AZuq6aKcoEs/mU17BCIJvZT4aPv8dNDSxbe1AjIvApeCMb32DGVg4zNBE3ujXFSGjkM
	MgJ+q88OPtH2Mx6BS42tztxuJ5RVzoNrSKPPHe5ms51fmR4VoY8VK4GGTfRCUTa5xKPoqd6XBL3
	eHkghYHj1I4uQjjl075WuVNyPkP3GjAttns0TdeC8b0YjOG0Q7qehq4+aaV2WX9iWBmR0oQGZJo
	h/nN/Edrr2vTMVRc8lMlYIP5JVce8FQ/BR5ck8BdxbpxPHqUbYiMfytYBu+3Z2q1wuWRA1gxylR
	mfOJsOARLgxieldZcU2nIKh+gZoxKTI0r7kq+8k5djymUNvETLqS9T5sf2NxGc80s6F0ME6byqJ
	dqZYNNcCJhGG4W4oFQU3r1DKbsXMOPk/P62muE06RFVBMCtB6tm5C7IJIhQ4WWgkJyf0sftr0DL
	TP0JVfSo6AnK4xPHHavS20fbeb0DCwqmpkEKxiN2neEOrFlKdZ+kdb
X-Received: by 2002:a05:7300:e88e:b0:2ae:5a9f:d98c with SMTP id 5a478bee46e88-2b6b410b210mr13103401eec.33.1769097323537;
        Thu, 22 Jan 2026 07:55:23 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:23 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	550230171hxy@gmail.com
Subject: [PATCH v2 3/4] platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:55:00 +0800
Message-ID: <20260122155501.376199-4-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122155501.376199-1-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MECHREVO Wujie 15X Pro suffers from spurious IRQ issues related to
the AMD PMC. Add it to the quirk list to use the spurious_8042 fix.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 404e62ad293a9..ed285afaf9b0d 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -302,6 +302,13 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
 		}
 	},
+	{
+		.ident = "MECHREVO Wujie 15X Pro",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0

