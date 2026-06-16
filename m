Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE13890F7
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620658; cv=none; b=PE27jTbETdL/fkYAKPWwhXNFD6gGbcikCO20Rz2wiQudpulivYkXbXtUAf7XDdKyRQ4jfJxyvCdgKL/Az6t37NbTWeuUnwKdl1cC9UdaFyhVR2JNavqYg9wcefzoJ6wDPvYbh6u1M5EYalvV1sRf+teoD0HOsTa/qu5Fyva8E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620658; c=relaxed/simple;
	bh=FfugnIQHm5unZ1sPR1Y/dZuhbcMyf+Hu3CPQK9MdeHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtkMPRtboAE1co51NgXqcDsmpQ5jI446ddYnFXzyHPywdH44Y3f01q7IrcUnEnZk4WpvLqMYWpsjDpAKZ3ukXQJ+g0o8w5E80gCeWbnWZIiSokWO8IDUXiICRpZLmOht4S9U6OArEwGH/OgkyHYnL7HWlzpo1TUTd9H7d8rmgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD6KhlVl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD6KhlVl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso24164945e9.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781620655; x=1782225455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j5+URZt3Wu1iRceLE2DPySkKJNC2rK90kTRHgoMPIB8=;
        b=LD6KhlVlHlwayDjDAR7n7v6Y4dplTfNFAimIfTXZLXetf3revKu7W/sGFuDAe9JAb9
         Z6SfCwrYCI50699JAjL10HwWrGQhnZ2jan8dh0jyVGY6CLpixBZL0ZN3UvGb/0R5ooD2
         8trGIoCX3YFzOHSj64taYDS62KbPiA0flRYHVZx6jxewInu9F53dLj69nfM2YzriQdRU
         BVSO222j71YZ5hirvvWlC1sH2d7u8S8YXJW+Y1Qtx8vVlihOe2VO+vU2uI6OYbiKKCWo
         StAyqvtj+Cf0BhWWvCaeekXK7Y9P2Gd+2CluXmt9WfmWKZ1RVjuAQU2EgjMWrZUXSUcd
         qTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620655; x=1782225455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5+URZt3Wu1iRceLE2DPySkKJNC2rK90kTRHgoMPIB8=;
        b=I2ESerGU5cvqTl/IZKeOejLDL4/F/WjVtdeU3NzV6chPE7IYIXt3MpNtfad0NmOh0t
         9rCPIC5+NjAC76Ekt60tuY/qlqcqKHFHRLhFsnODpxZyYZiVP2V7oASFPNBYTCxd92ox
         8Bq+z/mYB2L2Lg38q/sJkuETGQV8mNLEahZvnUJpUT18yGYrgtjU/4ffDEPaLdBVoltI
         L2VBcLkPcvK92S7F4hBkPBwPOZcYLoHhkQu3kRgnljZbKE1WqoKjMgQqSZaL++SU7xVK
         izppacv41cjYI3nEYXEnuzmv3KAT/RrgeIL5iEdVzyI7TsnYudhc6biuwf9zYAdVR+lz
         pPfA==
X-Forwarded-Encrypted: i=1; AFNElJ8CHWbtF/QVsqsJqZPd1kTDcZ/vnxQ5dWW5gYGvWpQIeVNEI568AC+v5pOWxWiluvkZyDFAh6hPPmMBHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjFPXRcp45ERzg6Nl4Fu2xVGEM/l4LjLsLy7BdYIoatpH5XSF
	hMEOnHH9BTrmw5Gs8I2vFgsENa74nPi113ZS1CDgOgxi9/ngrkiy0lqX
X-Gm-Gg: Acq92OER9OOgnV5hEKS1yFBAyH+EsRNK52ElFez/uALC8uDBlbVvCAaoSbHLfT9of/e
	bg0ohgGMeQ8gHzSUTG3WL09lfxcjFhdY7Xb0IREW/xFP5svk/OyMQmjZKt35mXUIe3Nx6wh9HkR
	p1n9Uiii+k8ay/81AL/IckZRmM7yPAt3Jtd9/QlwS78zz9KokhMBsXfUSXt5r5glLNaOjjskFZY
	k9U+OnyizLOEtV/6IAU4ffI0Nmz4HGwkzVapnW5kPbCGITxRyelmLyuuUzcXdU/Ma0uJbau7xzl
	zL6h8HiruO1WpCoi+v9ynfJ/C2EfDFooHciKBauYXoZ849sSo00MpRFksTjte6E1xwLeZSH5LMw
	ijZXIaKQZ72vYU/VQ51ULKC+uxphM5qPF57atf7nAkBHXCBjk8eg95i6RfcgIXCT8TnptsBQpV4
	WLJ889NFFUqLsuTbAUFAF8Qhr0qXIM9wTvmBaAP9aLEu3nKFJ2RUZyM+GrwBpNSR57+lanznev1
	QwjX9aNyU2pR5QwPBlBtVsLpKFNIg==
X-Received: by 2002:a05:600c:3543:b0:492:3071:1db7 with SMTP id 5b1f17b1804b1-49230711dc1mr53184075e9.28.1781620655013;
        Tue, 16 Jun 2026 07:37:35 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-461eaa0d1c7sm1813947f8f.7.2026.06.16.07.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 07:37:34 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <18c34b11-04eb-4e01-aad2-8c18fbe26efa@gmail.com>
Date: Tue, 16 Jun 2026 15:37:33 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] input: misc: Add Qualcomm SPMI PMIC haptics driver
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: David Collins <david.collins@oss.qualcomm.com>,
 Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, kernel@oss.qualcomm.com,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260616-qcom-spmi-haptics-v1-0-d24e422de6b4@oss.qualcomm.com>
 <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260616-qcom-spmi-haptics-v1-3-d24e422de6b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenglin,

On 6/16/26 11:08, Fenglin Wu wrote:

> +config INPUT_QCOM_SPMI_HAPTICS
> +	tristate "Qualcomm SPMI PMIC haptics support"
> +	depends on INPUT && MFD_SPMI_PMIC

The dependency on INPUT is unnecessary, all config options in this
Kconfig file already depend on INPUT due to an 'if INPUT..endif' in
drivers/input/Kconfig

(Yes, a few of the other config options in this file also have this
duplicate dependency on INPUT due to an explicit 'depends on'
attribute, but this file is in need of a cleanup.)

- Julian Braha
