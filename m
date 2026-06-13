Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6238E8A9
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364656; cv=none; b=dFZFRoVpgmXvV2+PsEJQ1WI7rXiLGEHBNKQAC2FQVFvK+Q7cajPw2EtRuER5oMMGnwtlcl49Kk8AeG6opbqaTg/JID2kmu/glaKrJEDfUJjgh3oy0vDVOFliMpZYSGR5eCXBi42uWQA9hegX3hLTRbeE7tTk7JcOyXxDwziUYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364656; c=relaxed/simple;
	bh=TUl7RaPF5P2FVFlE8jmILZaFIXvRQi8fCeGscBl9iEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSh1WByiEux3H3n8deYMA1Vc9H7kyb8nVcyHDxTUA/Gjl6+ANoP56yPIYY1wvU8Utq0dduaTOUTUEw7OTiowDk1IYFrx4xxXwMl40oE/8y30PPo95hg1mz6kz7XeW5W72HwlqhGyij6wL9e7rEYHTU6vrpGooeg85ZoJgzQ/Yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JdR8pI9u; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdR8pI9u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nql18V0Kaa5ElLjWRTE4tW771fgioE0H2BkTX87w1Us=;
	b=JdR8pI9uk2AITccC7oqWL4PvTonUDbVWUUyVVvvicr3103vL7iDREqEe2Jdw/f3VUsFWxF
	yg2vL0mHDetAg/Bz+QTu6pWsOFu9tC5Z4vZ+PX7ADZPQdSkkf3h791JpVWWSr/FJcn1lK0
	YVL0/CxtRM5KQOd56Hvxfry5Y1oExOw=
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
Subject: [PATCH v3 8/8] HID: asus: remove unnecessary OOM message
Date: Sat, 13 Jun 2026 15:30:29 +0000
Message-ID: <20260613153029.2559774-9-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
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
index efad6b623e65..f1fe3358a298 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1322,10 +1322,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

