Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315B43B4BF
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359496; cv=none; b=uvz9XHhE6rUkY5KDg1zxTpyMwgwBlu8CMX+8kEwW2C9hXwIiVsZUnISuffyZIXe7oikFekvVTxFQcOgktohUzvkeOe829l/SmAnNetOytqTPxARxBeIk3AYZaSt3nSOCgdQedJPDrtwGuq+/vLb+T1+pADwz58F59PMJRURZeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359496; c=relaxed/simple;
	bh=C5OeVmVc9RUqWQx2xLWOpeX88Xt1ishh/7V1x3S2xhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXFrFAY/57+/k7ZA3/MOlidKnGWbNIYYTbSKXWMS0MySOFIySdWKRwRFJed4/idsOUdxXklCnnDia+vNIVDSXtOwdvySqYTa32lz5pKrzNaFK1fF+FbBbuhjPPU3wSVZmZP5lGcvISIrwU7ZHzRFxiGv0/V/8/9j9nfkp0MrNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Etv2pH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Etv2pH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c45111bebso848371f8f.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359493; x=1792964293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=i0Etv2pHdqdDOtH/Drn40wJtjhf6YD6hXwev8uwOysg5fzTMSArXwinXXZKDVL/KVq
         hw2B+wlzRvui7mX1KaJP4FywAsos3+0VS2pOjSBLYTXz2ZM5D6ukoNN3DLgKYjFCFx+9
         StrWhKXZN6hc8lI3FmMGt1Womx+QIvgLaVNezzWds2se/Ixtkp8jTa/85Cz8jm4yxL4y
         aZt9xgHB4UWYVOQPD/Dj/FSwtODgwiorEvMJF19Ed8ofSuvtdOrRWpdRSjnLE++5YqNm
         JFd7DIS4n3/qiAfuu5k9HxynCtOYVptH3ttKSgX7Sk1DETMX4o83bN5/QHyVIEcyTWVN
         4Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359493; x=1792964293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=RXOqB3kMfrRoODEFmdvm6L6SDQKkwRViHvgcwZYxLYngvxbgqq9DxoVuhR7gIXrBdU
         jswm0w/Bwnl3SeDqnxRQAgTAhTrTd9d0769pSRSYQbDKVo4YwjMJCw47rYj9x9FaMbOC
         6nbDkEZ1nBeUJ1w0UEMFl3nmECFjQ+g12QdmT8FmTr7KlW5J0BI36lRui8+DFGMDqztk
         kM27E+aFn8LfCZtYQQW4+eM/5IslgmSCNW+vI3coAfS77MmqotC58t2dMMVAyqxDcvio
         Bs636oHgYwFOMWgE04r905KGaJVtXdPOWi2Sj0h6Tw+3zbjQbQdRcxVGI/OBhbmnwqij
         j4Ww==
X-Gm-Message-State: AFq9FYJW3zO6ljvDeqgaizElRzlqOV9yNgwK0cGY6awiGJMpAo2YJP80
	lfBn0qvhTeoBiaQ9CQ1xBJjAMetDzmUzEawDQDRrWS3vMMBB4c9/IqU=
X-Gm-Gg: AYBFou1gpuXqVgLQiuJa4DGDIwmYzdxESCs62XiqeWaERLnphYHN8GVC3juzQSCfDLW
	+X3POQVLhhPTPExsqfwtplPgQrNnpYX9GaPF7J+iiKZQD8/VKwUTWuPxKGazyYz/CnyRb1GAMEJ
	4x7FNODVbjpz9lucn4f44hqUJFaXPFJ7pAywhbnTCV5R7j2MkE/ilOyosaAx2sBW7JGxKMIEPrc
	4B2S2VHuED/l6Q1nbd3NZ2m+t95QFxAuSn0cwHD+gh1SlJ467xYFME6SeAbQOLC7lJoDqPigvUa
	fiSjqPOBpuJR4TriYtl440i/5sng9lh9TDxM1MjznoXP6saSXAreNrCQeou401JL5FN6rqNfaZD
	Xj7q3rdAN1Ol0bPy22zRos/sH0dFb26bQQ08hZKpFHI3Wa37JfxB75d5HMPtiMLiQ26hcXDEQ5o
	xxwLYFWpUcr/uaDSpql6aPjNMhFO88aTB867pXKI8=
X-Received: by 2002:a05:6000:400d:b0:48d:f58f:c98 with SMTP id ffacd0b85a97d-48e07fd288amr12216908f8f.40.1792359493335;
        Sun, 18 Oct 2026 14:38:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] HID: cougar: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:49 +0000
Message-ID: <20261018213754.1951187-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018213754.1951187-1-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cougar_raw_event() accesses data[COUGAR_FIELD_CODE] (offset 1) and
data[COUGAR_FIELD_ACTION] (offset 2) without checking the report
size. A device sending a short report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check at the start of the function.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f1628..2dc135d0fd123 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -267,6 +267,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!cougar->special_intf || !shared)
 		return 0;
 
+	if (size < 3)
+		return 0;
+
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
-- 
2.47.3

