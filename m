Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130913DDAF2
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645826; cv=none; b=qI4+t6DMw8hjkrOi7QvHl6/qOA8lGAKGrDOQny2KVE1fkYq1PGjh6rsXVDQSwhcrgB3rbPEl+BixHPiWATuMJU27aq7t6lwdncInfDOw6qBO3GiwhjsB1d/0R/z9KDRvilewBx4esNVQzDbJ20zuH9xN0RFRo89C/5YeFdHPc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645826; c=relaxed/simple;
	bh=Zy1500qdZ52ydg6ky+ZpPQBgqPAQWbDDqqVRZe8hlO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTEMxAuodWH0bOeO103Ey/9r5Y1AvJtrcZOtLTF68reja9uJNVen1W+EPBqRya24K3/NFrPvglDHtul9gYp5Tp4qkU3Zh8lQAovomCRIDRAOoe8ReL60gJxN/lvHfEI5827vJ2OUXK7BvGezEHdIDVy70OhO95BT6oOphluSwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ZzMYB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ZzMYB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C571F00A3A
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645824;
	bh=Zy1500qdZ52ydg6ky+ZpPQBgqPAQWbDDqqVRZe8hlO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W3ZzMYB/Bxkj5Dxo92VfYaRnpX3MUeeXp04y7XVnOtFxz3grGBLWfFwrkcH+EatLr
	 BJIE6y8i4pFaP+5x+zYc5JENgP4pEEcILAn7u2KUGZvuNx3wkYO08bl8HV4H+CABY8
	 TDqFkCMci1eSxZGT5643AP+iBMTaj2FGqf4SCId7wmGy7kuG9HK859sm0J01khVnMs
	 WmqBd5TaZY59IEb/fu/J4tMWWzPYd6HNVlgxVfvYLPaXhdRbIZkulYvztbSlQCISkS
	 veOC8wkrmcWPgdLKzJlMMpFoYb5UFOTKU729be4NxfIkrX+5MM3ccefx1OAv+VuCNl
	 G+Ru3pY9UJHOA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so646134e87.1
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 01:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp7PSCN2wdqeaja+q2ON4dFSXWgHHgGtQfKo5Pf2rgxjYbGXJI+hFYv8Y6NtbU2H0gaYSrOHzg14enjdg==@vger.kernel.org
X-Gm-Message-State: AFuF++kuJu9yp+XVaCDUUTcWHmOTbaJmEBoiQ/w+a/cAJHNS+4ATI24E
	aEIwpD0yNZpK41mhqoB3hFCn0fzlBVvyF8h6Vmf/x2rBfyf0TZu7b3gOXI5F9JhZglfImNmpVhG
	9hxUPPqDECXxQ6dqSWCl1idcHamZF31o=
X-Received: by 2002:a05:6512:12cb:b0:5b2:a3a2:1395 with SMTP id
 2adb3069b0e04-5b49c75911cmr990885e87.3.1787645823487; Tue, 25 Aug 2026
 01:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com> <20260822213941.98882-11-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-11-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 10:16:51 +0200
X-Gmail-Original-Message-ID: <CAD++jL=92mLe9w_VADZrSxPcban--S6LgsmpcPAHdLQ0yCZpHQ@mail.gmail.com>
X-Gm-Features: AcwNN1XfjeMQMXv8SsZ_-LXkQNyfno0-vAxpzV-yxx3Yu8Bj5QndfM-vNIxIuWI
Message-ID: <CAD++jL=92mLe9w_VADZrSxPcban--S6LgsmpcPAHdLQ0yCZpHQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your patch!

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

> From: Rio Liu <rio@r26.me>
>
> The FT260 modem control GPIOs for RTS, CTS, DTR, and DSR are active-low.
> Invert the TIOCMGET sense and the TIOCMSET drive levels for those pins
> so userspace ioctl state matches the electrical lines. Leave DCD and RI
> unchanged.
>
> Signed-off-by: Rio Liu <rio@r26.me>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

Isn't this just fixing a patch earlier in the same series?

Just fold it in with the patch adding this.

Note: GPIOlib has it's own polarity inversion handling, when
you rewrite the serial modem control to use the helpers,
the gpio table will include a flag for polarity inversion, and
then you just put it there.

Yours,
Linus Walleij
