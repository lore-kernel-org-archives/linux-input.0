Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990788;
	b=lLYgJJZd//yjsHdiVOqvjdKILjn1aLIrVjP1/sm8VznfH/xgwJrcnueufuaWQ5sXdga1
	 FRJcVeJViwbAjuplX6WxAv2WuZIdPsICqIMcl7CV/9kLkRBhXPKuF4uJlmwF9xlM4loSs
	 PNvaSh6L85IuakIpf6cTysoXpnp8KtzYWIA1b52CXBCXKQPJOI4Um4qrFBVfmFcrXZy64
	 AOO+MqkHcwJN8B/mE+pQA9TNV/Fg1nu/gyQWzLffl9cXPDIdLxRbqUGwBow8qm9/WWpMi
	 tTB/tdlaMz/SlWxr7NYaady1byGMO7YItSHAHp6Sf9PS+O72hsUt+yXMQle5BTHLB0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
	b=3vCPEis1ZZ23sbIryKUeHTlj5vIoAp42xZoDJyQQaLFZo7NDYQXFx0dU73Ud1DKXQV/E
	 dZ+sbjoplKWHrJi7RIQKornUwKyRH7QcZrP6QvURDrrx2+ryV0SSz1TUcNFWp3kZTZbUA
	 CnEcUTiPrVN6FzWqSy4O1RSKopuw9dWtUv7fgloM6zbIucdRQRnEFK9PpNZG3a3XqvDQd
	 9q0QEOeUe1r2dvdA1TdR3H7d0Yl4Im20dp2b3GTELfPMcNnbDoVFalzMJrUFthfx5BPhI
	 r31QV6SzppZsvGW49EgN2veEvUE/fwEN9ZnieDit7QEDZV/ZGR++is8HCm/5MgmMHSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9HC86ZS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507A606A32D
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 18:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8507A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9HC86ZS
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f2f2edb19so93082285a.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 10:46:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793990786; cv=none;
        d=google.com; s=arc-20260327;
        b=Qsy4cwuOeSQaVSHPIYT9lfgbDdtAzxawxB7v6W8wFJhgXU7WqSDwPcK6ryMXiLzW8k
         VAFXAxMIHRh3fH7XJnHrq6L8ZtWJDjq/Kan09djFEA50DU13y6/SF6CCZ+hm8Ro8NW8h
         kEjb6SZkStbyOKZyzJaW4jWXsHL8qDWr0/OFH8gJPZdZA/kIcGN0vzMjuePs477cZH0P
         tznFwkOXYWhqVYeRkFh6yY3p4+twVgQdNXEDIiBe49+viMSKFP+0ZdILUrW2pu66u4t4
         Ra1MtitVQz6WeBHDQQ3IiPIGGupGXJBbIxn+b3LFe0eVF046H+V4cg+QUPHs8rly6C6j
         Ud0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
        fh=/JfsvhwdD2em8mSGYsCjC59MjWbTNFNTnTYg5SCbVYE=;
        b=gK2ez9B+5vdJhW60/N2qkCd+vSk6VwgCIqgMrgqZ0IrXBEXrIU06CAr2im+V12R76U
         orF8pHW1AOfB3oMFRlLZLYNx0N6PFnvL8nVuyoDzMoCWKR2L7wLufwzz6p1I+BVpK0r7
         zVJvUAjAbUYqQLMA71plqpn03GlRHDAeki+1PbJT7L9tVfUQEyyI+VZxC6mhnYe5dRLl
         LA4Ep8cJuVdyxSib/698Skp1eLxsm3Hhp98NRL/pMRsnPLYvrHrSWmaPklufZUB6zH7h
         Yn8RtaSYF76kCOEl7Y3/VGbbFvQ+B2brJ1uhoY7gXKYUubW119rSiJ/lydCrM1+Lr6TM
         9bfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990786; x=1794595586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
        b=Z9HC86ZSkUDNPhx/CjWi/SScFfOIPSHSo7vMWUh+XGsATmPW8BWEkCM6bOCgqO0Are
         20V/CwD73gFN96nZWlmqysgtlzg+CXzInQPANKnmNePAw2GtNLcDs57tXNMHpd95fp4K
         m5pRi6yR71ZCllopH7Ng9CmRbPV0moMMBHJ3IgZrdANixqOan7PwN+ZUAYblo01OJz/D
         mrnxC/fS0LoYFk0xfk8L5+mFtw8CSkAJi36Nr/tAeEtHUIaHNZA/EKAYiXYe2yn97+vP
         vY53r76H67QgodzNEezlF9MB/G0k/L8R1rgP+HWHFLFuJsYq4T4nDQNrbBQXwxpN0NTc
         +qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990786; x=1794595586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oEn7bwxlp6JtTrktDXtiT+wX7H9tzS76+9SrUUaKcg0=;
        b=ihD8wbmYw6y2RMVFIsabFxSMc3iIGG3zUPCoNzUjXh3I6DRRnssatMYkLakjTpkJT8
         dYdDEgPYtmdTJI/Ym2ox8KPlpA2Zah5yLPSPwxJ4wdR/wwEPDWOUgbZwW1lNoRbg80Aq
         YLZ1qAz/yU650p/8CmRs7XLx2owrMU3wJvuoAAiX1dVBunQ0Ov+KLHwS8Qx0mJEqzeiw
         YYc7Gr5nbAkGrGm4QTh4i+Lw+SzUDnQwpzrr0bsnUVMesFG/ByLw2R2HJzIpSg0beqNf
         ohReHpFHSg4R31F2mBzk9JLK594nhwbCqk2DrTgiAD3pzFn80tbEdZnMeXXEFtCc5kz5
         kJBw==
X-Forwarded-Encrypted: i=1; AKwUvByxKIbHJscxt5n/Eb3FNd/57r1mzvI8riDZB3FwIF13YhJzxA7p5KRgYmXJLBVR9068uZUhiBScusKjNg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qb8d9/YZ8CFyfYKcSgXRFlFe1TI08+0hHcFQ8u8gGLZDr+73g
	McLzf4HtvA1GsMDJVzKlhPJZw21n+F0DR9lgzW2ndhy9OAIJHU8dwk/0HBrusNm6umkCkVK5mO0
	/+FVey1s31cZWD+bYpnlbNglF95LlK90=
X-Gm-Gg: AYBFou3xGM3hksDYNiSDs9VDAO92xJcD3AviRqEKBlnBgmfSxwFd/TGn8aEkWD6XLQh
	vEb8W6MHckcvUYDBIcgk462rWTVHXQYgUAp/jaYoMxC/n+eNFzUQlR50/cGVUBpksJ1TiKx5u0W
	3zDapVbGKd/bB5e3kJThUd+FuzCbLwt1EV9DQhWaG1OapQnHHX2YZXGDCYhCf5WeboTafAh8U8F
	i/ak6dsV3lG5IbPLK28iusHdCeUh/ofEc5gJTfS1aCqmtdniVENbi1Bb8alcfUhi4TLzyU/IkeF
	LOgcRcK+w9REzjJw+D948pyq/U+vl2z1TYazORO4KgMTokCxjRZXCFpOKRsjezjRk02E0S6WC8q
	tYt9WsTHAPt3dyzf3uKrUTlH7eZT9/R3NXy5L
X-Received: by 2002:a05:620a:2b93:b0:942:a42a:78a2 with SMTP id
 af79cd13be357-945f34ead3bmr431647685a.31.1793990786229; Fri, 06 Nov 2026
 10:46:26 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
 <20261106120405.169399-1-qwe.aldo@gmail.com>
In-Reply-To: <20261106120405.169399-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 6 Nov 2026 10:46:14 -0800
X-Gm-Features: AclHuK_mPu4CGKBJY9JOjjdbWKDK_1Mvm3MPelFofXSeQQja0gast3M1vggbj_s
Message-ID: <CANRwn3TtcDdy4wgHCRfzecAoB6m3Jat0kNOd-AYPskg1OA9+Bg@mail.gmail.com>
Subject: Re: [PATCH v4] HID: wacom: avoid divide exception in dropped-packet calculation
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:04=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail.=
com> wrote:
>
> The dropped-packet calculation uses a modulo against sequence_size
> (logical_maximum - logical_minimum + 1).  When a HID descriptor
> declares a sequence field whose logical range spans all 32-bit
> values, sequence_size wraps to zero and the modulo triggers a
> divide exception.
>
> Replace the division-based calculation with a branch that computes
> the forward distance through the sequence range directly, as
> suggested by Jason Gerecke.  This keeps the existing int types and
> avoids the divide-by-zero without any 64-bit arithmetic.
>
> Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 1=
6-bit")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Much happier with this version! Thanks!!

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> ---
>
> Changes in v4:
> - Replace s64 arithmetic with a branch-based helper that computes
>   the forward wrapped distance directly, as suggested by Jason Gerecke.
>   Keeps sequence_number as int; no type changes needed.
>
> Changes in v3:
> - Replace raw s64 modulo with div64_s64()-based remainder to avoid
>   __moddi3 link failure on 32-bit architectures (i386, arm32).
>
> Changes in v2:
> - Normalize logical_maximum/value as unsigned when logical_minimum >=3D 0=
,
>   matching HID parser signedness. Store sequence state as s64.
>
>  drivers/hid/wacom_wac.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 361738b..1d3ae94 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2426,6 +2426,13 @@ static void wacom_wac_pen_usage_mapping(struct hid=
_device *hdev,
>         }
>  }
>
> +static int wacom_hid_wrapped_dist(int after, int before, int min, int ma=
x)
> +{
> +       if (after >=3D before)
> +               return after - before;
> +       return (max - before) + (after - min) + 1;
> +}
> +
>  static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_fiel=
d *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> @@ -2551,8 +2558,11 @@ static void wacom_wac_pen_event(struct hid_device =
*hdev, struct hid_field *field
>         case WACOM_HID_WD_SEQUENCENUMBER:
>                 if (wacom_wac->hid_data.sequence_number !=3D value &&
>                     wacom_wac->hid_data.sequence_number >=3D 0) {
> -                       int sequence_size =3D field->logical_maximum - fi=
eld->logical_minimum + 1;
> -                       int drop_count =3D (value - wacom_wac->hid_data.s=
equence_number) % sequence_size;
> +                       int drop_count =3D wacom_hid_wrapped_dist(
> +                               value,
> +                               wacom_wac->hid_data.sequence_number,
> +                               field->logical_minimum,
> +                               field->logical_maximum);
>                         hid_warn(hdev, "Dropped %d packets", drop_count);
>                 }
>                 wacom_wac->hid_data.sequence_number =3D value + 1;
> --
> 2.53.0
>
