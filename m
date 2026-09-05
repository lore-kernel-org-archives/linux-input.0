Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12AD3603EF;
	Sat,  5 Sep 2026 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594137; cv=none; b=bvwk7XbXSoylPCOJ9a1Uy6dOVWwtZeOKzaPFhsAkZRvN78MwfXGZuiDZOmUJUSqHgAGTiGJcESsotdJjdOtPer13GziiqXPMdGIdHkPro8Rrpgh9L+DnCEXDcdyhpI+cDqyjAQRacBCK3qsgCoUW8NY+mvqKFbC1xbu1IcNm25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594137; c=relaxed/simple;
	bh=H/eaZqgq6qpTvuLcQTGlhufT/bMaJTRmkMp3ieW6DoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwLMJlhjgQZQJQNGabftR4H76iQiUKwgYof0JlPT64DUQXYhT1EX8C7TPt2OyF5wEW0BUQMpbj9wnzSsggumMo/90KuRD6TPGyW6dbI2zPGbqiomZw/uxExEnCjYTX8ubobdAgl+S3yXDTDH2R1qMcS0YB/kzTPCfj2Z9Ka5j6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XARi4o6T; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nQPnyGt0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XARi4o6T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nQPnyGt0"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hcQK01SvQzMlYK;
	Sat, 05 Sep 2026 09:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788594132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X5Hd7Q71LOMdduJNGEqX9EOif90ZZA++3BDP9oMJwCQ=;
	b=XARi4o6TUXXS0xBx752ui8uGwmgh5PXlExAs6PrTcima0obBd5zUxljp+XciXwtbo+mcg5
	B7wYjd+6d6zB1RaOZAkkSoCSirlRIpZuS2s/u26xmuMgRmRyfeFxQB2fZPjIPFJDB+nPzt
	VtcxOwE/7O5vVRezh4BzKsEA32AbOM+3tGAYYcWE0JPLy0q87p8emBrLWAzPANxUOMCU6I
	LokYg1PCpaSwQ8LOpoCKqbjDm+U1oBojr5s/UNVm5d6WYxGvoi18ss6BBPVpmVo2hKUECU
	WEEDNdsLMBb5N4G9YwXaxahPVDspXoA+Imubd8j/bjhcucsSXJdpiWGX4Tq7GA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788594130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X5Hd7Q71LOMdduJNGEqX9EOif90ZZA++3BDP9oMJwCQ=;
	b=nQPnyGt0V+XhPTPKmu279j5+cRyP3KqJyCu3gdI/YLnuFRByAArENSVKe4lXqamFNHLiMz
	e/qsakJ7ZmRvFfXW5SOjHX6y+iJnCkCvBqo/8i9zPyMqYVWKB3rXp81TmjBDjRAoyn3Iq1
	Rowczdd+4mo0kBzw9HnaPNul8p33MKE7La+s1pUHPg1aX8mISDcJOmu4ziEcqdIGElznGp
	cFlp5KYnoltMlLwz3BnDEhPMC68znn/kPz63dQwMYdF3kwpc9sjD1DyP0rgbSvCLdfevj2
	SdMi8ZE1+hhcCmly9CqdB7P7+OTzqp37kDouorhm5AkBPX2Lbb66rcn5umwfVg==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: input: Fix bracket
Date: Sat,  5 Sep 2026 09:41:42 +0200
Message-ID: <20260905074142.810529-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g9zofrnjn499zh5m3pm1kwrtdtb9n8oy
X-MBO-RS-ID: 321062bde63ba77fbae

Add missing '(' to C snippet.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/input/notifier.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/input/notifier.rst b/Documentation/input/notifier.rst
index 824379399..e7facd1a1 100644
--- a/Documentation/input/notifier.rst
+++ b/Documentation/input/notifier.rst
@@ -31,7 +31,7 @@ In a rough C snippet, we have::
     kbd_keycode(keycode) {
 	...
 	params.value = keycode;
-	if (notifier_call_chain(KBD_KEYCODE,&params) == NOTIFY_STOP)
+	if ((notifier_call_chain(KBD_KEYCODE,&params) == NOTIFY_STOP)
 	    || !bound) {
 		notifier_call_chain(KBD_UNBOUND_KEYCODE,&params);
 		return;
-- 
2.54.0

