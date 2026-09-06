Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D230EF8F;
	Sun,  6 Sep 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788688550; cv=none; b=WcLA/OYoA1/JAbor7cUJyYsqKhtx0NqaOIl8vS1Nk1+I/2ag6y8NbbJK//gjT9ylhP4DAhRLYORF09evHPVy8LUorMniceIirMxe4OXqFB4gNHuD8xn3nEICHMAzZds7ON8G0OTcdoUsn2wTqOW4xUvY3PWrtw5MezngnvFd/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788688550; c=relaxed/simple;
	bh=PdHtFQrEZxRfQaRuGUkHWy8lBIJMWWh/R5WreXfjkjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idevH/3yj1KMTMa4s4hcbD2wWfVyp1IGI9iWl3Q6UYuxbayPxyKxhumzM9ZydydJDu4GcdKKXYTJYn/5XbSbxF0fDEcYwVl5s2cbdU8e5+VzL88Hsn6YrOWts++33kck1nqupIcDxB6WNsMW7WvU4KGLT777prwV+0EJ6fawhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G6AmEr6R; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N1UXkGmk; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G6AmEr6R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N1UXkGmk"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hd5Dd008HzKpkK;
	Sun, 06 Sep 2026 11:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788688545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oPXfaCRDk1r/LjHJS3QxVcLwQH8nVFZEFREmgckGdOk=;
	b=G6AmEr6RaopjbGSxBwMiK8t1vyFIFYWGHzGlL+3arXcB1O15URIGmPA7sTZCE114BVPeA2
	aGoZkEaVat4xF1yQO9dAOlHrkbO2a4Rpa7Ghrtk/nPmTqsYIykh9huCZu+77AFGMdNXz8D
	DzK1Tw7h7ku8kTsCqnHBMU/+zXKEykIFAVna1YdNWxZmlY54nMCHo6a72xv6CnfoHNDUo1
	F+wxCQsgpiU+avHQ1Wm0ZKYE7LnbaphYFxcCTkhCUD0k0AnmyuA4TQQDvaSZt9vvZnul4N
	wRhw7/OUK47W/pvv49h0i+57vY4sgpzFJik83ctSmI0P6/fYxE7mm6lFmG40eg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788688542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oPXfaCRDk1r/LjHJS3QxVcLwQH8nVFZEFREmgckGdOk=;
	b=N1UXkGmkM2ryxKWzH9GT4IQgi9FbZE92gnEcG87GCFBT/ydlnnYNpcIMWL/oE/svTHuDB9
	olFLqg1CbxyokVqjtpsS1iwmvlrOizzQx5z7NDSpoEbHyGio8ABG9uYlvwdrHZAz5iJ9El
	Hn5ji7vXO/8k2wtoGMnQ5i6UF58pNa76DWstDaoBAwuPP1SycX6sVRJgW6QJAtisTTGt2k
	RleaBsthkV22OJXTEetmwJ/GJ2wLSzGBaEM7WDz/r7qJ6kGyyBl4F9l9rW4GoKT4KdqTcw
	zqShrBCFmtY0dUupFReY4dzeU5+jSbvXKqUVeLaUJGldMYme87ZR7+L8DKxpsQ==
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: yealink.rst: Fix typos and wording
Date: Sun,  6 Sep 2026 11:55:02 +0200
Message-ID: <20260906095502.1116994-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dgeho1ku1ge6gj44tqtkhfm8g9na5b19
X-MBO-RS-ID: 74edc56615892b4233d

Improve readability.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
CC: Randy Dunlap <rdunlap@infradead.org>
---
[v3]
 fix wording
 droped white-space fixes

[v2]
 add ']' instead of remove '[' as randy suggested
 fix a couple more issues in the file

[v1]
 https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
---
 Documentation/input/devices/yealink.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
index bb5a1aafe..de1460b6b 100644
--- a/Documentation/input/devices/yealink.rst
+++ b/Documentation/input/devices/yealink.rst
@@ -120,9 +120,10 @@ Reading /sys/../lineX will return the format string with its current value.
 Writing to /sys/../lineX will set the corresponding LCD line.
 
  - Excess characters are ignored.
- - If less characters are written than allowed, the remaining digits are
+ - If fewer characters than allowed are written, the remaining digits are
    unchanged.
- - The tab '\t'and '\n' char does not overwrite the original content.
+ - The tab '\t' and newline '\n' characters do not overwrite the original
+   content.
  - Writing a space to an icon will always hide its content.
 
   Example::
@@ -205,7 +206,7 @@ Troubleshooting
 :Q: Module yealink compiled and installed without any problem but phone
     is not initialized and does not react to any actions.
 :A: If you see something like:
-    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
+    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone]
     in dmesg, it means that the hid driver has grabbed the device first. Try to
     load module yealink before any other usb hid driver. Please see the
     instructions provided by your distribution on module configuration.
-- 
2.54.0

