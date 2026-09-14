Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305243B38BD;
	Mon, 14 Sep 2026 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429079; cv=none; b=h5kSDHgYV6emvwSNRDlHJNrZnLyC/LmLUn/1VJqF/PHUpVDbYxt+ghwNcXMBLk5il73yZO6nAtT1tL5slgT3vR+UZQo4XdePk96wDdkodcuOYxc0G0npV6HK7Ptt9/iZpFXAwMk0MkMoJ1KozK7OS4tt+5Rzug4KZMn4ONzqyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429079; c=relaxed/simple;
	bh=UNFThLNzlgQn3xGsJH+W8fOTAc4yA9tzNHzeyyZNtG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4mBcHeZSTxW9hvOKvrLYf4WXc3E3VKTqqYZkDKWTjutuctV9Oj0nqoMSsQzX6vMy/nK5N2346+OlaTExNtbPgMOT0IIbqM6yY1/tRelrwCmSkcljKA44WQZMzKEwhKEy2FwRF3fPoepip8D1Hnyh0NCz43049sU2bz0sN5eNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=NrUN4bkS; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="NrUN4bkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789429072; x=1789688272;
	bh=4tZj5Jn525QkA17zwkfjXmztpwCqZhcxjdiG+hyLmBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NrUN4bkSpGQmbk0q5mJWBGEUR3FTs4IG4cmmfIy8JFQ5dYMCPWD6M/tmHhbtaErOf
	 pRNZmq79QAPVhUIew2K2wQjGCwsnfFMOLItHylxYayMoikjqCHiJxxrC/MGBXveB13
	 bIIHRwbr+pogcB0LhMi5uTbyzuF/YdEi5eavHess1r6SXAMjUwk4ZT7QA/QO2Kpi5J
	 B2jiC2MANlGWAHd2CJuFGk61AXIXxf0HcXgKZ3F/lnCCYXWysShU6OzP5qE2VF7Y3V
	 qe5DS+UndK3FKG3JKBKCJg3jF6OfZWhyiJMzr813VZphEM1fvj2RcSSAa4hD55ul0E
	 fTPWKRz/hjfaQ==
X-Pm-Submission-Id: 4hkM5V46g4z1DDKv
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
Subject: [PATCH v3 3/4] hwmon: (aquacomputer_d5next) Expire the initial sensor cache
Date: Tue, 15 Sep 2026 02:37:27 +0300
Message-ID: <20260914233728.22725-4-contact@vasily.cc>
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

The initial update timestamp makes the cache expire at the current
jiffy. Since aqc_read() uses time_after(), a read in that same jiffy can
expose zero-initialized data or skip the first legacy report request.

Initialize the timestamp one tick earlier so the cache starts expired
for every supported device.

Assisted-by: LLM sparse
Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
---
 drivers/hwmon/aquacomputer_d5next.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 9178ac4cb..b58f5b5c9 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1531,7 +1531,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	priv->hdev = hdev;
 	hid_set_drvdata(hdev, priv);
 
-	priv->updated = jiffies - STATUS_UPDATE_INTERVAL;
+	priv->updated = jiffies - STATUS_UPDATE_INTERVAL - 1;
 
 	ret = hid_parse(hdev);
 	if (ret)
