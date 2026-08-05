Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104F36195B
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889615; cv=none; b=rmaw/9RU4bF5PqfH3JA/nxZJUPXzB9WrSJbHKOmck98kRu/jKvw0Dtn/cwGwjCOpVTcmWDDtSXrSozeVU68gvqcs8iWTiJ/EPU68rAQZdyiOFvJ3skxSWeoaK/TXtObf2Zek6jV0AXTfJx+2J2wL7ljYOIXXbXHS+qEifAlH1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889615; c=relaxed/simple;
	bh=8Ib/qaTGa1PbwNGkWBKQxFQsk2D4CT9qe0pTurwwlvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/CYZzUWECLa/sAwygdRYwj2gz39MNfeewoQww9Mc5p8H8IzWLWK/juOp44+ESukjr+rbD+aIX0zGQses3XQO6qQjN9BmRkvSC/cm1qXs4O96HlWnoOPo8ds2pBjlM9ssXSDhTPObHmHPQaViWmyp53YRy2Ybdga2uogabjC+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv1ImsfN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv1ImsfN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52b6543169fso2505511cf.2
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785889613; x=1786494413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IZ+EqBseqdBQygIlQeWXwAUEvO6/PiuHwN+sYz3VZo=;
        b=Tv1ImsfNYP68CARZDZt4Z3kS9JB4j5nd3x13MFJzSvS27+WQA7AvaJKVEG06uPr3ia
         UaMghgktJrgrYLrqS+C8aILOXkHBAGFIm9+KaqTgNWS8AKlZz1Ho83s+O6jR/rroOwRz
         syKVf+oii+o7iIwVEB454ejcyNatgr0V/+roKeee6cN1whn10q9Rf/xj5MLaFt89q8dn
         xyu7gV23MICJ6es2iP6k1QVI1ubTDXPz6jnqKKgV1Sex8vDy8zcz4KGEdT+sKS+TBbEW
         x6WVlvbSte4pM0srFlNxiJko3HFuiFXzVQXOG8mOpeTnE/UNbFHbbUidZHraciUoMDfn
         EYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785889613; x=1786494413;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3IZ+EqBseqdBQygIlQeWXwAUEvO6/PiuHwN+sYz3VZo=;
        b=ECRFkwsccHWWVC7A1QeysitYj3JRJP0+RqaEE+hG7IX7EE8m9VUzIq5bNxIPHT7hyK
         +GopEy7ELm4iUs18n8lNqTvCD105udTq20Eo8d3q+BaXFZh4qrNimSQIvX4Dj44+vzgP
         PbxAXxoqy57RNrjOLH0oSewKihwXsjBA3GkBtyZDqouP8hZMf8ORS705ikH+lbwSsmJk
         G+hYLjYAIdA2w4m9/mfyLrUIwrfTJgaq1qPGkSj6re4lhpyqDvJEAp6TgRr0klrqngiF
         F46JK9cPCmMM0y/Ic0sDnrSswPH5ctTiFc2d1eMNhn0Y67tvyEw7perKasCK/r01fgYa
         cNiA==
X-Forwarded-Encrypted: i=1; AHgh+RpPRliY/CcP4gPDFclvGYtn/4qXCyPhXgX/kVYDmA7zQwTLKQSSn5EhtwNqp1QH1gvpiA4i60P4rlrdYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfrNEyU7rZmut/mQUJFHIjtADekgWXeNbTvA5r+Jklt97PZIs
	BSUBe7/vu3MlDv1I0Iw18kLcCquklt1B4cp7wX3IoQWgDdM2qhvF+c8XDrs1ZDfm46c=
X-Gm-Gg: AR+sD11JUIgHVTMWQqPW7rQPeElmY7wjCITsy4R0zYLm/AlfkFsgRlgvk0p7fAFhr1F
	JWNI4NCKeVnTW2dx+lF1jc7VXXOIlKyrIRmlqHSUp2RZ7yo2nAJ/3+Hz7EQDjjkr7Ibxth99N95
	DyUN6xFOLEODuen7Z1BZAfKOpO0i7m1jjHNFZFPJ2XVCourbtpyeWM7yL0x5lv8bYrSvQB9QqnU
	+kthl34V8B1vW1RX48npbFEJmdcO+t96cDP9Mc91JqTrGInxUkCYKAS33zaLiHmtCwrs0XgqpE8
	x9IcBzLze6IOYgtL2JQeAiBoe5UU4Cx/zxmuXps4VvhkYmQiE/CTh+uoPr/uKWI6BdrKjd5Bh6K
	Lg5RYQxXJcj0pWyN4tOgB7SxL+KSRBo/zsfIKr+IzIylB0iULhx3sTZNJD3Bd01lnx/JcxcWN7i
	6uSLveSGrGUADjsruFZIli0GHyLkwHUlnEw+YiJnrJWtx/VVBCk0+Rwbex0Voxe9M+glhfJBbJT
	n/8EPYs5zN0pw==
X-Received: by 2002:a05:622a:230b:b0:51c:22c5:daf4 with SMTP id d75a77b69052e-52ce60c18eemr34720641cf.28.1785889613088;
        Tue, 04 Aug 2026 17:26:53 -0700 (PDT)
Received: from [10.0.0.128] ([66.31.161.230])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8972e90sm5650541cf.27.2026.08.04.17.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 17:26:51 -0700 (PDT)
Message-ID: <1d62c563-4ee3-4693-8f68-d464e5da57f4@gmail.com>
Date: Tue, 4 Aug 2026 20:26:50 -0400
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v7 0/8] HID: steelseries: split out Arctis driver and add
 Nova 5X/Nova 7 support
To: Jiri Kosina <jikos@kernel.org>, Sriman Achanta <srimanachanta@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
 Simon Wood <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
 <p2ro1683-r1p3-80qs-q6s1-nr6p18ss03p8@xreary.bet>
Content-Language: en-US
From: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
In-Reply-To: <p2ro1683-r1p3-80qs-q6s1-nr6p18ss03p8@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'm glad to hear this is getting merged! I have studied and tested older 
revisions of Sriman's patchset on my Arctis 7 Gen2 and would love to 
contribute a patch that adds support for it as well. I see you have a 
branch called for-7.3/steelseries in the hid kernel fork. Should I base 
my patchset off that? And should I aim to have this ready before the 7.3 
merge window, or would 7.4 be more realistic? Thanks for the direction.

Sincerely,

Benjamin Wheeler


P.S. And thanks for working on this, Sriman!


On 8/3/26 3:32 PM, Jiri Kosina wrote:
> On Mon, 3 Aug 2026, Sriman Achanta wrote:
>
>> This series moves the SteelSeries Arctis headset support out of
>> hid-steelseries.c into its own module, reworks it around a per-model
>> device_info table, hardens the battery power-supply lifetime, adds an
>> asynchronous status interface, and finally adds support for the Arctis
>> Nova 5X and Nova 7 families. After the split, hid-steelseries.c is left
>> handling the SRW-S1 racing wheel and the MSI RGB LED devices.
>>
>> Changes since v6:
>>   - Rebased onto hid.git#for-7.3/steelseries.
>>     - The split now leaves the MSI RGB code in hid-steelseries.c
>>       alongside SRW-S1, and strips only the headset members from
>>       struct steelseries_device. The MSI RGB quirk bit is renumbered
>>       to BIT(1) since the two Arctis bits are gone.
>>     - The Arctis hardening that came with the MSI commit moves into
>>       hid-steelseries-arctis.c with the rest of the headset code: the
>>       hdev->rsize < 3 guard in steelseries_is_vendor_usage_page(), the
>>       battery_registered store/load-acquire pair, the !sd checks, and
>>       the hid_hw_stop() on the hid_hw_open() error path. The
>>       steelseries_is_headset() dispatch is dropped, as the new module
>>       only binds headsets. The battery_registered flag then goes away
>>       in patch 3, where the device_info rework guards every
>>       power_supply_changed() on sd->battery instead.
>>     - The v6 patch "HID: steelseries: Inline and simplify SRWS1 wheel
>>       driver" is dropped. Its premise was that hid-steelseries.c only
>>       handles the SRW-S1 after the split, which is no longer true.
>>   - No other changes. The resulting hid-steelseries-arctis.c is
>>     byte-identical to v6.
> Thanks a lot for such a brisk rebase. Now queued.
>
