Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436641;
	b=xaUNhtrpWdI8RcFtLaEn6Ra83qZBWrS+sLTl0utZz+Wlvgt0aoarazKvLzObgp+kSxPG
	 aXJhNuTbZ03aWe7eP4UN8BkGQ0i2ITfLjRU/kn98VfFa4WgvywTB8KQm3deMAU4Wj2fJM
	 Xq9d3FI5D9olv9wodjsxKQY4+5AtUDvJVBWyjsU0njMl8HBscAHvTyLmtDoLd+IemFVCO
	 r9FisByg/hzdemk2Bm77hwLjO6CtVHNP2rhFq+BtypbfrnhFpRdKrvvEdpQeTDR/BPTCc
	 5mofgS9LN8BVcCt6YcFvdV9Wr32njvBkJRFrneP9uTo6PHA3GfXa1E0qvGzsquBdU8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=tNjY8+hhVU4H7nudtWwRsBTQX4I5mOLQRqYzvL9iveg=;
	b=l1ovQj41UYp8UQ8jEPPWwZBeVaryXrCRFn5M0Aa133UgOblX9610vOMWxqeBvxAWMmO1
	 tGBgZ/fsCgDAIdnwhLhQE01XHrhTIChRVpefzstn5Cuz4pC6i8n/X5GivHUowd1XlS6AT
	 0YddjHGMFRxsUB4aBHRha5XvdeP3CsePLYTL7qp8dmjAB4hq/XYh1wG3HI7nnQ9QhJxdU
	 VVrxagwOvkBsfW+ZXAENpDaqUzzDz7WqmoCDUf2l/IB2DD0potGkxMdyOauO9N1PoXXaf
	 APIGb4kvA3E9ZEaCqgS0B6dTQeMVf9EN5kvupPqEHjHt0tuFQgUixCbPd30HeyH2YWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtQuSOYg;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81704606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81704606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FtQuSOYg
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so523150466b.3
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436640; x=1796041440; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tNjY8+hhVU4H7nudtWwRsBTQX4I5mOLQRqYzvL9iveg=;
        b=FtQuSOYg8sSf4/9V48Ab8qAjujqQz8NpDRWzirALjzHz4bD9ONZbSyTxPwLYNxZbOM
         N+tqz91gdfSCbdcnbNd9ERMipX0rPW1mIPC5bJbEOmBZxkYHpFzJxC0BZCwTaqeov0VH
         NoGITM3lvvDAVK401wBOsWCUrXHF5o+jie2l1moTEcTi9kZlUiphn9ph/y2aLQZDbHzT
         6RoK2LwZgnIKSeQlmwKSQ0cS8oNjqJyxDiTeU1KKTdWBuRlcoqJdi2VLH0zbPeEyZ2+q
         HqC/OaOQ49PpMS8uzsx7hbRKbyErKQiGQ7Y6ESG3KlEtJho+Nj7hI1jjlJU1URXDHxtK
         YLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436640; x=1796041440;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNjY8+hhVU4H7nudtWwRsBTQX4I5mOLQRqYzvL9iveg=;
        b=Lk7i2kFvL3C+CwA/qBYB9IWEfImS/X/KeiAdn+I1p6k0jxgEqEaktawcbKn+ETaVh+
         TiKCbEsDPgxVKpj2bEMXnPmf5oGdBnRIEUBRXsxL4mPxTaKpA1tX2VUNmn6JWy2YFMNI
         7EdvxBw7cuPyTRAuv/3O7BCdhkLEH7M2Cza/Ct4qDk3C8qbooZfALSPF8/+t7LnpNNDM
         7Ucyw1q5sqck+eg80w11J/59ZfwMelmW1JiV9BRD8wqhj0ffQXu2ZWwJJcbVG6/tOHIH
         /HzD1Aq46N96YKTpP5dfe+JjFxjOXV7iIjJAVwFYQE28GfcgdR+FM0p/AY/q7uR10bMk
         NbWA==
X-Forwarded-Encrypted: i=1; AL+hErGiio7BuQLiySuEobk5PXMf89+QmKVmopX/iczKVjRlE7LZUwWgkhg1TNy04Jnh0kXLLwGRuSKGwS8mCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WGA1W1NbgGJhgbuBtUDHGCLZiyt3b6FJ3uhjQ5lvB+P3lpRWj
	UX8+hFeM/omMHVLvOq4EAG7X+7oKFF+j1Op6zNt6NbLQjA4HSWqekTon
X-Gm-Gg: AZFdTZcAVpcVOjHkp3JaMAkVJ5uU2/qFkgPWI4DhjQBdcBvwhflns/zMXUsgKAUKt+t
	+vwN/xCmdxIdngMlrWkI4pqP6lGrONxcN+U2kJwrviVa85gqa79vyT2LHC/yjzDBDhCDlImXr84
	tCO17CkPUlnifo/0ZdoSpYXwEQvMAwsDTkrdUokZ/gumKKe7UyKReeTWP6by/1NCEA7hdB5M2oi
	jdMBDDjYwrXk9zDWbKNDNMeRaoN0iTYkTVYsTpDyRTBG75tU6w3fK8/Hu7v+uJtJ35YhNCzJegC
	NzQi/DzpHRuLmGutKW5500Lo9huNBDWU4RsttZDQyhmWiiq1oBJeSztl0ZvCqDDFnBhUEiWngcB
	ozCZm6knv/nC+eGgbabSeStdxSL5Or2nBcSMM7B/cbaglkYwLeIyDC0au3Iuqg3SQCBRXfAjv10
	3mZB6RTuNXNOALH3JEQWJ0bwHzEUCeqvXvTGWFnUmcqlAHwpvpncp/TDo/bbrD9W59VsUIkfcDm
	KjDZzWL2Kpth7SyQcOGERsI97TlkK1/xLq6RaxpPpLWWMTL2Wu78tQk9VAWXr3XdNPKEvMALKbQ
	wv5wvIg7vXP95dZFWSqzQITI5Bfb+ps4DJ4HlR/ZAXQXt833NRlosGrR
X-Received: by 2002:a17:907:9612:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c513a8845femr1010728466b.30.1795436639952;
        Mon, 23 Nov 2026 04:23:59 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc42easm391318966b.60.2026.11.23.04.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:23:59 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 15:23:56 +0300
Message-Id: <DN2L64B7KMAK.11FXWAFFOOFV5@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
 <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: mediatek: Add MT6895 SoC
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-6-95c46597e63d@gmail.com>
 <sashiko-outbox-229131@kernel.org>
In-Reply-To: <sashiko-outbox-229131@kernel.org>

On Mon Nov 23, 2026 at 2:25 PM MSK, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] arm64: dts: mediatek: mt6895: missing EL2 virtual timer
>   interrupt in timer node
> --
>
> commit 52307c1c986494baf205914bdd46826de40efb27
> Author: Alexander Letuchiy <asalde.le1@gmail.com>
>
> arm64: dts: mediatek: Add MT6895 SoC
>
> This commit adds initial devicetree support for the MediaTek MT6895 SoC,
> describing its Cortex-A55 and Cortex-A78 CPUs, caches, GICv3, PMUs, timer=
s,
> pin controller, UARTs, watchdog, and keypad.
>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6895.dtsi b/arch/arm64/boot/=
dts/mediatek/mt6895.dtsi
>> new file mode 100644
>> index 0000000000000..62584cec0f4fc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt6895.dtsi
>
> [ ... ]
>
>> +	timer {
>> +		compatible =3D "arm,armv8-timer";
>> +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
>> +	};
>> +};
>
> [Severity: Low]
> Should this timer node also include the fifth PPI (<GIC_PPI 12
> IRQ_TYPE_LEVEL_HIGH 0>) for the EL2 virtual timer?
>
> Cortex-A55 and Cortex-A78 implement FEAT_VHE, so when Linux boots at EL2 =
in
> VHE mode without the fifth interrupt entry, arch_timer_select_ppi() logs =
a
> FW_BUG warning ("VHE-capable CPU without EL2 virtual timer interrupt") an=
d
> falls back to the EL2 physical timer.

Yes, you are right, thanks. The A55/A78 cores implement FEAT_VHE, so the
fifth PPI (EL2 virtual timer) should be there too. I will add it in the
next version, or send a follow-up patch if the initial support is merged
first.
