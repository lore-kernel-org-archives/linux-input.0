Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458B411693
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542273; cv=none; b=OJnhr8UtIVLBwSM/V1tR1JUjlyK1Ocj1eogm1zCGEdwGK5i4HnPU0LwEHDeIS81x0RjgmY5Cv9y2iRYtT7NrhFyqk2RDQt9ExLFy0My3ba6G4iomLGstGZ2kCG+/5T/QlBO27/v1Hn+GIuaWthVWWBe1+CmF6RhJkw5lxzwE6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542273; c=relaxed/simple;
	bh=s85qQNiHVEvW3e0m/zd1/GCoGy2nz62kaOetTwGqrQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXeB0WsN7iTXvWA9qO2/SSQWFC6Zv0pdFvuzWv//XiLApPUyM1xsbNNB2m0esYnhwI76XZHG1HWaGP89nqDXUcCBs6jXjcaSMANOMFNTFbEtf+RfGwsWSE9X/7uuOHqnfh4WAd0E+Wkf8pbC9hK3LQ99Vut0jz6XCkXr8Cz9JoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JXMjhdrG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JXMjhdrG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781542270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Qc9+XMhLmjnJObvngQIePsOYaXPwg+0FpYJS2QDFwg=;
	b=JXMjhdrGiP5TTi3FiXqknJmtumJI00K1UHVrs6/rZz8V8TrVVtysAdJ5572oW64qay3Iao
	nNCIDpCQNhLfTBoFwOX5oGNDgYrXwI11OYwiNR9GyGKSc38GuSZKlyUMZLlJbrCav5z8ms
	Jks0Lj8TTsDP+ZbV/5rx8vI1R2xmNfk=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>
Subject: [PATCH v4 3/5] HID: asus: fix a off-by-one issue making a check stricter that it needs to be
Date: Mon, 15 Jun 2026 16:50:56 +0000
Message-ID: <20260615165058.3845-4-denis.benato@linux.dev>
In-Reply-To: <20260615165058.3845-1-denis.benato@linux.dev>
References: <20260615165058.3845-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In mcu_parse_version_string() a size validation for response is stricter
that it needs to be: relax the check by one byte.

Fixes: ("hid-asus: check ROG Ally MCU version and warn")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bbf964b12c16..6896730efafc 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -835,7 +835,7 @@ static int mcu_parse_version_string(const u8 *response, size_t response_size)
 			dots++;
 	}
 
-	if (dots != 2 || p >= end || (p + 3) >= end)
+	if (dots != 2 || end - p < 3)
 		return -EINVAL;
 
 	memcpy(buf, p, 3);
-- 
2.47.3

