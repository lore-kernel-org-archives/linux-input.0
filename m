Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759533FE1F
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414297; cv=none; b=Bcw2/b3AYVcXzkBIkRjE4PQ6aflgwJhhOpwxdmKyrqAici/+3mgOCZ01gS1yGW9rxdmyT4bHo39WtIUuk1Ug8BwEi0tyn6fonr+vbPPaKt/plw1+/vgcLaPdb3P/D2bB2aYYfmzZB3aExDTx2fLsiMy9vzlF8g/wyAuHmFrpH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414297; c=relaxed/simple;
	bh=hjSCNa8VBj3LwTzLNo2UTrVcfHlIib4kXLh+AlykK9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnyWPqX3uMpdHZCxdd4NlMtYIWYX6Xn7Dkz9cLb+TXFqDEmbV02wrqoESGexTF53z5AFaBMobc3YJjqDJamp0VwgwdtdFi0j57mYJl171OPd+NgzOh7thV+Mh+1SWpWbbBk/AGF4fENWcamTvCChkJfh7uVa/0WdLAaNk+snjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA9rlxVw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA9rlxVw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ed3993c1eso119261385a.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785414294; x=1786019094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNDoYQ8/yRjrNOVgEPBvardx2QlUL1XI/80KODMgLwo=;
        b=PA9rlxVwndP5rpFr4vEiffXweh4HKKenTyFLD65a/Tk8Eg+4sLUws7Mbc/1CPVUpgK
         Hjb9KIyNsxtWS1BrxPOe1iVuM77Guvl3+9Bz400EAwuD9uvc6jyV/5B1fhTclimd7nnW
         qzBKvNSWeVdEbvMIWXnXtAO608Py7X3/j81e1S9f7J+bpLHdV6Jol4tgftrssMWHg2DI
         9+3y923VCl2mGcNBfBZQqBQ48oHXRmLFrSjsRjwLn/7rJAYCiyygwnPnAq1mQV7WEIfI
         sgoLZqP9pS7XLc+0FlgngF6eUHGTRh7MrSQZwy3ABMVBbqgFgILJB12JZaeY3rnXcqFH
         P7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785414294; x=1786019094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNDoYQ8/yRjrNOVgEPBvardx2QlUL1XI/80KODMgLwo=;
        b=lK7GqhW2DOVJrRma5O+Ixx8PIifZroDYNcQCum3/k7hm2scAsQTfUMwXwBQE2aX1k7
         Sirhu3dimHq1OQU6z6/5g8kgbt69l6tTO4v/Zri6mp9dI+9HLUFwuMdy9Y38ELsQNZyE
         g+jseMypKhKzhR+FwWg0sDU4KzBW1G/+uZBGja0oO35vnRV1mWNy3T5U5carRnEKumsU
         v+SwF5SQiriHGOuhhk5Fq6Hx5AQXrDjobx0jq/SpjcbQYd8sK6l2A/nc/3V34rADt7MG
         HB/m00+0tiVnAwMXJ9wBEn86yTYh2I9iiAdVLtcwGsrmjbDQVVJJVCCMdL9xs6AUofe0
         inFA==
X-Forwarded-Encrypted: i=1; AHgh+RrxBJWD8Qjc8+Hz8EdwMLXK++noAgNQHKl9Iv5gQUkwusC61RFNDniULlelL3xbmUkbL4Z8ICDKPt0rdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtO2Pc46z9+Lm4L9WJVJxmsAzyyD/wSkwt+xKJgOGgRzfZ1g0
	PXqk0FrBpLCI3/QSdsg7pIMBrF3hoU//pEYIXhl/N7XgbPkIOVyyGdltdeGCZA==
X-Gm-Gg: AR+sD11pyq+urgFW/GnmQirGfP5+EYo5oh+V+vFz7nRwUvtu+eCDV7wRfIRvytPsxiA
	5dWR+WIBjiaW9laukHPP2Ob8e+HxJ1tFlIzVKW0bWBV81iggweWQ7KQHFLppdT9TSIzg6G9PhdZ
	M4yxQW7JjbgNGkwIOUFROrcWPZEtwFdBV+WEHLGBRQrIY3xm6MmhBvu6/w9adJzutDdMMalchBT
	WCH/OF+j4o2uVNOWzqxS+9Fv+PLGCUbZ7+uO98P7VjfG2doW8mZ5vfqTwkm21e3I7JzngLtVELR
	DL0He0+WIqPGIND/n+LFdRAGrmiknxfBCp/Jy0ftL+yyWUcUrgsAr5Ep/wGBqYAzriNwh67w7Xf
	A2uM+CFVN4UWbDKeP8KYA6nKkOymdrvs5zQIXCf1R7byyj4Gu6DyqrQz/U/r5cTLwFm9t20Bfue
	ZBbTvmsZY7fzj2ZqAEGYu3oVFcj1gtD/sCvsWlAtti3BlF4cCDLz1FSSaPlUPTaQCepj9sQ+BKj
	wFQ8gZ0S26mc55bWACEsYWtoZ/HUjRF6oAv4Q==
X-Received: by 2002:a05:620a:43a3:b0:92f:fc1:ae5c with SMTP id af79cd13be357-93486af4cf9mr230775585a.59.1785414294398;
        Thu, 30 Jul 2026 05:24:54 -0700 (PDT)
Received: from ?IPV6:2600:383:440:7bed:54ac:9f45:f987:a319? ([2600:383:440:7bed:54ac:9f45:f987:a319])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d325ade8sm401156285a.12.2026.07.30.05.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 05:24:53 -0700 (PDT)
Message-ID: <8d3e05d3-6953-42d8-9f0e-ce42e2439c3e@gmail.com>
Date: Thu, 30 Jul 2026 08:24:51 -0400
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] HID: multitouch: Fix stale MT slots when contact
 count drops to zero
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
References: <20260522111527.69428-1-carvsdriver@gmail.com>
 <20260715143312.32408-1-carvsdriver@gmail.com> <amsJcWohgC8TJsYH@beelink>
Content-Language: en-US
From: Dave Carey <carvsdriver@gmail.com>
In-Reply-To: <amsJcWohgC8TJsYH@beelink>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I will resubmit as a V3.  This was just a ping since the patch has been 
sitting out there for a few weeks, looks like I confused even myself 
with this one.

Apologies for the confusion.


-Dave

On 7/30/26 4:22 AM, Benjamin Tissoires wrote:
> Hi Dave,
>
> On Jul 15 2026, Dave Carey wrote:
>> Hi Jiri,
>>
>> Gentle second ping on this patch, now about eight weeks since submission
>> with no feedback.
>>
>> For context, the other hid-multitouch patches for the same device are
>> already in tree: the INPUT_PROP_BUTTONPAD misclassification fix merged
>> to mainline 2026-05-28, and the ghost contacts fix (MT_QUIRK_CONTACT_CNT_ACCURATE)
>> was applied to hid/for-next by Benjamin on 2026-06-10.  This stale-slots
>> fix is the last remaining hid-multitouch patch for the Yoga Book 9 14IAH10.
>>
>> Happy to rebase, respin, or address any concerns.
> I'm very confused. I don't see any v2 in my mailbox nor on
> lore.kernel.org. All I see is a reply to v1 with patch 2/5, which would
> mean that patch is part of a series that I don't have any context.
>
> Please resend a proper v2/v3 with the correct tags so we can actually
> process them.
>
> Cheers,
> Benjamin
>
>> Thanks,
>> Dave
>>
