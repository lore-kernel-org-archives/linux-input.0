Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463D5632B1
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095192; cv=none; b=MPjRoBsd88EKFvXILznAyJjfYdZd/i34TBehiczvyGziIWYOcLKztPdMlrF1cP4N/jluKeWlyoIOetiyy6zlX4TUe4l9/4WhfPXuYQguzb+/0G/PHVce5u2JIeAcuvP8fo0NSQBIxt1mFlCuGsV4TB8QIEQQbFSED/wct1Emov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095192; c=relaxed/simple;
	bh=XumR3Wy9fE5xGCpIol7Xpgk6iG7KROyRi0hEfy7kmGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqMDcer0Djl6NOF2ofaaji9F8GsltH2Q3lBC1MD95/FWc+wySmgJvFn18AYTdmZsOZ4ZOqGNuO00eyja5DjnmVmTzZ/DjM07Bi8v1dRMq/vTYPzaMH5V7EgqE4/ei/+oW661jx0N3w46mdB57yhADdBEXpUFzaUBt3qj+W+GRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVjXZ2Ut; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVjXZ2Ut"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso4040274e87.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790095187; x=1790699987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HIREcnpSbtoZzKxFZ29E3etQk4OTENVP+V4H8YsjCyQ=;
        b=GVjXZ2Uth1Ov4XRBnptNx5MAJU6HLuMfr8khCSjRjXxAzHin9rut1cJm2J3MhoahuP
         ed778gYyaUQLt7UuTcU7sOp5lo3j73UFvYOSmXAjHvGPMXJ2b8qGNk7YF/74WWm+tGfD
         YRR/i420ww/TLF4IKexB3V5SKyq+eKn3JGACMebwFa36yhQC03ryI28cjKz6lPWCpxAu
         AU1NbCPZId0cm3+EzpTYZLtCCbubvAhBnoR83MRTYuodepQ9n8gsbjmCs8rHGxdbJBTa
         inEATaGsSlyyIt3MKxDO63pFy/xlOs2aG2h50KHBSbnPlMGesyINhFAwPTdcLE2FVD7N
         js5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790095187; x=1790699987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIREcnpSbtoZzKxFZ29E3etQk4OTENVP+V4H8YsjCyQ=;
        b=kYkN//8+8wxkTh7jftN4l+SEGvOGUeNNBRmdXR1CgJKOTgCrmg6RQrkvEBbOrcPLK/
         6pWy8iKBWV1vGi65mtlL1vK05n/kTkmFJzKChTxgZFNLR5P8+2fF7RfxJ4DeG/s1Dkaj
         bjhIYMWb+7TzeEAizUBtzj3jpk0kQCwy23ESGsxkaKnl5PMBo4Xux0LkqUMhvILmnCNv
         jwInxB5RS/hr6KybpgXtEakiQuP9kY3O8ulYEry8vnxI26gvEn60EeaV23HZEgx9J28h
         Di/Mx30TYK3nOHGwSGEjaUY7/jk2eBU95mnz1uaJOs/1ad/K80gHG8HyGIO+LT5FqB9X
         30Nw==
X-Forwarded-Encrypted: i=1; AKwUvBywwmLK4uO1TZWyv2oI/bMJQh6boCDKoZUCgo+PmzGF8aHcuKSe9cAWuMcLNPFZCWNjmWSfaGTjiLUrNQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kgFWxOBocKen3AwdA/2nIxlwszaQDWI44fvZO/M27v1+lM9bTZ
	XZrzd1olUtVjQ8wy4pgBbfQhs59CoCDUwBi/0Kautk5Kj/pMKoO28b15T5grCzFARMs=
X-Gm-Gg: AYBFou25rT0pCPzpV+vaqSlATxliEqdpFy8JHKmSFQe9nZaOMpKrBj3ZRErfgpOu0Ek
	Z3IIlHxxTjG8hJuLJ2yEVVvjZxAwTrP0Vu2Q8DEtGPTZOn87tm8iLv9+7SAxfPJv3OYPkcPM/Jf
	r6Ebms8+TVLg0KTKT731ONJ7J8QQI0+w1/d4C8b4LU717hz61vCyq1QFQaIl4vwfGjTE3qxXNlW
	+PMc9T11T2ETstj7hfkmmPVEl89FOEdwLxKEYYflPbih/bht4rkKt6rTjnr20cN9jpaoFMjghJc
	mKEr427UtXeyBSncmuBC8nnPcecwLkpo7Qz3qMONCz0c44O/0Tvey3As4lJwCzmKkOD02O4jnUS
	S5KsrzJVsvt4N+SZV7fncjaPU853hxAPkH0dfMm7wb1JRG6sL9RMVAAynI6DUt0qUeJMqWZuLJB
	4l5LXlh5Wvw9HR72bzmEpmSuMLT4fhoWIBjrQ3FfvlsstLkBA6IIUoYWRpQnzOcC4VLG13N61+i
	3Wmo4tb87Y3MA==
X-Received: by 2002:a05:6512:3e0b:b0:5b8:c05d:2aae with SMTP id 2adb3069b0e04-5b8c17fde11mr4355336e87.15.1790095187065;
        Tue, 22 Sep 2026 09:39:47 -0700 (PDT)
Received: from [181.93.0.0] ([104.28.200.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8589e3fsm18444e87.55.2026.09.22.09.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:39:44 -0700 (PDT)
Message-ID: <41f8ed8e-1466-4002-8411-bf9871da2adc@gmail.com>
Date: Tue, 22 Sep 2026 19:39:41 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com> <aquWNXpJuQr8HLBU@beelink>
 <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com> <aqwUYWPz_nORoFr6@beelink>
 <33a7c239-ede5-4091-ba72-ff429d97013c@gmail.com>
 <816a300c-1f63-4d4a-a0f9-8eef5bd7e748@gmail.com> <arJ-vvEvd93l_aAp@beelink>
Content-Language: en-US
From: Ruzal <daminovruzal7@gmail.com>
In-Reply-To: <arJ-vvEvd93l_aAp@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 4:24 PM, Benjamin Tissoires wrote:
> Actually, after a lot of debugging, it turns out that the session stall
> was a red herring: it's hid-replay's behavior which basically only
> listen for SET_REPORT events before it is ready, but then ignores
> everything else.
> 
> And in the case where the UNKNOWN input node didn't have the KEY_*,
> systemd-logind would not keep the hid node opened, and would further
> re-open it, 3 times, and 3 times we have a timeout of 5 seconds due to
> uhid not responding to SET_REPORT.
> 
> TL;DR: changing the report descriptor is doable, and there won't be this
> session lock with a real device.
> 
> Regarding the `map_abs(ABS_MISC)`, you are almost correct. The solution
> is simply to not use an unknown vendor usage. the second vendor
> collection is 0xff00, which matches HID_UP_MSVENDOR which goes to
> ignore.
> 
> So making the 0xff01 bogus collection 0xff09 (HID_UP_LOGIVENDOR2) or any
> other HID_UP_LOGIVENDOR* also goes to ignore, and the phantom node just
> disappears.
> 
> And TL;DR of rest, changing the usage page of the report ID 8 from
> 0xff01 to 0xff09 solves the problem entirely :)
> 
> 
> Thanks for this attempt, however, this is not great because there are
> multiple checks for MT_CLS_WIN_8 throughout the code, and so your patch
> misses them.
> 
> It is not great to have a BPF to work around a kernel bug, but in that
> case I think that's the most sensible thing to do. A proper fix is to
> restrict the parsing of 0xff01 for non keyboards or for non HP machines,
> but as mentioned previously, this is prone to regressions :(
> 
> Also, I've just checked the fwupd sources, and I think changing the
> vendor collection is fine. Hopefully this won't break any user space
> program, but OTOH the touchpad is pretty unusable at the moment.
> 
> Cheers,
> Benjamin
Hi Benjamin,

Got it, the uhid SET_REPORT explanation makes a lot of sense.

Are you already working on the BPF fixup, or should I write it and open a merge request in the udev-hid-bpf repo?

I can test it anytime.

Cheers,
Ruzal
