Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B41A35B648
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097331; cv=none; b=CYMInftgthtj+qRlG/n2Ecyp8zyqZcnLVkZXD1TKgCtUBfcjfXJjBJEj7l6lZngbJRtvJcyNI1eX4gzKlCicMN7dc9Csj6++ZB23m+KJQxREvJnp2KHStnQJHOs4CmS9LVyHUibxCjWfhAg9IMoDLVoSkCjFmX5Fs5joJ4E+w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097331; c=relaxed/simple;
	bh=pITSoNE3VQ33XxIaYm2AgBt4ZThPk06LRfJuwhvwh/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIjjq02dRltNpO2lAT3TMLcU7YpHjY0bzQwAOFZkrcMWfy9SmG+Nt28Vq7p9SVMz7j/Sbwi/5lXCsReNd3V4x8zaWQt+pJB5Cs+bZTXQzjk+fuNkmt7uYK1gg0rZBjbv0BnokafFAMErkZ1tTWrifCn7KG1mq5n/AlUk8iknXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgcetXa7; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgcetXa7"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b71557299dso1535450eec.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097319; x=1769702119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKtMTSVYxonSlbpUyIW/ic7Xfc0BNVbSgxoEnuNp57U=;
        b=PgcetXa7/UbUvlCl5xrRn2P0afO9xNMimnoaK2rZe/taRFWKcnM4Om6dTp1wKm+q0a
         mhk9xgYkHfw9G9MqzjoZgX2iCZ8YXCxifCLT2B4jEqLsEZXfBa1I8OA36YXOG4y3WIw6
         +7AQ4mN03yuctxeBDwra0W5ynr0Jxf2Cv4QCxOJ59PnnEw+RrXPTLPfbvMajA9n/G2vo
         Rg1I/DWIID4Z/vZBA+8DYHFb5Y0eZFKRx6Us9RcU9jobUO4nssxxdXX0ZdKWMKA4FtmC
         Cr2tMR+BddISbcQJxInHLFsxX6qGXkRefGcYXN8BxSbJ/lxtwbysfU8i5NWedE1PWv+l
         EPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097319; x=1769702119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKtMTSVYxonSlbpUyIW/ic7Xfc0BNVbSgxoEnuNp57U=;
        b=q9lymADWHB7CiS8Fz4id4dEAadXyPtZKnGyQIE+o0rLvCcPBFanYykUiNObzbkKrPQ
         VC17vDg2x2Qq4ZXmuiRCTeIus0f+k2YGeVfQW3GUyzoWD1ecE5AFyTSZQXhOhKRaVdnw
         qnyWCpqdb66dmrJ1onNL9MNWzoX6/0B2WPsu9B5J0s7PeClWsYjEoxWY0RUqafCEAwD9
         Urtg6gArnjFVlIrF4KG8/wTBDUig9f3NTFyl1M8Wrcp9jlB3erSEw0zLrO66Cn58TAFA
         /WfERyBtodadAW4kVYfapBKIRxVSEDq/h/zp1RYUpxBdsm/olZun2iPnRVgd2hBUku51
         1crw==
X-Forwarded-Encrypted: i=1; AJvYcCXcy6KecxzCuIf1EtrHR3zcXhwgll8MbEfsXBT9Ly6xca3B8lEzWGAG+D3yRbjWCHBLXR1KglYR6mOCvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAa7VhcGgBxfkNcgeHu4CkXOOZNRiobzGwXZikO3tlh2UiDpZu
	FNpsH5OphOHIzXIqw/Kt5gELYtTvt3ub5gTI7ohMfN6/S8RPTQCa3azk
X-Gm-Gg: AZuq6aJile/vfgxQzVemM021G5JDslDZzTFXGfLG5uDOUHIId2d5qsVeqXwl56Epe37
	SInBMU+MBnGfoxQEkmGU2u73LmAF1oqLDqd23ApS+c0vUgf4KlCqW9M2uJ/Pjn8ILtfair0/gjp
	NLeSORGlxZBaiwfZMfgQuAz2X6oYnZj2Ak4r7LJFXDqATfDNl94OR7RwD66ygjAWKWKJFMfOaIt
	oIwVv0bxPGUq3YnlSAINcEcCfuFpMFvXcHpHCvFnSUExevtq+7tMagqDvm7z++QvWiuUc8o6erM
	LBwaS9t3YiVPJsTAYzBdbkRalfz+CR/oNRS6/eAhdNMm2PnXDa1aMZhD/lhdwtHHcE6LSicStrS
	F506kFmuN2EJKkky5iroTqu8xw94EO75I2eGdCn2FAyjmD88bvA2zJicZwl+bvdYpOx2eUAJxE2
	+XP2zZsotwkV9lxT0bSQ4XAxwaDV3KGi3Tip9f2XV3yuhXoW21RibW
X-Received: by 2002:a05:7300:1908:b0:2ae:5bb5:5732 with SMTP id 5a478bee46e88-2b6b4e97901mr13128772eec.29.1769097318588;
        Thu, 22 Jan 2026 07:55:18 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:18 -0800 (PST)
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
Subject: [PATCH v2 2/4] Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:54:59 +0800
Message-ID: <20260122155501.376199-3-550230171hxy@gmail.com>
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

The MECHREVO Wujie 15X Pro requires several i8042 quirks to function
correctly. Specifically, NOMUX, RESET_ALWAYS, NOLOOP, and NOPNP are
needed to ensure the keyboard and touchpad work reliably.

Signed-off-by: gongqi <550230171hxy@gmail.com>
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

