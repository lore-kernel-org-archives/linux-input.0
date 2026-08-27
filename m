Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10346361657;
	Thu, 27 Aug 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832545; cv=none; b=a9Sm1gCOZx0KJK8oRCYb6zWJkSlO8uGO5PDF7q+G1ktEh3P5e0o7UZi8J/jjnh+mjCEdLVcAvw7gBznr8rjW8xjOzJXveFvVSfZsLRaLgt49OQitzp64fb3BqNIhWHOUxbXSOi4uV+9OHYcF7v80ZKi4aLrW+eZ98VCHDeOr9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832545; c=relaxed/simple;
	bh=mbdwbutkZwss6ZPdF2PM4vPsmT5mdFshOrb3YeTrAOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTnwsdMt+s1WaC4B9PN5qMlxkeEqwTj/f+adWS1ynA0hfu2KZJlpaUOzOhbE4Wwyd81OXEARhMegaIvLJKJ8Yw8ugAIKPY3f0OgrMKPvzPq7/HPuwWA0IXXqiYlQ36FCwYWmF+uW0EXlnSWO9zLTjJFlp+cTakscniUbEY0AMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HBc5Aiky; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HBc5Aiky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787832485; x=1788437285; i=markus.elfring@web.de;
	bh=SeejXeJ//Eg56iqsZWcJA5mATf7K0eLB+DNYbb942iY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HBc5AikyHCOqKMjFqfeeXXd4kh3sont/ArJyDpYkEXiDDFTlZzBYgcvEfX0zigD8
	 Rzb0Jkj+jkLiZp+U9wFzzcMVthP1NGnAvioHjFdVGFjTq44OJtw6PKSL/OHwmrHRB
	 V4hMbf8DL9OVilP3tkv2BoXjxXslOetZKakEImap/HCUQ0v/mk+5LaDFxWcmOy20k
	 XxE9QSKgYvwbHRXKTLOFTao0DbOIJMwUP+wNM0WJSkbed+pOjsWX0opKVrNYLv1J0
	 56bz8/+a/KIFDsrTCKY+Ay3EaoGGWDsA6ph5EHqIMv4b7gGK2bNQzMS5RqD5mCDWC
	 pQiGfdI53rdDZi2Umw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgAJ2-1wPxyF1xFO-00ka7X; Thu, 27
 Aug 2026 14:08:05 +0200
Message-ID: <eb3d4b7d-23ca-4ef9-884c-9d10c4f0de17@web.de>
Date: Thu, 27 Aug 2026 14:08:03 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH] HID: fix semantic patch and improve its
 performance
To: Julia Lawall <julia.lawall@inria.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, cocci@inria.fr,
 linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <bentiss@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>, Jiri Kosina <jikos@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicolas Palix <nicolas.palix@imag.fr>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
 <eaca9bae-fba2-4824-9219-faad0b9f766e@web.de>
 <ec917c17-dcee-bbed-b59f-49e3cde23cc@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ec917c17-dcee-bbed-b59f-49e3cde23cc@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8N8nDG8XTSH2elyo/fbP2VWMHykOxjD89BVDqF0uiH9gC5n5SKz
 Nor95GAQ1rdMPqpFprFOAQMD+3uVBy71XZ6Yc9C/tI3Rd4u/16UcGmL3xw8i1WzriPbRXVv
 3TNLSah7x1yggvYxsjHGzI7XvdLaQWoiGjBI3/0QHCKdAjj5eFgxoSLQCFybaYPaJmQDrjC
 8SgRyy8srQxZZ2nuaWGaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xj0XmKjHr9Q=;CzUcG8TGNCdlVMbcK44c+x7flvm
 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

>> =E2=80=A6
>>> +++ b/scripts/coccinelle/hid/ff_race.cocci
>> =E2=80=A6
>>> -@r@
>>> +@r exists@
>>>  identifier probe_fn;
>>> -expression hdev, flags;
>>> +identifier hdev;
>>
>> May the following SmPL code variant be applied?
>>
>>  identifier hdev, probe_fn;
>=20
> Yes, but it doesn't matter.

Can it occasionally matter to avoid the duplication of such an SmPL key wo=
rd?

Can SmPL variable declarations become a bit shorter?


>>> +expression flags;
>>>  position p1, p2;
>>>  @@
>>>
>>>  probe_fn(struct hid_device *hdev, ...) {
>>> -  <...
>>> +  ... when any
>>>    hid_hw_start@p1(hdev, flags)
>>>    ...
>>> -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
>>> -  ...>
>>> +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
>>
>> How do you think about to use the following SmPL code variation?
>>
>> (input_ff_create@p2
>> |input_ff_create_memless@p2
>> )(...)
>=20
> I find this completely unreadable.
I find this view surprising.

There are special views involved for the layout of such SmPL disjunctions.

Regards,
Markus
