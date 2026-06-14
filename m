Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1C1474CC
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429532; cv=pass; b=mICxOc5YIyAiAvPLJseyzn+cWzm3/StC0DWyWa5ky7tCE163d3fZPQ4ltLLNQ8wotAap0viHQ95hBs0W7Eo/QkrGfsnA4n6wlzaENLmJh1TkLAut83mW4Rnb1M4XImycdUi7XzPxQPzqLobqAu/0MqBstlZpZ/Tgx5nz3XBEZ+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429532; c=relaxed/simple;
	bh=E8qjyT8JaatNcEMEHAT3DbSpG1es4d80cANh+szhfVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA2dJ6fGGBbMiBn68ZtIiDEQkRny7DMFYKB3RLDAAEYYB22Lb0r/P7cKX8Yt0LFhWQlIvidH1BAlr1JQcveaMOeBl4II/lgaxRHSphc3LD9FynNNBoEP8zvLrfcXwH0X3Pz9vqHycWQ+GUAjVlVjSXlDvqbuAcqXps+nzVypIFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYrG7McQ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYrG7McQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-befd83e0521so620368966b.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 02:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781429529; cv=none;
        d=google.com; s=arc-20240605;
        b=UQzg1fM5WVb42t9UAlriC0hdAM5uf+cIcgTDyfzFGDM8hTTMPBKGk/st4eUKlCiY9a
         KS5ElYXp5nCkW18KBvEzPLZj5s2RNZCkcr0DV0A9n0OiMWXj52dBa/3M2eBg59HLwnnX
         tc1R9zuA7h7vdH59DQ5dyVJdsJfay7SRSbYZdzLFCGYgPrqZ5yycXdhnqjGfqaG6+aZ9
         zvOcJo3kVX6u93rxiHb1vvweBKMQSg4lqiHWLMX/uMkbQ/pJkW+Ni2tHNBkA542ED/3N
         sxvdpO8BrqqMe6BwLMw1EbxpvmSw0JxmX/3NcJE9bYN+UoRkJZpuEkn5nU5Ib3EEzqX/
         yuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gsL8U+Tj23wFzSN7oZJt9QcS9nfnq55hn1hbjS7HtiI=;
        fh=j2doRkAqirgcK0Ye68rHpMNpgQuygW0Wzmg0wT0xgVI=;
        b=a8J4Qyxl/XExy+h+10AmXLegJ3OLFL9QGNvrASZz/znIex0Xd8/M+rue2vaPp1WETK
         ZiqcJ2hifP2Od6b0TYf5UgNLZvTsZhWnINst8MfohTMLcqQE3Qvy5nJYShRrfqWM4rpG
         Ab3qlG2RXU4pO0UuK9bxYA7Z2EG4PtXk0c1PhWZQDB+K3R5/n8rsx2UQYdKGHHhw3tY2
         jhnDXxcyibQ+++Pft3VgmyNwCGeICEKrHX904m0omzmlc66twtx/xqakZADIa3Tx9VMm
         5VHQ56cSWsDp4p5oTVhIiF4vsrA5rZdZYoAL8wVVEEdraThBWvrNVxMlNeZHfMPXFKo5
         xFug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429529; x=1782034329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsL8U+Tj23wFzSN7oZJt9QcS9nfnq55hn1hbjS7HtiI=;
        b=qYrG7McQxfMvObJnpW/B9LxSwrGChm7PrzjUeJKJHHythFJkf9u1pkR3IQ7lfYTnLl
         7dJ2kuns+V7jEx3O2JPTgx9yhpw+quJ4fCoByGLREIvLfe5Gh4DrzZAUbJKkShW4sPs0
         hVcdwVXXG3cZoWg4KNhBsR9OWXGiPnhXBXtGwIzS6pgmtdZKLMm4AkKRPxOGm87ZsvjC
         3BtdzaNMb4SuaPJVkKeFB3VGHz+qRi0iFXXT5D3IzkkTMW2eyORDHPJ+UHmfKB1B1Osl
         F9zswIeXTtLrlSLIkQJbcgNLs/AGmgAXcPDVKDd++oQs+3hw9IAmTdIH5WbGVq8POOZC
         0YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429529; x=1782034329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsL8U+Tj23wFzSN7oZJt9QcS9nfnq55hn1hbjS7HtiI=;
        b=BIDT9qC+sNkxIMMgSHKRum6/x1TThZPIjyYsby3cZ3qFW/hucp5uRj8NHPst1jHdIs
         nM85X5UsHZb/3BMWjvwWiZRbHytP9CeSOMn1Oycp8xgWuW5nA8atfZ8TVortl0IJ+fme
         CZfud+UlY/SkJcxYE1RzpXHtkCm2iyh5azwRmM7sHsGAaMixtQNomESfPRdiDtCLkyA4
         NdrNDj52h6iBDp9zEzjgzV+P8ltinMPuJ/bb+A1qoECWXL4MFuUxeHSG4gH1cGYAXwG0
         0v8alkm/MGuusALfwp6J6R8w6y+Iqjjx5RBIKYgLnOnDZCwPhbY1QSBAMPXL0C+N38Tr
         nlxw==
X-Forwarded-Encrypted: i=1; AFNElJ8W/PJ23vYSztnwbsxZ1BAU41/tjQudex2xoZgGNMwfxdTNrZIOxpL4SBdB4mWBbyOVzs1SwZM9wwb8JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzc1B6FGPSFSB46C+hUQo6MTdAsl9sMBP60ySzT8Z3OzummtJ1
	eG+I3kZFHrtS0CuGY3hLlgGiSGEo8SWu/OyOwuDepEuAKbyobtDHEERi8ODA7nQFNt30+0KYD8C
	TnK0diggSRRsf2FqEbUC+L5YFT+2BWog=
X-Gm-Gg: Acq92OEmJlPJwmCqAdwHPHX8Oxe8VH7+YgMx+l4zbbPkIYbFoEg+2qF7X8t1lmzw4E0
	5pgnLfHmqMQq/Mg30tFCaCAV8BGP0G3nERkH98f4HiraoFVDHlQj1+6tGUWIff3dTQXYN7g8xTP
	f6j2FDCJBZa/iMkGbHNsup7fHuVlao3vUjJiQgOmsHBrWcvLtzv2ycCSi645ODVYZCa/SviU+Hy
	Jod85xQWdzQdJ0xJYJuAE9M/bWO8U8d4QCNhXY1SaH/NALcT40cZrN+Sz1KvDtmNmvzEAh/RFUB
	VTE9xRaa2dtMxXUv8w==
X-Received: by 2002:a17:907:6ea8:b0:bfe:ed35:e854 with SMTP id
 a640c23a62f3a-bfeed35e9aamr331695966b.25.1781429528783; Sun, 14 Jun 2026
 02:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
 <CAPnwWgNLd2RZVx__T1Z9siKwN_5HrA2hcKwrZ2C6YivQuF6Ubw@mail.gmail.com>
In-Reply-To: <CAPnwWgNLd2RZVx__T1Z9siKwN_5HrA2hcKwrZ2C6YivQuF6Ubw@mail.gmail.com>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Sun, 14 Jun 2026 12:31:57 +0300
X-Gm-Features: AVVi8CdjVhF73gj-rKdxo_hVxcpHTTIZi7Xpk_hSgB5hjyshYexkeOyHWts9HAQ
Message-ID: <CAPnwWgNOh6-zh1Drdox5YZD_Me9dH8JH76kgRsRrTOqC6Tt4kw@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: fix SMBus block read protocol handling
To: kernel-linux-20260610-80b7ab08@raman.v1.sg
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, wrong address in my previous Reviewed-by.

Reviewed-by: Michael Zaidman <michael.zaidman@gmail.com>

On Sun, Jun 14, 2026 at 12:27=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:
>
> Hi Raman,
>
> Thanks for the patch. Your analysis matches what I see in the driver:
> on a block read the count comes from the slave, data->block[0] is not
> initialized by the caller, so sizing the read from data->block[0] + 1
> is wrong. Reading and validating the count first is the correct fix
> for the FT260.
>
> I'm validating on FT260 hardware and will follow up on this thread with
> Tested-by/Acked-by when that is complete.
>
> Reviewed-by: Michael Zaidman <michaelz@xsightlabs.com>
>
> On Wed, Jun 10, 2026 at 4:42=E2=80=AFPM Raman Varabets
> <kernel-linux-20260610-80b7ab08@raman.v1.sg> wrote:
> >
> > For I2C_SMBUS_BLOCK_DATA reads, ft260_smbus_xfer() passed
> > data->block[0] + 1 as the read length. But on a block read the byte
> > count is supplied by the slave as the first byte of the response;
> > data->block[0] is not initialized by the caller, so the transfer
> > length was taken from stale buffer contents, and the count byte the
> > slave did return was stored without any validation.
> >
> > Implement the SMBus 2.0 block read protocol properly: read the count
> > byte first with a repeated START and no STOP, validate it against
> > I2C_SMBUS_BLOCK_MAX (resetting the bus and returning -EPROTO on a
> > bogus count), then read exactly that many data bytes and finish the
> > transaction with STOP. This keeps the whole sequence within a single
> > I2C transaction:
> >
> >   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data... P
> >
> > To support issuing the two reads as one transaction, teach
> > ft260_i2c_read() to honor the caller's flags instead of always
> > forcing a START and unconditionally appending STOP to the last
> > chunk: START is only emitted if requested, and STOP is appended to
> > the final chunk only when the caller asked for it.
> >
> > Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.=
sg>
> > ---
> >  drivers/hid/hid-ft260.c | 45 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> > index 70e2eedb4..946ed0c6f 100644
> > --- a/drivers/hid/hid-ft260.c
> > +++ b/drivers/hid/hid-ft260.c
> > @@ -502,15 +502,23 @@ static int ft260_i2c_read(struct ft260_device *de=
v, u8 addr, u8 *data,
> >         struct ft260_i2c_read_request_report rep;
> >         struct hid_device *hdev =3D dev->hdev;
> >         u8 bus_busy =3D 0;
> > +       /*
> > +        * STOP terminates the last chunk; clear means hold the bus so =
a
> > +        * follow-up call continues the same I2C transaction.
> > +        */
> > +       bool want_stop =3D !!(flag & FT260_FLAG_STOP);
> >
> >         if ((flag & FT260_FLAG_START_REPEATED) =3D=3D FT260_FLAG_START_=
REPEATED)
> >                 flag =3D FT260_FLAG_START_REPEATED;
> > -       else
> > +       else if (flag & FT260_FLAG_START)
> >                 flag =3D FT260_FLAG_START;
> > +       else
> > +               flag =3D 0;       /* no fresh START - continue current =
transaction */
> >         do {
> >                 if (len <=3D rd_data_max) {
> >                         rd_len =3D len;
> > -                       flag |=3D FT260_FLAG_STOP;
> > +                       if (want_stop)
> > +                               flag |=3D FT260_FLAG_STOP;
> >                 } else {
> >                         rd_len =3D rd_data_max;
> >                 }
> > @@ -708,14 +716,41 @@ static int ft260_smbus_xfer(struct i2c_adapter *a=
dapter, u16 addr, u16 flags,
> >                 break;
> >         case I2C_SMBUS_BLOCK_DATA:
> >                 if (read_write =3D=3D I2C_SMBUS_READ) {
> > +                       u8 count =3D 0;
> > +
> > +                       /*
> > +                        * SMBus 2.0 section 6.5.7 block read in one I2=
C
> > +                        * transaction:
> > +                        *
> > +                        *   S Addr+Wr A Reg A Sr Addr+Rd A Count A Dat=
a... P
> > +                        *
> > +                        * The count is read separately and validated
> > +                        * before sizing the data read so a misbehaving
> > +                        * slave cannot drive a write past data->block[=
].
> > +                        */
> >                         ret =3D ft260_smbus_write(dev, addr, cmd, NULL,=
 0,
> >                                                 FT260_FLAG_START);
> >                         if (ret)
> >                                 goto smbus_exit;
> >
> > -                       ret =3D ft260_i2c_read(dev, addr, data->block,
> > -                                            data->block[0] + 1,
> > -                                            FT260_FLAG_START_STOP_REPE=
ATED);
> > +                       ret =3D ft260_i2c_read(dev, addr, &count, 1,
> > +                                            FT260_FLAG_START_REPEATED)=
;
> > +                       if (ret)
> > +                               goto smbus_exit;
> > +
> > +                       if (count =3D=3D 0 || count > I2C_SMBUS_BLOCK_M=
AX) {
> > +                               hid_warn(hdev,
> > +                                        "smbus block read: invalid cou=
nt %u from slave 0x%02x\n",
> > +                                        count, addr);
> > +                               ft260_i2c_reset(hdev);
> > +                               ret =3D -EPROTO;
> > +                               goto smbus_exit;
> > +                       }
> > +
> > +                       data->block[0] =3D count;
> > +
> > +                       ret =3D ft260_i2c_read(dev, addr, data->block +=
 1,
> > +                                            count, FT260_FLAG_STOP);
> >                 } else {
> >                         ret =3D ft260_smbus_write(dev, addr, cmd, data-=
>block,
> >                                                 data->block[0] + 1,
> >
> > base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
> > --
> > 2.54.0
> >
