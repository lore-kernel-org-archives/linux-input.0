Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609067;
	b=FNbFWkotZPqSVz0IRAjefLpN5emLYx9wRPQyap3llCy6njKGbEOVUZZzN0fZKOPxjLgC
	 3L86sa+RZVASEcQS0WFzobjmYNyaOGRUELPrr5E8WSDJRXsdhJktyJ6eE4QEFOI0hykYT
	 zNw63wuL8If8Rpq6Ceqh3i8DrG2ueP6j7v0D5jhdbqH2XkhJ4RmiHvLk3oiBqwtxGoCxx
	 LsiKBEBRRZHIuWt5wE9z+koQYRdbYkP2epN7V6UKQJBS1xQW6ZWdxTSStiZbv/SltJ7MG
	 LYAcD+erjQ6DPZk58q+tVoP9/ovSdgGgNsd4M/Wjgp4ZIPuaYFQ0LuJPnEwvymigkwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
	b=OIryxKuhPEVp7z/8FmGjiaT+nwZOTW1DKU+wsGRJV9EdVbdupA57gZbouvO6FpnglGdo
	 1/j8OtD/Rl7RVVD4Os28w5WsJuaHg+EKSG7WsX0hvYwv1C+Tt+l9lDS5le6mUD2f/UoCq
	 joVYXPcnwZj14AQ0OmsUImuneK/6Lzb3TgXSmlsSmr+syRX2uANncWr0OxfE4w3U6Hx1g
	 Q30a98tojhVXUdMI0XAxcKy3Yq/KdjNba2r9VohEsmRDamW36emcOvEvFlWGYcvMh9Ryx
	 NIClpmmoxXe34tHZ6NfFrxt9Szyp97n9AFkzsFea9PGQbtEyPei9b96udd6o7spngOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kjGOALsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59079606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 18:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59079606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kjGOALsu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91b8b456dbeso11035876d6.2
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 11:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609065; cv=none;
        d=google.com; s=arc-20260327;
        b=p70mVPgfcjL1vmB2ASbJAyPl0dDF34BIqti0d6Nrl33ekPI+Go8JAt7sAnTnugvnul
         V5MuS/W6mO6MkpOLur+602+iz53pOcqNOt3msSCDBFkyaELk/tTNid7tmcdiPE1e6CZw
         HGCxp8JxsofaKTdAmPG3Sc9HXDds/N82QK8YoiDKcOm1my6lzV0H2sIsrjy/98InmSul
         QObbnODaLyYbEI6GBoR15IHJbeoWqMccX1Y/sjVaHhmn/tKAN7EhM7g6rxYJZ4H4cvl3
         uKKY2nuRgDnVfFgkuwWE4XSJsUeVuypJcliiH12p9yqY9tULRUGtwgA7ud2xy+10uG6b
         4JUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
        fh=1xL8+BLVymr8jfZfdnC5WNnDwjFVZWwBT30SL5GJ97w=;
        b=KZYm8/yaioVDWWGaqqBeNyQ/3Ntbv/Arkl9aYQ4n+4DU3s6n4Xx/chUZxzun1CvRlR
         Ww6UqaqNw3Gom5qXab6Z9k5K6lSDJoaGYXPN66OCwWPdojnT98PseTOoIWUitYtiHrxR
         DMoWRi5fcQ0uGLt+keVR6d5HxKulnxnbP8Wjs+l3BZxO07bwI/+IZtPpVbDrl0A8QgRt
         dNr0R4G0xE7pscJjy7/wz9i3Q4H1RO6RRK6YmGekb3Mre9PQCKjyl06nFsxCm3+G8Xz0
         0VaxuZ2dgB+eLZ00D6v05u3j8pWhiXOnMw05xXQ03EEDT3ksehzVi+lGJnCM6dT8OW6j
         h/OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609065; x=1793213865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
        b=kjGOALsuRc96u0lbbBCHd+t/kSgHPs10UzG2JjaWN0A0JRVmmpjP+hr1FELaqqlIkc
         a2VxPzU2BjzlRqvebHagLCCoTnlxIn+hRgVkVnmFUg6+KB9wRNBijyH9EWOdT1eWUHFi
         d2sNdW29OMq6hggPg6S1bQUzcW+Vjgdb3ckPTvd70RuODMYSEtZl/s48Wcs2JBQh3yWB
         AgmJwDXmuUPTMUinlm4I1FkxrxxrFyCqgZkRfF6ArqcIIVz7T+pl7eNLSdvLk0RE6o6f
         k1KLciec+Qjw4Ope+zrjrSrXqtLdsmJX4PUgPOZAjf3vCcPQduHNzs7t31mMdnaf8Jwl
         e12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609065; x=1793213865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyL9llcsal4SOiVQ33XFom8NGFxfymW1uiK43kazgp4=;
        b=x3r3k1n9U7M3IBQemApT9PmKhUm2P+LB5afW6l7txCARRB89JCQiSkAViVCgZ7ZJEv
         gzosnugN9VYS3F/LY02W3xC1T5vR5gvdlESpltOZQvKLypNzEFqDOeC8hxpJ8Fm3+gFp
         lLwEkWNIgSzh6GtKw50wVyuxcfr+XHSFHuTCGcm8Mvgo0q7LHUaC9ZT1LJHXecbkm9/v
         Q3h11A7kfskCHq8NlrHzeBYL2fG7CZogcTaJn5L9Dcs7KVocK51eEz83NKrpCDYtuwqA
         sXkgUXP9XHRAKvuax+FaozwAHSCF9DTG3oE8yuIAOo7wpp4K1i7S7SqDftL0QiXMvDXz
         JYvA==
X-Forwarded-Encrypted: i=1; AKwUvBwLG0u2Y/ELMds8fkazqENP3kg8MmHtFK3kPNswzrHPm0mIm4ubqLCB8eEt18Y6lB07baQnIus+seJhcg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIxHWwP7QRd2tvED9beVqAES5YoKOvzhhUgBBlNL44y9PkhYSYA
	24uN7UQozbQua16FrykBAevvX6fvvrzmZ4Ug3390gP43pGc/MMfAWzVPWgikastDpJqDnC8Aqn4
	8NDRSMeMbPSD80FPaSJEFHTtOHQeAGfw=
X-Gm-Gg: AYBFou3cD4rc2cf6o2xoZAnBKxbmS6E0YxVFRZdNsJfERdxzwGN6kqg5BuZFkOlu0X7
	L+P+jt8iL74QnwnuNXEt1MUzdplunnHYhAtD6zKZ3QlfFEiarztYTGmJxD1AgwckJRT1H5rr4Ps
	nb84A1KMpwULx/Usu/s2Ff2w37dyaYUvXyaUzSQQcbi86XiQ09EFRnTx/2IeRmWCxKJqimRiPGp
	olBjxQk3UmCIwf2qzUwALACZhnrjA9KNbIzCLv21PXNLj8H3rOILxrsKD0n0D5ptGjOfm3ZoBRg
	wSmRrVelJHLvpWd0Dd+tRMGXurO9TX3qxuRoTseS80vM80bRIevxla/iZcpDy7KJPMkyZcUKmnp
	gyf9VWvGBk3Curh9J2/9DmBvH4mhslwNabO4f
X-Received: by 2002:a05:6214:2026:b0:91b:5d3a:4fcc with SMTP id
 6a1803df08f44-91c12f57cd8mr50541036d6.57.1792609065159; Wed, 21 Oct 2026
 11:57:45 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261018124755.850888-1-jinmo44.yang@gmail.com> <20261018124755.850888-6-jinmo44.yang@gmail.com>
In-Reply-To: <20261018124755.850888-6-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 21 Oct 2026 11:57:34 -0700
X-Gm-Features: AclHuK_ejuCq64puYEyVI0F5dBdnGQ6uXcliBiinZhl_jRQ73tHCVePIfkfF6W8
Message-ID: <CANRwn3Sw1r6PWqZVynBdtqDC=T6SjF86y9VcNM7WYBhhX0LyJA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] HID: wacom: add NULL input guards to Bamboo
 touch/button handlers
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:51=E2=80=AFAM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_bpt_touch() dereferences both touch_input and pad_input.
> wacom_bpt3_touch_msg() dereferences touch_input.
> wacom_bpt3_button_msg() dereferences pad_input.
>
> All three can be NULL when the corresponding
> wacom_setup_{touch,pad}_input_capabilities() returns -ENODEV during a
> successful probe. Add per-function guards.
>

Seems reasonable to also add a check in wacom_bpt_pen(), even if (in
its current state) a null pen_input is not possible for these devices.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



> Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
> Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD de=
vice_type")
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> ---
>  drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index e0bf03123cf9..a34db1505625 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3151,6 +3151,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom=
)
>         if (data[0] !=3D 0x02)
>             return 0;
>
> +       if (!input || !pad_input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: input is NULL\n", __func__);
> +               return 0;
> +       }
> +
>         for (i =3D 0; i < 2; i++) {
>                 int offset =3D (data[1] & 0x80) ? (8 * i) : (9 * i);
>                 bool touch =3D report_touch_events(wacom)
> @@ -3185,8 +3191,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac =
*wacom, unsigned char *data)
>  {
>         struct wacom_features *features =3D &wacom->features;
>         struct input_dev *input =3D wacom->touch_input;
> -       bool touch =3D data[1] & 0x80;
> -       int slot =3D input_mt_get_slot_by_key(input, data[0]);
> +       bool touch;
> +       int slot;
> +
> +       if (!input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: touch_input is NULL\n", __func__);
> +               return;
> +       }
> +
> +       touch =3D data[1] & 0x80;
> +       slot =3D input_mt_get_slot_by_key(input, data[0]);
>
>         if (slot < 0)
>                 return;
> @@ -3229,6 +3244,12 @@ static void wacom_bpt3_button_msg(struct wacom_wac=
 *wacom, unsigned char *data)
>         struct input_dev *input =3D wacom->pad_input;
>         struct wacom_features *features =3D &wacom->features;
>
> +       if (!input) {
> +               dev_warn_once(&container_of(wacom, struct wacom, wacom_wa=
c)->hdev->dev,
> +                             "%s: pad_input is NULL\n", __func__);
> +               return;
> +       }
> +
>         if (features->type =3D=3D INTUOSHT || features->type =3D=3D INTUO=
SHT2) {
>                 input_report_key(input, BTN_LEFT, (data[1] & 0x02) !=3D 0=
);
>                 input_report_key(input, BTN_BACK, (data[1] & 0x08) !=3D 0=
);
> --
> 2.53.0
>
>
