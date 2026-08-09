Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A5155C97
	for <linux-input@vger.kernel.org>; Sun,  9 Aug 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786248400; cv=none; b=Ifma494E0SCSIV+IdQMi/c+EPT7xlysNmNljiMEEQPYpzDEqPRxIj+BwCE1KZ66Dert1bfabM6MJBx98dBOtqiJVoPkxAaTAdrR0nGiggdRdEKmay0/vodnHAnUpesYmeiWwpXFc3kenfX7fMtrGTWFv+07CeNbhpMb1/jWvW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786248400; c=relaxed/simple;
	bh=4ixdLs0c1oBF5qGMiXD9Shl1pl/8YOexLJkDMeNJ9mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlId0sWj4gSRTJpL8O+TL9p0xw1aBHsTRfVs6sqLx9st7KaaZXnhWoe3ZF+wY1bYU/psfLAkw58zaovqSeSQSrNEBDMsKtQd6IpEbKeFWvBLJuKVKgIDlQx5ZoSMBoTj4EOUQWErc0wL4+wbjGwURT9NLtsilDVeHYQ7qgxV9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGXIjS3g; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGXIjS3g"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38511175ad3so756000a91.2
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786248398; x=1786853198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZiwJ3psFmwCDlAOlTSr72jl+HTRZJgSpJDka32BYsbM=;
        b=PGXIjS3gYxbcqjqhweJkxGcOHH4vc6FKNGvVfAss7XG52jI3mhJZr3WdySkc6OgF/l
         ZahF/3Rv6uBBRH7dauQfTNifM/tNOdmh/tK/qfFcRNr/lcVLdc6ES3oXmlsGlpSKPZc+
         TGb7wMpcOInfncUCrLVNzE+qkq6zOsMYsepkDoSpH8oYuxJ3Be1DJEf7NQflgnyQ5wco
         6vyAafAYr2oY3HTU8mrl/Rvn5lHVehs6wx/5bZW+btzmhlQFA0FxQ+Lx0MbebW1MsZFx
         SKDYte/vFmb81l9Of8Y32Rp2eYMuV3IOdOV6LsRJmPvo1QMzza9NXkK9gEgCQW9QPHcK
         ft+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786248398; x=1786853198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiwJ3psFmwCDlAOlTSr72jl+HTRZJgSpJDka32BYsbM=;
        b=pEcy0g6SorY8bEpXHxSmw2YCTfMPpame/KwX3O2ddK+MQXvQUGkVwcm932XejctzPb
         XCtH5GLHximjsRXOdP4utCKQCjSuRLWb06xOiUGnHfnV7XwE/IeuuJJ1RieXOW/aEa7X
         TGBEE4TPUIFr5GGn/I2Iawp+s5yiIMmghHwbO+mlhiU84U9zknIFD/098mGCAAd8G1zf
         9Y3bdDLovT4shakQDJBGykrQq5T89/b10UqqeUNPeyT4J6uYLTr0WNMzvCdFp1RmPd5y
         QOghBIR1cuh8cSK7OY25/jKObYliJRoUCrqPwjhtzmCbJq/zdL2sq2ZkaoxB8FhKYyg5
         d8CA==
X-Gm-Message-State: AOJu0YzMUmmP5UX017oI9Zn70hvA2aC0jwMRc9sAKOO6ry7th84dV2mG
	POL/EHhsFVH+hU8fDgJKWAA21h3DvWDiHLBE3o1JXO98V4/hcsqYUZBL
X-Gm-Gg: AR+sD12XKC9S0TduG2LmgFK3rFTuh19ym5Xma2lEMd5JDRFofjsF4Fg6/KgxPbIjql5
	iXNTSQ7qtowPcYfcpTsI6NCH1KU4eI20qdH88CkX4Gz6gMoSG21C25MqbQCj2r3yoD9Fyy5OxIV
	DdSMvg/s7TwcbTY+Q3sjdhOyezHFe2p9/r90bSd2LZoa88bsExqjgVyH6VByqUGMMKl8Wm7XzUH
	ZuLuK4G4vcCAQqkD9XO2DmFJ3DblH/2o5yVsj+b4fQVjGOTiM0REZM4wBScaF++HcBgrrhAeq5w
	vKkESdwYXCaecKz0lovcSw9Us9af8qCavYlq4SE74oGmVNVz4kb97TiFvowLH4LvI2qOkZ5wymC
	n2oQnBH0SRSxpVgYHJgu8+89yUPwTElH0g+VuhN4HIn2kBZ9BMm6gqMlHmdz8qhemyjnlGTXmLb
	VtH0A6EQ3rvNxTNEP0ZJTLPNF4kGPxVDjXfgizr5p6N1GdLUrHqnqild965qlKxHpw9FNRXlsfF
	bJcYF/UAIsTjIFR1w8LuN26thIK9kAHebdeaguunzxe
X-Received: by 2002:a05:6300:6bce:20b0:3cb:d5f7:301e with SMTP id adf61e73a8af0-3cbd5f76787mr6226446637.38.1786248397953;
        Sat, 08 Aug 2026 21:06:37 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:746c:8928:e990:23a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm22608997c88.1.2026.08.08.21.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 21:06:36 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
Subject: [PATCH] HID: core: check field offset before dumping input
Date: Sun,  9 Aug 2026 09:36:29 +0530
Message-ID: <20260809040629.12666-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid_set_field() passes field->usage + offset to hid_dump_input() before
validating offset against field->report_count. field->usage is allocated
with exactly report_count entries, so a larger offset is read out of
bounds before the existing check rejects it:

  BUG: KASAN: slab-out-of-bounds in hid_dump_input+0xcb/0xd0
  Read of size 4 at addr ffff88802ab28fc0 by task kworker/1:2/48

Move the bounds check above the hid_dump_input() call so the function
returns before the dereference.

Reported-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a942efa43c928a1e3daa
Tested-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/hid/hid-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a2af..7ea1fb62b9d4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1933,13 +1933,14 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 
 	size = field->report_size;
 
-	hid_dump_input(field->report->device, field->usage + offset, value);
-
 	if (offset >= field->report_count) {
 		hid_err(field->report->device, "offset (%d) exceeds report_count (%d)\n",
 				offset, field->report_count);
 		return -1;
 	}
+
+	hid_dump_input(field->report->device, field->usage + offset, value);
+
 	if (field->logical_minimum < 0) {
 		if (value != snto32(s32ton(value, size), size)) {
 			hid_err(field->report->device, "value %d is out of range\n", value);
-- 
2.43.0

