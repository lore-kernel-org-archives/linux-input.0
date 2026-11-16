Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845069;
	b=tUgQi221ZERFlk38SfED+RBOZEK2FKNvvDrtt3lTZ6ipcrna8ZYytrbfvpjcz/1+5Q2H
	 yt7SPzXfxqbn+wqN+LLIEZwf3UZctNKdLYyPGUaEAR9VSTsE9LkTBEH75qmsegPoCMzDh
	 Yx0l/UQddw0Lx9OOdmP6/yi3iFiD688TboP8+/j387lj06BFBbVOomlT4VPN2c9Y93sA8
	 pGFaeEjle2OJxj6yvOtMI+2VjuJcW9e22mdb9m7ip2CC8cvQIuLW3a44fh0X4It0uJioZ
	 EUeTWxwoUWnVgsmFeYOsMK5mYyhDUiP5aktjmh/4EsrBY2ghrOcV1bI2KjautNMwxgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oudFixRtaDN0mNTqiDXHYqi9yn0CpLULW9SIu8yrdcs=;
	b=HEVbsc+REjlqP8utwt/A9xl+naLvInZVxBtDV6Bweatpvtn64CYBgBAV9R6xbBV0v5U7
	 zoC8h9vijR8/3HuPPfjGbLTY/p4sQeEb3DmkB1LYG6kw1rl+RrrZFHlybCGB0OKnEAAVe
	 U9vIx/M0bDYvaphg5svBZNVmrrJJI/MmWEcBJjWxcP1UQG4RK0JnsY1FmoHs+JW7eQQst
	 Eh7GiRI2FfGFh6/Z7KYWIRxOJzX8I6deKudidX2JvliLRl2oCKRxNcJmayI4nJpn6f2LG
	 x/x23PCznKD7TaiT0CS4SBcweNTnwJfBlSnbT93qvgi2wrWuIkr8ZGNB4OP/lgMQP9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yF9KxRZ7;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FD606A31C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 16:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F3FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yF9KxRZ7
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so38644105e9.2
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794845067; x=1795449867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oudFixRtaDN0mNTqiDXHYqi9yn0CpLULW9SIu8yrdcs=;
        b=yF9KxRZ74V14Ex+oBh1l7en/55NNZQlkrqjVk9oM7FwO54h/Kx4RYp/fIeXUxhcF5l
         EFS1LQBh+tSXYPrKvtqw0a7V/8BW5wnA6KI/j3ikmxmMs5p2OSdwzo+v9NO9l95Qokgr
         mBjcxKeqOnNPZszVOlL6A+oPdQVhpVMWxRcr2cox7vsrySovrrBjSi7K29RbStcIN4qT
         kzQqass0uylTYUua0+9TRjfRizJf9X0LB6ZcLR9thg5EbAbzttfGBAYPDTK/cd8jVJtO
         ek0LqiE2U69e8KuhPyqGXmQ0Fe2loBLnOVtEcqrrTZFkR344UE4rRUE/+ofZssBlKHkd
         80qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845067; x=1795449867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oudFixRtaDN0mNTqiDXHYqi9yn0CpLULW9SIu8yrdcs=;
        b=vA1waI0G7JpaOTqxQgvvVJJa3hhy3DiKxPFZVzqk8onN3lgwjGZLy2MI8L63FOhu6H
         lTlTFL+PTB2m7GYhHXuTBGfatFrJQQ3GF/VEyiFCqFqxkbYPfVkh5zQzsOrbsXaulrIq
         LAnUeZGGgjTQ3hmwsNApNLhumXN2dzAqIbsqGhqCbZQdwEffyN66zC7uCgRxrX7YBvBA
         EVUGu9+RhLBnkwOTWWdZLc7Ooikdao6nkukBjii7WCev7NOF4zaDBDwUPMlkUpQ95wlO
         q+TNG3UJo19PheIWf01XcSgn+zBs6H73dcba+L+AIq9wL6+VTenZUBeK76V8F6RleoQB
         b2uQ==
X-Gm-Message-State: APuU4Z8dZTX5tVdBDVeDujSZhV0EtfKiNCyYG3pbKrMAlI313jBgBmmA
	PC6518sH6lmPhVD+r+eNsIXE7yTlsL/5ZnzfJNBxyFjzWDxWrHi/WF3o
X-Gm-Gg: AYBFou1rerlJIMHKORs+fDdiXg1DpMqvFSv+JT+rMfPMn8pttDfZ2Qk4hDtM9GapCpa
	fXEvb2P4rctztqSj5PaHGP5kqwww2uZPm3MKyYQz8lmItuACU/v+dIaIkR/trCZSu8ZuCTd2El6
	Wz3qdLx/IJZkXiRcK6g3KWLcqvPQNvxhZz776hQSc+bYZO36dl5rj7V37FtND6weiF9f/hPSC5V
	iDr+UmqppaH1Wtrqzrw2dpcJhiaXQzAK3LdEeUnjiSn0ICyrD9KnQc0gHLkDP9eeQoFD9ZTKhFx
	5cJTX5IPv9Z6OW8yT1sPfFwTj5OPYF06i7PxdISzNJaPEbz4kgho3gdcPH8bjDlZ0FASD8buZli
	oPe9sZAFyTTVnM6sUhwuEUalXE7AFuPeNjB7GQ6gDUm1yI7jxpTKHs8xobuvfcvsdB1eJ0NxG1I
	c/MIqjeQTtsgGzYtLF75pdhNQUYjWbIf5cnGv3bPvWxye3yw/prKHitZLElgV4hKxFzASWMg6/A
	RlMRaIXOADRAtVRdSTqPuHmdlatVmLjbs5WOrOmxn+VO00UNdVyw3kyXGF8sSOkGxPEGb9loFnT
	/SznWIUWui/PJFm4PgYUpOepxjxOUd5hzf+eI1kisa2Oc+OlhfZHyi67vSELpRxxtJQsQ9YevtA
	W1e6mwOfoGcWuhg3brg4zMfMPfJhxKlN/jOTdBEIXEZyFVK7k6VBl2X/5fyiWZQqv5qUouXpS7N
	bASegmM5KVE+WRfZWJyqSP76yINpLFh/B2a+QdUCXs7c76Cr7DD7AfqWBDx+Rni2zp9GYnIrqGQ
	Ox6VVUhfO5aRB3O6BuUuF6prA+Mb2C+bwPtMT2ztj9A49hIEAXJsyvP
X-Received: by 2002:a05:600c:4e8c:b0:4bb:60ba:49e0 with SMTP id 5b1f17b1804b1-4bb60ba4a70mr164125695e9.26.1794845067477;
        Mon, 16 Nov 2026 08:04:27 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net. [95.143.148.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e1esm271456895e9.3.2026.11.16.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:04:26 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2] Input: axp20x-pek - support the AXP313A power key
Date: Mon, 16 Nov 2026 17:04:23 +0100
Message-ID: <20261116160423.39752-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115150903.16855-1-jernej.skrabec@gmail.com>
References: <20261115150903.16855-1-jernej.skrabec@gmail.com>
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

The AXP313A MFD cell is registered as "axp313a-pek", which this driver
doesn't match, so the power key doesn't work on boards with this PMIC.

Match it as well. The AXP313A has no AXP20X_PEK_KEY register, so leave
its driver_data empty and hide the startup and shutdown attributes on
PMICs without timing info.

Acked-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- Drop empty axp313a_info and check for NULL info instead (Dmitry)
- Collect Chen-Yu's Acked-by
- Link to v1: https://lore.kernel.org/linux-input/20261115150903.16855-1-jernej.skrabec@gmail.com/

 drivers/input/misc/axp20x-pek.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index c34e002258ee..040aec5f9e4c 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -193,7 +193,20 @@ static struct attribute *axp20x_attrs[] = {
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(axp20x);
+
+static umode_t axp20x_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(kobj_to_dev(kobj));
+
+	return axp20x_pek->info ? attr->mode : 0;
+}
+
+static const struct attribute_group axp20x_group = {
+	.attrs = axp20x_attrs,
+	.is_visible = axp20x_attr_is_visible,
+};
+__ATTRIBUTE_GROUPS(axp20x);
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -392,6 +405,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		/* No AXP20X_PEK_KEY register, so no timing controls. */
+		.name = "axp313a-pek",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

