Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862689;
	b=CtOg8GoRl4PvyttKEptFKzkxI1u4Bp3/YfZ5sOdpRfYYNJkvts8VfgZZtV6HlgwaaE32
	 lRSZ5hUHwm5XmjBK1U6A6C9Dj6kAsT2+SILw4MTt/ZIuZiP6KXS9BHuawajNKwd5Z1z5Q
	 SP6X0J+vDkMMj1lhSepz/mayTNUruoD+IKpZH0r2tdprskDH5FHntdSodNrZUXmHGz3td
	 QwI0qAryE0Mue6d+pXT6uuyhr0bnIL1W2Mp9nFfpw18tQOVzxXCIl57QqBq6jSY4sxF7v
	 rdpKPmdE+xOSmHXO8SaPojgT8TWvkeQNrbLLyDSwdomTo6lvhwNpDuDCH5yYHbFtB+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
	b=d1nc4PcvuANaZSV3RxrVw+ayi2x98/oiZjQgOzQKV6MjYMI2H8OwLQBAX/jU/VdgxVKc
	 aUhFFcYgS5oklgQbE6y5gnycGvq7lXJdAGnY5kLNTq8YxXlx/RveA/0ehNjGIggCdCCWi
	 wGyFWSnUJydAuyv2zNGg5IGs/4lHW6M+0YbEE7gYRmM26WsWZyZBucsHSVcBktaLVBbpo
	 CIEBCTDf2iNuC6IUo6igSkj/qiHU8yHzl2ZCz/5tUcllIREaRXzWffrGuKdmkmw5VjFKS
	 lzZ9MijDhcAHEyKqDybvpM1+Wh3zzufut3xppkeibAACranO5ANkQGMpF6lyS2Sglyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xhfpB4p/";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C1606A323
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 20:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 522C1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhfpB4p/
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso27498175e9.0
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862688; x=1795467488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
        b=xhfpB4p/FLz4tPvQ4XDyzPJZhYbKdby9eMFjsG4ed6t2AZa3F7CPzOfipZSOTimeWe
         BcDpq6gokbNTxIQ9l4fnGfjfFt29zj3RD0h6lHh+vJ1bX552MblcNRz+J8927R5ZmjeF
         iKpG54++B5Tp/HqvgFsBZU/VNWRkvyP+JLjtw/G/z314VyLXrSJcxdPsDrmr/1FXdlvg
         DIdw/tMELU7KsErDToyfosjf4meSG+J1RxQySHwdKjVeXk503qOmotvoqiMa9MiZS+ON
         XrDB4pfb8+ohnHUAfF24YjeIm1F8rDtjJQd8EA/+blfE98B4+XJy/aO9+RNJN9y3qjfU
         QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862688; x=1795467488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
        b=IAKBvP0kG2D11LbEQYwRIA/x9jXxaLm0VJh2y4DJiN37eiPkHI0K/E0oWtccmDePa6
         qX+AUYFl9XpFPfHbwzG/HpW5tNN69zqG8zIMhlUo/tPIJN4wOxA0o27/OqB1974QqDyg
         qyx5flFpBeUsmSWyyinqS+a/BBFtixmTFHCVPJFVrv+as/8eZYnpxgDCWx06pzbizQyH
         2Guj+2Cmn59gNndQ6BZ7amDczTqa2CdoPfJJLCDkUPAc5rGyVtiPhuf3QBuwXtalSHTc
         ZtQfCMDN+6lSafLQzACfwTIeZgxLnHHIUyLtySB3KOKP/ChxJ+VBVqSgY/5gzxu6jU73
         hFLQ==
X-Forwarded-Encrypted: i=1; AL+hErFwKNQflIV+tYVYdP537zBPJY1nCo3sXIh4JQoFlr0gBXN12fr2H7rOIfrsVANhJIjKcvnej9Buuare+w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8IrI1On3TB5AAlstVN8TsbEDfu7dOGU+sxCL5WSR94bk+GNUhw
	p1UWaOK84dSHpPDJJjdoAla/vyWyvTYbrwTrF0lDA8/eBMRagaOjMQ12
X-Gm-Gg: AYBFou0QUCtOrCka7UYGrU4vFlF6JlRbuap9729rw60xHucLQ1811TnNHPJD8KQKaMB
	80/9k9YbvC4ZqlRQsZOnj60tXPI6hWO64zRiBjPJQSWyP4xrMZeKIH7zb6+gXCM2WL1b9mCRhgN
	eKsNlSU1adknOE7LKLkd+cUvN9aA5ir4VyPhOpEAfcKC+4muERLV4EXHXMtGQV8fEalFvd4lwai
	f5ZZ8VSG4dZtpOhK1IegCdyAyLysw4EuroWr1Nd9YB7qkwCxgR6n28OVyUikpd9o0124MlSn2sV
	0Rm2EpycKZhoDqFOJgLZxxaTTokaZWt9dCSAecy7qtMSSL3WA0b4EV3FR2/IrOczNeFLMH8hG1o
	CaCTJEoT7MqJbMnRkfXB92iqyfigZwXpLt/XoQmY0yCZ8zkoUFiOtPXNlAxIlbSL3kgoOqFAHNC
	nBv0KuK7/asDRvdBqhbWNdrXhnJiFD31TJctYMHBKzIPPCJDBetLDg/qMErjwhmFZ2X7d1RdOc0
	fM5YqbC+uh8PGyZ9hC+zt8geMwCVLgTnu3551cxdYk0yyhloheOvJwXT5AB+YJt1bHHhffpFA1D
	d58ug+FEFGlQWzRJeBE0bPCcB9s=
X-Received: by 2002:a05:600c:a00d:b0:4bb:693e:4c8e with SMTP id 5b1f17b1804b1-4bb693e4d5dmr149922355e9.21.1794862687584;
        Mon, 16 Nov 2026 12:58:07 -0800 (PST)
Received: from m2.. ([37.142.154.59])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm20499255e9.8.2026.11.16.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:58:06 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Mon, 16 Nov 2026 22:57:50 +0200
Message-ID: <20261116205752.18800-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maarten,

On Mon, 16 Nov 2026 11:47:46 +0000, Maarten Brock wrote:
> > TIOCMGET and TIOCMSET work only while the modem pins are GPIOs, and
> > return -EINVAL otherwise.
>
> Without checking if it is possible at all, I am wondering why it would be an
> invalid operation to TIOCMGET the modem pin states when they are not
> GPIOs.

Thanks for catching this. There is no good reason for TIOCMGET to
fail there. The -EINVAL came from the Sashiko review of v1. In v1
both ioctls returned 0 when the pins were not GPIOs, so TIOCMGET
reported every line as inactive. v2 changed that to -EINVAL, which
fixed the wrong answer but made TIOCMGET fail.

The chip does the RTS/CTS and DTR/DSR flow control in hardware, and
no HID report gives the level of these pins while they are in UART
function. Two things I checked on hardware:

- For a pin in UART function, the GPIO report (0xB0) reads 0. With
  RTS/CTS flow control, the CTS bit stayed 0 while the peer toggled
  RTS. With DTR/DSR flow control, the DSR bit did the same.
- With flow control on and no data, the chip drives RTS (or DTR)
  active. I read this on the peer.

For v4 I am changing TIOCMGET so that it does not fail. Lines whose
pins are GPIOs are read from the chip, as now. A line in UART
function is reported as the get_mctrl() comment in serial_core.h
asks: CTS, DSR and DCD active, RI not active. RTS (or DTR) under
flow control is reported active, as measured.

TIOCMSET does not return -EINVAL any more either. It ignores RTS
while RTS/CTS flow control owns the pin, and DTR while DTR/DSR flow
control owns it, and it sets the other line. So DTR can be used
together with CRTSCTS.

Thanks,
Michael
