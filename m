Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAC40D582
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827905; cv=none; b=qqZn20j6Om9x6gvppEYazf7Q0lFA6P/1pCG+PaJt/CS9JF0RYkt340gbC3DVRsZOMNgFm8/yMXB6J6DP5JD1ZOuyPtS133RoxyjyQ3nQAkwQNKJj3bYTUH48YysHc7hH7pegZTjkQYfo0d7+VCpjVK2Sj48bz6Shd69gM19AJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827905; c=relaxed/simple;
	bh=GMju/EgZp82JHzbVGyYW3pvQG2lTQlBpzRTZWwMPjkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwO570so9GhwebDpGEMHPdsqVQ8NKdJhtoo/M7D5i2+8uaxe6szzvaySzKkn4kH6NtBk4PHHv9wbwfdeMKxNWQbuLHk3ym8N1YfblV8BUjG50Ce2hGzmLYBRQDjyQeNvfx5tWa/ibF0yj3gtgtp7miYT5BMJIfKh1H62hSqfMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PyXwlAwU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PyXwlAwU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781827902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBTbDwBsYlP0et0osVzNMnZmf9CN8iGrsjNl8KypPc8=;
	b=PyXwlAwU4Xh2Gfm46OdRmWn7oaQQH8bYwdcbYaPYf4auCmkGvrotNF46uvkVk4j5nslk1k
	hPkfjfPcLSMxVObHto/zCuuogasMMq5XVsta6bhwQptkMx3TQ2/ppTwZIdF41CZp6NpGui
	p21EAgbrGgAkleIGmBEHrqY5JTqJ/9E=
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
Subject: [PATCH v5 2/5] HID: asus: remove extraneous OOM error
Date: Fri, 19 Jun 2026 00:11:00 +0000
Message-ID: <20260619001103.1189200-3-denis.benato@linux.dev>
In-Reply-To: <20260619001103.1189200-1-denis.benato@linux.dev>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If devm_kzalloc fails an allocation error is already being reported:
no need to repeat it. For new code this behavior is disincentivized
and checkpatch.pl reports a warning.

Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 40191eb9e2e8..d31e71ce3d19 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1383,10 +1383,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

