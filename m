Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFC217F27
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769367019; cv=none; b=PQ/WB0NzrUWB0OpkQcFATLKtB21T44MaTJe/vKgFEpNcAVO1JU+Gpe8UJgCMEQF/ABmxvoIp2CRBS3sPZMizlpVPlkAMdIrSqvv1fxNSxyyrQpNTp9VWyUsxXSciB7JHZL8t2zmY0D+WY/tUqYjcpmjVCjl7tr52FjDujx80jVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769367019; c=relaxed/simple;
	bh=iHz2Zx+6vxSsJsLU+2K6h4Mq/HcxIkwRv8Ovqqhd5QY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cciD4INJtnQFondRdwZ+WsRpc4RA42Iaw1rwlx9Z6LkQU64NNSgjWf2zUoD6z76t4ACKje4XWbdIO7k4h21UlbVbjBoR8KmmtiOgCuVJv2ptig8eLdvCHuA3I0xh6YEPgAI/XUBRPmdNm4kmDX24s+Ae5g7b6Yb/zaeXg/v2Rt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3mJcFed; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3mJcFed"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c6a001e3bfso221150185a.1
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 10:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769367016; x=1769971816; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHz2Zx+6vxSsJsLU+2K6h4Mq/HcxIkwRv8Ovqqhd5QY=;
        b=A3mJcFed+u9OTMcF82nUy37azraEgVQX8X4HNpoBRQ2HsIzn3Paem+7PnPzIGpofxt
         GWQ+vsWV5aXOxFUGU6+goDFcMyhmW9BTr0YQDwQpoCAMWyE+HCBhGaghWGOH7ad6xr58
         qV5VcUCyPGSCpN4Kcvk0uTyNehzqLHoN8Ev17Ar9OLG71R0HD8Aa1BaRXCjiLMd/RY4G
         7PncvTYPb43wkwH5mxwMJFB/VlTJC3g3iVSk4JeiffgYQljvG3ReHGVyvMvirGcrQDJg
         QpPlGKQgKSaBVGoUn43jCo0+i4CXTNoObR5u7I++3zlzRIqoWTYnd1+/COQEmyTnNPD4
         aQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769367016; x=1769971816;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHz2Zx+6vxSsJsLU+2K6h4Mq/HcxIkwRv8Ovqqhd5QY=;
        b=jnW01/t3WV4DEe9UnRZDKMcLlDM9d8GrsQu23b7iJosUQsL9qZXgpqtgsQIYC6LJwa
         GOr7yg1wFoFqwnaIHHWRKwBhyJioc9ib911NBwpi/2EgCn+zhcXGpf9hjYiXEB+BjguY
         0kcXJg2kHdU7IXgXU9UmGm1IDiKG1UbaeewiyWoHjNORYlaAYNjAkg66d0jjQgxGTyQA
         TonEb7Ay+iaxD3aSrAIUgwprxcTLF/gaRV2Q3RBr+aZivlu5jEVp7IOWQQDb2x958aKt
         AgumXxOJM37KirNO8KcxY/SBASmMM9amNwceNEOaEn7gyOl4WWyWAp2TycHPg2hWDP7M
         vQgA==
X-Gm-Message-State: AOJu0YzHSvksEPCLEHz+3Q4BZMSNcH1QFwMWoU2tWVDTaLq5M1JKloDO
	UKGWCtTBEaqud5UEjcYQZTN7PVZnfzxMjxUpotv2PvnOmGT6zUJ7i4sIGEyT5NnI
X-Gm-Gg: AZuq6aJehzzZz1F0/68Nxa6gsme7gA8Oq9zk+SlMNivFNVYL/p3XEI091O8a3+n2eXO
	CS9odJBIlhU9Knhx86Yh0zSLMjXa/6G475kMerwvm+FGOwhFPthqScXAs8JSP34fN/r913Oavw+
	sHnW2lAbhYW9gm7/1fQPWjZtL6vBYhKofHG+fFUoReg0AMWQRYdcuYRH2Bu5kQR4sxWqn+64grV
	z1WIPz4kUOLKctnv8Vuc0LXSECloHdgsbW/M3HK+eRDoc4G1h2fyL2N5eZB/62B6zArgce7A638
	4VjVh4t/zNMs4iKRskgtRv0YyX85FF4blwZj+LjMNu1WViruf8SQQCczoB997j2A/gOGDFf0jBC
	1kXC8/MJrQAv1FQk1njfAnzgVSjNe0E3d99n9uEDFBFbQDh/ZCXmvzjIQLhyP02OJAgRf1PWWnT
	8xKPS3rfU4Oe2CX6nBM9oT39e4euTZ/jzOJ/mKCj4eQS/VXaglTqdYxFYxyz6BCh6SKuU=
X-Received: by 2002:ac8:7e88:0:b0:501:5281:5388 with SMTP id d75a77b69052e-50314c743ecmr24702381cf.48.1769367016584;
        Sun, 25 Jan 2026 10:50:16 -0800 (PST)
Received: from ?IPV6:2601:195:c980:6a40:6be4:b939:d709:5751? ([2601:195:c980:6a40:6be4:b939:d709:5751])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7edef5dsm63704261cf.13.2026.01.25.10.50.15
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 10:50:16 -0800 (PST)
Message-ID: <71dca93f-ffc0-486c-8490-7934e38b2521@gmail.com>
Date: Sun, 25 Jan 2026 13:50:15 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-input@vger.kernel.org
From: Yelsin Sepulveda <yelsinsepulveda@gmail.com>
Subject: sub
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

sub
