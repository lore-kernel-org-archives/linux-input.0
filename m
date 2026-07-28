Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968703BD63C;
	Tue, 28 Jul 2026 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221725; cv=none; b=Mt+wn94Ye1VyCfWCbZEUyGaGtBAVHeOgDCCtwnPwZZfJKSBK202aKSvCMkJStxJ26VGyzPODsyfB9xxrDONC43eL1/oSPWxa8XLkJA16zY1otPiy3gHjFyCP0x5uRHclh0VO34BYB4dXApbbHghnvnhRHuUW2wvr5kKBZBj7GQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221725; c=relaxed/simple;
	bh=CqEvMPsT0RyoucC1PZEBc3eqdOOOqZ0irolz0dUqTPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaKNrJhfMiyyi9nub8NiFqMkuCZywOMjzGa6tvAz8ewc7yEsXQaXGvYXYj1W/1wW9iFeP9Y3VdU1rleFXKPLUAhYElbHkOuKrnrRbsQGSKsXS8rzClhAW4VHGQ2t5GuD/tFvJ2GwQTEPuDWUBoFtoYx82La1VtmgX8b4pySmO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=NNlbF1Mk; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="NNlbF1Mk"
Received: from LAPTOP-99KJFSET (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d3f7929;
	Tue, 28 Jul 2026 14:55:18 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [PATCH] Input: lm8323 - cancel PWM work before releasing device data
Date: Tue, 28 Jul 2026 14:55:18 +0800
Message-ID: <20260728065518.489-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa7819e4f03a1kunm5eaf0c14e4291
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh4dVk1CSkpLSUwaSR1NTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=NNlbF1MkDIHwFwfZ4MG+U+DJdGc1iDYtku2UJid6CFPRd/B6PwVJ9Wb3VJViyjBNRWooItOwvAz2BW3JREnXCY/cf2Sw4Nda8FX7CPp7js/xkltBfhOdz1WTCASKxN8iFpva+NdrHo7cit8xXi5bEv8cKymHTz9y21Pn/pYKMR0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=zBkHXStGPXwR4XycoaqqVm9GHxZAbDHzwx87ArUcilg=;
	h=date:mime-version:subject:message-id:from;

LED class device teardown sets the LED brightness to off. The LM8323
brightness callback responds by scheduling its private PWM work, while
LED core only flushes the class device's own work item.

Register a devm action before each LED class device. Devres teardown then
unregisters the LED first, cancels any resulting PWM work, and only then
releases the containing LM8323 data.

This issue was found by a static analysis tool.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/input/keyboard/lm8323.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 7bee93e..1d799ce 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -552,6 +552,13 @@ static struct attribute *lm8323_pwm_attrs[] = {
 };
 ATTRIBUTE_GROUPS(lm8323_pwm);
 
+static void lm8323_cancel_pwm_work(void *data)
+{
+	struct lm8323_pwm *pwm = data;
+
+	cancel_work_sync(&pwm->work);
+}
+
 static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 		    const char *name)
 {
@@ -572,6 +579,10 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
 	mutex_init(&pwm->lock);
 	pwm->chip = lm;
 
+	err = devm_add_action_or_reset(dev, lm8323_cancel_pwm_work, pwm);
+	if (err)
+		return err;
+
 	if (name) {
 		pwm->cdev.name = name;
 		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
-- 
2.50.1.windows.1
