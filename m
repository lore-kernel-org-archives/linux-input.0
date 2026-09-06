Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2C3C1973
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677697; cv=none; b=cEFLyKmhoxqCElHG96Vp4Hqy7s2hu0RRSZbMTt/An2K+RyJg5wWpb8ZKLw89IBh6U7fjo2UxnOlhQsNeWjpiUqwLgTC+7FRe0gPYwzJ1dUXwhouU0vVX2SvVmShhpX3tblrwF6bgT3b9qZ0FpMNn2rkeYiKnuw3PLkdRugSsBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677697; c=relaxed/simple;
	bh=ihV5OQaoP6INSs81OrTckxcfcEXn8Vp2Yb3BUC0Q+Ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IjXT9uk8FlkkuZVTsInS3Bka3jNRUNx1Qh2Vcqp32K1TT2Sz4/YSMJfyh/puKPsNcv2qgrjyokQ5jjxQArGhr4mCwsLuBfIbx2az+Sc4Y3ddSWnWaxrVJK40fU+TAptoSmIEWOdiwFX5gmm9D9N1exhrpUiv75h/hG0VPKk6ZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHK5b4vX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHK5b4vX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso1938616a91.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788677694; x=1789282494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C3R8tPe9lOjKH7p6qWRmtf7FvkJ+tCfMXgIaxL2nfTQ=;
        b=KHK5b4vXZPLdKdm82/aABRkIgKSIsefrvhCfViOHR2LuWjQ3KLV9b7HjMK1v9PqL5D
         VIriafVMFI0+XTo/xdhSbqYjY+0m0jK1bA33aLCIc0RgzNlCtbAenOkFDldj/5XGXimZ
         d2RSEotZsuK6/dNkMwe7UYcFTrSyHt48vOPy+cPojKIniCBqzDhJQAbsyr5PjIuWughH
         j9Oq4N1ZNAejzResRWo/2B9prPZ9N6Uui/6j6LeqqNiUBeRHG7DUkOOV0qtFlofFw33a
         bdCxWWnRqXs0Kf7kwK0ywbFOuwnDvxU/tGbLW7mCA7sNsEJONjwtJkBRfdzL/Iinw4lG
         yfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677694; x=1789282494;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3R8tPe9lOjKH7p6qWRmtf7FvkJ+tCfMXgIaxL2nfTQ=;
        b=AY/nh38dJ/QHJJ9idGj9/EK6EToAeWAIvfv/Opb3ynlxliKxNh4Nn/iTVrfCYLNvi6
         ufvTYzuV0fihTiG7KNSpv7DCQavRps56Y4dNXL/eeq44TKdfIkNqxzHvG2ZwWvp1rbWz
         /g3KwSG4Q2ohK7m5JTayC0HMXMBOl2DU0+m/2qiuk62yVEXYaq1L/84/FLP214TOYNnr
         FGrGb8iP1BdAdhvx6yo8xlx67cTKwT5pHimHfepucqxZQGRXX4LHFlHW7zyPMoiLgOeg
         dIVPx8bgyLLDHzLeFXVmR/RMXOevxGI6rTqBheAI8kFfSmLQaxEBrpCfDzePFOHF8YZ2
         CmwQ==
X-Gm-Message-State: AFuF++mFPPL2CMFgccNbyo0fss1VUwnhvx391dXTsjA0KLUG1TZBMYBX
	HqOi6OfcQV2Mcc7wcYyMFxk6O8vvLZUbtVGAgU0J5Px6ScCTzLUAV9f6
X-Gm-Gg: AYBFou3JWeK7zLkj/TX22kM7CHux8F4Vl4MnG7ScAkoO6qerDWthz/PsVrD7Y6urrqd
	nLmI2EEb9rSF8X1kJGww0O7gtGXDqwbacwnEokwo/ezyPrZ0aKKcBsGdtlbH9eMaGNuVgcke5xo
	8ft+AvOlObrJF3dmEOzpxz95HRYDzN3uHhRV70e+gW6yovOVj47/LY2AWY7Noh/dmrqeyFzc/F+
	UhHBfMvJHhtDdV/cPrI8Dbu6uvLRKEr4q889l2d48WMWZG+TxBVUMeu8yRNhN+2wAgaMExHlnHt
	6fRZhcRgSz49p2Gqetsy5GMFH3GR3O9JUUPnTZH9jvGKFHI55hFWnqvSlq7MN+ve19LFGVClZ9W
	b+ZVlSAFlrqCyUjaTmBeVF4Q3rWfuohLmg0mMPIjrhxJTqhZ+53uc6DlFSmb4xOpxwZs8as815A
	2dy322oh+JM/r5T4istEDfCLOikU/e1g89131YcOe7ebggRBdS4zmPOBQ71/GoxMIenaKVNw/oi
	zd4Jw04YNxGdg==
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr22897521a91.6.1788677694175;
        Sat, 05 Sep 2026 23:54:54 -0700 (PDT)
Received: from [172.29.66.128] ([120.236.174.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc060sm22686761a91.3.2026.09.05.23.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 23:54:53 -0700 (PDT)
Message-ID: <4d101d62-9ccb-4e3c-a7a7-8d0c273f0d69@gmail.com>
Date: Sun, 6 Sep 2026 14:54:52 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhian Liang <liangzhan5dev@gmail.com>
Subject: Re: [PATCH 1/2] Input: tca8418_keypad - Add devm cleanup to disable
 interrupts on unload
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
 <apvip-xz2GFH96uU@google.com>
In-Reply-To: <apvip-xz2GFH96uU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

The INT output is "active-low interrupt output, open drain structure" (Datasheet §5, pin
table). With the handler gone but hardware still enabled, a key press pulls INT low with nobody to service it.
And the driver requests the IRQ with IRQF_SHARED,

	error = devm_request_threaded_irq(dev, client->irq,
					  NULL, tca8418_irq_handler,
					  IRQF_SHARED | IRQF_ONESHOT,
					  client->name, keypad_data);
	if (error) {
		dev_err(dev, "Unable to claim irq %d; error %d\n",
			client->irq, error);
		return error;
	}

this stuck interrupt is seen by every other device sharing the line, and may trigger "nobody cared" IRQ storms or, in the worst case, cause the kernel to disable the shared IRQ line entirely, breaking unrelated devices.

The same leak happens on driver unbind (I think it's a rare case though).

-- 
Zhian
