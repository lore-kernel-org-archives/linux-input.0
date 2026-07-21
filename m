Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386F39184C
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599185; cv=pass; b=ox6UjTVHwyEIqkBoQtMX7EbuQcEkylRpSot4FGfmpp4vNB7GB1A0GcQs4RTqmjItjhc+EtDE3O91u4opb9QrYk0ODNWC/RFJLF7Oiabf/mKETFNqxWpJ/xXMTdQwYTdZ8UsgCkTQodxbjhPJHZ0b5TBE25/3HUwiGTe9CZuwoyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599185; c=relaxed/simple;
	bh=i3sU99lLnsRINhuxjQ8AA35cwOhFEqWMPh00SzN0ncc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1xi+lyu2r17P8DBqGfDUt8cQ9s/ZA7Mu9BJnUre+BZKBC45iOfp2qhj8iLliLkzSxu0nmoyCnC2ku2jq8nfPZwKNTPPKmzt3KiIQd3C6nVtjFIf1h4mh3tcHPVzRnp0lioFqy2JGc6L4bkrKBeVeyyR2w4pWFmfIjkoNj6hS4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3h+Qd7V; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3h+Qd7V"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc891373e0so134329585ad.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 18:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784599184; cv=none;
        d=google.com; s=arc-20260327;
        b=d0B82mLypvfJXJy0F6TO3GGIu5hLHMJmiJuBa28j1dxxz68BVaakeNq7wpPBcJLLxR
         UshS6fjabV0sDm6/FO00LOTaX+6j6Kn+10FkEJL4Eo6uEqgDURX/HlIcpw4WawxPv5f8
         bNc3QSF2pZvZfX/085bH+JfeqIDtHsDrTIIldC7CF9eURCmvfOBYcHRn0Nv91EZvt6lk
         RsCnOA0aDexNH9+w/4U+oVo7BdDIpu3j/zGEhmVqDFfKYYYwGCKm2e7/BWWHM926I4Wd
         8Rid4s/3Q08tLCp9HdZ/whcmd0h57nr9as0awL2byoSVzurr5yh/aENPT4sl1JAcgadF
         Pw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eKgnGW53aIVX4UTjXJyniChv8ua8AxIqLl8jGMdkoV0=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=iHhovRvQUtQY3mtGY5d905wLiaSVKbw/f9twJru4w/MWuhnoVZWXQ5H3MEY61yv346
         1wvhyPHV92SjNew3+WaL9A+eC+FSYpDnWoy1ts1jJnO2bC+4H/IhUuUV6dDDDR3B0Mnm
         qmn3LO+QwiOc0Ks4qMIMKkJwzEMQBhZuX5gFTrWj8TcZksgwg5xItqcOI/Ng1G+vfufu
         CefO9QlvVYQDNu3EV0BL7RVAUGP2rO7lGjirOkSuVB4E6nK+iYZukklNPGLA3DvBqBTu
         USrldZhTSGiZAJgzv8pd2JgV+2fGdG94toeAHS10Jv+TjMQt07C7oO6G0PZiQq0zLVRk
         H3mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784599184; x=1785203984; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eKgnGW53aIVX4UTjXJyniChv8ua8AxIqLl8jGMdkoV0=;
        b=o3h+Qd7VKd5IHn8umRrPtYyW4I+d0qmrGVSR5/zvAOU0ldhLj+uX7K1dpFUgeeU6gA
         qJCkgVfqSI/gjxRkmDQNQ5ZUMFMuoFJpFoqlpmrqLiiCJk88LsV69Z9d7woolpGHXr3x
         nHwvmQnsuG6MbbdNGDAnGmscgq/gG1bu7aF0VfcaYiLLqr0mq03ijcxATbxANIu4A1Nh
         ejCZwGRIFkGCDVXQsvy+biLKoVTS9LeJ8QOtlczLH3Gp09k+k5123V48UKXAoZBZfx0o
         NBxeJmX6TT8JcXBzvmWMIiBI+d4o0kMHdoTmkADLBCDmD9eBmlm8D8ZQNXpfN6UM7yTd
         0ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599184; x=1785203984;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eKgnGW53aIVX4UTjXJyniChv8ua8AxIqLl8jGMdkoV0=;
        b=GjG8o6eE2BAY5Upm0jv4OZItje85HfyKrik9EVyd13H5Co+oCGAHzX8/T1Fwp+Nu5Z
         FWItmY7Er5PyLMvuHUtRMa8N+GMHpT4HBs5ha03Tge1lM+CLTaCGXUBO4YuEM+7UaWSa
         FF6q8tJfwYaqxx3GhgMA3sLYTI0Iw0mB15XvtyW5Nse804PxSitEshTwHGlWwOkA7NdL
         0twkVH7s4GQN6lxk5CirXInfqXc11/L5hddp2yutgFhoy7aYHrfguTD/6ot5J+waVeeI
         vm0FgxSYOIWoEcunIDIA7TIvI/Sz0tQs0GIz9mBJ4GelOqMqmlzyWf1odwWo5hU5MqZO
         D74g==
X-Gm-Message-State: AOJu0YycrvGIiXRAsdVOo8k2VDeuV5sZbQdxuZv/DRp8cgBmlvvjG+RO
	TmpeKu448PNLCIQ3WtApRHgO2o2daugfWXZO4altNQPYsZlFIrSZ6W18U+KQq9e+4KyWngnhXVy
	CyorY8YVDmXOmD0eQhatP/E35KQEDL6Q=
X-Gm-Gg: AR+sD10UnKtVpEUuLIXFlh5mL69ZfYST9zttB9zebtePB3T2XBvoW05GX6vaGQXn9nc
	WICx+BsJcNe+tsJr5PD44dJkpYKT3ZB+hFiI9vWOS9r0VG2pTh9Rda0Uz2A4TH4Vjl7VJOBcFqj
	1XgavtJzlnGVztjBDflA5obqlUTDjBICBKov+WW7fIVzTm2yl5gZkiRsG235MQe/ksaB1pFYvMj
	e4xJN+v9k93ID1rHGNlplRnj75Ww+S43GUHw3sXsJzBZaMmYzFg6yB5O937jdNOTfeFjrT3e3Tb
	gmTLhC8OxbxREF+glYGso9hBTNs=
X-Received: by 2002:a17:903:4b43:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2cf3481d1b6mr167478315ad.2.1784599183901; Mon, 20 Jul 2026
 18:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720090851.230244-1-phucduc.bui@gmail.com> <al5VY95YC0Y40MJY@google.com>
In-Reply-To: <al5VY95YC0Y40MJY@google.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 21 Jul 2026 08:59:32 +0700
X-Gm-Features: AUfX_mxLHzdYF0uGT0ocWKImTI9M0uAbCtmjJnzAiQk-znFYGr1XmTpEDl24J8o
Message-ID: <CAABR9nHHe1AzWmqhV0d5p87qfSsBk2O7bYj-Weowyr=99wtNNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Input: snvs_pwrkey: Improve probe error handling
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Thank you for your feedback.

> > Use dev_err_probe() for devm_clk_get_optional_enabled() to handle
> > deferred probe correctly.
>
> In what way the does existing code handle deferred probe incorrectly?
>

With the current implementation, dev_err() is still called even when
devm_clk_get_optional_enabled() returns -EPROBE_DEFER.
Since the probe will be retried later anyway, logging an error via dev_err()
causes unnecessary log spam.
Using dev_err_probe() fixes this because under the hood (in
__dev_probe_failed()),
it handles -EPROBE_DEFER using dev_dbg() instead of dev_err():

-----------------------
case -EPROBE_DEFER:
        device_set_deferred_probe_reason(dev, &vaf);
        dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
        break;
----------------------

This avoids log spam while maintaining deferred probe information.

Best regards,
Phuc
