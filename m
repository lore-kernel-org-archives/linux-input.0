Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893374C9001
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361034; cv=none; b=gZN6xrjQY05jXpnmr35tdVE27PONDek2qyF+aYtckIYP28o+KD+8Awf1sbep2QLgDmnPkYLsRBwdzS4X/vdw0ZYGz8NvRbwbPJlqgjRjg6L3Anc/KrZTJkTSQb77OcyHGcK4dxfXIvXUhX3Y0uPnWCiaYswOPAvSNYGSTYbswOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361034; c=relaxed/simple;
	bh=aUzjK8ol795HHRbJphJgtTRR/M0uYgvtIthrbMPir8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0v45TxrohS5/BHoeHsybamJYtZwZwNeTw86tRUK8m9OkUm8iEr1KU60CZf2j+V0anahEfdNpMuG1760pDTkAUcDK9uDlpUOMMjWdw6IG5RPkJeqYvbrWy8jXFQtn1f2fGjzi6vX59uwCHD4mwCBBRL8yqYASpYPfe2US7VWxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Sh5Uvg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Sh5Uvg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1e1dade31so4246985e9.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361032; x=1792965832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=Q8Sh5UvgvP4HRrHOAx0ND5VXeQOPGy990Z0B1Ea/1GNOaTjbrO/AEZvI/8STswJjDi
         QrcXdQIdUlCHuRh8zXiKOuTi9NluUCwRpX0xtzOnyEEcV6PVuLMd5UuOmEJkhRiNlkuj
         LkQbRXMknDeo493qrDRBoAh5s7BBRSbBIduMK5bA+c6yndEL51Z1vQmVSi2OsdNYOrws
         KSIDsDp4XOYvxTkikKaEBImKGQrLOBGhy+6HoTyT+n/pmuzyL6gNUmD072EZAHyBMcoB
         sjX6s1iJH3Mu7ncqjhxBNoNgw3xqSqeVLFD9pldlzwgJjKECuu5q3chCDZdpVvTP3CkW
         3hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361032; x=1792965832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=2d9OprcCSQ/We8A5gweP32rsUzVscLvCH3K0E/rYqYUhbs1y1DiLvOnUWFgmFFZzJ+
         rGZDS3Bvs/yosPGeHRA22TwdIk7lxnc15Y7UyeZ1Jt5oOlnBLZOyrhOz3L0zgCbV//XE
         XnB0ANwPl/Rnfi5/E5TvRAMYr48dPSE2bQqDRxQXA5GkCedxMRCTLy+GdzH8q+guUhpr
         5thGg+adbVN5NsCoh01KozLaburdalPpWK21vI8wVp9L9zUqYRImzAGoWPh2DvX8L/6w
         byeswrc3zTrB7roJPXNKOe8jQPYRoKiR6l5BzXs0uTdYqxRymSca0Yeq+fScUdX+GH15
         BaHw==
X-Gm-Message-State: AFq9FYJyu2nyqSC82+tAUyQdJx+C7dLAIs9dougjgEuSNkKecvZIv0RP
	3iJMQl17+SblFyhf5qgi3EvOfx2gERpiTDOvvFr1fRnMKpm7DjFeXTs=
X-Gm-Gg: AYBFou1yLYaFSELpNrFtz5yN8UUQN6ehMO+u9X1t+2OjkPH3Dbvtv0HSgvMZY+hZGxV
	Y5uaJ4wINpAGW+5jJItIryLiMJjpMqywP/SHEvvC/tIPJ4OeqQ9Tt7KT3GEks8G2TeOiWEkBN8I
	O5IBo7fqKnQ3y048lm4pjgzgguwT/BWUTc1XgapBLveQ/zOX92Mjf0LX+rFQpiRlJ85eRyLvxdm
	QqabCS43RKqKIu1gSJLiehdb3o/fIxbkBlLlFQozIc27kMv8sUNwYfLTedUi8xUarTgUJ/QMrLX
	bSGnBF4Mx5siDKX6RjedJ9rf8Pii8WDFTHNP8jRPtvxtf1+6wGd5ejy4P0Ve2M3lLy69K1yOPXB
	KGRLTFbMAphBZ1Dp+LIsDyNgqb+jCdlBs5UpZys6Uyv1i83mEi9JWDjclLpgam+XJttV/RpMYtF
	eLeJTK5Sak2YpfELdiDZSBVeUZQwx6FCQoBxaovJBp5zA66QwZKQ==
X-Received: by 2002:a05:600c:638e:b0:4a1:e489:f8a1 with SMTP id 5b1f17b1804b1-4a1e489fa67mr42945455e9.2.1792361031771;
        Sun, 18 Oct 2026 15:03:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/8] HID: oxp: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 22:03:42 +0000
Message-ID: <20261018220344.1987142-7-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018220344.1987142-1-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

oxp_hid_raw_event_gen_1() and oxp_hid_raw_event_gen_2() cast the
report data to struct oxp_gen_1_rgb_report (11 bytes) and struct
oxp_gen_2_rgb_report (16 bytes) respectively, and access fields at
various offsets without checking the buffer size. A device sending a
short report could cause out-of-bounds memory access because hid-core
invokes raw_event before it validates the report length in
hid_report_raw_event().

Add size checks before the struct casts.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-oxp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 1e691ebc1199e..af9f60d45bf29 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -318,6 +318,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_1_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_1_rgb_report))
+		return 0;
+
 	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
 		return 0;
 
@@ -391,6 +394,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_2_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_2_rgb_report))
+		return 0;
+
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
-- 
2.47.3

