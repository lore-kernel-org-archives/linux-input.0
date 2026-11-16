Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794855252;
	b=YVlKtUvrqoTv3LSX2F0iEqTpeGsQrMc5Rg/qFWaiU4npLoMnh4iK2FLBJpfoLiaRfu4R
	 Z5ha3EYjz+YAPqDoUBrLWEXoy7i+XHVALdGbYZ1k02u3IL7odzj6ndggklkusQt5WjzdL
	 RwOd5yJDP3nrAnsRFc8D7dmCFMebJ1C00URGLBWBMY+4NSSA6P0hsDNHhFpt7l778xymE
	 8sMz6npNESh6koble5hbQ5yNBv1c1VC4/wYGMjsW1QNXObuHwGghk0BVbVn2hta9ECMAW
	 4bLGT0jkhWfnx5IIr1rZ0yjwYHzfWuqFfm94DuhTVF0/rhYTiLxAOk6KgTlwsdKX0XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=choMbSoYoRkI4EZKogv+on35PXN8ET4WeIfVWxIT3BE=;
	b=Wfhwyj8Ke6y6Im4MvTnPfg2iQS36VcP7BeLv3Nq3jY10HClsojKL1IWTNLn41WNFIViQ
	 UdZ4Pdw36oZZjpIUxgXJpjygJNcF3TVUB2yjfiIEGvcQdDRAMgMIdHS/1O/PaK2ad06CH
	 F0XRYy19UhXBW8bti9qB8btZVrn7IUpvIZRLd3ihV7aSVne+wAmJ5TDnkejFtFu++9szE
	 pHxupr3bo0ILm/wLG9/feN4aCIAHKm5TkZzvuxQ3T+JXbjnoXgcV157PFGWw8I0kqrbLA
	 LhRS2xD5qrKWykl/4UJF9Ggpvx7bSKKVRn40ysCXx+Vf2uywzs/gwpdFVHPX0PdLMDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Td9LqMZB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AE606A31C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 18:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C6AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Td9LqMZB
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so6734238a12.0
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 10:54:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794855250; cv=none;
        d=google.com; s=arc-20260327;
        b=KbXVkhoUHKrhaUxOtDR6PjBcsYgdSojgMugJtFuaQztHwntjFnOiCvFUDkDIEayXvJ
         cGkXZHXE23nebe7w4Zmba5jVxlIuBBMdmI6opZV5VcRB3kE/vU+RMEv7bmiC3nGMPOYP
         COXEBnCbvAcENiJWjoCrZYdijIODJhRnQO3waAU5AXks+49uaJarmnYnPSLoObGvopUi
         D/fu9OsX/knSRuatc9Pdcr2yYPMit1ynBulOVPAV7pY8jiGT4pP4DNNSy/5CFyWyG03Q
         K418D+1MFIdGhfgIakzZIWVdU+KRZnLtIOtABX1b+wZBJqyil7kto7KpZ6Mj5LloYL+2
         8ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=choMbSoYoRkI4EZKogv+on35PXN8ET4WeIfVWxIT3BE=;
        fh=aJyvP/+aiUEwb5+BnGWNqDvbivtyxnEqLEB1X/+mgMA=;
        b=gkuViTEN2gGNf2FLOOqyuCnBexzbsuNinbCQZP+1tN3eU9l0OHUjxxbhlpAYoTkCR0
         FnQqRmgF35yemAdkwbgq8fsE0LT0uQ2tzKAwsua8DlinZSNyZHvl7zpTg0eGdEyBHKO+
         1vifjuOqMwtQpf8j9O+tA/gbXAU5AvgG5Lomj62Z+NoC4Fssyr070brdDD86hqrosHis
         BcZXoGPWVicf8DDAHhZzMs7XGYfoioNasziLsaocbzhHaFXoJOkWuzHyRX6KCseYJ3W1
         qeFT7/KsZCdoKJX6gAhKMutJKhwWBFSJ5es7eg9WJnTC9vPRdcnJFrvEH/wahz72q2Rm
         uWFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794855250; x=1795460050; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=choMbSoYoRkI4EZKogv+on35PXN8ET4WeIfVWxIT3BE=;
        b=Td9LqMZBHFV+p0mazrBtRu96p5TmeDwPSQL9a0Q0t2RN0IrNFBDVPKczSyar5mB3Bc
         OafxvqCuCmDeEB57+4beLr4DNjm5m0LyELvSw1ORSrE56d/LA3wyfChdrGA0jxRIykn7
         hhEfia0r2dUyociyyU72vSMffQK9ZaQbI1r46NRTin5FpTNCmpErvszhgIScGHRXnwWF
         G5/Q8X/HxWtX0G6+Tb2DGGWMvR6c4u1392Yhg/1oDPLBL0M3ynckTyLSv/KIK/1nSclj
         meWGOh5PUVcmQpMXPqMIHl6aQ+gXY64pO5HuKJnptk4vmtfaGf9AE7F79tnA2bS5An6C
         BOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855250; x=1795460050;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=choMbSoYoRkI4EZKogv+on35PXN8ET4WeIfVWxIT3BE=;
        b=k0IJN96QEBtBBV5JrqBSPUD2li8Xv9ed5tqK0/FHFMwFYPe9npExr1wEOgieZT1VJ8
         oBVrLtFQw6aF0S/ZWdP4bXjjrC+pEv9P9dMiOb37t2COvftWwVA+4XWSH0mJ8BLpCShE
         7OKIn+OP4dG2HDofwS49yACne0N84ee75oRQsDaFItSwEEI4lt7IafeK0226/tRfEr6A
         2+zZDB4ddQQCGYmMJrBIdBw/iYUJTB7LgXMgNB8SdLGqeebuHznJSgaDu87DgIgZJlBm
         XEkUtcX0TJJ5qOYKYcH9qs3F4sQ21eqXk7iQo4Zu+q5xzleFCZ0mRLlSdH5WTaAnl4bM
         H55A==
X-Gm-Message-State: APuU4Z/N00ZwUqfb8in434e5U4HFN524XzsfzizMaHXIDJJGojqs5uDy
	KTr7mvTYgmNBvfZaLuvNbZ5IAYn1s366ATlsJh+fqugERph+fsvrZ1nLQlCZEizwDTuUF5LNdYW
	bvvSLhTsitXtl9GEzWwgQf/vt20m8V7A=
X-Gm-Gg: AYBFou25+teZPx0YN+JubqHuDnm6GZ21Ya29Pwo0M7B1weew+SpsgsoTGPrpbB5GzNH
	z98CCfl5TZeQpGVL6zm69Q+f42CLP1kNoIWYltwl0QVs0wTJ9ikh6WibS/tLQQSS/53IGao1LtR
	Y6PFk/IMwqbAR3ovA+4YhZcED/doDPBFfav8VXUdrPXfjh1KkZ4mekSwPK+rVZE4757PoLdTplE
	Y54kwm44Hj95M741sR4QZ9JptuayQqN9fn+imAIsDWmZE+YKQssgro6ynAE6LPs2DRq/JPo5QGl
	q+yjeE8PmXMbVoUSwMzQGSZov05YkAb+yPNEY2ULmSSoMwJXUP0l7xoAU/Vjhb92nFxCNRwrs80
	3l2YgtJP+CDIE2gTQozABzSHcAFSD+AlxCn8=
X-Received: by 2002:a05:6402:3210:b0:6b5:9714:dea8 with SMTP id
 4fb4d7f45d1cf-6b7c0d24511mr9592011a12.45.1794855249794; Mon, 16 Nov 2026
 10:54:09 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020122712.526797-1-l.scorcia@gmail.com> <avZiZoGO4jXjIP7D@google.com>
In-Reply-To: <avZiZoGO4jXjIP7D@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 16 Nov 2026 19:53:58 +0100
X-Gm-Features: AclHuK-ct3_bPqNEIOSB1NJrGGSJAI5u9bKqHSATB78hAxnxBRSskimQcv_9q0Q
Message-ID: <CAORyz2LNRfnvbCLe+49A5kAF4NSi0zuYdpd95+7=Hx=KQh0B1g@mail.gmail.com>
Subject: Re: [PATCH] Input: goodix - sync the irq controller while starting firmware
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> There is call to goodix_int_sync() right after call to
> goodix_start_firmware(). Is it still needed if we call it here? I think
> the vendor drivers does not do it.

Hi,
unfortunately yes, it's needed right there on the Lenovo Tab E7.
Without it, the REG_SW_WDT right after it fails with the error "Error
reading 1 bytes from 0x8041: -6".
The vendor sources for this device [1] show the call to
goodix_int_sync exactly between the two interactions with the WDT
register.

Actually, in the same sources I see no trace of a second
goodix_int_sync after firmware has loaded, so the existing call could
be moved a little earlier instead of introducing a duplicated new one.
I tested moving the existing call on my device and it works just as
fine (basically, my patch + commenting out the existing call at the
end of goodix_firmware_upload.

Which vendor sources are you using for your reference?

Thank you,
Luca

[1] https://github.com/lscorcia/linux-lenovo-tb7104f/blob/2dad69c9f28611ac6d3db2f1ee11b480a60d83ee/kernel-4.4/drivers/input/touchscreen/mediatek/gt912_p98996/gt9xx_driver.c#L1529
