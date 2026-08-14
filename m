Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5652345EA9
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749342; cv=none; b=NGuXC33V5I5OatpKBBrbXom97niKUZgPsP44VJ/kJG3H/Qg1tHQfYnTltgzzUKOop+3VocclQLbXoOpB4EEC6NVwZF9USUrvPp5dqgLv09I3pmDXfYfIoWI4CPBasM8l3riiFH0CNAuXzi+wXVObzIJQSh5HRYLom5bYu47S+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749342; c=relaxed/simple;
	bh=I/uarSh+Yt39CznkLrrJywz9PlnXuGBPGtjCAp/Ougk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fokUlsSDBjCQw8u9hCW22SMJMVCNY0eWPziqgL7qUvhtA8IRzRO4E0s4pUXhMr913omH1Y4wHsdnO/rgco2wyRvqZ2298qhElmdHaRvtlo4jvsWGtkrweIsJLdNrR22UYuyn6ZapPOqYCdn5tqKBq7OXepEqtBsd7hlDAbpH3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKquns30; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKquns30"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceab75934dso19557685ad.2
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786749340; x=1787354140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ky5gskAaSEf8NghVHXc5sj5etgnRYYESi/dHNnxk2Lo=;
        b=lKquns303EQphSt1wiWFrZoDL1Yj3ydehnjnUJDrPfTBjjXEhybCAnN73q1n5C1bqJ
         QwnOFY+cbUqpDxTvuAeqEFFNLBMkrn3c06adCBYS78Z/QBTKidZLWS7uMxepGv5pJbWF
         GrJf7v9YsKK5O6mfEdStXfxi8jXx7pm+W0LcdPRwj8TO2WRVESw1FVMOyZifg6xVNcpH
         DR5qd5WoeITl08j/97DF5QyLjL8vpFTebBG0ZpuoxI5X2KZszVcWIaUuUAr1h8yxR6r6
         AJ0rKtHhYBFL/7iUYXQ8BbuCB9Kmg1ByYsXh3xDcRu0lZ2OheON9Z3JSiy0K5ug3fif/
         FXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786749340; x=1787354140;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ky5gskAaSEf8NghVHXc5sj5etgnRYYESi/dHNnxk2Lo=;
        b=eiySqYMKLfgMjEa3NxFcHvrvx+y/RG+Dokgv3T9MPyHRmaWkFr2suzL/vv4BL/SvGW
         rbDBTPT4pwlmKK6WXMjQX9BEGw8O7YXdz1Ylqsc40AA+KHntHnXuG1O1BMloldNMVCHc
         I2aPeO2NIVxh9e9FjVWb0vUSH3UPlzwqe1mvfQDAZEwLMn62iAmjHmpcLGIkWvMH+JAn
         te/IDSF41UhgwZbcQMuUlqi59xwjtiw8An5H0g99QkLr2ecFb5Yytaf0IK0qZj3LhLs5
         s/O30gXe7RrzwN9erhW8X2uK6DDSuQ0NVtVIhyrz7viqXJarpbvVe3q9Hd92A9RabuJV
         sFpg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm5IWlk3VV3DfZLRy7Mg2d3w5S69rYFu0eg80gw3EzN+mpgxVvZv7D+WPVAJKSy9kf6QJ4A1wipYZqGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqoTLw1xYOSw5c1KElmWGlgOF5r8O1Lt7LWACd/W8tLvgYDLVk
	eGfZxuYpk/asu5LYupKt41k9TxaRpo1LQ9vJJTV/naW4Oj/oMnwxSdvlRJg0PA==
X-Gm-Gg: AR+sD12KvsXxzt+By+q/5Vr+LF6EjTDE4d4xv/ed9e8F8CLi6PmqUK6BnKNrkNHkVNJ
	IuxbS9akX6RWxYfRXjUG1troyqvZ+aN5n8e2xLqzw15t+tx+goHWe1jH/5UOHAFiKOsrfbdSGjI
	dvGkspLhlMz3FIA8ZF3cJIREXSxOReonEpJWLjUSLA/AtQFjzspG6IkGbkdegtU3C4gx3wZw159
	U8XIURjdqkJm3Xt5B7rl41CNz+5f0/Hc6wvQYCzvWRfEPumaIvXYo3/5BfcjsNxaimS8tm3mlrS
	YqrhxXfYErTdbvkooioy5E/RDOhyJrkeuvQY0mJridouu25X/k33avfEtPg99rnsBNI1KvcaSTA
	qB2fNRTeR5xiwIfRvA81lKMmH3qOp2re7Se2eVQqlO+PRqJgYBouQrZe4uDpbK2VGsaXhbyXTZd
	Y7bwnQbjvKl68hF7j3LuIbTp/q7/CEaTr88YRMqL+FhnWXh4tYcg7m2D2zN9IEB4j9Llry3o8nJ
	8B1WmSDxJePFptLnJuH2hYA
X-Received: by 2002:a05:6a20:2587:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3cc71c1b66fmr10536211637.1.1786749339907;
        Fri, 14 Aug 2026 16:15:39 -0700 (PDT)
Received: from [10.1.1.24] (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03f9sm8733169eec.19.2026.08.14.16.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 16:15:39 -0700 (PDT)
Subject: Re: [PATCH 1/5] m68k: Fix atari mouse movement
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260814031745.17140-1-schmitzmic@gmail.com>
 <20260814031745.17140-2-schmitzmic@gmail.com>
 <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
Cc: linux-m68k@vger.kernel.org, Miro Kropacek <miro.kropacek@gmail.com>,
 linux-input <linux-input@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ef9e0128-6309-546a-715a-3e7eb476910e@gmail.com>
Date: Sat, 15 Aug 2026 11:15:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

thanks for your review!

Am 14.08.2026 um 19:53 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> CC linux-input
>
> On Fri, 14 Aug 2026 at 05:17, Michael Schmitz <schmitzmic@gmail.com> wrote:
>> From: Miro Kropacek <miro.kropacek@gmail.com>
>>
>> Kernels are built with -funsigned-char since version 6.2, resulting
>> in signed mouse position deltas getting misinterpreted as unsigned.
>>
>> Cast deltas passed in (unsigned) scancode buffer to correctly
>> interpret sign.
>>
>> Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
>> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
>> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
>
> Since you're now in the path to upstream, you should add your SoB here
> (applies to all patches).
>
>> --- a/drivers/input/mouse/atarimouse.c
>> +++ b/drivers/input/mouse/atarimouse.c
>> @@ -70,9 +70,12 @@ static void atamouse_interrupt(char *buf)
>
> Alternative, you could change/restore the function's signature to take a
> "signed char *".

Agreed, but without a way to test this, I'd rather wait for Miro 
confirming that change also fixed the issue.

Cheers,

	Michael

>>         atari_mouse_buttons = buttons;
>>  #endif
>>
>> -       /* only relative events get here */
>> -       dx = buf[1];
>> -       dy = buf[2];
>> +       /* only relative events get here; the IKBD sends signed 8-bit
>> +        * deltas, and the kernel builds with -funsigned-char since 6.2,
>> +        * so an explicit signed cast is required
>> +        */
>> +       dx = (s8)buf[1];
>> +       dy = (s8)buf[2];
>>
>>         input_report_rel(atamouse_dev, REL_X, dx);
>>         input_report_rel(atamouse_dev, REL_Y, dy);
>
> Regardless:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
