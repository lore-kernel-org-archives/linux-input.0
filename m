Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229D489873
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517721; cv=none; b=NEmXA1ymZdls3Lgr/tKGyuPM1dzFV1OJx1xdyZ3rYE9PjQm56adwfe2p8g7wL3spe/60YOM4PD5hS1NPTXkRe1JDJ21SXsvC6kBDhlAmr8qUr4utUPTJejxpNrpI6jv+rvT2vJ3/t379pcfl+OE+LOHar79ZvZyWs44a82MRmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517721; c=relaxed/simple;
	bh=rPZcOpyFAWw+rCmO5axPYt0b1DLzUbaTjOBX/SXE0XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaTjGTs/H9G/gikla5FKjK6StHZQGEa5c89tpjw5hyr9Vz5CFrcDLZmgcpUWMKzna+FNzoPFMXIrvlZIfkCqrvVtGh8HLomT7e5QyphDbu9g6rgfH6ygwNfXcUbCXgq8dtmKmmuOsqWlacrhKSGr9HwdRbIHWM3JUtMJhYPJ+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cx9hKZ22; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cx9hKZ22"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9770e900464so807729241.0
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785517719; x=1786122519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a3uosmlQ92VLotu1yUsXXtb0Ksng61Ixtp5DDKNHhqo=;
        b=cx9hKZ224QDEpRu6eiR8Kl+WMvtsIEPibCcKqFpl3WGRqmvi2iQ9HfyIXpea7VdVkY
         1tDlYxb9ThNybVRYbR2uq2DwoKoemj242RZXLunV/eBv9A1q0/uvK41DXc2zlNocDSKX
         1E70EaMEkH3dfTvf3Z38XTtsrZOro3vR1FTCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785517719; x=1786122519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3uosmlQ92VLotu1yUsXXtb0Ksng61Ixtp5DDKNHhqo=;
        b=FTdtr8kbNdLZ+CRf5NhxCBe7vYHRnVNG5omlMpj23nSJgslaJFSwaYo18bK0KT9knN
         sBP98XqYU192fEy4HXwK/NQs92yzTq3HjRbTTrtNb0azJQhVAuiyIaORN30cmRosXThO
         MZQYFjrIL3bSDb/ffR2NR+PKjder0X4sJiR2uAFgahuVsXkteqhwqlPjgnxR0IRXVSCi
         MUPwX9scTBCwAAhX1HP0+1TiItgS8kLQOQgE9cggvbTexkasyN4Y4rGIRNEbyRPMkfXd
         9E/cgWwrXL/cJc5rEClWZ8tIzHmhxsz3YpLk+8SiKmniGen48hUMGOGTDZ9fahKpqm3X
         636w==
X-Forwarded-Encrypted: i=1; AHgh+RpNsj1wrRA+jZhOW9Zx9Opon9fQ6URg4qFKdu1eazPLQSpU10QBoNdiZfw4YfHQejIsb6t8dgI46dh2fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzBvSefWuW6PGem6m5N5jWYUHaIctVgpDb9jt8DbJG7Oc11zI
	8YrQtMn86sdgwMPIkm1sBLmzU+PRDfb+8pBal6kXo4IgGh4PYDvCewVGvP8G72X4uW6ogqzNZi9
	Xu7A=
X-Gm-Gg: AR+sD111HfkVZ4l905pPg6DJNtRyxsin37KAtsujbJigNTuhfPQe+Is6oRJUOwiE8nx
	QueIC4xRUe4Tn9gS0+CLFrgBQDAbjSxi1lOEM6vqID4a2MfrKKSPlrbINvSyTqsuH0X8ALHzWN7
	8PU8y6uTDLx6EA3R8GubDCw0m+ebitBn6NcAkXjoisFlpwqmJJ8hSfl2EkK7cWeNV3ok/iEa7/w
	73WdKYY1yTNODeCupuW3By++V80oDphTBHmGPa848sOot3FSLMZrnszW4RXplUqTFf8oZutauxF
	eHZ7cLl0cOtWodwL1bFH5SjyZg9zKbRk67ZA7czZEuAjPxpTMCQjAkZTEGGuvg2h3DF4QPIkucT
	KLQeLn3sjqaOtzoTSMUqF8vqdFeDFKGYLN1RaJqPEyIcmO/Ib9chJnL4rsO5SBNTVMB34MZdZ9H
	W90MwbAAjVriTeI+CEh3jr5CHyU9E3MG0HhY5Zkxf4SpQ7gBGSmfEjtqOvWO1OgoFZo9rrifmyQ
	0iyu4qyVTZoGKIF7q3wwsay5Hp6qOI=
X-Received: by 2002:a05:6102:33dc:b0:745:53b2:d651 with SMTP id ada2fe7eead31-758fa7bd7eamr744525137.12.1785517719093;
        Fri, 31 Jul 2026 10:08:39 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-977eaef58c0sm724132241.1.2026.07.31.10.08.38
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 10:08:38 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bfdd59df9bso1303814e0c.1
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 10:08:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpMHmPYEcPxU6nAZS6g113Z1jUhWHKBrLqB3+2hPxF/r5KQdSbTQovK2e6PoBZnGEaC96hVcEgNIzObaQ==@vger.kernel.org
X-Received: by 2002:a05:6122:4641:10b0:5bf:6dd0:36d with SMTP id
 71dfb90a1353d-5c37e954434mr788785e0c.8.1785517717221; Fri, 31 Jul 2026
 10:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
In-Reply-To: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 Jul 2026 10:08:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkFCqreB_70m1f0gZd50mU6AQLEfF4WBXOBqnYNpvijg@mail.gmail.com>
X-Gm-Features: AUfX_mw2h7GZHELPTxhnrIO8qI4k3I1yebCvbdVIhfmU4wAymq1lhqxG3gKJnpY
Message-ID: <CAD=FV=XkFCqreB_70m1f0gZd50mU6AQLEfF4WBXOBqnYNpvijg@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure
To: Chao Huang <958028483@qq.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Matthias Kaehlcke <mka@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Huang <huangchao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 22, 2026 at 2:37=E2=80=AFAM Chao Huang <958028483@qq.com> wrote=
:
>
> From: Chao Huang <huangchao@kylinos.cn>
>
> If enabling VDDIO fails after VDD has been enabled, the power-up
> path returns without disabling VDD. This leaves the regulator enabled
> and its enable count unbalanced.
>
> Disable VDD before returning the VDDIO error.
>
> Fixes: eb16f59e8e58 ("HID: i2c-hid: goodix: Add mainboard-vddio-supply")
> Signed-off-by: Chao Huang <huangchao@kylinos.cn>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for the fix.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
