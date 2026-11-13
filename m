Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794560306;
	b=jDpq6NF1kEPoSUYrG7WtRkKRb5A5dNUfuReLsKhbaxivf6iq1YISPbyG0xmEpgFFGrAG
	 dgHa/ZRdfWVEwcAOUH29ZjUdkC/z6T9IsD1jkebn9vh2XxwRcCQg/eWZoqc8Qd+nJdVD6
	 eu3g4o0P4DSYSyDgi5GNWSH0ZxRgF9LLq53W7H3lFDuMs5gNRlbkW6c5ejK1Dw25dRg2y
	 c/3EvnJ3B50a2+rki1ZwyYzl4rXRkOTRkUArrRS2a3rJlVPMrwna0uzAmwUUtSCXdYc+p
	 tO7RdT1oZ2FWqt1WdP6Ti48n/xAO/DyZ0dW2sMV/N8Ea3EDVdSdkj+WJ3lhAt84ve7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
	b=t1oI+J7yAVyyXnR17GBmvJ7pszOxwdUwP143QloHjUPIBTZFxwJ9SFk8EzCnYpfUEc29
	 sdQwg9XHpwaTcu43//C1dEpcLa9j638qAG0Lo6ipcNAKTrSnheveao+amFZcyliqt9mQi
	 v0ZB0n5fSpynIbn0AXlHCFvTzHuDrGmzgKYJw7S4ZsqTHo2Lttozcm2oIrzE0TqLBOs/r
	 zu/Hc2rQeDTxWS3GBNVZaCTzPj6bGafmk+6LsZz/p0ZajwDG1h/7cn6bTlk3a0if8wGFv
	 HZ/O03WUT/iHyHFAxEuJFPzFdH+ga9OAiZHEpyhvXLsZ+c/Fp/OFgc+638nSDMgh3ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riuEvSnN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D8606A321
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 08:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 532D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riuEvSnN
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b308fca7c3so5729067b3.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 00:58:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560305; cv=none;
        d=google.com; s=arc-20260327;
        b=U+gTZkAlDyZkmy7+o1BA7stBIxRzwVfbjluEhASA0ENHg1xQYG6ZAjZOlaoCfEhG9u
         KfphMndQjubxGWfPZYkCBMJULu1+YuQ80V2PlHIVEyw9T9FTcNmYv2rbfKJW9AEbnV6K
         9HH06thQ9+6JOm2V9czIj56vWxUM+rrPxvxY4SEuOxpfsQYZEafwuUlkWVbIZMQymxyV
         nPcqK7U0Au2fS0xlrn1YqUGbVIIEGkGcR3sqnQ4RB9PbsHL2ngNbyMGKnKW8L1iwM6VY
         Xi6m9eTCAG6j9GN8/JiixMXRK0HJ01peZWbYj9FZRNTIzGi1C/MFfgQ8FURXyQFv4CBC
         sqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
        fh=eYTE9Es9YFsU7Z9Z4KgovbvJyHKODGb0LUD93pI+f7I=;
        b=Tfv94BTpKyV0srvARumfPW6FDNrfpNH8sB7Ir4kE8RgUeNcnf6QMW8IhSm7xUW3Y6h
         YFeyZKChoCa3uUGU1GR1sxjhlBaBzTm+Lpv1/K+emBqy0+BNQF2Bx5U2Rq9PmXhv2KbD
         I3STelohBPx/dMRaItIU9Agu2/JzVIAEUTAlvdUd46CHGuczJAOt/qwAFNqiJe2e/N2N
         b4Sfj80spCFldRjo6AzyaGVkQp1yyK/QQekyeoqicrZPIa9kubGuqSMAsZy1al0CAFaC
         15A9g28fu/Az77+WhjluvmLWecdoDV3m9RnzG7WFoh5vNhCLJnEASewP/ioRz5I1Uo4l
         fL+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794560305; x=1795165105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
        b=riuEvSnN7JmdLlXxo1i14j8AdCq4QwCe+cbdOjeCp7EGB7A19vq5maOIEqo8K85Ji4
         yW2a2Bu0TQAzsaVZGGVeCNrHSMAHXQJv78EtKkBmqq0VcYwmuXjOOAYl84PWZGKWvbNN
         ZhLJF9aGs07sLs8Ha6u+1VQR+l6SlJPbL3oiyZQnL4vCnGYgQjYwU8a578Tl1ec06TYR
         OGLQyjS1avlivz7inCsRuFUdcVlj6MHB4XY8P9SZqPFun7vOibhXPifH+Jgk4fH86wDP
         uv3mYbZ4av7L4+NtVtvvDqpkp0aG4GJbByEU+fgMG5zzRG2XmZkG1j+gwLfwnoWBaJWX
         o7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560305; x=1795165105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
        b=OPgZy12V+RK3B23msheMF5zdQMyu//S1bCNndqJIu+e2iMFZZ8hDl4sZ9vTNx5ClIK
         lkjxD4rRfuuh6ZGNVBdPQnM5ax7vpp+FGcSdrmHL41Kmv+/VoVmYPWpJE10OnoMBjq7k
         3rjr2wLmBPvlB5vfwvBvRTapQQ2Smwv0gk3y22cQ+vBezJPiz1vJEzs+NP2g6FEXojXd
         xDE0Lk/sinepK4dmyV2FxNjD7R2pufsmy9oRujl93jro+rV7CVKLh4UyXv0C5AK+DZGD
         Q1XJbQXuW7j5eZuJ5BMIAF+9bdIKWihp4EfApWJ7LDreawX3P+DJZqOa6Lswnbr4tBMC
         xMTQ==
X-Forwarded-Encrypted: i=1; AL+hErEkL+WgYS4oSKmtO97Da1WNwJMEnp0p7y7rGT+vIpIGhGFj69kCt/dSdrTY7LhzwxSR6TXj6bQ4MxLo2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/r19U/akQDWW6VTzxbFVBAH3EX4mMC14z4xtpDQPprvZk8OjKv
	vcuxX61u6nCKW5L8Gxk3ZbhOMdVLSaSGlFoJv5ZiW/p6uG2Ir9KITQFVN6h7n190ehfK1tqQ4Im
	AWvU4xOVLp+khX0LGj3JrFqw34BhBv2M=
X-Gm-Gg: AYBFou04CjVCSLS1lj/Acsu+05GXGMqkxNZY4qyV9wCe9lA730EcQamgGTYk7MSbgjr
	VhcIvz/yoQlJnCeGnxfTQ7zwY+3L4nVb7t3YQkYvPsxJcCWOhdNffzCbjTbA94GLYkyQSgsJZNP
	7kLSG6dncOuwmzhJWiDOd6g1hDiBXlo+US4eVGhZFXB4JI1/bPf4VMGaOpEJqnvXv12bqw+F0sH
	1+OC4dCP1z5I1h3CaYrTZzKre0GdZ6dxHRGMrU0eAHs59GXBoK4JGJ6T/xWvJQ1Z/c405iv8HQk
	s/wytbNBvxNqWO4CDt2M9qI4ylieEV0h8GGcSVfw4opmN9qTgAAc9FxN7TCrAi6jwUSmPfr/AeE
	8D7tqDBhX5ApZBcgeZZ8zGYSkW+CPa6G1R4I9Z+nRLnLRNMgGM31U318j9aDuK8pPOfYY6o7Yne
	d6xQn4hTovjjXyK2FkcKtb7n8BRPKAL0YePjrgJ4GPmRXgw8EQYfnWc/WO/xjXxwWz2PutOXr86
	qDXZgNehH015BZ3wBReU+CAO+b1q5e8G9LWutt6o5PTnR/YoW+BX3AlFBDmgQ==
X-Received: by 2002:a05:690c:7:b0:8b3:22c:b40c with SMTP id
 00721157ae682-8b4aa0d0fb2mr13819027b3.7.1794560305368; Fri, 13 Nov 2026
 00:58:25 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-2-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 10:57:48 +0200
X-Gm-Features: AclHuK8xbnlVzSxLbVaTLM1vgALdMGppH-yIDCfls_fqrQt5T114mrDDfzRO1l8
Message-ID: <CAHp75VfKx3DRa0hU+TeFmvi_24_MLVwhmwFRsHO+ggMZXYvWbw@mail.gmail.com>
Subject: Re: [PATCH 1/5] Input: tsc2007 - drop platform data support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that all in-tree board files (including SuperH ecovec24) have been
> converted to generic device properties, legacy platform data support
> is no longer needed.
>
> Remove the platform data structure and associated hardware callbacks
> from the driver, check the pen-down GPIO directly, and remove the
> unused platform data header file.

Very good!
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--
With Best Regards,
Andy Shevchenko
