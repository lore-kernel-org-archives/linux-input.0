Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AC5326CE
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077206; cv=none; b=eppAnFzszaRy1R6kQ989ZAF6DnEx413NxxYk30bBWVjMPJNH1gHG4veSz27Y9r8W20gYW1MR3tj4y39QM9TWHInCMyWB6jmca2WJbPFvkYvdno+YomtK3eyEg6bs6u8nt12rzuauMGErv5/6CfBGgCyDkpzoZwt3R/VPtlJuBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077206; c=relaxed/simple;
	bh=r79clFkHcqAlIgAF7dPQqiJC+HXwMzt4NkqmdL+gKqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFI1XZonoiwgGuRquNF87e/1W//0H4mkY/XNRiBmu8YEquFX0IcLhLOuOQrsOeHNQxtvvaHBEkETAcYw+vGACsvhtdDir660FK6uW3pZtlgE69QD6+iAZ0SEkyz7YP9HMrDsj7wN4+bGXWqf8EQMpV5jnHeo2oS7oeHHGaY8D1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWWwH4Z/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWWwH4Z/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-88b7d853b11so933378b3a.1
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077204; x=1792682004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOQw7g2Msu66bDzbYk3ptJu7TL6fCzl0qAToEIpu/hQ=;
        b=VWWwH4Z/Wt7fab4fvKqrFe74NRkcE+RmtxtjS2BVAyxGtRdhjhhkNIj0L4/qDMkvO4
         xE4QZevYJ7Kx3/0uMyZ0SKqsd+TQH+S8swX/Iub890xia9nlAsksPJ3CPha0WfoMRgOM
         7dPO1JUTI91BAtgE4dfEFEQOVZ7aqs9vO/4fRnegj1RFFs+5gHPEiAi/8xtdgDWYReFx
         bNUDxPxhevtNDpwMxPlQUhdgSkGqcdBcyJZU8siKWItCQNV++NDmSiC/ipMSIYTmKLLl
         jto7SnI9kxPPTTSsrBsu5qTFTyR8Ssw/QW2WaUjEJ4qLCZcScDq9PP/YOd3u0ntXM3o2
         M/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077204; x=1792682004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOQw7g2Msu66bDzbYk3ptJu7TL6fCzl0qAToEIpu/hQ=;
        b=NBFTx/jG4OvqNp1zz4GqAfA5O3uEjAMrA8llzXavDCpuzCmALdF9mzQx9H9+lgTWFE
         BxIlVx6ND+/28CDSBD9f8OlnNkC05egirNY3Ap21fz3zHiZktyjt7EF+wWFPmXWQ6WPR
         OW4OFSu2mmvs9kU6v7nXqwhdql1UAyVHizkrOJmourlhqFuhjRDZw6CZJBP6/razmUpT
         SEI1vPH6enoNbMXQqRofA0U5Nl9oPpXzDMLy1dB50g1gcf8DiyJW7HivMygI9hyBqZ+e
         3/aXuiQCNzVCrkbd8InmtoSvoiMogRbW7cIVd/faqfmyrfElgJeNMtQehiGXVlsg3nd2
         ssbA==
X-Forwarded-Encrypted: i=1; AKwUvByLYD4LUJZIH5grHWrvL1B5zAHvf1Vqi8B0NsAw33hJPmX59eoP31SxTvG4KmlyPbjSsHfYRw9oIwggmw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIL+PeOmBilg3R7D7FieWRt4ff2EM9AqD0UsFKguFu3dieVn+/B
	TvKCCifsIH7tU/R3vfIbIlSnVDxqCMzmhuNdaS1OTV2BpD20ihKmk/2o
X-Gm-Gg: AYBFou1/KZnIyJe+Pn1TqXnfxNiV8xQ22KIolr0mIgSsnTfwcAhu0UGs1MTCr4FCs9C
	PK/PvAPBF1OuC1Bu94A4xBZTcQrF8W0zX9JFZ4Q2Rn52iZcHIVh02UkbZmxeE2Wb2u7mvWKF6vP
	H+OdEVq2pK5WeJLhFCRCtNCmhjaraL9biTjpPLckIunPSNovVWDHeWEG8Gj0f6qyRrfLX9zgjua
	+0lvgnfRbZ9zkAhbPQxctoV5pV/xpkRklusU+SBQxd6UoqC+IJX1IFNQ+mDAVJN7fCIJAsVBKza
	XlNTOQD1Ia5ty6TXcvG17dgThKmQ2Q7sc6MELc2F50bbcjn821KYeQkFbU/DA0BhbumEtlyvIsy
	oMsvnGc0DEpKHut+W8XpN9wT6Rla08aKoOXORNQUpjPEsm6d6j/yuc5qjUYf8rcGTGNnREIwulF
	ogiEH1rDD8s7RCspqf17UAYXgkQEqa5+4EAvmgMyyHTe7pIssmXK1iQpFaizVJ+IDExIuwuRXq
X-Received: by 2002:a05:6a00:c482:b0:899:465d:c8ff with SMTP id d2e1a72fcca58-899465dcb17mr8864486b3a.13.1792077204050;
        Thu, 15 Oct 2026 08:13:24 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45b:16c8::245:c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d7f51f452sm2419097b3a.1.2026.10.15.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:13:23 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Harald Brinkmann <hbrinkmann@braincalibration.de>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: saitek: don't dereference a NULL hidinput in saitek_event()
Date: Thu, 15 Oct 2026 22:13:18 +0700
Message-ID: <20261015151318.208115-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_process_event() calls the driver's ->event() for every usage of a
report, including fields that hidinput did not map to any input device,
e.g. a constant input item. For those fields field->hidinput is NULL,
and saitek_event() loads field->hidinput->input unconditionally:

  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  RIP: 0010:saitek_event+0x51/0x2b0 drivers/hid/hid-saitek.c:154
   hid_process_event drivers/hid/hid-core.c:1572
   hid_report_raw_event drivers/hid/hid-core.c:2109
   hid_input_report drivers/hid/hid-core.c:2180
   hid_irq_in drivers/hid/usbhid/hid-core.c

A device that claims to be a Saitek MMO7 and uses such a descriptor
triggers it with a single input report.

Bail out early when the input side is not claimed or the field has no
input device, as the other HID drivers implementing ->event() do. The
claimed check also covers a failed hidinput_connect(), which frees the
hid_input structures without clearing field->hidinput.

Fixes: 37c492c8f6a9 ("HID: quirk for Saitek RAT7 and MMO7 mices' mode button")
Reported-by: syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eba2b3201bd25a97cddf
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2: also check HID_CLAIMED_INPUT. hidinput_disconnect() frees the hid_input
    structures without clearing field->hidinput, so after a failed
    hidinput_connect() the pointer dangles while the probe still succeeds
    (->raw_event is set). Reported by Sashiko.

 drivers/hid/hid-saitek.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 6fe7c087c594..7e1160a24230 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -151,7 +151,12 @@ static int saitek_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct saitek_sc *ssc = hid_get_drvdata(hdev);
-	struct input_dev *input = field->hidinput->input;
+	struct input_dev *input;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput)
+		return 0;
+
+	input = field->hidinput->input;
 
 	if (usage->type == EV_KEY && value &&
 			(((ssc->quirks & SAITEK_RELEASE_MODE_RAT7) &&
-- 
2.43.0

