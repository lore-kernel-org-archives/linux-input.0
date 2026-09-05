Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66030EF68;
	Sat,  5 Sep 2026 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788590061; cv=none; b=j1mpP9K5BxHHod7t7oPYqwCPYbSMgj72k5wUNmeshA7wBbSe5jXL/lypkqnXGR5Bht+e3m8iRGRDUtKefbV7nxsAxJZ5lQ9REPsk3ZE5WUYbGfkHB3u86mJ0Ii5V7eLasOe6J3s1Rlw00vcDV03Tr7YOjil0SEgmGODra0vL38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788590061; c=relaxed/simple;
	bh=ulsYmydCQwXv3NJEJ6v4AaFI+0YuCeAKzqzLHRlYT4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltOFwWSyewNQZNwAq9CpzkbYTVdf1Ocll/XnOixOK0h5VgobV4HPco7+MXSd80FghVUuxBZeR1Jy92IVQjJZExwjIlNYhvkZWgKQjSKXC2H1AZE3bphcc/CBa2aSFSJLIpprBwZ8wMtGDfrhXureyzvd7jyo5cVnLm/J2/KJ954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r2oEVAIP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U9xrqHw4; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r2oEVAIP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U9xrqHw4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hcNpd2JklzMlGr;
	Sat, 05 Sep 2026 08:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788590057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUN12GwvDepL+tk3DWK0mSOUPqSxmWkpN0sg4aFAd9U=;
	b=r2oEVAIPjkTodbjbWSRnhod0kgKmYt8m2a7eYNcG35ldlgpiimur5mfw3Xj2a+3089+21p
	Y08IZRvvR1R497M0UVLXiGnKatJ9NXqNQRU0earaY+AQFzJTYKj5yuVqQ4thYrrxTYzjp8
	4uTlmI94BbsRFkeplzISfr5rrAVVnIxLrdVs8J4kt8xzdgtWE2TREO1RaWB0d7YM1jKGvt
	WT9OM0qmD7DgVnAoAJ4/XnzzBvVrbvDDy/WgRuvMrmScuK6cxky4+NufCPFiU3Ph7hNYSn
	+cywgOB1rK04zYdU9C7oqeD9bi8SfPXNdzYpHpFf5vP5UoSgrx3nBrsJSpANxg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788590055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUN12GwvDepL+tk3DWK0mSOUPqSxmWkpN0sg4aFAd9U=;
	b=U9xrqHw4Adi3adKn0WSk+VCXeyG3VscCwPR++mLwGJw/EVNY1wM0lpLp+p48iPzSEKcPF7
	x4MqbM1Wcdd/9NkZskzKnLF5Tl7d4MC8SaqV4YKwoXiZKhKBPLj4YeNmUZwpcemGfv8VvV
	5El4qOpKbB5XQaJ71tK+optJ6NaUUfYmrCYTSu3+wNBm+fppGTtIDFwz7fzUTJYeEjA64g
	Fr7jBQ22sCFYBaJZrfGgK1JL02G7NdccKUzaXKiZrNoupmP9OMtoWkUqmsBVj8csqZ+U8G
	fR7aqx6Xbbl28lRRXC0YkR8MXr+DTbrgrb9qK8h/yQTFu8QPIjGR+cot/Imkqw==
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: yealink.rst: Fix typos and word order
Date: Sat,  5 Sep 2026 08:33:34 +0200
Message-ID: <20260905063335.792618-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d0af4c34ac50fda69c5
X-MBO-RS-META: mzgjhxba9hfpx9em7krwxhemnx1i9i6e

Improve readability.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
CC: Randy Dunlap <rdunlap@infradead.org>
---
[v2]
 add ']' instead of remove '[' as randy suggested
 fix a couple more issues in the file

[v1]
 https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
---
 Documentation/input/devices/yealink.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
index bb5a1aafe..79ac21690 100644
--- a/Documentation/input/devices/yealink.rst
+++ b/Documentation/input/devices/yealink.rst
@@ -81,7 +81,7 @@ Format description:
 
     Icons or pictograms:
     '.' : For example like AM, PM, SU, a 'dot' .. or other single segment
-	  elements.
+          elements.
 
 
 Driver usage
@@ -120,9 +120,9 @@ Reading /sys/../lineX will return the format string with its current value.
 Writing to /sys/../lineX will set the corresponding LCD line.
 
  - Excess characters are ignored.
- - If less characters are written than allowed, the remaining digits are
+ - If less characters than allowed are written, the remaining digits are
    unchanged.
- - The tab '\t'and '\n' char does not overwrite the original content.
+ - The tab '\t' and newline '\n' char does not overwrite the original content.
  - Writing a space to an icon will always hide its content.
 
   Example::
@@ -205,7 +205,7 @@ Troubleshooting
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

