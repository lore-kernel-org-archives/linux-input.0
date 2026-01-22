Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EF360743
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097335; cv=none; b=PRIzSk6l/NeFEmfqKVaYM91lz0ihseSSZsXr2qZjMA8v4IqdRMMJASRK+w98SW1qoeTA65mwIJizHb7UKV/mubZnZ8j5l2DCs8k/bgHMj6EjOkeA0yL3fgWVyJVKUztaGiYi+csv9Wumu+SeajrD7ICuO83jrvLfTH9HdIiZ3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097335; c=relaxed/simple;
	bh=9BDtGVLm/YNavfQzhSMk9a18TtGw89Iu8RHa4FY/yvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYXzczUbifNvl4UrhALXchGcFjk9hI23vpsnhDDU6SIxwrkzUJwRM4mI0Jb98oCRCRjXjovbvVrHYgree3/63qDTFCdMGkCnjEDZE1QZwRhrx4hW6J8GZDh3HgNV4qON78eLhrBiP7UggSgX8CS45QZv5QiTUVq5rzTVgJjPWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss1uVZj7; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss1uVZj7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1520475eec.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097328; x=1769702128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq4VY/0urpQ2UO/GnbuvVu8bQyR50a/yUYGs16zTipM=;
        b=Ss1uVZj7KFP5VpFPeNbgCmoVJyEcQ2bAaPJa/GFIsmZ1y6+feW72vh4Okh25tgezlZ
         8S09KB0wduIbkEvoktIjlRPiXxMwOB05mfGWJ36rI5oa5Z6TU9LvxgnDScu5KZUmwp8o
         mlfo0OK3jhvLK1EjEJA/p/+IvRK/1YL628odLheVIc0brQlv84o2cHQwDRzDT5QCrA+h
         RdUeZC5K9TxVvrugouTVK4/MhUEjlaOIK0iDtNP2vEZdH87WnIAq4s0UHTq+YzhmYc1t
         zdNhEnKyY2pKgyytGhB3alhPG/MnrLR3Z/tN6Eg58z2tP4lI5SeW9hrSF1t/KJpQHf3z
         eNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097328; x=1769702128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq4VY/0urpQ2UO/GnbuvVu8bQyR50a/yUYGs16zTipM=;
        b=CJfAUQCusQW9NvbpGtVv4DJKAzObTqp/o9n5qfUkOXPMGSbyhQvzI7xMl4pExUNfVN
         csUWXP24OEuXEQb7ZcLqRvMyvxJIOcNuTLiae8AqxoSlTuDCz+eseNoCKBBYtO3xOTPB
         oknH7AoEqiOz7SRV/haQ3mESrGKIFySyMNLFnwzBsUoqi3ClnuH7epK1C7rIL+psiiDm
         NxkGMyh6SdeJk+FXgLGCaXMf7ZY1+LogDARXIQ30RxrgLiYx3z3NzwOrevIsETza2RVh
         8/jDAUNsCeuA27bpP90932oEdC0MnR0CSzwLKzzovDHTuiZGZgJBN0TOAkWoMkAZuqVs
         x7qw==
X-Forwarded-Encrypted: i=1; AJvYcCXHdlwzPb3dGudBYjeQs0ZOsD1EGZdySkQyDcY2Dzi8Hi9ZfqP64ClkNSFU/VwgY/nfoELTgCVhxefPKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QBCOluLHQPjeF2Rq+2ESLtLauNuAvE+tFZwxg4phoZR8MSc+
	S49K2JK2iU05pccIh+tOxmAKMD/IxMuiWBdwtCnDzM+C4Y/qGrJJ2r3t
X-Gm-Gg: AZuq6aJg1ypyo/y1RxEycny+V6VHMNsrd8eo9UMwKRYOhC1ggFz7vLyObxpaMR9ojdU
	OC+OyeoFOzB6+EjkiCKa1cAPrgLNLxrimEuxotMlyX9N+ouPoQ/6kOld/4UjF9gHRUDj3TUaCiH
	uiQUtM0z0TO9O196CQtDc07EXfegmy4bxwBM4/RQlc+jfzC5d2RYxq5bWFIZfOm7Tk+pMSRAzKs
	8Issiyn5xn6yrS4+HT6Eliu0C4eUh1+3+BrwYv1dyCnjVrNVVdMmKhSSZ45PBzswt92YmtQC0wA
	8q6Cl+X9fOH5HqB8Y+B/IQqwhy/IuMQSalQaLn/0Nkuv8LcN3Kr/Ks6xXjiL6mIOjbiJf2dsfvN
	xtWp4g4hYwYFa/+w7p6HcI6GKFEZ0EfuAeFDgd/HcT2ysWmDh14F/alYknWPsLELHWAMKRTGXFG
	cIx7Nv3bM2RlAveqkbILusLUtiscmEcYwxmOD63PRCO4pAQX28ukk9rNDVFRLOM5Q=
X-Received: by 2002:a05:7300:1496:b0:2b7:1ef:5862 with SMTP id 5a478bee46e88-2b701ef630amr5208031eec.4.1769097327956;
        Thu, 22 Jan 2026 07:55:27 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:27 -0800 (PST)
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
Subject: [PATCH v2 4/4] ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:55:01 +0800
Message-ID: <20260122155501.376199-5-550230171hxy@gmail.com>
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

The headset microphone on the MECHREVO Wujie 15X Pro requires the
CXT_FIXUP_HEADSET_MIC quirk to function properly. Add the PCI SSID
(0x1d05:0x3012) to the quirk table.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 sound/hda/codecs/conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 5fcbc1312c697..2384e64eada36 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -1123,6 +1123,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad/Ideapad", CXT_FIXUP_LENOVO_XPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
 	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
 	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
-- 
2.43.0

