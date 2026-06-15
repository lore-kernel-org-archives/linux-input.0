Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64B416CF3
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542272; cv=none; b=MkqMt6TbUAxCIZLTVo2njqOmwK0xy25Ko7xMvDKUfOZNJ/jN8bNVm+k2SaGPkcSndtFncvtCTCgpo0zZtVGRdwRpgF11iFA9ER8CO3p/Rb+52rQwLCrl4cTEJ/k7nixVN8+UVbUAef23Ab8IqA3jmCRIYAhvFauupfAtB6ngBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542272; c=relaxed/simple;
	bh=8ogDW2rgiF9wQMoCEMO2PNKD9loxDqZkH+6sO/kX5dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGtdK8eHB+9z202fwW6V//upoluCQTDmG15Kq0R2ocJC2T1tEoE8ezQs/HRcToBbTkbTM0SWO4LzGHPdI7I349QZ1wvZDdG+dfDBYywfMoPeTaVOh70Z/4cl1VRvEyEBtcANQ6EymgUGfyJlhDYvxfBiCwkRU7vj/Mp1DkcHKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ua0755RR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ua0755RR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781542268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKLIj9vT4WlJl7R/cCaWhzSoecgT4v/CYbYv0sqbN1Y=;
	b=ua0755RRROuZopE3xSedqqNKcsJ71sr717xbATFAqyai6Q98/JhxwT3CR6mqOe8phOid/M
	AiV5h54W2y5JMjrdaB4ZUq4/Ueg6UFuXuHHab4lfUFarXxigzPkF4sfezXcywlc4CUlUPO
	U+XPPiErAi34sb73OFBh5SzEoK52qPo=
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
Subject: [PATCH v4 2/5] HID: asus: remove unnecessary OOM message
Date: Mon, 15 Jun 2026 16:50:55 +0000
Message-ID: <20260615165058.3845-3-denis.benato@linux.dev>
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

If devm_kzalloc fails an allocation error is already being reported:
there is no need for the driver to repeat it, moreover if this were
new code checkpatch.pl would throw a warning.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 05ca6665e0a4..bbf964b12c16 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1377,10 +1377,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (drvdata == NULL) {
-		hid_err(hdev, "Can't alloc Asus descriptor\n");
+	if (drvdata == NULL)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, drvdata);
 
-- 
2.47.3

