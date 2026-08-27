Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE1411FA7;
	Thu, 27 Aug 2026 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831489; cv=none; b=fzA0+Mifl6XZlAZjnakKSEdII1hBC0+wNeTCeJu7TIsBfCIxxvYUK766IQL2aaDr7zqJfir0sjZDqZEwGqUvrCqPFUKMdOzSNGbdD/tHPs+0+bSsDh4h3AGSevq0pslN0cU/1qtS8xq2BRLEmATn8tAkqoSnfnWunxXEKc7QJDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831489; c=relaxed/simple;
	bh=+AJ5cnbS6PfFnLylozYjZQtsBgD5h0i00Hf/p5B/nDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QH4443f85YuD+nMKi9zFry9TQD2Hu7JN4wQMUXM82NUd+WSN1KXJAieTr0pJmZeMS7kXjgGoghw7oG7VveEKgV+NR15wpPamOH957LcV/HkoaS8xJsBD2aUPe2/mzC+fHH+PvokM6bSzejeYBDQAlMxovmlBOh/4GvxQ/H/IopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=X/BL5JEF; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X/BL5JEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787831472; x=1788436272; i=markus.elfring@web.de;
	bh=y6IUqDzkKzp21hBhFE+s1vrZY3K0RKLWVaiYQm4MzDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X/BL5JEFdVarEx2nGvbaxGTo0RnVN6LenTg+GwLm1hg+/yXVZ9FD1uxiSya6Syv+
	 goC3jfZ75w0sogskDS8RFfSlgMnnEP5Ose2o7cXK4lHK2yNJfZ29Uf152QI5FFz93
	 nA3K07DDiAuxT7uvzGuIpqlqVMylRscf7G0BTsPw5F1nJ4qv1TLlfGiBSSQMBb1Q/
	 Ue5nnKLfUEZP2APVmH3Ae3wZsIA9htAqMP9Rlcdsh+lAu+To4SYrLc+yDl5uM7gbU
	 c3d+535AFb72X9umvJjodKwlwIOBhKPqCAz8FeOYcg6xT3NvHfMnNtcSvp7yTpbL9
	 qNG2rHm2xgF6hIC7Pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xjd-1wrl351t8V-00wfK8; Thu, 27
 Aug 2026 13:51:12 +0200
Message-ID: <eaca9bae-fba2-4824-9219-faad0b9f766e@web.de>
Date: Thu, 27 Aug 2026 13:51:01 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH] HID: fix semantic patch and improve its
 performance
To: Julia Lawall <Julia.Lawall@inria.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, cocci@inria.fr,
 linux-input@vger.kernel.org
References: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <bentiss@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Filipe_La=C3=ADns?=
 <lains@riseup.net>, Jiri Kosina <jikos@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicolas Palix <nicolas.palix@imag.fr>,
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x8Lyxg83SMX4omPnEW/SkSKJ3q/UITCkKKZFQu4fW2Hyemyhhny
 5tOgi/Qjj19/j+GLDkUQe3Ne2EWjz5VCYqbQzcLwT3z+iQsJ6T5v/KjWfHRxXJVCY415slg
 HbcUTh51Yoivtanm/VrrM6Y99xGUCdCITSm37uhh/4gr5JRIRJcrM7/VAUiyaW626Jp4NUA
 h4VfZhk+GqS73FcCKFpiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9jDYJJdZ+EU=;sfskM2UzkQZYPGuQX3mfVgoidPX
 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
 hiXRk6xw==

> Replace "expression" with "identifier" in the declaration of hdev.
> This is necessary because hdev is used as the name of a function
> parameter.
=E2=80=A6
> +++ b/scripts/coccinelle/hid/ff_race.cocci
=E2=80=A6
> -@r@
> +@r exists@
>  identifier probe_fn;
> -expression hdev, flags;
> +identifier hdev;

May the following SmPL code variant be applied?

 identifier hdev, probe_fn;


> +expression flags;
>  position p1, p2;
>  @@
> =20
>  probe_fn(struct hid_device *hdev, ...) {
> -  <...
> +  ... when any
>    hid_hw_start@p1(hdev, flags)
>    ...
> -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> -  ...>
> +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)

How do you think about to use the following SmPL code variation?

(input_ff_create@p2
|input_ff_create_memless@p2
)(...)


> +  ... when any
>  }
> =20
>  @script:python depends on report@

Regards,
Markus
