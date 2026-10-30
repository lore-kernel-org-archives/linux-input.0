Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341860;
	b=u+CX4gQlz+ImLxYrlBil5nIYd7tgWynyxoXzTPO6hTgJqkqVnUcftP0hZ+kgOVjOb16n
	 UWZNGxNGp3ZonjwvE4237Iz8ik0bpNON0o8qyd1qV6qK5K3PHfXs0z6Fjf1aAdq2O9WF4
	 Flrm051WOS60I4Hd8RiZxRXXTxuhcWNU+E3c9KidVNK5nB2obYju+yB8kzkzpaQhYT4FM
	 uYTC5hD/qUZ4MuHr8rsVUlh23Qfjwp5xX9IlpHbxkShrWH/KdcWm3dHvsKnelXZRnWbDN
	 ig+F+Tar3RcUaTuAcS7JasSVEXCU3VkWCP8rOb3PVNi0SrwDxQIXRQg0cRXEpGcn4pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UppOoST0Trl7TROBBYtHebLU93t2eXyMY6EcGmmSljU=;
	b=HlaVmq4Nk9zmWTQxQucCwSfqrnSYnNOfhiO6MfBe1wVqD4SEI7pnaVvmw38mQ2LI+Xv+
	 r0pU9bOaD/HmfUaSd4AQp1MnAlh+bnwOCnhYWfZDBXajlsQfto6RF2sCfQWjme5BF/i0M
	 MmKsw1zY/W8t83fQil77OF/X+kGUOtw3PUeAGAGWsw++JGKeBMoHsCFHt+Ia6XrmvJ6XJ
	 6nFomUa9wrNFRekIOarz0pBsf2LGKhp70/UQq/HS1Em8VERVKPWOC6t8iDtGU2iRy1Uba
	 1mU9taV7yezQTrHPLHJqaxjgzo/tXgJxvsL2QIis2Qa46/HR9Mdu/oVDiNRdCCzBafA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmhjGgHz;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DA606A31D
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 06:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67DA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmhjGgHz
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so910580eec.0
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341859; x=1793946659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UppOoST0Trl7TROBBYtHebLU93t2eXyMY6EcGmmSljU=;
        b=HmhjGgHzKfVwRzuxoZn9FAH+hl9oEvGgNolCPK3hxscZsQxL9/qZaEgAYM63Mj08eZ
         3BkNCkGGqBT01aGnBhd1z05UHeOVYZ0PXB4Ve0u9oke8Y0kdiFOdiUB24aUgmGcE35YN
         x0v2ySqq5BYQa+n/YnWDJ8xwO4SeLmEowhO082yfGHONJVlJhdqc0WCclA//NQFwbGzV
         wQT9tTkTF91BmYJazkzHCQse8bQTQI563EugFUKluhZgZhbI+tSHvbQZTLO5a4yOgEEF
         rCAv982dGFLUqvoFRmmKJVeYUnbOamtcFiJfW1IOFmF5EqYgKJxGvaUpUGGxtafEyt1s
         QyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341859; x=1793946659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UppOoST0Trl7TROBBYtHebLU93t2eXyMY6EcGmmSljU=;
        b=b83y/jv3NGBsGJTU+HFCFg42r8GbY0XcxaeCBzK1LcUb/tcpTCGPFulbwGCYccNoDf
         Zi0WFg4OISRBCridz2BNPIrHTueRZCMUUQvkM/sdR3dzHpGUBcVDd2cJtVI776JPBlsY
         vAxps+9yOh54o/JzxCBWpfyMnVoMNzpWDWPtMkEsfRDVxC3J6tsi+pQNsJzkFIofppyK
         VEIvVT5BD2wTjJlgsLgyH5qFrs4esRDPHJ3OCgoJTyhGIYVtJaPuOZXmeamJvubDPsPG
         DmA/OsYUbCGqTzr5L3FQnEnLM6gxW81DS1Z+cN0TpkZYrqAJ18+fKOpyEyepINY/3BZi
         wmRw==
X-Forwarded-Encrypted: i=1; AKwUvBzptKR9I/P1eJuiK8gHPFsX4Z04D1umreM/aYb3eD7dcH8TYMthW6xF6JtRlUyqd1j6Ueaz26x3mzA5wg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKYDIXRRsXl8uEDjvPtVZJXP2zpuJoCJYNpyIq4wvOIbgak4SaA
	JcYSKJaK9P0N0zRskjURDh+WFlPg0LnfrgEB0KUj/AtHz+qNwRMEk6CtYVVWQwKI
X-Gm-Gg: AYBFou3bq38Fd7yYzeyHXJ5+laloJdUiVftXrmaaL91rmJ+7z4k4IAw/NY5Nln/yJqa
	fUaBr0PVGixj+6w181fmdyp8Fcqd0lkVSYecmEIxaxM27pd8txY80p4Gg1kM4sDWqw1stB98nA4
	hJCvuRukkj32t+UR7/ooFCTjB1QC4HWW8un/yIuat4cr/sbNnRxQYQ1bG1SdNHFyohYAMKj0rw7
	KoASNw78ACNUkIWt6d6mjWrXUMxJIFS2mJTfmjW/SBz0DKBhnUgXGjp3i/RlS3n7PyFCMxUNRP+
	sUD3vXETBzPy1SLaB+NNv6GXBSUAMjVBEB5WumIMI/4kiTici+ZQcBL6qKLRPS2yON7JwFp2M+y
	ioJ+urxoDJqpT94fWQuni5RjCLo7BXksx0v0Vf8BlOso3wPTrNKLX9A+bj63DKakuCNU2HyOZdE
	KdLx7kUB/OfBrQRO7gZbFMtxajoaRBaMIxEsOiP02m3cp6eaS4+sOH8+Hpb3UVegb/z9YRpV99a
	XQnKrpr1F+mO6oSJpBOKLzEFpA/NF1WjtKCiRleaJ+BhTIycn8740nxGDJYEI56d5/Dap/Bm3hw
	swttWBgjHnhO/WElPMkwFc5BQIHPRcRsk5cYvyooYJ7N1A==
X-Received: by 2002:a05:693c:88cd:10b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-36a4238940fmr2362399eec.14.1793341858562;
        Thu, 29 Oct 2026 23:30:58 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm3914964eec.5.2026.10.29.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:30:58 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written reset_seq
Date: Fri, 30 Oct 2026 14:30:53 +0800
Message-ID: <20261030063053.170432-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026103031-hungrily-compile-49c8@gregkh>
References: <2026103031-hungrily-compile-49c8@gregkh>
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

Hi Greg,

On Fri, Oct 30, 2026 at 07:05:10AM +0100, Greg KH wrote:
> I'm sorry, but I can't really parse this llm-generated text.  What is
> the bug here.  What is being fixed?  And what is changing?

Sorry, that was unreadable.

reset_seq can be changed at runtime, but the new value doesn't work:
each keyboard keeps counting the old keys too, so pressing the new
sequence does nothing.  2/2 fixes that.

1/2 is for a race that 2/2 makes easier to hit.  The new list is filled
in one key at a time and the keyboards pick up each partial list, so
pressing the first new key during the write can reboot the machine.

> And how has no one ever hit this issue in the decades that it has been
> present?  Is this really something that needs to be fixed?  If so, why?

The sequence is usually set on the command line or in DT, and that
works.  Both bugs need a runtime change, and the race also needs a key
press during the write, which takes microseconds.  I only hit it with
an added delay.

1/2 is far too big for that.  Telling the keyboards about the new value
only once the whole list is written avoids the race with a small patch,
and doesn't change what the parameter accepts.  I can send that with
2/2 as v5, or drop the series if runtime changes aren't worth fixing.

Thanks,
Zhan Xusheng
