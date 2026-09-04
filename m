Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756403BF679;
	Fri,  4 Sep 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523877; cv=none; b=LeWUtverjJqgSCh1ZUbukmnZWzKWwAz2f8KwMeZKER9CC4BNh3HUnnYZlI6svR5f+/kThMoZKpipJ1SZz/QE8O5S/m45YN2Nfw16JeI9LeQEjnuwBewtjcRIOoJEOtqa7o5Degmz94yHxWw1f2x56EGgdB7rq3NFWtUpO5yIUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523877; c=relaxed/simple;
	bh=eUjTHN9dyMl0vVDBg6k8jcBVvowq9uxqibLPGWC4dgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/rrkjKD9hfad+mb1RR9zr7ru1jQ4jBp2LZFJIpHdxUx7yzLEZjEG+XGuk1IYbOEYOsD1G0RRIWJBT3A75zSlCTAwrhUVO1BxAgXfU/2QH08L1gnQcmE7e41gmVDP+dOyR2wkrEDa8zhffWSBvUDb2vD5vj/mzRCeX4QoLk79tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZEZM99Tq; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sRfwW/MS; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZEZM99Tq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sRfwW/MS"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbwKk68lmzMlFf;
	Fri, 04 Sep 2026 14:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788523866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNjGGfYKOiqw6qQ1250aXHKA8K2I0V6WNge1XrEBt2c=;
	b=ZEZM99TqHkRo37T3FU6nZwUyEyF25bJxFcpsJ119IZ80Gf7SHyXPUeXRWwSjhmeNRV4aUu
	LVm9qHauxWYXU6Ru96uIRDItdDVSm9nv8BTnEctcADGLGT0H21XxTVJX9XxRnfXLQsBEgF
	Yuac2icKluBrNdLSoy3SyIWJpsnEqTWdxedtRxILJ3hYewyWare9kkxwVx2qFu4/sNL5mN
	k0Btp+o92ets+aCBInE1fXemk5cNWTplXRAxFnV1V65GXHccqEEr1jsW2ppGEo377OPs8s
	KhYHrYwfBFTbMQGnIw2JfSdnQDNv3OgVn/NRgB2js34850Y40ovCiRj/qUtL5g==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788523865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNjGGfYKOiqw6qQ1250aXHKA8K2I0V6WNge1XrEBt2c=;
	b=sRfwW/MS74yC0M5SseDFgxyG/M4QiiYgIErm6f6JLHJwGhyrIoAqI1oIowOiGlkNCJeMnt
	yNreAp1H4U8QLYX/2md3BU6Dh6QSRc8YZDv+91saEKYX/EnuyqOIc0HEYYGYvoFy9s2GPE
	0f7+bAf+4E92PlF34DQ9KGOBLTYmPj2ZtU571UO0zAQA0SVuySBbbleLEunqy4i+bCkLNF
	knj+VCEnU5ysDC2qLbKlk31f/0+Q0bLiIzWjtjN/MeY7KJIwbT8rT1rStLU7Mvm12/YZ5m
	WEB5FspQOy05kxMQIqNJCxE7lSH8Y/GwdoYA7m0fiJQ5Xi9MFHZWBQu1b8wJzw==
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/32] Input: yealink.rst: Fix bracket
Date: Fri,  4 Sep 2026 14:10:26 +0200
Message-ID: <20260904121026.759218-3-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o6bb1kuonptaokoy5ajjctjpd8pfjtma
X-MBO-RS-ID: acc02d7438f2c191d66

Remove needless '['.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/input/devices/yealink.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
index bb5a1aafe..de86cf7f5 100644
--- a/Documentation/input/devices/yealink.rst
+++ b/Documentation/input/devices/yealink.rst
@@ -205,7 +205,7 @@ Troubleshooting
 :Q: Module yealink compiled and installed without any problem but phone
     is not initialized and does not react to any actions.
 :A: If you see something like:
-    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
+    hiddev0: USB HID v1.00 Device Yealink Network Technology Ltd. VOIP USB Phone
     in dmesg, it means that the hid driver has grabbed the device first. Try to
     load module yealink before any other usb hid driver. Please see the
     instructions provided by your distribution on module configuration.
-- 
2.54.0

