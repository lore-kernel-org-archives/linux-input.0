Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793715041;
	b=Qr5aLOrZP6UbrgCB3z1tKJvZi5wdPn/IW2boI0ccSts2BjS0aYTy5xoimuTZ2FlfPug5
	 LMTnYgS93/kYYOcoADCuAFUMORw7/CdLlADFpB50qiDmXIEsTbCS6j0zHIrLi55XFvuL4
	 JHxmxOP7grkstjoQunQ7cZcTGpye50m8ta9WbDwV7GKQ6I9hAle7iEsOEIeZM6UguDu5d
	 nPC17Den4uFi5nZQldjC++dwYIQQwS9/l6NH2zhbE1qnkLwwNcXMAmoEO85pD22NqgYSl
	 6uATp39I/GO4xy/l4FT2QOs7+UJcVLdJCtd4Th005lIxUQtMqRcOL+SINyzaMTtzXMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uPtZiAuMvsQ4xj67j+wg/mIOE4N8PxgJKIgehU/HgNU=;
	b=Vo+S/+DeO6U8mF0tyMOJb2hRYzjMZgTpdtDVlfdBKCPRzHi7oViJKc354WUJnmXS/9u5
	 Xj1m3lb1ZuGz/s2kDqW1nrNgfBKDoKYVw+z/O97K/2Vmq2bVN3gytyl1G8CeL4+Sgs6dX
	 UHNbBpoqFvIas0ivBA4iMz4dbKH0AxzunSgP5ZfUL3I0ptjRKwZLGrge9qqlHsWVPg5bS
	 SNVOqZde2vxr+GPC8Lla+uGZ1XVAFY/TGW2HhBH3Av09cmKdTPgtcFWCAV1YyJv06myvU
	 t2YJ+GkquIDeY63Kic3KWjttX72j28CCs9xQuKjmJ2gn/X6jwlrj3JGNumt8cQrhKJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhbLGUia;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C698606A324
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C698606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhbLGUia
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e83d2cc8a2so8961405ad.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 06:10:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793715040; cv=none;
        d=google.com; s=arc-20260327;
        b=G174+6yetjHgYqN0CR3yV2/GJv6/ykCyRKDxAxKqkY52u/w3Gzh+tTZ2/LTKc5VFVl
         kL7rCbuva427YMtKhaY8fmH9T8DT9eMpyZuKw8JID8tzPxIdvQb8ALuM96REM37zmRg8
         JSbC3sUR1iuolbAuIB3s8SC17oAWoRslnNbgjtBt5+475gf8mOtUOv05Z82FI2qaEgCd
         4jItwKpBiKfygyiw8o5SnWu4HuzdygGR7C1PJeatwKZWb6i2qirJv5QPWfe5Iro9uinX
         N2tQqm359bKk0iZTehv1XizFiBi5naNXs+yBhq/cRQE+kVRH3y6UdcLL6d2Jl5O1Er9Y
         GdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uPtZiAuMvsQ4xj67j+wg/mIOE4N8PxgJKIgehU/HgNU=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=nb1k1Q/Sor8gNVKKyR+X/A9pTYfI3CHscpqCG8uiuVFUDd3ZRJtAgJEVei5s3IQVZy
         /0shES6siWEwScyKaPNkk2Czhzn6e3fiX8IP8anRIR6qvqHslpKZwGmHx42pFwq4gDob
         lXRriB2HOl+inhp1qG5DFAKmmbuffFxdUcPHhI+4bQRIaKXk1HYye+Z0wW9dWJ8TO59g
         2i9g4eC70GzbE74irK8rz516G4hKn5nWZpr1a89iyV0M+oCihbBIMba4dOuyP+krgtWv
         BKfgoN5elzOI6KdUSD6b8dK/spa6P3JJ4aKgaHXL9FRxVwFHtCgXrHwnfbuaYwImB1cI
         P+KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793715040; x=1794319840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uPtZiAuMvsQ4xj67j+wg/mIOE4N8PxgJKIgehU/HgNU=;
        b=NhbLGUialYWs4Y1CdyCdn+s8oKi+U8QGxdX3eX4/8T6GIeAuvFJLVaxIxFUvU6r3OZ
         7MdBlKHtoSW1kRLyYz51Lur+fvPyBM2v0FFuwCrwS8++GW9xZcPX3YneXXo1IIA3WBR8
         3eTw3CauU73MVWRvnaRhvTx14ZHdDFklSA9aUtprUIHkOiu/4GfKpKpRwY1zuz4h59yH
         U6sptna4WZO9HFvBdk/IyisJfPx7e1/hP/m3XWct2tRj65DVllrD9hffcfN6LndpzjuG
         VwLicQ2/xpixnu7uMFauk5hnXEB232C0LsTwRYV/PFtvpxOt2SYXZfpoZpQP/3/nLMc+
         Gb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715040; x=1794319840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uPtZiAuMvsQ4xj67j+wg/mIOE4N8PxgJKIgehU/HgNU=;
        b=eOTxxB3ET6Ibjpqal6flSGhI0U5Q8/q3eWgm4mP5bhEkH5cNaF6rm32fvjRu32Qzc3
         08FK41s/Kc8inCjrSZMO3lud/oNtaSP2t5pmBDUA81vVQCwhPAF3QWVO3jRxorYU39JS
         DowtywWoQaDq36Sr2xSaTyw7svw5O/aL103Y3cGTQkFXFayPiByey9O1VRQAF2PGhlDZ
         u9BUwo41lwehpSjqs3XujY0tzbLrIc4/Uhic7NseSMB54Pq2C+5Q0oqQBWWuwvqD3WXU
         o1D3dJag6nUuAkQF9MzoR6XOtC/tJ4y90Ts9ywlUWbmudRH+uljaaL/trDEJgF7cohOl
         Vw9w==
X-Gm-Message-State: APuU4Z9QF1mLyQ5V+7Uc9N8zIZhU+p81DIrwV4PbmMwOjeCTY1EQVSf2
	l/2M9oCzuGmh9rciLRInhrzmDplVdYKhyAnDJEXp5MK/cQ7xDLog6zMSLqWy7vzk+NmGf9zpPMw
	XXs6ZshVROTGIa6aEtfdLcf/UtnYxwFqH4uD9O3QeMQ==
X-Gm-Gg: AYBFou1UcvqbRQ3i4RFSvadByegrjEv/PItIqjNiY3ACjw3GB9gGL9tYCptBvkBkiIW
	fHssCevUqlpDIZj6ZEwuuW5cI8eTAU90uqX1c+pN6Gh9Kbtk+CyzjPyiolc9V5Oebtdc2tWWAcO
	SM/S5VI6D2nH//wXvvggKRywNowbUW9C8NV4SWuZQCKuwTTntxkzWp/r4kMJWmsF8qnLNfbBGuc
	42qQzPdfd6O6ii+HjZRp+06ShwKp0fNlYtx+nTIj6YyKk13CQdSJGGJZhPy0Ln/BJKpp9G23tkv
	cyeEET82a80N4pVFJUVefJTwldGiW11Lge54BynbPAmGu6Vaa6DQq1UyK1Ge8SHvxDQfEya7rmX
	fvK4yiPNOXDcpNo4sS8cr5wAgI0+NNOsEzDMtnQ==
X-Received: by 2002:a17:903:1ace:b0:2e9:5c29:9955 with SMTP id
 d9443c01a7336-2eb3644fa3bmr219840055ad.4.1793715040482; Tue, 03 Nov 2026
 06:10:40 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
 <20261103131127.1585884-3-lui2012qwq@gmail.com> <sashiko-outbox-195329@kernel.org>
In-Reply-To: <sashiko-outbox-195329@kernel.org>
From: cy l <lui2012qwq@gmail.com>
Date: Tue, 3 Nov 2026 22:10:27 +0800
X-Gm-Features: AclHuK-nHRxg_AwMHq-9Y9sHupz6dUc2DZ1jKWeWqrReY7GXWkzAgdYuxCKe-lo
Message-ID: <CAE=Q7=5eUPmNevwqQuFQBDTni5MRk=9nPkd4pPXqoWOoi7Gy+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: cyapa - clamp SMBus block reads to the
 caller's buffer
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, correct. The masking predates the clamp (the out: "ret > 0 ?
len : ret" convention), but it sits in the same length semantics, so
v2 handles it: both branches now fail short reads with -EIO (group
branch: ret < len; indexed loop: ret < chunk). rmi4 (patch 1/2) is
unaffected: rmi_smb_read_block() zeroes the caller's buffer upfront,
so a short read leaves zeros, not stack garbage.

On Tue, Nov 3, 2026 at 9:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Input: cyapa - cyapa_smbus_read_block() returns full len on shor=
t block reads
> --
>
> commit 17f2cef41b86752525f835330272cc728242a63c
> Author: Chengyu Liu <lui2012qwq@gmail.com>
>
> Input: cyapa - clamp SMBus block reads to the caller's buffer
>
> This commit bounces SMBus block reads in cyapa_smbus_read_block() through
> a temporary I2C_SMBUS_BLOCK_MAX buffer and clamps the copy size to the
> caller's requested length to prevent buffer overruns.
>
> > diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cya=
pa_gen3.c
> > index fc3fb954523b7..cd80ae51f4e52 100644
> > --- a/drivers/input/mouse/cyapa_gen3.c
> > +++ b/drivers/input/mouse/cyapa_gen3.c
> > @@ -254,20 +254,30 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyap=
a, u8 cmd, size_t len,
> >               return -EINVAL;
> >
> >       if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
> > +             u8 tmp[I2C_SMBUS_BLOCK_MAX];
> > +
> >               /* read specific block registers command. */
> >               smbus_cmd =3D SMBUS_ENCODE_RW(cmd, SMBUS_READ);
> > -             ret =3D i2c_smbus_read_block_data(client, smbus_cmd, valu=
es);
> > +             ret =3D i2c_smbus_read_block_data(client, smbus_cmd, tmp)=
;
> > +             if (ret > 0)
> > +                     /* never trust the device-provided count */
> > +                     memcpy(values, tmp, min_t(size_t, ret, len));
> >               goto out;
> >       }
> >
> >       ret =3D 0;
> >       for (index =3D 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
> > +             u8 tmp[I2C_SMBUS_BLOCK_MAX];
> > +             size_t chunk =3D min_t(size_t, len - index * I2C_SMBUS_BL=
OCK_MAX,
> > +                                  I2C_SMBUS_BLOCK_MAX);
> > +
> >               smbus_cmd =3D SMBUS_ENCODE_IDX(cmd, index);
> >               smbus_cmd =3D SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
> >               buf =3D values + I2C_SMBUS_BLOCK_MAX * index;
> > -             ret =3D i2c_smbus_read_block_data(client, smbus_cmd, buf)=
;
> > +             ret =3D i2c_smbus_read_block_data(client, smbus_cmd, tmp)=
;
> >               if (ret < 0)
> >                       goto out;
> > +             memcpy(buf, tmp, min_t(size_t, ret, chunk));
> >       }
>
> [Severity: High]
> What happens in cyapa_smbus_read_block() if the device returns a short bl=
ock
> count where 0 < ret < len (or 0 <=3D ret < chunk in the indexed loop)?
>
> Both branches copy only ret bytes into values or buf, leaving the remaind=
er
> of the caller's buffer untouched, and then jump to out:
>
> drivers/input/mouse/cyapa_gen3.c:cyapa_smbus_read_block() {
>         ...
> out:
>         return ret > 0 ? len : ret;
> }
>
> Because cyapa_smbus_read_block() still returns the full requested len whe=
never
> the last i2c_smbus_read_block_data() call returned a positive count, call=
ers
> that pass uninitialized stack buffers and check for a full read cannot de=
tect
> the short read:
>
> drivers/input/mouse/cyapa_gen3.c:cyapa_gen3_get_query_data() {
>         u8 query_data[QUERY_DATA_SIZE];
>         int ret;
>
>         /* query dataabda has 27 bytes */
>         ret =3D cyapa_read_block(cyapa, CYAPA_CMD_GROUP_QUERY, query_data=
);
>         if (ret !=3D QUERY_DATA_SIZE)
>                 return (ret < 0) ? ret : -EIO;
>         ...
> }
>
> drivers/input/mouse/cyapa_gen3.c:cyapa_gen3_irq_handler() {
>         struct cyapa_reg_data data;
>         int ret;
>
>         ret =3D cyapa_read_block(cyapa, CYAPA_CMD_GROUP_DATA, (u8 *)&data=
);
>         if (ret !=3D sizeof(data)) {
>                 dev_err(dev, "failed to read report data, (%d)\n", ret);
>                 return -EINVAL;
>         }
>         ...
> }
>
> Wouldn't a device returning fewer bytes than requested cause
> cyapa_gen3_get_query_data(), cyapa_gen3_irq_handler(),
> cyapa_gen3_try_poll_handler(), and cyapa_get_state() to consume uninitial=
ized
> stack memory in query_data, data, and status (and expose uninitialized by=
tes
> from query_data via the product_id and firmware_version sysfs attributes)=
?
> Should cyapa_smbus_read_block() return an error such as -EIO when ret < l=
en
> in the group-read branch or ret < chunk in the indexed loop?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103131127.15=
85884-1-lui2012qwq@gmail.com?part=3D2
