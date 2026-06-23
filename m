Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7603C3434;
	Tue, 23 Jun 2026 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197605; cv=none; b=dHQlNOYbbQjgm8JD0wbX8eD1t5uq8nRnooTJ0CzmPpl1Fxmfp2ju91z4LbLPADikXgavtr2T82sTzkGmJRNk9j3pFESYf/GiNW3Tkm1atYjKy45xYTTXVb1evPn0PT/u13REGUJSUt0HJAAvIDPk+rCSIY9kqeV9nlL7gosN6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197605; c=relaxed/simple;
	bh=HLzvQ+pYyoaEQGWDyszPCRwhF9uLsA2QTk/KziVx1A4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXdaLxnwwl+ozwHA3XQ32NGjTIf2AL4Db8b6OYfzJ7gPbihqKxteOvyLqT4T0msPqHRO1JfZGsjiKlxWLE9gqEa/J3AUnZ7lpTfkw6/Sfg/LI/WMi0AN8brpOpBJ4Npfl0pZgLPIuNIuRETE1woVdY0J0ydwlD6OV8Scw2xGJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J10Q44hq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J10Q44hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ls
	4J/QhbY8rX8JRo+S9j3TVT86HwgaOrIHvv2LMfVCk=; b=J10Q44hqYW92OeKIMp
	RlkAV0ZbeY0vgny6iamV5S3tOZNx7tfyD9vwSXJz4w1bZMpiXQ5tmo0I2M071IfN
	OFvtNaGJdqGHU8XrR0i204Ij/rYFPSRGQc67XfWB/S6S+QTOusWEPtlb2pd70D3x
	1I9IE2X4uMiN9FqndBOLnj7tw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA3wXgRLTpqKzqnFQ--.7057S2;
	Tue, 23 Jun 2026 14:52:03 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	e.velds@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] HID: logitech-hidpp: Fix FF device cleanup on init failure
Date: Tue, 23 Jun 2026 14:52:00 +0800
Message-Id: <20260623065200.1966629-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3wXgRLTpqKzqnFQ--.7057S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4UKry8WrW7JrWfGr1kuFg_yoW8Zr4kpF
	WxGw1Dtr1UGr47Jwn7Aw1DZ3W5Ga1kJ347CF9F9w1xur1Yy3yv9FyYv34v9rnrtrWvy3W3
	ua45CF15WFnIvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJPE7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxhN45mo6LRNF2wAA37

hidpp_ff_init() creates the input force-feedback device with
input_ff_create(), then allocates the HID++ FF private data,
effect ID array, and workqueue.

If any of those allocations fail after input_ff_create() succeeds,
the function returns an error without destroying the FF device.
Add an unwind path that frees the private allocations made by
hidpp_ff_init() and calls input_ff_destroy() for failures after
input_ff_create() succeeds.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/hid/hid-logitech-hidpp.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..fb2062233df2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2861,18 +2861,19 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	 * ownership to FF core
 	 */
 	data = kmemdup(data, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		error = -ENOMEM;
+		goto err_destroy_ff;
+	}
 	data->effect_ids = kzalloc_objs(int, num_slots);
 	if (!data->effect_ids) {
-		kfree(data);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_free_data;
 	}
 	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	if (!data->wq) {
-		kfree(data->effect_ids);
-		kfree(data);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_free_effect_ids;
 	}
 
 	data->hidpp = hidpp;
@@ -2902,6 +2903,14 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		 version);
 
 	return 0;
+
+err_free_effect_ids:
+	kfree(data->effect_ids);
+err_free_data:
+	kfree(data);
+err_destroy_ff:
+	input_ff_destroy(dev);
+	return error;
 }
 
 /* ************************************************************************** */
-- 
2.25.1

