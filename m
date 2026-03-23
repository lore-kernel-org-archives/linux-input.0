Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1E359A66
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302431; cv=none; b=IvHa1F5nHuEwpJ7OCxxrEOcR56z3xi5fS0SE6N5KxTkdZCKGXRj0aJCuaLjT2VgKy9prpCXTB5aVBS2WbG79MHceRfMv6Sad7hA4E01xQHLEYBBe7JVLp8+99BkzpcEHWHiejrXUkZSmTX8khyW5THmWEm+USVqG2Nlct957hRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302431; c=relaxed/simple;
	bh=5v2f05+95vtaiP2pU9TOEzYcN3Qf8RFvO4AlRc4G3Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFgEcGi9In9uemLrud1wplIwLgtlwKYUFmu89MrrQZZ7mAAhM+HuzA+8vXb1plHFLZeJDE7JC8uIxNLtppHvZ/NN+KjrFYKn80NKkNHi89yFi9XkStVv1sx2/e3LAcUWFve0PzTytCYA4d+shHJHr+ygWS/FKG1qQJO1cCZwSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNKwr0CS; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNKwr0CS"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so2658637eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302429; x=1774907229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JacqTfWrvvLmnrpcnkfeo2osQRM+bJ6qsve3VHphMCA=;
        b=kNKwr0CSkv9tL8o9Zwwrgkq9bBLUSoFicxEL4MHxMQ/S0a5KiI5iZ/30Z4I0WxKYk9
         g8+KVQRYNUfbA0KWOo1XEPSEGKIqfR4FgOXgTq6Q6JwjVPECmoXG9Kfo4pfcIBuMZdAO
         VfYDzaMct0O+iyt6m+LwADKMvp/2WCxlD5Kergc85qHsT3ai3n7NGh6iVWtbAgxxD+oR
         cFcUQ9YuKadtWYePOadt/FH2ha6ltFwqlfmpV0oc+YKaDy5TCMXXJ+GdKTzOgtPfH3pB
         +h8n8/PlGwnywjBgYlVSp6X2pawiibbz0j4vezCRLglsTIh2IkyPqBvyozNP9apipxsF
         LrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302429; x=1774907229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JacqTfWrvvLmnrpcnkfeo2osQRM+bJ6qsve3VHphMCA=;
        b=dZRiAb1yeGCc1VmZXOUtK1xtO7EE8OaQMIc5C1fEL8o9C8ZqGpb/WRDBRmrmdRB7rv
         zMXj3xxQIDZgzely7TYTfoxDAvvMCDRhMOvy0rJRPQEOaOyDqoloSRdFdB33YAosvtDG
         Ap0L/W4UmudMp6hDCGmxS8WHQTVGiT8wQzSCB50unno6ipW14dClk9E0VYX1hKtdoLdo
         T68iPII6X+DbqDVC0ZjTZeADBseo3EbniNpOFZtRgGVuVqXQqzlJeBUkgN5XLJY6NRhV
         vLEydjICtQRQ+VV9dMnIWT7Hvb/VWB/wGsaQK+gJWl2yPw5Ch8OAu58PcWVvfw8heQy1
         owcw==
X-Forwarded-Encrypted: i=1; AJvYcCUpg46mrQAP7wWFsehbnRcGP09JXElrkPAf2pbByVJBk0N3sXH1XpXmaRsq4LL1AjECcZeTS8Cbv9Rm7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDu3FcAhXasM/cPeu2yETJCnL4K6ujCC2RF+WquVYzzlS7tK4T
	er0wALkWxo+9IOjrUYX0fFuYoys6CXt7KQgefKvKcF3PaUmaQ9XxLCVl
X-Gm-Gg: ATEYQzzNCxL2rNwk9PFdmhut6EBdHd7AtAn6JKXi/e82/v3MTqOjznGQYlHc0OSwNEU
	b9U2hdTjWREAd6xnBGnV12ItwKYLei6JzxTeHRIJYHWRg0GF0rNzzT/sl7U2xgF9b1lLVcAUpz5
	yhSSP6EJR1CSPDRJFhw0/pvEvzF7bhPhgl47AfbLjQ3Y6zrN8tXdtUMmUrDqYgh4Q/L8hx61yqX
	j81+lFkMWN9lncj1AVO7UCw4DY3zd8ru8FMuDXzpf3kovj1saWnxBVZiyrXz7ou8+mQHuKzTn3B
	Buc+gL+L//S7zgMjBCtFEQrGMoY9WmXovwKxGKLqAIuQ7fqLJ90/s2WM6McSUhpk2yE/2HAWMq8
	t46I+akm6J/GrI3Yg5il16GvwCX2XYoqOdqXhWHUo2KSTZR2sWUnQ0Ympwr9arM7yxIXBUNfa8Z
	Gv71dbMiN/SZmTW4yJmpYXy5IJ9FhvYwfvkSe8Z2va3V3x0gGWY/2CO9WGVOUijlDk
X-Received: by 2002:a05:7301:6794:b0:2be:d6e:6ba3 with SMTP id 5a478bee46e88-2c109724823mr6274840eec.24.1774302429229;
        Mon, 23 Mar 2026 14:47:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm15943512eec.24.2026.03.23.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:47:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:47:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: matrix-keymap: fix key board wording
Message-ID: <acG0oS1nR0yVX1gv@google.com>
References: <20260323140024.104475-1-hugo@hugovil.com>
 <acG0CoKkM1S9HzLF@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acG0CoKkM1S9HzLF@google.com>

On Mon, Mar 23, 2026 at 02:45:06PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2026 at 10:00:21AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The correct wording is keyboard, without a space.
> 
> The driver is often used for handling sets of keys or buttons, keypads,
> etc, not full keyboards. So I am not sure if I can get fully behind this
> statement.

Actually I was thinking about gpio-keys, not matrix-keymap. I'll apply
this.

Thanks.

-- 
Dmitry
