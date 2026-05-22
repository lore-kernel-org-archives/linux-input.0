Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC3385D77
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481953; cv=pass; b=bVggsXsvOZtz6bovWh4VPpTKWGqMqMqIYinuz2fnNZilZyf/ZQ+Uy8G2Z4rUmW1hwDhZok+JD3N2pwnz7jLaTxv3zsdjgb94mgr6uIPhE8b6hrLmQ24YylnkiDrodWycS7x3syCWzUlOVKDNa1BUBe1AbjQoq0oIbHxCqLuWa34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481953; c=relaxed/simple;
	bh=Ev2miirDGeKRHrRpnlO+Mvy0UVh5ZPS9JQr98BABgbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oD2KuTYGoz8XzgD+UQGFhKx3z2joxsyJTV6PK1zpIDUmETFjI19mwsrL3y+X9VBWC6QqLN8O/IAntF4f3L09IXgQCWVWY/1Va253vXg3W4657RR/W3jYIsCES69EYXmdc+5YQkiWr2bCiMZTPsCDnuYKxlavImkZenuUP4zdBug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMg3Gb58; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMg3Gb58"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso12477382a12.3
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 13:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779481949; cv=none;
        d=google.com; s=arc-20240605;
        b=W/KdhGB9hIlAU5pSpcGjuOYNRZKKuYL3R0de4XXKNy9Bw8lO4ac4WLexPaXyqGXNWU
         YuU02oJr8imRHhukIHkAB5GehLEg5d6RjviAPvyOH1lidupZ7fA1yL1aEyxkJZdnLaR2
         q2JGr4jASvDg43XCthBW/75wco3jWAD8++JBHaJvoWB9ftB3/zT61OoABBiidZ2iHAW+
         M/4nALoOSluWv6BWWrvIu9ELrU2pAB/7wIe79bq4qAPqKbT+YWdGHMWl+dqnpLzUxjE7
         QTn7aX2s3+I2CvpqzfwnJeXidRSR+gad078t6KHeHKwTlN34X0T5hUUR/lgxy8XrcF7E
         yASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcgYl2C+0uVQkHGkUHgGW0mtwGpaJdoCOIDv4XFR9/Q=;
        fh=mRHz2VwQEE52LAdjYQaywb5ExLHJttVqQFOZu8n8RDk=;
        b=PvZZz4/Tn7eVdK+FIyCb0ksMRu4l+FOoMlGkKbZfSLszmcAQxMjNYq4eIgycxRUg9n
         Ia5rWNLUTSUpvkqo6Fi+5uKCtJ5qJTDrnPwKGD9sEJJktxIoCRuJE2X0gRhTYOFPG3q8
         xJ7i05PIxLpxkLGiRdQYlaFw+LvbF1C00qfezxwok6iPJ9EJiZBZbQ0sTlhek7GaMIy4
         07pd0ziVN1kOhzIirmaR7stRKI2FVgs3SD5PY5ieqaWOVy5+FysscU1KDCgIGcfAtw8f
         /YUoo7KgwujhRt71yg1A3OrKXSoFV+tLwjQ/ykdL4OY5jAeqSI/v8XBQCB0N4aLYYOPY
         kRvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779481949; x=1780086749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcgYl2C+0uVQkHGkUHgGW0mtwGpaJdoCOIDv4XFR9/Q=;
        b=pMg3Gb58wpDbzBwqKwpW3XchEK9EmMAXCz/cIRs8IBWzwPHI0omDWHPHnFkk0jE48A
         BZbJ9m5SVIkHw3x/bWtwXSSxvOYxveeozz48+FPq58qRvx+ruI1BA5DBHxFtfHlpRZgl
         EQ8+xvktQizdEEVHU72VASDwNgIZ6MI/zbGDpnSGzXVLDTzKxi8+pkRU1D9pmbX5uSFW
         UwClpQgTCf0uhU16kksKfxxeI0pLy7pJ0mia4dYk8MIk5yJ3yp78wumO4AEhmsVX9+zE
         QcsDnH9DVN+9LMz/aQFSWx3EZgxVeGqW5FHr+Zm5a0tAdfsT50R4K8/DutqFbSpsfNp5
         He6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481949; x=1780086749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcgYl2C+0uVQkHGkUHgGW0mtwGpaJdoCOIDv4XFR9/Q=;
        b=JDaKV0d8q1BRdIgADdAv3w7uu8A2Lqi+0ocy9Y3gXDTbyDR7VwBEHx0McsAHsox7bi
         fPe3+B/6p+U+z+sWS9JMWe+mF8w/GRF0hhzVIOPaFfrlzIHg8FGfPRdNZLZ1Hy4Fxymv
         BdnGIb63dL87y8FtUmnHsA0xJO1TCQZgP8xjWgJrukTUBYmLBa/pLxgdcnV+5SIwyyM+
         c5arOFC9PERZGJGJN7QHf1HF+7R7/gEgDOoioWuX5z94o/YTTeWPsFozP7Yw+uyaR+T0
         TBQuirj/nGPbZBYUG2jsLmVFPWaYw/ka65+petzh+7bd6RpzKdILA8W7SNrK44dB3yrf
         TVsA==
X-Forwarded-Encrypted: i=1; AFNElJ+l7hyMfQ03Di094xNp5MmIK9KqOnx+Bcyh6K/+7YED9SNkaI0Pzbu/5T4xMmVWohJXwXm0nMZrWm8Rxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLRIHbRYJ6Z+DlIk+pukoi7ugH3OxwlZoaeu6NGLclO84es19
	4ss4/J58i20wt0L3mZFUFrfGy50SXZoqQRcZyuKxqwc8OE8Ipy5rYEfmfOGYGQM4vWqXj9WaO9C
	hZLhAjW8e8dfiZCi2LlG07+kvAn/ZLBY=
X-Gm-Gg: Acq92OHGhSJhlr/SfwxCq5dmbT0yLC6870/DGvHFQjJrMsLZU7vSp+tH2HVoIaot5+H
	BNcoltInfXB69T9drDCYiQR9hbbDOnP92fk13CHFUiLyRE09Xn2TNGwtVcg/osRh1OMUnF4zkzw
	XUxDh0NKWQmNJZTqFpRhNH8JDHX1WCNHB4GzU3en8p1scEVer2TOAOI3tIN66kjIEIuksTTObUw
	O4yDufHSrnU/s/e2ph+RPqd1ZT6DinpgaHzk7zpr4oD+ytRSMlFQhIF9IwJZ75Tj8LbEEbICGDE
	SYmW+GnIPmK4wJjMoIfnCo0QuyWGdHijIq2sOR47I92iByRi0A==
X-Received: by 2002:a05:6402:530d:b0:67c:2674:a57 with SMTP id
 4fb4d7f45d1cf-6889c28b9ccmr2949931a12.0.1779481948863; Fri, 22 May 2026
 13:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321202446.724277-1-charles.embedded@gmail.com>
 <20260321202446.724277-3-charles.embedded@gmail.com> <acDLSiujizhuYfOt@google.com>
 <CAHua+AMP-gwgFCX67rdDrfS8RUGpiw2msKYRn07AVWy+u_vTwQ@mail.gmail.com> <CAHua+AOOy6NSQJUPHr7-VQp2zv6ggq0PXjkCbboN_Y2gY+zZ+Q@mail.gmail.com>
In-Reply-To: <CAHua+AOOy6NSQJUPHr7-VQp2zv6ggq0PXjkCbboN_Y2gY+zZ+Q@mail.gmail.com>
From: Charles Dias <charles.embedded@gmail.com>
Date: Fri, 22 May 2026 17:32:16 -0300
X-Gm-Features: AVHnY4JNb1S2uobueZdyf3l4MXA8Tnu-ULIXkkCCqachWz-eGS2OxfJyx6V0DM8
Message-ID: <CAHua+AP8RUpT=1=HbWgJTB+Nb5X4B4=t44WEy9xjqggmH-Lm6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: adafruit-seesaw - add interrupt support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Charles Dias <charlesdias.cd@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 4:24=E2=80=AFPM Charles Dias <charles.embedded@gmai=
l.com> wrote:
>
> On Tue, Mar 24, 2026 at 10:59=E2=80=AFAM Charles Dias
> <charles.embedded@gmail.com> wrote:
> >
> > On Mon, Mar 23, 2026 at 2:12=E2=80=AFAM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Hi Charles,
> > >
> > > On Sat, Mar 21, 2026 at 05:24:45PM -0300, charles.embedded@gmail.com =
wrote:
> > > > @@ -289,6 +341,19 @@ static int seesaw_probe(struct i2c_client *cli=
ent)
> > > >       input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD=
_POLL_MAX);
> > > >       input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD=
_POLL_MIN);
> > > >
> > > > +     if (client->irq) {
> > > > +             err =3D seesaw_register_write_u32(client, SEESAW_GPIO=
_INTENSET, SEESAW_BUTTON_MASK);
> > > > +             if (err)
> > > > +                     return dev_err_probe(&client->dev, err,
> > > > +                                             "failed to enable har=
dware interrupts\n");
> > >
> > > Maybe this should be in seesaw_open()?
> > >
> > > Thanks.
> > >
> > > --
> > > Dmitry
> >
> > Hi Dmitry. Thank you for your review!
> >
> > Since this is a one-time setup, I believe it should remain as is
> > within the seesaw_probe() function, similar to other pin
> > configurations.
> >
> > Please let me know if I'm missing any point here.
> >
> > Best regards,
> > Charles Dias
>
> Hi Dmitry,
>
> I just wanted to follow up on my previous response regarding the initiali=
zation.
>
> Please let me know if there is anything else you'd like me to address
> or if there are any further changes needed on my end. Thank you!
>
> Best regards,
> Charles Dias

Hi Dmitry,

I would like to check whether my previous reply addressed your concern.

Best regards,
Charles Dias.
