Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C363A1D05;
	Tue,  8 Sep 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868603; cv=none; b=h/2UnmVnDCTSiN0enT4nabsNKawBvBVQbIufo2/ZxUmxhx6ESQd5JoiS10ig5njqQaZ01+hJqsOmF3I+FcT6GcMgFArAqofHZ0fuUWQEU0kXhC4eSk/uYe028Kz4F4ryWMbTtE9CcGBM8lpnjszaQfgF8noEEEJg6NhGwFfJgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868603; c=relaxed/simple;
	bh=hIXMu7VU543C5Aw2s+U1JIXfcEKqYnSmUqqOkmBcGmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezJgTWJ3E+VZtBXzzViXWCMw2Z+bXXH3ZdktS5+xOVwNHEXMQNYo1JnFXVwkPQYSbhFAD9bqkbOh7vrqa7xkwfIV5aVj2skbiqqmIMdX8XK9+82yPaN3OCWFeETKzy51K0kkF9OcJWoMoQ4Gty1WxVRp0MBqTVUxxtXnsaRmb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Mrt19+H8; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SQLx3Gh1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Mrt19+H8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SQLx3Gh1"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hfMq537XYzMlGQ;
	Tue, 08 Sep 2026 13:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788868593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rc3f0b6JALEUQytgIZPa7NtSat7l2lPyA6Q0PggfoN4=;
	b=Mrt19+H8dmwUc2patyXDMxybd0eLPk+HEc8wXzlUFe8EtEIwBgZ5NJyjRxKnHsWKK5/ok6
	cQBxR/4xW7Kfb31Cm2xQmeyl05DcJr7rjT3kcOGN/uF0QlsajQbgimstqDw0KSoL0frWkA
	rPGgckuaLvP4eTF/mtsY2yBipdbzlF/NNJLNj+WVOmdkIo2DKQiKb7ZUf6YfbYqDAoE5nG
	Kxy1BUUW2f76hvi7iZv+RgvoCySTnYL5h2KH2bh7Niyz20fqZGJuXu0gqc/IKuH6A/oRea
	u8QPvxsk4o2gRKK39dTQCUMJw+k7xEK7SOfWao6XuB8p6661BKzf28vsW+E7ZA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SQLx3Gh1;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788868591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rc3f0b6JALEUQytgIZPa7NtSat7l2lPyA6Q0PggfoN4=;
	b=SQLx3Gh1s1sQiVDdVZ1HxghTcr4xz0T0DRACs8DQV+jfn9WOWewWNDaWlOsB79aj5HXQTk
	47Mbo8kj7L1p6NXXV7CwulzhM1ZADHgk1Pf3HiHYmKCYZGfhPzN675T+qldPB8BSOOkexu
	a06wWh+ayGFLJX0dzagA6yG1JALtXNPf04vxEm/zxMKCY1FFknlOoKE02V+RmCiP5KVrV1
	q3V7VkCT/t6/rFP2cg8jG6Lvpg06XD+boQKMhdes8tqqfLvJ08O3KG7PQ6a7lneCtG/5C7
	sHeVfZgQvkaNNcjXRFrwr+ScEt/GCCvzGJR9YJb3BSyFGlkTaG0PhyqXRrBHBA==
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Input: yealink.rst: Fix wording, quotation and typo
Date: Tue,  8 Sep 2026 13:55:50 +0200
Message-ID: <20260908115551.1345764-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yebo7f9egk9rbk1aa6ze4t8uj376m9r4
X-MBO-RS-ID: 899faebc50bdf9fee7d
X-Rspamd-Queue-Id: 4hfMq537XYzMlGQ

Improve readability.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
[v4]
 fix quotation

[v3]
 https://lore.kernel.org/all/20260906095502.1116994-2-manuelebnerli@mailbox.org/
 fix wording
 droped white-space fixes

[v2]
 https://lore.kernel.org/all/20260905063335.792618-2-manuelebnerli@mailbox.org/
 add ']' instead of remove '[' as randy suggested
 fix a couple more issues in the file

[v1]
 https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
---
 Documentation/input/devices/yealink.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
index bb5a1aafe..53191a3c8 100644
--- a/Documentation/input/devices/yealink.rst
+++ b/Documentation/input/devices/yealink.rst
@@ -120,9 +120,10 @@ Reading /sys/../lineX will return the format string with its current value.
 Writing to /sys/../lineX will set the corresponding LCD line.
 
  - Excess characters are ignored.
- - If less characters are written than allowed, the remaining digits are
+ - If fewer characters than allowed are written, the remaining digits are
    unchanged.
- - The tab '\t'and '\n' char does not overwrite the original content.
+ - The tab ``\t`` and newline ``\n`` characters do not overwrite the original
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

