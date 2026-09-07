Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DE3BFAFC
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807017; cv=none; b=GPi3lkWZGmv5qz+t+cuDiPwv7YpwnUh2FIgKNFY/BaeHHeGYLqF3+S++LbrIN8jKx7FgiAKX4EMSPNvk/bn3ryE7YxgHgOzYVD3vTYOM5+uTL39JQ7nNKGaPzV9aUd92GVmFVCVs7KBGrrmYrMeujrU+gOb7eYQl4iAAzyz9XfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807017; c=relaxed/simple;
	bh=J9BZRX6oP1MPxPyLTPWVaWjRNa4HUnYcg26VY3Rb6Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhlW6/CQADY+Vv3W/uV14eTvySuxPKa82nS+ij9/BVha3eROCCLaXK+ALOiPSQ7fK6sJFlKdJWybqqoKXaA5/eZQYwdbZL+4L1fVQy60ejksMDcqH8hsEg6b9Y27tlesLMLuKPVooHeE+UfivilBielG7Bvd0Od5r/SwqB7YB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEJve51b; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEJve51b"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d157f691cso596855e9.1
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788807004; x=1789411804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOfBbKNvf4wumPkciSn2R6wvTiBsYFrhYc9rrrbfPSA=;
        b=JEJve51ba4qmTYywtPrxmTgZDV+nx4L6v/EyhZZ1UBWMZDVUXMZVzNWpfZlfGkOm8B
         htGgT+WhPbUI3EVRc9DhocNSUlJKktQPMiY/VWiGX9f3m93iMuTX5kwEaqr9Au1FfwGn
         RoBHwY74HEhpMSUv8EdKs2wl62WkQ5TR/Ba4wwoSJxKes4avtnRDhky7RBRN6775U7ZE
         pvRBoJKxtUYO6yCgep9dzxgjjQzAYh3bNV+VTQwLJ7mQPc87KPSJjJpG+Ifk+Ijk57kc
         imjfcc/cw3VzI6iw0ZWzHJr4M/Z8RNDdAGh1NNfa2gvMIGpDgizfHFQt37sw5GobY+4X
         Gr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788807004; x=1789411804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOfBbKNvf4wumPkciSn2R6wvTiBsYFrhYc9rrrbfPSA=;
        b=aesm/lnXxjQt++8Z7ci/rgYQv/GmXoLCWLR4PvSqfud0RmXYoUMkFYlEQD0CXga7Zm
         KRg6dIz32TqTKMnvNqFX8o2OT+f3nKUrGRJtwtjigV0b1QffI1pSWuTSwWTv2ktCQ0ud
         WAcdKgk7MTA3kVMNR91cvBHp2dwV0rpNER4sY24BHqk8GaGPDxT37AmTrZ45R7yp2UGQ
         l3F43m8gTMEkLwmDqgbA/eVd27mYc+T5Fxbv/5EjsrH8WsSlosxjuRnCv4P1Fua0zHH3
         kclf7LDFGLUNjqqN9cKJcXEcum2KgIumAjQQqDJxxNA+hDPMB+rcmqsHnACkyxj0/r4O
         8RNA==
X-Forwarded-Encrypted: i=1; AKwUvBxxIGSDMtJjt7qF6g1TeDFWwnIFMc3Mn5nSl8Me3/mLIuzeW/TnzYOFS4JYdh3dmDuLjnZHCbLt6k7FvQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kB6lobvOO2zhktSIOUi2wb/ST81sJ2VVqMqqXQUpC62g8pR9mS
	vzu4O0Yq5ZhHnjZJKtn5YiPyUZqrYnZl94wK17nSy3KTPEULzW1kFYJa
X-Gm-Gg: AYBFou1mbn8HTEtPLfJ0lb61n4c9dEIL03dbpOJzIHBBE1kBdGUm3BUNVBeagCxk5ov
	inMenSYFPoNUPwt+IH4TZmyxTiit8kbmUMBRjZbkrJTHRmgVimWeXaT6jI0xob8AR0USTh7+51U
	H/aVht3+BZZRXSi7SHxDdETv4etT0CWHGQYrcLyP5L8SKhWgpPpwfb2ZhGXfT0NjG5Ozc/gU8Qy
	JvwuCWbthvPyc/Fnei14kioOManNE6hxUwgRoPlSm0Zlf1Ux9hXFscR+VLVkJcK8vQ0Kx2KDMgL
	qtRnRPrXa+E4ogOVdglodHYM9uP+ezTs/t6BPeFgCtNHd2097ngrHfk3+zpIIhBK915FnwOl5Jn
	KAtoWgljT9LQ0WjfgOU8k+GfeZ6p9zfed9exhHZaSedP6MDOGF7UPGMTFzPKC56KuX7uwAKVrQB
	mUv4/5dC1v197JPDODk7v2c+R2YWiA5pzhNyymchj3f4L2QO9YxCdpvLWWzZPaif6VUov4pM7R2
	EXjoZB/PPyGzpGaD0PVss+ryfefl62M+7QHW9dieAVNalZlJBqwVZbJC1wkZIk0LvoBvH7EqOVA
	x6pZH0OXQItiEg==
X-Received: by 2002:a05:600c:a305:b0:49c:ff81:e062 with SMTP id 5b1f17b1804b1-49cff81e076mr147773075e9.2.1788807003690;
        Mon, 07 Sep 2026 11:50:03 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce591f846sm203600315e9.1.2026.09.07.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:50:03 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before updating state
Date: Mon,  7 Sep 2026 20:50:01 +0200
Message-ID: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
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

