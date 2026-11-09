Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247938;
	b=HSRwpBsakSbxGJFGf7M+nGCjBX6ux6jT102kRT+UtN36Q8GDCSf8XpZhj/gRi+fEOGLv
	 hv9Fj46c3rhoFQFnxVLDvawoIoT4TGB3Qv9KF2OTcq/bUeDuuYiPcbE3zozVtU6KbviEM
	 Ydrbj7pPuTNhp6NJlTU7eLwe/GtObc1gIx4bmasp012gN4kzQzXqVXzkWBmOhpFkItIdg
	 Rc6wluvojbx3Le9GMxlP93usKy8vbOCJEufvtvA+QSWLKOWmn363TlcU7+Btj4ZySLP3q
	 aY0FHak1e628InFpoqtnDac+sgoyfi3A3WXzUdzwb2QIXi2hDGHtv4d7tldOlN1CJKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
	b=3uhXfR+i39qieymdvCoIueLTM3yILBUCaaXOa/R3HvfOUtOFkaDqoymcq0l3C9PbT4vG
	 kTLmzGmufJBdG4Mm1rQ7bQ+X4oJzGrpYgLBe3i1FKmWVsQVDEYVhmDww1W2oH16xjNjp2
	 Ce3krd5HwHI+DP+VFvcFdSMNjDFjSDtDeZo1hkaHDj3m/b2w+804jXv0IFW81MHsm0l7R
	 wtHmh5cSpudDoPCuMCjE+liWdyZhs/pf1HWraTXVXLjhwbLBkZvdtzhorDA81StDQakY1
	 USZjNVs2uasnYD/lsvpL8HjRBY/QaVHsStopxjRmn/xOcIWsVFh2wxr7XIdtxbGB9wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYFkyAo2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A64606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 18:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A64606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jYFkyAo2
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5495d549924so12243421cf.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 10:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794247937; cv=none;
        d=google.com; s=arc-20260327;
        b=RQOMDDoZsqAvLpkHKRAmAlDdDKbT/NAi02Cz85u7KD0LaNHR61+KZhUY+wpi1c1kON
         kfgzMUeni3NsciDnJiSzoIGFNr2fMwO+oa7IQUmoVBgTfpSsJSTWhla3Q40mcor787Zo
         76AWK3/jyB9qRBmO7NXzTtWVC7mPUAA4QSoGpfHY4EZ4kefMbqmG7TBd6I8QpG9LUOzV
         KWWbFbnEh/Ta7c560vzd3BuA9pGhgApHEy8mi4vX3J6NF5S2FftEfaVw1Q6Cqm13nfCV
         PD2l4HgsSbMCzei4ya85hxp1w8tgsKZcWzoJhFgQMWfvKMN644QXAnjpv2Yq2Ay9EvKd
         SY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
        fh=cn8uDmDawJ7CYFnpo0JdVFjrKc9WZ1/BL87INi8JqZw=;
        b=YBzS9iDFIt5i6pkfLgB7GGPpgFHFmOmcdQn3UhFxftjp8I28DP81JkBCw9RBkz6UNm
         py413oflhGTnkB0g7iVGFHTNQOeVhPSxgvNOFVvWW/MnrB1ZChaBc+Yw0Rub1ntqpQa0
         LbXNxMGR+Fbfhtdcz6SS5LEHGwpkTSS3OjSyR5R2Euk0Sz89ONxJIXpVN5X2abE/sjmY
         8BZHM2F8y2MI5g4H6H8Wcgy5PTr8Yo0xppMLlT6ZJluBMwKobd69gksiAgHqln2BiVKz
         BqxlmuAdJCELciHcjL6C5t1UBYHUUINLHfiPI5Q/WtcRBL5qrqIuoSSS710ICQ6ww9x2
         CT1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794247937; x=1794852737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
        b=jYFkyAo2Kyv2q9G/ATbzjr2YhaIdcEZRAXQnEn6SRzTaE9eL4W/QVLk5jZ5iVUllLh
         sYQpHzdVFPcAeb7sNiviahcxwgzZqBYK3Dttm0ze5X/GLlwEO3MVErU7GpImiwh6V14M
         0sG6ZP5EYXHy4zMDL4TLnqC78Qk2iCOnbM8uBRjli+FCmeYoTKhrKmtbXH7nDSBDaLlc
         08F+Jf22vhVTOO062d+btL/der7gis/haSuX2fHGNNwOkqcbzjiWgTbVYroaRAL4f66o
         n7su4+HNqq6ukX1N0EikxdtggPHkmUa2xOgiMRuTdNuqbbpmcy5QQXPA44Ox3LC/lTZe
         F06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247937; x=1794852737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDGAaQ8TMvgUEB9dx62M0e9zR6BoUuJi2I6t8Mao9/4=;
        b=2QbcKtivvoNXcyR31X7LPhhuK2Y/SJ/bAZMq2mC1Fxscmys1t03EwZFkME0R0JZDk7
         fSmSbEo8j9eWjEM0cee6TFOMxp3YSZJG74wAcYy+BSE1OJXJeCoK/yCQgl1z2/ddkoGg
         mrkT2DnAZLcEKYcAD4O2Nd/B+8lQQKK6pa2q2lZL4gvNNslASx/tg5s+Cdf86htcTzxG
         gugYuBF3eTbh2agz6qpqgdF/MsHLBChMqLMyBy+yJjl6mhN1TjslF6WOyJ1+Y2wCVpWw
         DyCVY6FDUYldgXifgvFW9o2p8PTe+udywkSplaPx9KaWcVck5PC9c9ATQpsAb257qB+P
         Pddg==
X-Forwarded-Encrypted: i=1; AL+hErHCGOTpFjUQfALbOr4m6S4IR6QsMcGFMalY9FSX0B8IYQEnEVhkKD05M3kaFqpgsA8NMXlryntQLcqz7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9zEVxucPFzXcbHzP0rvbYDR1s5r4aW33+BKQqRudqA1cv8h4mg
	g77bMet+kIkp15pKnDX7JY/QYn1oOBa84PbTOCQgV6zqqOyeT9ENioPEYrKJtkP7Mm3O48qQymt
	6klgwd9H/cADS4s/wa0BsbzZR13HncCU=
X-Gm-Gg: AYBFou1nrlHVagmwL9rInHVf2sdTSq/xUyAs00TEiVWgACjNe0/Tefvq678H79anD82
	Z9z2jWOVDgNMY8HRMElqMQ2SDrCSvri3qPWol1r3wZs1bICQzboHVJWqU5D5rFiQkIpYFxmo5Zl
	ghwBUE/tkD627GZwNmrw0hx9hQSKZal8SCVNV5U6gpvTB4QZxajXyn+LJLKX4LBENmiV2O/Xymh
	9sCoTGpkBSNh1IWVPbkSjkFoJafIq+/fdIJurYlxmEOTwHpDI5/wd70sDdLX7lezvnBqmON7Z83
	kzWIyVY+hhRZGEbNIQkKChJtZ/J1IToeBEhb+wgjFxPpnvD8f46WGzxyrdVRx5DzoY82yUJc37P
	gABG8gqA2dHoAvG7ZoPOTH0AhypzExR36H32u
X-Received: by 2002:ac8:5a49:0:b0:536:6c87:ebdd with SMTP id
 d75a77b69052e-55527133c46mr2041511cf.14.1794247937229; Mon, 09 Nov 2026
 10:12:17 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106213526.3393779-1-qwe.aldo@gmail.com> <20261107012636.1008932-1-qwe.aldo@gmail.com>
In-Reply-To: <20261107012636.1008932-1-qwe.aldo@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Mon, 9 Nov 2026 10:12:05 -0800
X-Gm-Features: AclHuK_GFmi3iEIOGHod7r7_OlLsZDYJCh5KSeGDmqGi69z7Emf7p-xajIEWGmY
Message-ID: <CANRwn3Rt_zT5jwCvgbC1J-V1EUzLKKqDC+aDrgt=y1HkzpzYuQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: wacom: validate battery range before scaling
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:26=E2=80=AFPM Aldo Ariel Panzardo <qwe.aldo@gmail.=
com> wrote:
>
> Battery events divide by the difference between the logical maximum
> and minimum without validating the range.  A malformed HID descriptor
> with equal limits can therefore trigger a divide-by-zero exception.
>
> Move percentage conversion to a helper that rejects non-positive
> ranges and accounts for a nonzero logical minimum.  Clamp the result
> to [0, 100] as an additional safeguard against out-of-range
> percentages.
>
> Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measure=
ments to percentages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

LGTM

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
> - Reword commit message: describe clamp as a defensive safeguard
>   rather than claiming it handles a specific ADC scenario.  The
>   caller already filters out-of-range values.  Code unchanged.
>
> Changes in v3:
> - Drop s64 widening and div64_s64 as requested by Jason Gerecke.
>   Use __s32 range with a <=3D 0 guard instead. Keep the clamping.
>
> Changes in v2:
> - Clamp the computed percentage to [0, 100] instead of returning
>   false, so that slightly out-of-range ADC values do not prevent
>   battery registration or silently drop updates.
>
>  drivers/hid/wacom_wac.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 361738b..36bab07 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1960,6 +1960,16 @@ static void wacom_wac_battery_usage_mapping(struct=
 hid_device *hdev,
>         return;
>  }
>
> +static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32=
 value)
> +{
> +       __s32 range =3D field->logical_maximum - field->logical_minimum;
> +
> +       if (range <=3D 0)
> +               return 0;
> +
> +       return clamp_val((value - field->logical_minimum) * 100 / range, =
0, 100);
> +}
> +
>  static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_=
field *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> @@ -1973,7 +1983,7 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>                         wacom_wac->hid_data.bat_status =3D POWER_SUPPLY_S=
TATUS_UNKNOWN;
>                 }
>                 else {
> -                       value =3D value * 100 / (field->logical_maximum -=
 field->logical_minimum);
> +                       value =3D wacom_wac_battery_percentage(field, val=
ue);
>                         wacom_wac->hid_data.battery_capacity =3D value;
>                         wacom_wac->hid_data.bat_connected =3D 1;
>                         wacom_wac->hid_data.bat_status =3D WACOM_POWER_SU=
PPLY_STATUS_AUTO;
> @@ -1981,7 +1991,7 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>                 wacom_wac->features.quirks |=3D WACOM_QUIRK_BATTERY;
>                 break;
>         case WACOM_HID_WD_BATTERY_LEVEL:
> -               value =3D value * 100 / (field->logical_maximum - field->=
logical_minimum);
> +               value =3D wacom_wac_battery_percentage(field, value);
>                 wacom_wac->hid_data.battery_capacity =3D value;
>                 wacom_wac->hid_data.bat_connected =3D 1;
>                 wacom_wac->hid_data.bat_status =3D WACOM_POWER_SUPPLY_STA=
TUS_AUTO;
> --
> 2.53.0
>
