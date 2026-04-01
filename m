Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDEE47279C
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054692; cv=none; b=S/3VAnsqSsK3FALjYqGnWkDup4DiHtHj0no1psg2epDPd0HkEEszwhI5fJ4ITyTwNYAy4MeF2yvauxFW18Vg6BEZoLG3A4VYMqhPY1+dwMEjTGNFMxRGJ6Q/7/Jse0a/T9QLFalDApipmBqAt6gNnnowH/H5Sse2du3avcBI6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054692; c=relaxed/simple;
	bh=eCtz8uzC3ZyJhfgNc4nb8F31dhwu97gqPpF2HvCCt2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PkLsr17XsTa5GLx7Q9SWxeoXHcOGnXNQPOSxUQIpA1hC/dXRZh4B66YqR50e8GmvG6oOX/egzoD3qnu8WZR8AWFB/zVzzCyoHlx+xaBlFTty/tlDPR6HfTckw9lhusYYqENeXrksqsBGszEDg64oMX+fCsD652gr/Xr3hHFqrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1sXwq8NL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1sXwq8NL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so135531866b.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775054689; x=1775659489; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCtz8uzC3ZyJhfgNc4nb8F31dhwu97gqPpF2HvCCt2s=;
        b=1sXwq8NLtGdu7z6wbHuWIWyUwu/5yButIFiqdCXoUK8dS+HqT0cW9HZen+TJFo24Ny
         L8+15BoEum2NVrcrquJ7scAQPBtdnPQqZyh8pyZW42E5vPez6PxzlZWHnydLJEgxm3M9
         vTO3/WDspo0LQg/TytROkih1KmnuprcqS92TP2t0p2LxVdPi48V7Uo/vxCDanx6E4SpM
         NywT1I8Xa4yxvU3uRlUf8NfYOZSNT+cQwi2e4sLpaMukapsxG8Gnz2hrVX36cFDHdt19
         ty2aTjEfoptx5PUiuVcOVWM93GsLHLTXagjVw5sFVMzIfL/6xHIdpNkQS+ZkXooL/F/9
         NChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054689; x=1775659489;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCtz8uzC3ZyJhfgNc4nb8F31dhwu97gqPpF2HvCCt2s=;
        b=LKzMQ2QcBRV00B0fDFkc2owbcyUSFR4TLRh+IkELu+2q7V8HqIWzpytKfFoPkvxkFH
         1tc6LrVnNHyfUpHIdnYBLevfGwSku10+BRbHvdWot+qJ7vitOHQ1tq6yPOuKdN3xXeUt
         nvrGcXsUdRs85OCAzJHoLwAj8zJeJScTnFGx1v7IADRQsph490pFCciJq/6Rs0VoAH3D
         TWcbh7yLrClbLYhAc2ZsYTgh1xDrbqMK6B7GxjFiMsYEEqmGl72j9YW3U/IyNofZkN5x
         PhJ87rKAsKkuvQPFfHquNdTyyBPbZhiHoUVGmuIxEJdaVhkE2RH6g7rJHzd0DRNLqEXO
         M6/w==
X-Forwarded-Encrypted: i=1; AJvYcCV9hMGkWQ7aloI7752P/Iv1U/JbHzkBn9UBtcMyPFYCrpImfCHkDWCHte1Y8chJ83VzlvC0y5q93UEdAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYv+AvW3wezVRuOmIvKSfwSWQcB4Mv+z7hCjf9jN454LVted9
	5U+xgal0CM6CrrlikIWKDlLPQ8WF+NqZQopAachtcBXO7iG/U10Xmjjg7a65nLZaVso=
X-Gm-Gg: ATEYQzyM3yoBZLaN3uvIex7u2l1Zv3P0oXRigsmlaRrocwUfamDhk4ezJB6bFdrhpUX
	+jnIX4Tl3nnPsEbB7aiCy0Cgn4HzRH0QblK+R/gTscZE1ElRIV9hwwwZy7tTnVeVNwNnQpXypB4
	Pz+o7nIR+7VflLxJbFWmWozLAEQTxEOHZHaxr359ixBl9+TiYtrP8Y47gvK627gNAsgCPSLOho4
	jk+DTb7vS99EiZp1tLYDVUjtj7eEUUJHhDP+EGHJFxmwEJSLIFlnJhhsUqMrWhpfCkZKDynelth
	fRK4/J6yNaKa6BT3dc4mHcwBfFjIou760uA/tyqIiHex8FPgS5tugxDkaS2j6U1sM7iNReZdzLh
	H0MENa48ejW8+iT2XW/2N77gu72vF3RQ6of9QqUceqVc13AA5+kEQ1VQ5G4r63C3tyx6b3d4Em7
	ZSKt4ofvmlMRz5m6mysZcqrF4pKBXf+mxs2RZcCi3TqixuvPWEmcwD1wR/iUWnuWljcv5Gb+cKK
	nxYcigir1N9P0aIHF3Q5vk6ILUXjEK//NGo
X-Received: by 2002:a17:906:3750:b0:b9c:1a5:acb4 with SMTP id a640c23a62f3a-b9c13ca82fcmr213347166b.45.1775054689211;
        Wed, 01 Apr 2026 07:44:49 -0700 (PDT)
Received: from localhost (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5fb3sm538720866b.31.2026.04.01.07.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 07:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 16:44:47 +0200
Message-Id: <DHHWDE7QEOTO.1AQ85UBLO8IQG@fairphone.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Griffin Kroah-Hartman"
 <griffin.kroah@fairphone.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] Input: aw86938 - add driver for Awinic AW86938
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
 <20260302-aw86938-driver-v4-3-92c865df9cca@fairphone.com>
 <aae7fRYaoDHMptyu@google.com>
In-Reply-To: <aae7fRYaoDHMptyu@google.com>

Hi Dmitry,

On Wed Mar 4, 2026 at 5:56 AM CET, Dmitry Torokhov wrote:
> On Mon, Mar 02, 2026 at 11:50:27AM +0100, Griffin Kroah-Hartman wrote:
>> Add support for the I2C-connected Awinic AW86938 LRA haptic driver.
>>=20
>> The AW86938 has a similar but slightly different register layout. In
>> particular, the boost mode register values.
>> The AW86938 also has some extra features that aren't implemented
>> in this driver yet.
>>=20
>> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
>
> Applied, thank you.

I'm curious, where did you apply these patches? linux-next doesn't have
it and I don't see it in your kernel.org repo either.
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/

Did this slip through the cracks or will these patches still appear
there?

Regards
Luca
