Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDE41D12B
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877275; cv=none; b=nAv4RLyE2+zFyNwAeB7J+yTu8ItWf7gyodDMVcJVSswpb/CEatD0U8rLDe25ytFD3gv6S0ECG67QpG0NNtVJgahxYoD8SDDdffi2kNpQiZlj0v1WPqbF1j97pEnjUK4t2zRJ8FtCFO6cSuKH1NN8CsICPY4CmiRCX5TT2/TI4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877275; c=relaxed/simple;
	bh=QK8n0aRu78pJuksNxP9TGd82+C2m8alZfOM0Uauqwr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qa+HZA3O6q9J8XbldzWW+shSehQNZmaUrOs0WKLJh1+mPCMGjf9IHn4RdIZMca8qsmRm0q2wlI3QLs/i+h0IMyLmhxFP2dCIuAsAyJbe8jDQmMcMOPEgwpd4u9Ise/jJtWiY4B+fXAPWMlAnSJZWqL0Qp8TSi0fGMeS73whjyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=CjiPR7Ik; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="CjiPR7Ik"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QK8n0aRu78pJuksNxP9TGd82+C2m8alZfOM0Uauqwr0=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790877265; v=1; x=1791482065;
 b=CjiPR7Ikg6sJH9+Y7IR5woB8P+UFLdxUB03jmFAundmhp9D06+fC8oV//cWHs1wramF5D46u
 eqT79TmigF1j4NuxFNzLl88eY/4EvcuBgORLT6LTVmTKzu+XXcRzBratwMqlT88RZUm/BfUAyBo
 NhHNbrx2VzMf8MlsRpOwFrq6T91Lm548oB0/lAEaXZOozMMGjNMQnSlzMLg+b0IxfD5dh+H02t7
 9RqRHlRm8/WRtorW04EzrfkIk3SIzTdeuv2KhzTSW/4Z9w6/7TmkQtaoadKyYznZNEyLYfWRPDh
 amXVxpXO2WcAGaY1MaBQgsJN0gf1+PyLaTRq2Aez/GqXg==
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02f8acdbc266cc03;
	Thu, 01 Oct 2026 17:54:25 +0000
X-Mizu-Trace-ID: 02f8acdbc266cc03
X-Migadu-Flow: FLOW_OUT
From: Diederik de Haas <diederik@cknow-tech.com>
To: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <diederik@cknow-tech.com>
Subject: [PATCH] Input: cyttsp5 - convert to DEFINE_SIMPLE_DEV_PM_OPS
Date: Thu,  1 Oct 2026 19:53:18 +0200
Message-ID: <20261001175415.159900-1-diederik@cknow-tech.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of SIMPLE_DEV_PM_OPS got deprecated in commit
1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")

So convert the pm ops to use its replacement: DEFINE_SIMPLE_DEV_PM_OPS.
This also allows us to drop the __maybe_unused attributes.

Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
 drivers/input/touchscreen/cyttsp5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 9266c07314be..7b0613156fc1 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -942,7 +942,7 @@ static const struct i2c_device_id cyttsp5_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);
 
-static int __maybe_unused cyttsp5_suspend(struct device *dev)
+static int cyttsp5_suspend(struct device *dev)
 {
 	struct cyttsp5 *ts = dev_get_drvdata(dev);
 
@@ -952,7 +952,7 @@ static int __maybe_unused cyttsp5_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cyttsp5_resume(struct device *dev)
+static int cyttsp5_resume(struct device *dev)
 {
 	struct cyttsp5 *ts = dev_get_drvdata(dev);
 
@@ -962,13 +962,13 @@ static int __maybe_unused cyttsp5_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cyttsp5_pm, cyttsp5_suspend, cyttsp5_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cyttsp5_pm, cyttsp5_suspend, cyttsp5_resume);
 
 static struct i2c_driver cyttsp5_i2c_driver = {
 	.driver = {
 		.name = CYTTSP5_NAME,
 		.of_match_table = cyttsp5_of_match,
-		.pm = &cyttsp5_pm,
+		.pm = pm_sleep_ptr(&cyttsp5_pm),
 	},
 	.probe = cyttsp5_i2c_probe,
 	.id_table = cyttsp5_i2c_id,
-- 
2.55.0

