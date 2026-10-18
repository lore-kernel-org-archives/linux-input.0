Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD174E01E5
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361033; cv=none; b=dKgb46z1ynvxEoPggKWyzgaQ5QO1VmdQHWDIuXbrkCo0KOsjeu08joxEWrPfLH07O2u9aRanjKUp6lFvRM3QC66ePhU8dvoFSKU3+0XaSaCGq3bRE34qWolBvJ+RPgv5LRZlSkLZK1kAcHUzkFCanjQz34NxOrBIlCWIv12X8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361033; c=relaxed/simple;
	bh=TEReWKhHAWlGInl30NA0QerMBstlNh4jb6eCUhA0BqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAfxOU0WtIHXUfc3C35UXRxJdISEgPdCpPNACsXV5Zw9ursiFYfuZ7md+4JvVDbbf+WdBDUzBciEKNNzH4XwZaXeOjmaKrDmPpTT7VA5QQfyTm4ctYAUbGCKDqKkjQsq4f+WrafTtSQn32kyxnjaBXlcNAkGLhMnKRcMsl05/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn9szMRb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn9szMRb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so20565795e9.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361031; x=1792965831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=gn9szMRb/S4M1M5s2qrpD4Tkbl5LGY4VIUBFUxy5Ou3ONsFUGgnmTBHvgUv/Gtth0p
         n0GRIAthiopYBxO92SOWt7PPBzuJdLpasB6MOC7S9pXMspJgIgNdGcr+KpscJOYOBCba
         oZYNGkNuB+kZm4xPBR7KKHNMN+T/0tOby1mTG7ICqsaRRJZLTDlXFS7WeqAs5+u94t3Y
         OklqOMSz/7pEegAJJmdggJ9SN28hfaYLghiU/EC3qZeG7LO81YyF+ikti7vxbmTc8dKp
         vmk6eEcV+/dyrbP8OhLFxLiJhB0iQjZqZA8Mi7z10kMg3LMLteiOU9hISM3h7r0dY+9l
         +dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361031; x=1792965831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=t+xlMONrCMEvIru8AM+mXf9ni/238ECGIwvlEhS9JpN87YG5FDF/Mwp45UqJeoHR7k
         zEKmO65bebmcwjFJzBLW7PLU1GqLr9YwEhVGX3V0HqXmEKVXqSRpaFzfFAX6rwP2sVMo
         CE5fTRog2fAfHi/W4kT8dHt0KBHefY7XOrXXEn8ACmDxFPQtC/nruhodSRUj894qnGGr
         mjRoPZRjt2RB2AGd1bl9eUwGKJn+2j78CvsADXr9QWMOCXb6J4y6NETtmRA9KaHHnODE
         SjRb4NwyV2BXITDBGEkFF+chWPQt/DPUyDj92NANO05Hgk+KB7qwUQyTfX0e1E5lBxdT
         YvDg==
X-Gm-Message-State: AFq9FYJ2f8tFafj1g3rkJmhczS3k+uWwyXN7VxYr+L6zZCwIcQjlvMxh
	oThPye56TPDptCsS6r/+YZkKl7QIZGHnd/UVyG86YMNG44HJk5SsLNU=
X-Gm-Gg: AYBFou1nJ23NwkFMUBehedW2aSAL7GXEt00WMwZvusihB0xXYZxKEi/MU9hMuXKP4qG
	HprRgxKh6P79+5y4ia0uAVTXvpEUpxjksvrzAiBFuZniJ8J2h1Uc3JhOXaqL57RdY0XH1XOT5OH
	gRLLbZhrcgBOlzYpj+KLm/EPQBZ+J2gv1m0eg5VZJwakW+xJoWXbiANrSFqCfOktDBdJAAEIDK6
	DiCiN+k2CHatWRrCdES0b25vJeHacuGuNXxvsVojzWKw/WAit/i/Alr92NhTMAVEIKaAg3zLirH
	3KoMx06ePrRtqdjeW8whAt4XqE2PacaHvAULHK5F5+/k1V1ONfu9+dyOKq2miKHmKjsK6cWvwvk
	hUig50x3sYgS2JjDkEks3ieRsQvTMXLCdNGd0sZqFNttYUcm+xS02DCHozvbeZhme4iS+M/r9J0
	778b6WzaIUlh3GcjfmosVHEUtQhgq4SM5reAad61Y=
X-Received: by 2002:a05:600c:6215:b0:4a1:d41b:5060 with SMTP id 5b1f17b1804b1-4a1d762b705mr105690375e9.22.1792361030661;
        Sun, 18 Oct 2026 15:03:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/8] HID: zydacron: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:41 +0000
Message-ID: <20261018220344.1987142-6-tristmd@gmail.com>
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

zc_raw_event() accesses data[1] without checking the report size.
A device sending a single-byte report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check before accessing data[1].

Fixes: d0742abaa1c3 ("HID: add omitted hid-zydacron.c file")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-zydacron.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1aae80f848f50..203457398780c 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -116,6 +116,9 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (report->id == data[0] && (hdev->claimed & HID_CLAIMED_INPUT)) {
 
+		if (size < 2)
+			return 0;
+
 		/* break keys */
 		for (index = 0; index < 4; index++) {
 			key = zc->last_key[index];
-- 
2.47.3

