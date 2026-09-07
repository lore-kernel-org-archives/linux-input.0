Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDD3B8D76
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807009; cv=none; b=lUg4Hg4xGIRsJO+lRif+T6az/7WnNBMIe1wv/frNgrpjECX/ElZxxmoiRgqyL8TskFsxSrt4D19XzSo/Z4Rkr2gcO4XDcr5C+0ha0rk5AGiOHyM2Tp1p5bItC6l8DFl7UVckACGlpfegcXLDid8VaEh10U5k6GIjO5RlejOwPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807009; c=relaxed/simple;
	bh=J9BZRX6oP1MPxPyLTPWVaWjRNa4HUnYcg26VY3Rb6Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q821LfMcIJ2xSui323vhas+XpmGfCT1PdfsFO45zEctIzGLzJYVWzaWM8sEqpgijy46Py42mnOtINrlrKoL1HjsQ8uZDU7OOw37ErAXXipJFpzhjEN/kSjqJNCcupuHMEjNV0SDXHLNIGp3sZge3rNRm2c+IHxP3k7oS6v3tLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6vsse4p; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6vsse4p"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48583cb7d44so325501f8f.3
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788807001; x=1789411801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOfBbKNvf4wumPkciSn2R6wvTiBsYFrhYc9rrrbfPSA=;
        b=o6vsse4ptwttyaOx3yFIBq98r7AH+n7Q03IFMxtKwcXabToVonh/SYsAOTpIXdE6ay
         lhfCdpRtMMBpVqVQt9NxJTS2f/tsL3lKLbGWxv6elm2Q6O2/EGbM6IGQAv4VsJEIFvlt
         ku07KTIr/rTcPQweNKAY4cTyWMaL57scHWzvuUHVTbQHAgfRjLsskoPUGBfo1bHoQBbJ
         ZzPZOJz3bM1/fFeXBMaikV/vE5m/gTGG5ecDSOl7u0danEJQPMY1vEwMlZ7xHX8/9qQp
         W1qnaAp0Bz0jUGRSbBYqkCe1AL+eLtLFw9cR7BLdjcdQMlCorDkJYBrxMbXNlmhSSZiL
         YBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788807001; x=1789411801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOfBbKNvf4wumPkciSn2R6wvTiBsYFrhYc9rrrbfPSA=;
        b=aIH8Rvfl/P3VYZBOiOK1AEfSNVnNpkiahJE6SFRbQcZYDrf2WiG32N6VkErlKgyPgG
         O/kP8HONkfM0TuUPwybp+srk0iaUi7fU2MFG+3d5N7tPxXz/5UepbnJgYMdpJH4eK42e
         fnolhCTCKiUg90pYLAIytQEwe5RI0oUvCgsBiQezHxSbAGNwrc0X0Ueh3PS1MmFuk3jR
         rVBChvs6eFxzTWaP1IwhG46PpBwC5WHMmY3SrDHTaXxrOV7d4q2lVJFhzmaKZbVEQWi8
         h5XVVjXjy4SV6FitHF2QEx+IbgzZYjwnlWtGDuc4mrT/ZgLyMrxhk4yvB9a70ynIsHIt
         IiCA==
X-Forwarded-Encrypted: i=1; AKwUvByyiUkUOQrUmPWghtnb0RodB03coHVaiYny3NmdAEVrQ3/YSuTof25ZVpV6vJhP+NtbwV8EwOvsAJ3uwA==@vger.kernel.org
X-Gm-Message-State: AFuF++lH9S+OY0NRM+c6MhOyw4xzWoihqQc/nhKS+vOEk53UfEPY/C49
	Ju7vvMrI3919JrbiSOHaDprukW6ZV2I+y60eHlnUm6DrH93U1DfKxhHb
X-Gm-Gg: AYBFou2pUSgtKzA8DenfU8m9cOYw4hVg5/S77c9G1hbzO1qXRGLf0k9mKjADiepQSzH
	mzxp/LKcUM99c9hcfWyZTvAU/B2xw/V84qQCXIfUu38u4WTMRhZY2pATEyJHr1fR2fcNd3EnBGG
	LQt+lzIM1EPJcshSFY5wTohI3i+SeB37OEAfgEtPuZJt1BWgVBy0oHW3SY6OVJXEDGvrWXAAFnE
	gyUwiD+vxApb2qAcl1PBsFHfiVqbEVC1faIY1JaLaNybbh8D2jpk9MOTMtaAQndN71EOw7q+QHK
	ZgrZoUz/cabBhlChc1Zx4f4ppSyeyNEL16TYDc9UOBQFt9j3zYi5NbLAb8OgaH8NoLhzzTVuPDy
	/PEDbpwB8k5l3XZx8ypfEzox73+KgvoSZZ2AtcctYwMlxv1i22bCNnmwpkYOO4tGDjvMS60TnQn
	VyWzKSB8pxZWm19n7GNZt6on1kQ9JsYPCYfvC7zd7sRXVXgoVvaJh6M9KxOOojt+IDG9JSMCx+B
	JsAOUnqySGGGdXATUNIbfh/XMSTJleW7fIbTOBZvOLKZWpdx518yhCr2KQnnDOFgJfhKSQNvmvR
	YcPmM0bchEfGv5E=
X-Received: by 2002:a5d:5d02:0:b0:484:398f:2c7e with SMTP id ffacd0b85a97d-4859796277fmr10518031f8f.0.1788807000882;
        Mon, 07 Sep 2026 11:50:00 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm26480510f8f.2.2026.09.07.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:50:00 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] Input: aiptek - validate raw macro indices before updating state
Date: Mon,  7 Sep 2026 20:49:59 +0200
Message-ID: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

aiptek_irq() derives macro key indices directly from tablet reports and
then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
the derived value in aiptek->lastMacro and later use that state to
release the previous key.

Validate the raw macro index once before it enters that state machine, so
lastMacro only ever stores an in-range macro key. Keep direct bounds
checks for report type 6, which reads the macro number from the packet
body and uses it immediately.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn
[dtor: fix macro fallback in report 5s to use -1]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
(cherry picked from commit 95dffe32a66cbed07fbfa7afed39d56d5014e04f)
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 drivers/input/tablet/aiptek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index baabc51547b83..6210cd99d6291 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -658,6 +658,8 @@ static void aiptek_irq(struct urb *urb)
 		pck = (data[1] & aiptek->curSetting.stylusButtonUpper) != 0 ? 1 : 0;
 
 		macro = dv && p && tip && !(data[3] & 1) ? (data[3] >> 1) : -1;
+		if (macro >= ARRAY_SIZE(macroKeyEvents))
+			macro = -1;
 		z = get_unaligned_le16(data + 4);
 
 		if (dv) {
@@ -699,7 +701,9 @@ static void aiptek_irq(struct urb *urb)
 		left = (data[1]& aiptek->curSetting.mouseButtonLeft) != 0 ? 1 : 0;
 		right = (data[1] & aiptek->curSetting.mouseButtonRight) != 0 ? 1 : 0;
 		middle = (data[1] & aiptek->curSetting.mouseButtonMiddle) != 0 ? 1 : 0;
-		macro = dv && p && left && !(data[3] & 1) ? (data[3] >> 1) : 0;
+		macro = dv && p && left && !(data[3] & 1) ? (data[3] >> 1) : -1;
+		if (macro >= ARRAY_SIZE(macroKeyEvents))
+			macro = -1;
 
 		if (dv) {
 		        /* If the selected tool changed, reset the old
@@ -737,11 +741,11 @@ static void aiptek_irq(struct urb *urb)
 	 */
 	else if (data[0] == 6) {
 		macro = get_unaligned_le16(data + 1);
-		if (macro > 0) {
+		if (macro > 0 && macro - 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro - 1],
 					 0);
 		}
-		if (macro < 25) {
+		if (macro + 1 < ARRAY_SIZE(macroKeyEvents)) {
 			input_report_key(inputdev, macroKeyEvents[macro + 1],
 					 0);
 		}
@@ -760,7 +764,8 @@ static void aiptek_irq(struct urb *urb)
 				aiptek->curSetting.toolMode;
 		}
 
-		input_report_key(inputdev, macroKeyEvents[macro], 1);
+		if (macro < ARRAY_SIZE(macroKeyEvents))
+			input_report_key(inputdev, macroKeyEvents[macro], 1);
 		input_report_abs(inputdev, ABS_MISC,
 				 1 | AIPTEK_REPORT_TOOL_UNKNOWN);
 		input_sync(inputdev);
-- 
2.43.0

