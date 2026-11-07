Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048509;
	b=Kjdv9aaz+mVu0Uuvd6R2nImMJ8jN9HK3bAkdGbRxvHT0MpktPkaQdP+OBiglX2PDs3w7
	 bJxeWic1w7LZC32uJ841PUJtoKLsue6+LYbyOFoydWfridTSrSqSN8c1lK1s9dGmgomaj
	 ZctYi2c6OzQEZBdAYNCeDjFwE1SE6x7KcMkXOCN6o9G8pa70Tegd2wTTsj2jLja8w1K0W
	 /r7enj0+2+Ai8QdYsvXh2dMPR+Qj0cMLTZ5xRENEa6oPLvtbMK2V+CLryjJ6D2ddIKAmS
	 CF6ZyaBGZGb806OuNjQNRuwrV8+TissIz3/3AEyo9VerSFD77DW6csu3xAD+JPln8ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048509;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8y3qUwF5AW7hRyJC8vTVeAE1YxJuk8veAqbgzvjkaCE=;
	b=ghEzHWzxjxLEt9FBIkfRTz1Pzp/Qg0bsCkAnAvPt/zfURmXwjwfa7Rl1WNjhIAMHwljc
	 mDidob58BPaYIjh++l0EmKHxlPdYHcPFSRP57e+sXG8XqR4+6CVdc7ZykVPRh864dDWeW
	 ZB6rQAEAf1ajywzxsHbrL2WEgcFFK5pzNQry6wMl//4cAaQCrCK+lRyLlalTNSvz3pP3K
	 6C3IboOYHMBwCSKRuIU8fbGjs6ORlNjx7wFfJ6DEKI68RLYudnvaWyNRkoXMfs7kVV95L
	 orUHRtbZAamr9nb1pcyv3NZr97onhzF2nuiGP2TYYAFCo4JamANZkrvUctyub2KwmAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=cVrQLdja;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058E606A32C;
	Sat,  7 Nov 2026 10:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C058E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=cVrQLdja
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8y3qUwF5AW7hRyJC8vTVeAE1YxJuk8veAqbgzvjkaCE=; t=1794048508; x=1795258108; 
	b=cVrQLdjagm5ExuhSyBg4bqyHy1FERkvyL2TmjSa4FfBIA5Oj+Vt+ZZh7m2E/bvjONvIHPqRx31h
	p9b+zckJA9WmhPVyopBHH46TcWCUcZAO5MRyoYD6iOnFcOwX8Ru3vCREyaY2HJhYUWs7S9SOaOlp3
	iUnZBJ1VqtHSoyglwPBu4MkWuHRP0yTRTnl6o41Tzpix0gX1auit8fQYiHOf++IprB7fdIjxA54Sr
	BjH3jMOhdOVtsd4HJm35coVCCMepTXAG+NfBf4meY04MPsKVRuPm4AglFSAPnpDnkWhL5rg2mLLiN
	6PuzeY/mf8hvvMqLLByIPYpBYJNPCcoYVLsw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	andreas@kemnade.info,
	bartosz.golaszewski@oss.qualcomm.com,
	arnd@arndb.de,
	marco.crivellari@suse.com,
	tony@atomide.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brgl@kernel.org
Subject: [PATCH v2] Input: gpio-keys - do not BUG() on requested wakeirqs
Date: Sat,  7 Nov 2026 11:48:07 +0100
Message-ID: <20261107104807.54410-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having the IRQ handler called when enabled IRQs arrive should be considered
as a feature not as a bug. So do not BUG() there when this happens.
Also BUG() is too harsh here.

Fixes: 3717194f24922 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
do not BUG() at all here and remove the other similar instance of this
BUG().

 drivers/input/keyboard/gpio_keys.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index fbc31c5db3db4..41a9210b40176 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -412,8 +412,6 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 {
 	struct gpio_button_data *bdata = dev_id;
 
-	BUG_ON(irq != bdata->irq);
-
 	if (bdata->button->wakeup) {
 		const struct gpio_keys_button *button = bdata->button;
 
@@ -465,8 +463,6 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
 	struct gpio_button_data *bdata = dev_id;
 	struct input_dev *input = bdata->input;
 
-	BUG_ON(irq != bdata->irq);
-
 	guard(spinlock_irqsave)(&bdata->lock);
 
 	if (!bdata->key_pressed) {
-- 
2.47.3

