Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8818DB2A
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894836; cv=none; b=bOBZp5Z7u+AYyWC/pDsNjKxrUmkJ7x8FAcjIr9Qf+rN4mpSFxcG8CEPYe+GvM3Qxl++O02sava2G/vsXM2qO3LpmpTGw+cPCvk2dykPC7A8W+7BFLT/eQOZFVPERvQ6Vhpv3rq5jLC+Cl7FJOm7dfjbjgzpYmJC1pRpgr8Y6R+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894836; c=relaxed/simple;
	bh=5jN52IdsSbjm829LHP1blJIbKJN09jEu6RV1toJJOcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptzUV//GYu+CWC3lqK8nKGGKbvx5a47vSJ/oCX7GBbOX8aHYKn3PxKPOsovQC4fdnllgh15A2IX2pX3uWm5os2VwqCwC/fuNbOyBTx3WuUCE/n1OyS11yFS9ykBRH5gVFFE4AkEAEeIgjW9n4z7FKlHYZ/il6knoZf3Lxs1KxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+4i7pzN; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+4i7pzN"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271195d2a7so1074633c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771894835; x=1772499635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2uvQ9O24I15o797RSwZq84+qdPgPwWIChdomW4o10c=;
        b=k+4i7pzNP5KNRfAcW8DURRSn4kAbkpNN6esuEif3aGSvcMEuzE82Y09nWKaU3r5vKJ
         v3a3BaEqwbfZu4LWJnB2oeuXRFEgSw/4eYmTiXAxcAYwEO+JGiXovq9cD2kVo5LXF6W4
         SwF5UT/40nA+H2aw/8F5QQJb//jt9ERMDDG5YMgRcrE/vcpa6+KfkihfOXx8qGuqXcuy
         XJ1PezXmF6FwlEDLklKOMGH2y+cxlZfR7NucU6hPhFP+M4LrvWDqrntMTbRRGsKFetrf
         96GK1N2y7dV2XeHWedQx5eox9Y/+eN4cX3ZJ/pT9mYSbeEd74m091SnNtfGZ1zKaKgJb
         I75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771894835; x=1772499635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2uvQ9O24I15o797RSwZq84+qdPgPwWIChdomW4o10c=;
        b=tJT1fP1G6cKOp8kgqmSQsMLzRtbHJ+0kvQSzi4FBcqhYrCF0X601IZXsYbmfQ3Xrhb
         rtLUhsEZi6aIohV8UFujSAOwHBQunIdm9s4s6i29tXFCueGUuekj+aIeRawD2BmErJLb
         3vEQjDC/yA4K/CyY10ebljXmtEQpPtyClSo9n/Ladrran0NvAJp1OKx3ZumBMuz96THI
         dcrHPBPpib/E+cfP+2uD0LXXZCyH+TGdR+suQgvdiHZzngXgxmOxjrgbYDtuhLzPoItk
         RMMNe5RWJx0G9p/Xr3oszy1O7aZKloQwb5WcAE2PbO/j+thynbjfFmQuaFghS9ppH/6C
         7zgw==
X-Forwarded-Encrypted: i=1; AJvYcCVv1y5EasJkHjvLmR5wPEANWmhsYBd2dmgeWooiF7abEoBT8CeWDMZxcnOecFactvus/d5DIWcvsaQ5hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJk4V8wUY08Pk2aTkA8FXE4+GArmokNcpP1RTXerXeqzvLJD2
	wJNMXiCyMdySNPDZusI0vnK6N/yyLD6AgvkUitV37kLUGRMZYirRYAk6
X-Gm-Gg: AZuq6aJ1M9kKbYDW3K61bIcfo4j72Z6gC1drBst0i2nWPf6H8nADamh3UtQM+ZlGFND
	5mBK1gOxH0PMEiLouek2P7VDpneoDZ28nPidnlBZWle/2AnT2cWu9mV/YUKFHOpjUO1r9hycBIi
	LnU1f0YxNOX8DI1folkd2IGbJFhfnIfJmXck5D0z2u/hkLpF/TCsdq7zvhc+BsUG4UG+sMc7QR7
	tvrXU7ww+YpSsjsEtCD0Q7GyQ2xSi3BXzmexdhtj3efJxURXC3Gs47WfWKc0KpL8e/9noOVUweh
	5LXHUBaJiekl+ECqNqbBEr+hILAO3WmzHBxgC+l6jILrv0xEkaRV4oShAC+P82N52b1RIlZYSpq
	beydPll8Fq1B/JFDOrz0IQc4+vno6KrTCBBQT0CBdwIweKJZPZ9RxHgTFSMRzTgIghowZSVjTTa
	KthWi3vz9GyESCkASwnIyuF3TP1XnhwiU3/V9n8yUZT7UIgpelNxxe8UV+WiPe+Y2JI9eixHwW+
	o/c/Q==
X-Received: by 2002:a05:7022:a91:b0:123:3bba:fc4c with SMTP id a92af1059eb24-1276ad50e28mr4383416c88.38.1771894834231;
        Mon, 23 Feb 2026 17:00:34 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276afa0bedsm9107517c88.16.2026.02.23.17.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 17:00:33 -0800 (PST)
Message-ID: <41b4f4c1-f0c3-4ce7-8267-039bb77ea953@gmail.com>
Date: Mon, 23 Feb 2026 17:00:32 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: msm8960: expressatt: Add
 coreriver,tc360-touchkey
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 beomho.seo@samsung.com, jcsing.lee@samsung.com, linux-input@vger.kernel.org,
 nick.reitemeyer@web.de
References: <20251205-expressatt-touchkey-v1-1-1444b927c9f3@gmail.com>
 <532531d2-8f26-4ffa-9355-7821a4d64200@oss.qualcomm.com>
 <1e74b956-a45a-4d3e-b7fa-e4d5dc0390db@gmail.com>
 <97d9d942-236c-4f8a-902e-0ad2ab684a76@oss.qualcomm.com>
 <1ebc2e1b-f1aa-4559-90a0-feb628d5bfe1@gmail.com>
 <aZvPUn2RxUHDahfO@google.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <aZvPUn2RxUHDahfO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/22/26 19:54, Dmitry Torokhov wrote:
> Hi Rudraksha,
>
> On Thu, Feb 19, 2026 at 08:33:43PM -0800, Rudraksha Gupta wrote:
>> Hello all,
>>
>>
>> Top posting for once (context below).
>>
>> Not too sure what the next steps are to get the tm2 touchkey in. Should I
>> resend the patch, contact someone else that can help provide guidance, or
>> something else?
>>
>>
>> Adding Dmitry Torokhov (official maintainer) and Nick Reitemeyer (person who
>> introduced this variant).
> Sorry, I am not sure what the question is... It seems that you made the
> driver work without any additional changes?

I believe this patch is blocked on Konrad's comment:

 > This driver mentions a register called CYPRESS_MODULE_VER - maybe
it could help confirm the model?


This was in response to me saying that the "coreriver,tc360-touchkey" 
tm2 variant works as is on my device, but I can't tell for sure if this 
is actually the variant that is on my device. There isn't really any 
documentation for how this peripheral works and I was primarily relying 
on others in this thread to provide details to confirm that this is the 
actual variant being used.

If I'm mistaken that this is a blocker, please let me know.


Thanks,
Rudraksha

