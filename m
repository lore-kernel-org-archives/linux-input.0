Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DDE488225
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058179; cv=pass; b=LYt19dGh17Xv1GbSeYMZgIV/oKRDRouQRN1QE51xINklpAeTjaqSFiyX0in/LMIALMArBQabAW1D7D77OsPE0mvAw7Wmgf3INY8Y67xhDAvEO/ZfeVH+BSRxcYiNXxwPEZn2uNp55zh0BuTcJW4ZF9xTdET3vcgTwPDhqUu+S7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058179; c=relaxed/simple;
	bh=hSu1JaeVAndUvAhhkiZSL0QmtqqDPtkeyI7Y+YpJ2t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmCKsLzBzJYxHfOHor/hdkadE3qZWPKgmKDgMvLfEVaTnfPI6nazyuimA0QyKUv2qgwUxcV+awV0vsQjoW/DCM2di04LHK0lIiObrK78sQ5xA262i6dYJMPYiht1srZjXpknuCR3tYbRHMq+mkhsIqxMgXca7RtwHg073L9kc44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcXA1JNL; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcXA1JNL"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34ef3so3332213a12.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 23:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790058178; cv=none;
        d=google.com; s=arc-20260327;
        b=pHjuQORbfXcvUdq5ORRjVqyToWI+nDiDfeTm57iEKuPWukFzlOjh+GS44pwIosIkqe
         WiD5wH8DPkf3KBaUTs1GHDGEr+SXDZPQE0arZhkGWhCDq0RxkcOI/R1lPjGtj/PVAKn1
         Z2luZZVZG7g7qszo96gvhO+2DMM38P2bTrsyD4ArpU0rFO/3HS6gtIYvyFag1FkG5JnA
         vpcugblgoNllVdN645rcyZc0SG3pEUJDzTdI/bxC2kR5LCOL/dhSurN+RkXcrT4qToce
         mzr7rhLdb45OGB07co/zXREt3wzMAnpIxhr9pE52ssskoG3YUiy8dTWFK+RvgCfjDeBv
         9IpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlRa/2mN1jPTELIhMBL0D+bQZ9346zjX/6r12JwRWOY=;
        fh=AJQS9oAhSZiGRUles69RFI2i58rG1CkTgwqPPGB8IKs=;
        b=PC9UUM+XzSQjmLFRuQNd1CepQlnrfecTB/gsg0LrJlq4h6u1LjxPga3w1Vl3vD6vqX
         I/yHhP5sQnB/xmkuT7Mu/PLVPo/9f7aA4fgOw5JAJHSEPb8TsAWx4q1BpcLm9rj9CdBZ
         VPGMCCZbuZxsUfZZUrNdUekM5UnNV27awI7YVnxJpZT/9jAaSLGFmWYpIiUgUiYwkI+Z
         NK9bX7RMv/P+gtzgZZ0mZky6CUMu4UGak8SKyweBCGrTE4zGq4wubs4R9HYqFkATv5LS
         31sTWOp0ILeh6Gd8+sUU7rRplnIqmQs+0lJlP6rhf4D0uNiYYQauxVAgjXEDOCd7Ra/+
         ASbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790058178; x=1790662978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BlRa/2mN1jPTELIhMBL0D+bQZ9346zjX/6r12JwRWOY=;
        b=dcXA1JNL+fxKsbQV6PE0pyITEU9Em4HXcYKF+kXE5zYeSw9tK9jUjWRd/hu27r+9hz
         yLds7xbxrHeWDW3Z8EzNT20H2bR1QHebXGPh+25bLtKskcXjaAS8fcbh/XHJYNJbuhc8
         86NtZZVpEoxMVBWoSiMT9dRiE5LtZMhuV4fk9qeiIXgHdxeewo8LLwKKlQKcwj0MrJtg
         jJcqSHkT9O8C2pjpmAsPTO+vqtda1wzGfz23sw5I99gVitvjBfQ9z08Z3mUP+9rjzEJw
         P6oNFt/q1YhB1awhpWMUJnShObXsd/+wl16K8jxMroWyxgIKWid374mcDsjiVGjg/s2E
         qp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790058178; x=1790662978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BlRa/2mN1jPTELIhMBL0D+bQZ9346zjX/6r12JwRWOY=;
        b=cyCkqSx6SNxD5ubh8PeUKAnmFILDbqrQbDTpkn9ceNeuoV0UaJpYRsjU3DEYRwc2Me
         GQdvr6Fo1cdFezGQAPdrE0iLIwDugPZwkDWInOeRAe9UqrjdtuftlIB72p/totonC8t3
         weYD3bA5I5uL1r1N/NXV9OpPuMkBxl2VgmeBT0OdaLV0potMop/DFdSQOGXgbAuimlLN
         e1YsOfrYWqP/JuC4nQkbkQMJSCJ1y1/ZpfjIunvrF5KWlfjfjoOXhvwRMnYaDtci0LRY
         g32orRdn4iEgz4MQ4Uvk/XQNUl2RNfyCqfF+cYeNYE4YVAY3eDnna2uF++tvMcwUpHtI
         WYYA==
X-Forwarded-Encrypted: i=1; AKwUvBz7ibO7pcB6yWz7xZaQQL1H87H255YG71DpvTQCLVw8VNeRH9iXM+O5El/AIeDaeFKpF24y2+TaHGKzdg==@vger.kernel.org
X-Gm-Message-State: AFuF++kDA/OB+ED/kTXNCQH6tehRJU32p4Jkz9NGsjZmZei57LQG1NuU
	s5uJYbOiwABPSyT48aBdaKCgUqmfRKn0ogk83aYPZeIbzqQcUBrLelv0l6rZ1yqSvi4Xc7+waqY
	rAA+Txrz7q0SmICsuLweMM8myLhtbSGM=
X-Gm-Gg: AYBFou2zjUbDwZzvzTrqtC0AzJblSY2SpBE4jaKM3ReZBaSrANl3N2WZu6zA+T+h+5t
	jAG0mTYmTnzzv6rtKaWJEsZ6qgWdVC22nuUJIlPsfgKn97+HWzTEF85zChMAQONTClN7KKU5SjN
	/5OzWJcU/kJvIpQ/gvfSb7KUuXflXA5GEdtPzAadFvVQ11iaiyoMXMmAs9NIpPI8n10gt8yaCGv
	MSTHLOUwoOAiBkevMFYoouyT7gBwY2tRlCThS2yStM/ANw3eZ0t6/2FhyKetFlPVPk4lTvWucyK
	jkUM381RbxHpr7tmb8KJGS6DIxByV0BrjtKfmH6L4liN3tK9nKvhq2gHDfuar/tnQCge8uSuO2i
	NHn6sVCgy6Ib4
X-Received: by 2002:a17:90b:5685:b0:39e:6a82:afd5 with SMTP id
 98e67ed59e1d1-3a0731f4259mr175881a91.39.1790058177750; Mon, 21 Sep 2026
 23:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260921175234.3137985-2-florian.krischer@fkr.dev>
In-Reply-To: <20260921175234.3137985-2-florian.krischer@fkr.dev>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 22 Sep 2026 09:22:46 +0300
X-Gm-Features: AcwNN1ULBI8oVbCxinixK9CqeBUWrSXGHlwss4CieTetvjbU4QPKm0ZMViGeQTk
Message-ID: <CAPVz0n13hNPrZ4NKxindNQRdCbM28kyj0UDSarqzd35DEpny5Q@mail.gmail.com>
Subject: Re: [PATCH v10 fixup 1/2] mfd: asus-transformer-ec: use 8-byte event
 reads on SL101
To: Florian Krischer <florian.krischer@fkr.dev>
Cc: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 20:52 Flor=
ian Krischer <florian.krischer@fkr.dev> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The SL101 embedded controller exposes the event window at 0x6a through
> 8-byte reads. This matches the downstream ASUS SL101 driver, which uses
> an 8-byte SMBus I2C block read for command responses and events.
>
> The generic 32-byte event read used by v10 prevents the physical SL101
> keyboard from completing PS/2 initialization.
>
> Use a variant-specific event read length for the SL101 in both the
> clear-buffer and interrupt paths. Keep the 32-byte entry size for other
> variants.
>
> Tested on an ASUS Eee Pad Slider SL101 with EC firmware SL101-0202.
> With the matching serio fixup, the built-in keyboard completes atkbd
> initialization and works.
>
> Signed-off-by: Florian Krischer <florian.krischer@fkr.dev>
> ---
>  drivers/mfd/asus-transformer-ec.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>

Hello Florian!

Thank you for looking in and testing this series.

> --- a/drivers/mfd/asus-transformer-ec.c
> +++ b/drivers/mfd/asus-transformer-ec.c
> @@ -229,8 +229,18 @@
>         return ret;
>  }
>
> +static size_t asus_ec_read_size(const struct asus_ec_data *ddata)
> +{
> +       /* SL101 firmware exposes an 8-byte event window at 0x6a. */
> +       if (ddata->info->variant =3D=3D ASUSEC_SL101_DOCK)
> +               return 8;
> +
> +       return ASUSEC_ENTRY_SIZE;
> +}
> +

If SL101 needs a different entry size, it can be passed via
asus_ec_chip_info structure and will look much cleaner. I will do that
in the v11. Since this patch is intended to be fold into the series.
You can test v11 and add your Signed-off-by and Tested-by if it works
for you. Will that be acceptable?

>  static void asus_ec_clear_buffer(struct asus_ec_data *ddata)
>  {
> +       size_t read_size =3D asus_ec_read_size(ddata);
>         int ret, retry =3D ASUSEC_RSP_BUFFER_SIZE;
>
>         /*
> @@ -239,8 +249,8 @@
>          */
>         while (retry--) {
>                 ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUS=
EC_READ_BUF,
> -                                                   ASUSEC_ENTRY_SIZE, dd=
ata->ec_buf);
> -               if (ret < ASUSEC_ENTRY_SIZE)
> +                                                   read_size, ddata->ec_=
buf);
> +               if (ret < read_size)
>                         continue;
>
>                 if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
> @@ -318,12 +328,13 @@
>  static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
>  {
>         struct asus_ec_data *ddata =3D dev_id;
> +       size_t read_size =3D asus_ec_read_size(ddata);
>         unsigned long notify_action;
>         int ret;
>
>         ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_=
BUF,
> -                                           ASUSEC_ENTRY_SIZE, ddata->ec_=
buf);
> -       if (ret < ASUSEC_ENTRY_SIZE)
> +                                           read_size, ddata->ec_buf);
> +       if (ret < read_size)
>                 return IRQ_NONE;
>
>         /* Check status byte with ASUSEC_OBF_MASK if data is valid */
> --
