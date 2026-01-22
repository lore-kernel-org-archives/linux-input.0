Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55442B72E
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083610; cv=none; b=CchxqYQjCoYHrGT6/9Qea3RLlQjv9f5onWjxZQUN0wyJnud8bZhQLi14mlc+pIqPi4IlNo1kSEbtgbTaPZGPfO6E8Z31J7nci7vlEC/egwG3oxNAQlDBzKVj0REEzT35lShsdw2vK16a2J8iSLSv6700bckBOZfXuLcngjlO+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083610; c=relaxed/simple;
	bh=lzQOHxQiqicwpQZ/0bQDBj+etJcHN83pFExJSiWgqjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WntVn1YBt4o5jEcE7mYXDG75TbToZ8Vbh0MTSU+Fiqrd7796wtNCaipMIihQcM5DZveVlU3c/qBGaSOSGSmqa1YQ5QpNTu1cm5HDMhXSwa8f8hTY5Cz9SlKQvOU4MjFpfe4W5K06o3XQkGIaon2YFZpkIrkC4B1S0g4tUVR97H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6ZQKPLH; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6ZQKPLH"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233b172f02so1369191c88.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083607; x=1769688407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVYKSmzyZdSbDFLhu+4sm/8SaDX11ingCawQOFktQ8E=;
        b=D6ZQKPLHY9yvkSMgrIoPkcBmS1C2HXPOXXRw7c5U0yI1YTrkTCeuT+altHh6ADOKFq
         7tY5Z+9vfcm5iYHBAGtTPQBz4xR2lyuUD89HMUbuDpvBaQKmur1lOxpRYqDf3HJG6kcU
         GdXnXFqyY1MQqUX/DVmXFw1GGW3uFqTmwQGRRUVwt6qEy6cQTyYZt6/9QApONf9IeI8r
         CL/q9Qs5pmkexV4ozgTh0KVNP1fJps3+ikMPkSrrSQN2/pljc1mQ/eFgLcMGyNUm6bIR
         7uJVdzGzAgqReKOqoLk7NjE6ufbXMFGA5u/ZS7BnJOUAMPuYguVFOU4C2H1E7vOG+LKm
         HH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083607; x=1769688407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVYKSmzyZdSbDFLhu+4sm/8SaDX11ingCawQOFktQ8E=;
        b=stlzCCxUKt598G6nTRgPkQ5KHxCTeRHzbe6DmHhWOcMbb0ML012+7ZQAJorCCOwqGd
         VKghjT6u+KnHy/Niugcts0q+seEgBsQBcVKb8gw70WPNEwArkEQ5d9ClNUas3aym7Qi2
         MJPJg0Wq5VPibcwaqwLgXmwHbvcdKUgxkO2b+ecMdWqeGajiPAUTXJU24+OwsI6/I/yM
         mBjyKUmpc/SyCgSLN/m5gl8MLDfw+LgB9D0dSSMWoLGniLSCGm3DPfrxbC+3CyjWNe4e
         57eUKTyFiCaxv5APAZ4o2HgnwVtxWKJ3OHHbYDWiMpcjGOJiG4TeuvLmC0QUi7geaxa0
         2B1A==
X-Gm-Message-State: AOJu0YwAoNqTFaQCda++db8ErTDZ7cqwfE++uXKG4w7+zF4K3aRjuQzS
	mo3hfA3jrynHvnZJqk3PxcAEjEtJTfnWwDcFWFF8N42mwudlifFp5EtdPJla6B5z
X-Gm-Gg: AZuq6aKUP1xV+vgLgBK8sORI3/V8uKv/m7iqR2ujBvOB4crNq3IGfdkQkKEQhPli1wV
	fRiMo+Rt77YXpysu5fyeLV3cX5zlx/nOlYr7//Kgn5pIfzR8AWUx4xm5EP4g7Gx6xhU5BZzzeN7
	zLnhXKNH68WcFtVqMh3pOVqDlDGkiog6qVRUABE5tiW27SPZiyr6hslp0KtsQq47Ipb3c/W+FEQ
	YgoEY1ntZr5diQMXYs2TYglV22+Rr/zgRq5Kl4MALGSitQ6dJp901EGoOoR71PRrOqgOw8Konq3
	9oN1a6jpEq8eW3YMEC69R3Q0fVFTMIuPpU8ur6iqhZuwk58jxWuRIW4jBpZGAXKqWjlyucVafk4
	E33vxdUnpFHOOHxyecDz6lafoKiLiSWVjxiTrrVPixgn/lPEL9F7XBI02w65ygDZDMx8UEHTrHw
	eGzSY4AQs93KQTZI91mqqZjwpxTyX5fASUaekXrQx8+BFgozXaijFc3A==
X-Received: by 2002:a05:7022:204:b0:11b:9386:826c with SMTP id a92af1059eb24-1246aace2c2mr6783066c88.41.1769083606475;
        Thu, 22 Jan 2026 04:06:46 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.213.30.138])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7171be2dcsm5535845eec.11.2026.01.22.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:06:46 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gongqi <550230171@qq.com>
Subject: [PATCH 2/4] Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 20:06:40 +0800
Message-ID: <20260122120640.3471876-1-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gongqi <550230171@qq.com>

The MECHREVO Wujie 15X Pro requires several i8042 quirks to function correctly. Specifically, NOMUX, RESET_ALWAYS, NOLOOP, and NOPNP are needed to ensure the keyboard and touchpad work reliably.
---
 drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 654771275ce87..4cd09560c5bfb 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1176,6 +1176,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with the forcenorestore quirk.
-- 
2.43.0

