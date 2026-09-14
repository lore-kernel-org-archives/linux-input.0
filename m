Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0453B27D1;
	Mon, 14 Sep 2026 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429075; cv=none; b=vESbIYz1kwmuSXhzaPfoeo04VNe6LKu6DPQ6FFv0e1Hc/Cvrncnmr2YlQSI6VpNQfwCkfQn4bnbu2eHjwZz4Z/sMfThnSYhL9jPFJr1DO+J5FdRLIUIawpEE7AAS7pL3bolWlBFjo1SaF5ixH5NkIfkNmckjEhZnWVtcH8Crkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429075; c=relaxed/simple;
	bh=73dEZSYKQyrnCp6rva3qeY6ZIPnE2gMcsRY7zPXy3mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7aOpp1Yo6ikcUzyG0M580AXPuy4fhbkkQ/csdna04n/LCMIWUV7Zc9DYWqiq+ww2/7Oz8IFvGQ6UDcKirasdpGXGiBrZvytsa+1KbLEVdfMU8tEjvtw0OYI9GgAkEbv+PPbLE6n5h90KAj/y8U/1dD/GypCjSAtBYiNmn3TFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=rFcH7POk; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="rFcH7POk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789429069; x=1789688269;
	bh=afo39gMY1xRYx9X5Pi1btnvze6/snqsc7LiHy0/rX5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rFcH7POknqLR1leSHsIGj2tHj6lBtpQXFYPrGnONAofETHbu9JyO46f76200gMBxC
	 X45m7e6C89Pe/7JwimjHLcRpVvjvhX07wEUcnSlRat1CAKDV6J0QnacWE69/ybu0tT
	 r9kTup1HlWUrQuYK5pUn3h0MptGszmmJDTDAR8avlR9GaawvFcMdb3IhZvm5u0IMNF
	 NfmKrs+2Oxpipu10O9QVAwS67+Jp7bB6IXIv9GzzGE8zd1DanHajG8ECsB+qj6lz65
	 xeBLYLxpXzHC9F1aDSDsZvkCD8E/+OHAHFnrYQGtkKv48hamz+k10AnwGAdqhpYDLE
	 amLtxYAJ5Hz0A==
X-Pm-Submission-Id: 4hkM5Q6wxDz1DDX8
From: Vas Zayarskiy <contact@vasily.cc>
To: linux@roeck-us.net,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 1/4] HID: generic: Respect specialized drivers match callbacks
Date: Tue, 15 Sep 2026 02:37:25 +0300
Message-ID: <20260914233728.22725-2-contact@vasily.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914233728.22725-1-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A driver can reject an interface in its match callback even when its ID
table matches. hid-generic currently yields based on the ID table alone,
leaving such an interface without a driver.

Consult the callback after matching the ID table so hid-generic can keep
interfaces declined by specialized drivers. This allows the AMPINEL
hwmon driver to leave the separate keyboard interface to hid-generic.

The same callback check was proposed previously for Logitech devices:

Link: https://lkml.iu.edu/hypermail/linux/kernel/2212.0/06724.html

Assisted-by: LLM sparse
Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
---
 drivers/hid/hid-generic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index c2de91674..ebc38ae76 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -31,7 +31,13 @@ static int __check_hid_generic(struct device_driver *drv, void *data)
 	if (hdrv == &hid_generic)
 		return 0;
 
-	return hid_match_device(hdev, hdrv) != NULL;
+	if (!hid_match_device(hdev, hdrv))
+		return 0;
+
+	if (hdrv->match)
+		return hdrv->match(hdev, false);
+
+	return 1;
 }
 
 static bool hid_generic_match(struct hid_device *hdev,
