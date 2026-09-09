Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA051991B
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949760; cv=pass; b=FQ813FUUCGACexIaUG9z0hs2fVizkyY0lzKNn3z9+BEBDHB7PeKD7TlA3XsV/zQwpC4TvSGx9R6Q+dFw4jE0pq9r/TXM6lBlEcZc2XDrhAYIU4W9g/Xl2o0FM2qJnM5QwlNFPtpZBanNNqntCw5pjsQT5K6OrF7JZwZP7FgnSes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949760; c=relaxed/simple;
	bh=J47IYNdod02F1g3+6k0lLJqlTKfvKgWjoiv7iAB14FM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4Lna0BWRXhKRZyJkZOYU4mstpoUriqaacJY06W7jIGL7/CuU5agoTwaPTD2T6wrpih8tXFaxTRmmpBl9xggpE1XL2Q2WIDABAcq/5jKVshd6ySAxljQRTP/NBWvGUxvSmfwptWtjzjZJqHVhM3VJ3abGDnrJkY/5eWTi0cJchM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITjnVSwy; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITjnVSwy"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0d31069so559031e87.3
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 03:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788949755; cv=none;
        d=google.com; s=arc-20260327;
        b=qimXKdfxE1VZQ7ONR3lZIYbQ2k0FLpgk5fWZpJl8SBiOm1IMuu1iNoL5hOR2ZObuCn
         OdxMb6Dk4YYv5mb8vy1i59R55CC9uZcPlI08u1m3h7a3lT13JCXI9iOzVtO/yG184MQB
         NjmGc5Vj67EJiTbTAxM0qV3SGHPYFh9rqbjjZvrxEV++nOlshfI/ZrTJwYZwEh9mgls8
         6Db6dslnCfcMXwBM95H9F4jqCbskjSOJXwP7gNiLD097/skKjM62NTey7fPYjVWGNNhP
         1MhZZrNa5MzyDlYg+0e4wFR5Dj2+dFhTOcLIgqlPIWXWdCOZp5oYsgZPldujScvPG8zu
         a5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        fh=DYskbriCw8V1zpaam0TvCfn9zrz9JQj33ZGKdXHr8zQ=;
        b=C/Dt6OBl4zHb9fYotmvO+yxN8HBzeXaroxI7kCCj172zt8faEYRwMrQNHd7ZzaWenF
         vq5ov+wsX5C5O7fPURfAPZfNtDN1Wo8BLIr5r/l6HZvATaxV2dgvAqwFSuG0tvRkCXNQ
         J0UyBlWIDXOGxiItZP6sssS4vQG1YHy05CIStadHF8BQf/5qFc284p4TH4px5kMo3WbC
         I43S2CPEk3M2VgRsqDU8r3Uv4zUYP/siWq3OfqYNJbQJew30XPRQageQ1VRhoLkL4c6u
         C8k8+8dxNmBpUsU3ueHrL6nll4INNmtFFDTJlQrLHnkOiQM2j2F6F3Okgty5cfnkwl+E
         IvyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788949755; x=1789554555; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        b=ITjnVSwyLX+koaMbfacdPUYeMT86TVB6KnRaAnuXc9LxcstfdcY7zF5pELZAx8Pq1y
         wCSt0nnLEp/PJeeGZBGHfXY9+7VjpSlqRxvQ3RgeLjQP+LK7ifwDS3gq6xbtwEbUvOga
         TsAQWzWu2b2QjJvlm4D8nMZ6CvsRqdNGJ7DZ5dBpN43O611gcjTtPWOeTTColbM5QmfA
         UJJ5PMffpFW9GyEFx+CZmmw903cGxNFJun0Spgtn/k4sSxEofcYtmLT9Thbs9gLgEBvg
         LHUoTpGB734C1QQXfXPmAPL2ygKiZ+lYErDixiBGdbgwudT7alnBhlqtoxv+GsB7oI1f
         EMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949755; x=1789554555;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQJPNUSAFJ7E51M7cx5Rfc6me1C9+bNgv9Pw72X8t8U=;
        b=NaDStalVS06Dq6iEfeJJFrbCl3bjqIOAu/qwhEsav+PnlZg1maWV1wcDOKQ5zE3JY8
         qifnUOjiFYsFMx60VPBGexbACqMiGFUVgczJJzkOMEcHh5zS8lyy0f/wgubDwQ3bn9Z4
         cILwWxBA1FjX9Fb6LUzWh9j0/eiqqw6VkE8vafZG8G+NCl4gcwWefqhY3XfPJu0sGT6e
         v8TMktIJMDiBj0RyiudqGdI1UPu3sIBvFDDXNpN26GMBdUMlnukUoRWEqdC4RSDwPsrr
         4j3ekalx0To1pXAB5if8TgRlZnsLvbFGK8Yw5yJUfTsIXcD5+nv/W38aBk6ltOWlFynM
         e4eA==
X-Forwarded-Encrypted: i=1; AKwUvByKi9G42IRk7GfKprzxj9l977sTWQuA0z4g56ej+N5N0r/MxDNz6CypQlKehrFVQ5qM0nIsjbjN3uJTrg==@vger.kernel.org
X-Gm-Message-State: AFuF++mDg1tTWBMw0wN9YL+vcAxEEpo02B5VPbKDxeA6OCb7lrw1R99E
	eIN2c+HqUS/b+VFiEBKxogUmmrl0AteP2ANl3npsidj17K4yknsRU2dWMp0tMR/AdvS3SzQxtNI
	MMdGHHUqCtOhX4HHwbyUcBQlDesbpXs0=
X-Gm-Gg: AYBFou0+f54CXrHWAvqlT/YAUi//mc1H8EJF+tv7EBlsqowmE4bEZOsK09EOKUBztAL
	ew4oEx+AQgUORTQiMdY1SX8hC8e19eB7sdwAa4vvfHnRTr1g1hw92R32GeipE1oH+KmQ+lCR7zl
	AMPDJUlI/xYj3+TAxoZ9Xdm2CH5K9NIANXQWKrPfbyLnjPMieZK7DOatXZHNFX0GFsLWmHiyDzU
	DkWBvfi5buyDRem3mwQYQajW1F09nrSVO8aUBcUT/aONy0NVvdUNIVA7I4z5GrP5HvHbmaMwyq/
	Df+Ph0Kuf97I/wXYhqmdD5uKDH7fWLd8tBVGuDboXLaxdR60awTa+zrTJpTFloMPZPu53fh7ruV
	wLlF/aa0aCGmt02xsjWD4ENyxDSMYb38UhKbcjpCaw6wWVZQe8kg=
X-Received: by 2002:a05:6512:33d3:b0:5b1:5b49:9463 with SMTP id
 2adb3069b0e04-5b61705a661mr5719374e87.4.1788949755153; Wed, 09 Sep 2026
 03:29:15 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:29:12 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:29:12 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
 <2026090833-mutt-whiny-242e@gregkh> <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 9 Sep 2026 05:29:12 -0500
X-Gm-Features: AcwNN1U3c5d0ZRbND99B9WQAjVzD5VEcqFI4ZUv6legwqveMel1HfygidncW3Qs
Message-ID: <CABKbRo+qUMG8=+-MnY34KkscgZdPASieN7CgWce9BTCggNSvcg@mail.gmail.com>
Subject: [PATCH 6.12.y] Input: aiptek - validate raw macro indices before
 updating state
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, 
	pengpeng@iscas.ac.cn, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

commit 95dffe32a66cbed07fbfa7afed39d56d5014e04f upstream.

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
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 drivers/input/tablet/aiptek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 2b3fbb0455d5c..9e78105bace77 100644
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
