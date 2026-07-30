Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031B39A061
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384877; cv=none; b=dl5/KP0m1nL7k5PRR5linoqiTA/mA++toNRpBtAB9udcH9eiKqoNmtB1PzH2Bfvldd0GUKeCvq/9JQXjGccPPfBEk3tuQ+KugzWEDnWPourYgfqOb82ktxX1JYkgetlGkahcmjvX4Y909PxOf7ea4E9hV9CAWgj7UXFRHJtrsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384877; c=relaxed/simple;
	bh=iUTUtKfysETR10vIzFW0p9tfuS27SYOpBdd6OglRIVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7xhrg/G013hSSIs0qfJwmcSFowCxGvdatyL9e89dRtDmWV9XFOa33LkzoX9bNreLNFnW+WkWGUFYRrqymwjrb/UjCUurIfvd2RXJmmDWLQ5sv/us6LyBPiiKL50zsiBYdf7fqK+1FHToNhBLoGl9V6VKGaD8CZSRT8tX3XrEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=gwR0W9bB; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="gwR0W9bB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384869; bh=iUTUtKfysETR10vIzFW0p9tfuS27SYOpBdd6OglRIVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwR0W9bBtsGqzM1hZ7yVsGJSPKVeGdZmJHIfMJPhNaJuCL/l3396w8elSvfkucZNw
	 uK0rozeQ4Ft1FxOteGqI/9r7dpBdLqutKfAor6+rt2CcUvp8xh1G5D7fcZdeiUNsZj
	 IKDloheGIT+HavoZlHaHFtHf7NjwFPMKtRovk4by76BnnDAvEJUdi8jSWDSV2gcaym
	 LnTQWBRw8w2jAB2Dz6wI9IPxjFY6qtR5SLQqEA2UnctuUkdIKWL+6ITsqE3ERcxW6Y
	 FJeIsS5P0c3kOlMw7sUQw7S9fLcZbEZ7RroAHZtret+j/ItRkAFicUx43juEs4aBRK
	 SPlrINDzgmdZA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 38B5A13208A;
	Wed, 29 Jul 2026 21:14:29 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v5 09/11] HID: steam: Zero-initialize reply in serial lookup
Date: Wed, 29 Jul 2026 21:12:32 -0700
Message-ID: <20260730041251.1659029-10-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When requesting the serial number from a controller, the function will do
some basic bounds checking to make sure the reply is valid, as well as
capping off the reply with a null byte before copying. However, the error
logging can leak uninitialized memory in some cases. We can simplify and
solve this by just zero-initalizing the reply memory eagerly instead.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 222b5751040a..ddd439dd069b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -488,7 +488,7 @@ static int steam_get_serial(struct steam_device *steam)
 	 */
 	int ret = 0;
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
-	u8 reply[3 + STEAM_SERIAL_LEN + 1];
+	u8 reply[3 + STEAM_SERIAL_LEN + 1] = {0};
 
 	guard(mutex)(&steam->report_mutex);
 	ret = steam_send_report(steam, cmd, sizeof(cmd));
@@ -503,7 +503,6 @@ static int steam_get_serial(struct steam_device *steam)
 				(int)sizeof(reply), reply);
 		return -EIO;
 	}
-	reply[3 + STEAM_SERIAL_LEN] = 0;
 	strscpy(steam->serial_no, reply + 3, reply[1]);
 	return ret;
 }
-- 
2.54.0

