Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF939936E
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158938; cv=none; b=u6cxgeC4Cri4gYfDveuSyDnN8Q9NZpOyNXl5bzls0lpFAzDMU0yoWGz3gJrnTuyoOGmkgnEbx/Jm831Qp3Un+SZUKgE1bBY5Kvd10FIBWgCSfNOBjAcY5x/7KcGqBesjo4KWYzVcT/ERgOSWC/EmsLP3nhsmcNypbh8Fa+h1n2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158938; c=relaxed/simple;
	bh=WgH0xFGsLcxChp9qekgARXHm3ntKjhWawPAWTCPfAS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccjzl3FBBxmdheVW48WXHqixETuqBgv8RAsjIh466XY5rGKAMoSwKNJjMxsyU5eA0pAEQPvnF2xlNmmKAM1atSnC6rjZp4a3t1agL/rSH/ZVUw0GwxXcNMDzjhm19g/AdnxPDh7JYFpRQve82EgJWhQCdNXT4yg0EQYzzfXXUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP6XiVFy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP6XiVFy"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e30c26a4so84755966b.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158935; x=1792763735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaG+BrVADgXDwHo831rR0nkrlIE/ZtOkilAp8e2t4CM=;
        b=IP6XiVFy4O4dxgRkddrCfQ8p30NCiUIMrHRL8LLuNKVQzXfRK7QW3z5jjKhMnbM91x
         7xf946aV8eF3+zEDQ9qvvZZMssd3QFkKMgb6riPRHzLrMGI20aPIgH3y4YOZxftfvJl2
         wdaFI+0B2JBI+96USezfU4BOxZIcjvWBztqpii7GTVnk7RIQVeJhHzxxaUaeaHEXYUkZ
         nFjlM1UmwCzEaIrPi1yNJ2IjPU48i5Mnu1vTZvgSQUiHrhfVARbp+p6iUFuJDor9EvTt
         3spGOamte90OcScjnPT7WriLe4hiJkONzRRXs0jaPKqX221fp6J9bTg20j8ZWKDgr36j
         LBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158935; x=1792763735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FaG+BrVADgXDwHo831rR0nkrlIE/ZtOkilAp8e2t4CM=;
        b=26w+jbVtlZTmooPpidsbAy6+oclc/hO+rM7A+A9XdoRBg5dUzNs0F7VxtazViXZzy/
         nzXBLkW01tSWVfxs5dg/pGLznWx09vivPr3UA+re3iopM8cU/HzKPOwF6okAK0NL8pa6
         6BY8Z9BU0M2fzA7pNDgldbs5rCA2r5gtF6aDq7ZRvjjy2rccaCY+ONe2zEgeE1MikqYd
         zgOzbs4LjT+d1LnrGW60e6Hj4fsOM2WvZGyqbZX3sw/L76HMVYu9DVVRo2Z+BU6jS/Wy
         3w1CHwoKz6HyY1Embf5is5YiOGVMn3B3p5lzehWtuFQBB0sYgvgQ/yyJ1UXwPIuKve/c
         3N4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCnSSy6Wa0tlbRVD0LfTdzqeTJS86NkBX+KEQkxn7i7DhcpjqwLCM4D1T0g0mtOama+uywoMCxiYeZCw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgfApWqadBrRWcdgy5NXELWVhNq0hkwexFsyqfRWrHtrKLh+AP
	iagbL1tpfGJImfkwf9qDTOhBSnsbXGxrD+NGpobPQJb2KdVM/UyeU5B3
X-Gm-Gg: AYBFou2vowjU2DDT7taFg1n5u3o+omLf9AkJU+AEqwIjkIj6NcCTazawYyXB1tcrGZp
	sic18+hPNYHrvjIeyrU0fS1ca2ZvGDnwYAXSJ99zLaYuGP2k1TvsDDPXyVgNP7wxp7+06dqHGec
	2wux9kUKS3ThvMYf//dqHZ9mHZ9XOJEFkfC9J1nwYU762X+CMLJm6Sg0pW469+SZbvG/9H7KWm6
	YWQ/J8v0bTFCnqAkyNfzaMHU5WhjJB7zE/zin9lAszFFQ+NlCLZ4zp1iNMHsHVF19/Fxr+ISj3e
	tKXqnUkdOD5HvupiRZyBi8/8mVphHogBiJSzxyvKCiC2x666t8iBpNSs/gpwEVWbz4JTmTSAugH
	t7JIG7lxKxAG+th0ZkaZhtiyMADChD0igCQANWHBIajJ3LdOqxhRiE9jrm0PR8kUqFPXCMTDZFx
	YyLj5NZpWCpeMCZSP25Fdnb3zAxkiT0vxdZoaGBt27d5CT2m1ULrLAmcyLYo4kz09e
X-Received: by 2002:a17:907:a317:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c401e136d98mr341429566b.1.1792158934663;
        Fri, 16 Oct 2026 06:55:34 -0700 (PDT)
Received: from beelink ([187.15.113.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e328775sm75262366b.7.2026.10.16.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:55:34 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v5 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 10:55:14 -0300
Message-ID: <20261016135516.2957381-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009103333.2476105-1-qwe.aldo@gmail.com>
References: <20261009103333.2476105-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Benjamin,

Thanks for the feedback on v4.  Reworked as you asked -- devm_kzalloc
stays, a devm_add_action() handles teardown, and the try_module_get
reorder is now a separate patch.

Patch 1 moves try_module_get()/get_device() before input_ff_create()
so the old input_free error path (which returned ret == 0) goes away.

Patch 2 adds a devm_add_action() callback in hid_haptic_init() that
does all the resource teardown at unbind.  hid_haptic_destroy() just
sets ff->private = NULL so the subsequent kfree in input_ff_destroy
is harmless.  input_get_device() pins the input device for the
duration of the devres action.

Changes since v4:
  - keep devm_kzalloc, use devm_add_action (Benjamin)
  - split reorder into its own patch (Benjamin)
  - single-owner teardown -- destroy only NULLs ff->private,
    devm action owns workqueue drain + buffer frees + ref puts
  - input_get_device pins input_dev against concurrent release
  - workqueue drained before any pointer NULLs or frees
  - input_ff_destroy on devm_add_action failure
  - no hid-multitouch.c or hid-haptic.h changes

v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v3: https://lore.kernel.org/linux-input/20261009110509.2432308-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 87 ++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 25 deletions(-)

--
2.53.0
