Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552C2D838E
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664575; cv=none; b=gbid/iUblLFDtknLC8j1EuY8X7TZm+bUZ4tI1aslHW0QOyWrAvrLNHCHRGEmKO18pAA+oPpVbt/6Mook9kBsCtvSavDsJKBDxfpSaHeKoS33fb1Xyjz+H/om3QdVUimC7kaVqFvQ60nO7AneCwCbFtX8LI3Yp3H4U4qLTJBRG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664575; c=relaxed/simple;
	bh=BNwN1Nj8dybsZAvcjPKnwuKZ8iq6jeSsMk9qriP/fVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upWNQ2nCzJDh2Pd7wGljSWyjJBSwkvePQhMW2+BYR4rdLyRIteagE1dADCKXN20VfMTsWhm37pHhKXN1F3Pvjc8ZyT2u00NRRQlWQZ23ZDW1KyJIx+JzJ0KRaKgPU8bPysMTmBBy6DPopx6rEr8yczElKLAbYJL++5JXd7sEZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqvFxo3r; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqvFxo3r"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7fe4808741eso26557287b3.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664572; x=1783269372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoukpSn0XidsboLVp1WFiGbHVvRe/31Qvf7l3Vt/lN4=;
        b=cqvFxo3rzry1BhkRKKgLkAoD3xSI+LTAcIfLjRq/hATkA6XiqXBkhThmYW7XzcZC2w
         Thj3cRkp+700a9fnfxldYEs4JfQNN0MkAvofMzPAvV0ZgPrshixS1nHDrD/TP3UCgYgI
         MnuFg6CWQ4bJpyWY16Ej2Mawq3Dc02j4rXg4gNws5B4F/Zl5PqNNA2AT4tdlvjNdq0N0
         JLFqTDKaCqFuNQU+T+m1l6/zPYij6KI1EobqeHL6MyIuXlsobZRkm6A7cZKBpwKiCICZ
         rAYqwlgiuPAbdoBflKqZF+/EOr4f3/P0sYV8DK4l/9aikZRg80WtbX5uynW048OE51wx
         DD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664572; x=1783269372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoukpSn0XidsboLVp1WFiGbHVvRe/31Qvf7l3Vt/lN4=;
        b=JmT0epjGeiDdJNJ6QDKgbJwxrPl1tHtrJoQMkkZo06p/EdDZoqwTc/D4dAJKPDTXXx
         edSirAKeHTgwkbqAD6w4RU6Z/LKpI4fo+z0W/q+ccYpNiiPRf7IYkB1zBnvaSJjgesGE
         paSAnWVfMbbF/i7QlTvqlsDXn7bbHCKeMt+f7Ai/wih7BUY130xbijXugP+68fqaaZGS
         3a9sOQbWvsZeg2Hmmjk9BPR+5dzs+IN2+DxRmbUFzHjhNythSEB1lMVTAVEXmSVFI15j
         XMuuvprUcByNsHznl/3IGesfFVvL5+fhzmEoA0HYxtbdICmUL9YQ6jPnUpns7Nb+3gfw
         TKmg==
X-Forwarded-Encrypted: i=1; AHgh+RobzBWTYwGTMyVy6khdME6mq4fcXhjVykH35D9bLyzPzknPUeCG+zmcAvKqxLVoJR0Q0XfGcR72VC+gYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgFspR8VgjuqL924FxbUVofw8ugkCPjN+IEMDSkxjMBOCMxNG
	eJQ0FOI9GxgqPGPJ6BksryilAcivewBAKmEEorMKd2iT6ocboacWiAfd
X-Gm-Gg: AfdE7ck9e0xgy9CW2opQH/yH8h4ZIss5j1cFVC5iNGnN9NfHjqiBVsFsyR7XZfiIfLO
	J9fByXEdmx40WkclvCqhWz3T7aESV9/fWfVjBkMotw553AaMiO/+njCNatP2RQEzlQjbnoP84yw
	SyUHQmrPo7/y+p1pR+GNo1b36yy61jV9FWgGOa3mUlux15/OUKDp4N8uO+8lMJf4/jLV6p/hupg
	bARY0VJNbWaA3AQH/nVF5EW0DsRAnSRvttO4q7SIRCa10rzth5v05REZAr6Bnl3edgwX0Fn8CGc
	LvRmMwjyZ4O5Jx5RdCoVLRFcyekCtE/Cifiqs8sYEZIsnmMy1u6W9KE0yGwM0ySfol+slnYcHBH
	gtvUCblAsXyP0GraZtzGxMIh/ZV9tLJgoT9fm+s1zAAYAQDR2ySALvUzKGyyyACY6fH689wnahu
	kVUJtUmDjKa+2lT6C222UtOo9GJA==
X-Received: by 2002:a05:690c:7243:b0:80c:85b6:7644 with SMTP id 00721157ae682-80c85b699a3mr74070797b3.57.1782664571895;
        Sun, 28 Jun 2026 09:36:11 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:11 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 3/4] HID: zydacron: reject short key reports
Date: Sun, 28 Jun 2026 18:35:26 +0200
Message-ID: <20260628163527.14279-3-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628163527.14279-1-alhouseenyousef@gmail.com>
References: <20260628163527.14279-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw-event handler reads data[1] for report IDs 2 and 3 without
checking that the report includes a payload byte. A malformed USB device
can submit a report containing only the report ID and trigger an
out-of-bounds read.

Ignore the key value when the payload byte is missing.

Fixes: d0742abaa1c3 ("HID: add omitted hid-zydacron.c file")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-zydacron.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1aae80f848f5..b882d2a0ba1a 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -129,6 +129,9 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 		switch (report->id) {
 		case 0x02:
 		case 0x03:
+			if (size < 2)
+				break;
+
 			switch (data[1]) {
 			case 0x10:
 				key = KEY_MODE;
-- 
2.54.0

