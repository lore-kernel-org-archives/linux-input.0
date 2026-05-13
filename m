Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61C47D95C
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687293; cv=pass; b=HimxPGncbYbwTbpZwkZ5F87kBL9UMIRRrgSkwZ67XSGW8ZvucpFC4kcKdjvRoNifKi00swHl8ek99phqTQRdbIqzbgbqbvW1AHfT1v6aC6uwPuA7v9IvPeUgsGm8URodoNhDjsRN8LdFVrs0mUFHIAxLwGIsEByZJGTXj4b3LI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687293; c=relaxed/simple;
	bh=Qbd60J64k003Aq/VrcEF9ItxsZ2cCsDjKfneevCT3yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/LVLl4xW07f082FOjUkIc3gCFMHLs5PmAQtwsH50Zvnvi9nf5DNK0hO0hR8QjCdGlXJaiWBGsRhGX1AC0gr3T+hQ+HQPFzjYNTOQVfYbnxsJ6A2tOoDQeQg+/zi1lqzmxobUv0rhOmcSMLr6lJs3Hqusn//F62Ow7zWE9gKt+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efYO46KO; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efYO46KO"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd373f83042so241810766b.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778687290; cv=none;
        d=google.com; s=arc-20240605;
        b=YpcLh6DG50I523TBQ5GZeyydEqGCYVLM+/Kr8oTMWlzELHdAudYacsIuHnbbgXY/Fg
         Vb3F7zk71+7iGYL/nNKdKLY9LRlpJD0GoCwA1SfcQYETOevH8V2qmof7JMJLy4e5VSnh
         1pzKuG57oF5Qame1EXOWqzMgzqSW6aQJaHDzFd9Bb7dZjlzG3csbg3A6aKd/mwOSBxxh
         qBmP4HrsifiTAUJvgwz3JLBQs/RX9OiLXVU72PqU8BlPXwUHsYzVjXvmb9h2NzFPSvCw
         PRitRqx4sXuh+0QyHpERDfmFIsY7RgPP9NC0qq2miQQ9hkMQ4rHa7b+TmTIKYgq7a99x
         Zwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8dkachk0WX3eaVF7WmKsff8zgWZXq5GvXzSGAILyzQU=;
        fh=XgrkBubajoGE97NeDWGdMCqPrvmE9Rua1RdTnJ5rDyM=;
        b=evDzWmhB1Ah21w2GBzhJb7YE46ALYlnDfPYcA33UlL6LJCD4Wcni0lplyZGt+lAkCQ
         eDuikJJincTO2NiOpE25upcorLtRxtQXfkWznLNsnLHqc4r1IjWjwuNX6CtVZ23BSSXw
         PlRenmNUUxVUgfqroWiKBc8wToUwFKxZfY6LLNQDEUgHatt0EYpt4RcRnx/u2+SdHaD9
         XCDB00OPnLMpXlwvUs8K32OVmc/xKRSOCTahGo8PAnDKKuUdwcP72oAAWPcuBbL1+wXM
         C9akhGzZ3mEfpVVv+5qHOrHi6sxmmAy1PoczhoZlaBvly+bgLJUSxAhlmEM2/4M/J0d8
         URcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778687290; x=1779292090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dkachk0WX3eaVF7WmKsff8zgWZXq5GvXzSGAILyzQU=;
        b=efYO46KO3K8jARZvNf4heKuBwa18OQ4Oajxi3Vnei3usHeb9kCsp/9PWPRWP45D35C
         enjnsldlU7P0NOFXfqaCu/jU6rsJoXyhJxDa3E8AsazkJY0AMxRmGNJS689dTTbmx8iV
         qL5LxmJbfDJRsRbLHZ4UMLNc8dZTtPcWeQHAPJ/h5yTmEhMEcKl1d5UN6ZCOAJMFM6J2
         uY2ov3hK92nrPuQT3TD5VawndlBK/edo236Z/zdJU7RsXCPPj+y6O4Y8/a65IKiEx36O
         0Z0GTYceZ2XFlzjWd0Y5BTcNtQXoIkOIX1cC22bE4Jja89e95Hh/3trujJC7TyoUGXeL
         zzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687290; x=1779292090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dkachk0WX3eaVF7WmKsff8zgWZXq5GvXzSGAILyzQU=;
        b=basuPli3MHxxPslmz4SCDqU4D2WuulyksV0/YyFVk2KEDqDCIPko9y+mB0AKqukRvo
         zXZFv8KAaX63dBvhViTttxMgQOQgHIVhmV7cY8p2y/EEGwCHAEE1tTKaqucV0iAYJPqI
         SoKZJ72l2CrIvdaVAoB3eqw8riinGgUTPED7Aia40tRi/SW4S97NFGlGZVkO2cB/+R0C
         q0no0vTzZviCuDZ8isIlzIZro53D4XKM0VbA6vMIiQ1r16wrnlrgTI3EFiuxHfyJXSjA
         G3TJgewIhwdN7OdR5Tj0NCmnljiFtgOD4jbiUNk2ihal8jaL2aBvsZ00xjHjzZg1wMCW
         AOJw==
X-Forwarded-Encrypted: i=1; AFNElJ+GOl/QAQbqUi07Ds8iPulz21uadz9OPUJqR53wZ01LdrL3J8mp/+PMmHCCdZNNL4Egr9jpMCkgKxSh9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PE7L3nZGzLT+vIcraIjk8T603EkuN0MF/xz5NcvwWX1GIa6K
	/sYBMdiuZwlhTsXQCeDwzgnYzAdEZSTMg9fYjD497T8rrq1UOeFnpB8mDfR12x0ljZgKZPD6rYA
	PhVXf5jR+3HXLWua341l36Aq5bNRMeAc=
X-Gm-Gg: Acq92OGtRYAovHCiIHAFJkMHDnZf9VVXEtneyV54KeJdY3K+zbLJYdK75nRrOtRSyAb
	0y6N40EY4yp5zkmJrpDF1/53k5BGj9gxR7aLtok170EOeTjQFMwxHhQ39TcC41ZoCJFGMysW5GX
	nx0qPfVuQx0OStjJd1R6BSC8IzY37iGFWb2WeGrLKtk/4J8GkePXglIMdkn23R8VdT4BBT8WyFA
	0N0wUvh4m13WhpUlwpECjoIcGegMvtHP4zEPYHdkHnJqAnYGbY+TeyJJqMbgBYU31EyVuU/SFEK
	ShSZD3tJPtLoxbF1E3Kx4Ne8HCa7LqQh55Zza6Rs9w==
X-Received: by 2002:a17:907:744:b0:bcd:c899:904e with SMTP id
 a640c23a62f3a-bd3bf484874mr249895566b.7.1778687290382; Wed, 13 May 2026
 08:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513075935.1715836-1-lee@kernel.org>
In-Reply-To: <20260513075935.1715836-1-lee@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Wed, 13 May 2026 08:47:58 -0700
X-Gm-Features: AVHnY4KZLSY3dQ15iDGEZ94SB3Zn1wsXCLnliS34n_SJKMblVlqjWzaTPYwzNV4
Message-ID: <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:05=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> usage is always located in the first field (field[0]) of the feature repo=
rt.
> However, a device can specify HID_DG_INPUTMODE in a different field.
>
> If HID_DG_INPUTMODE is in a field other than the first one and the first
> field has a report_count smaller than the usage_index of HID_DG_INPUTMODE=
,
> this leads to an out-of-bounds write to r->field[0]->value.
>
> Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
> hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
> this stored field index to access the correct field and add bounds
> checks to ensure both the field index and the value index are within
> valid ranges before writing.
>
> Cc: stable@vger.kernel.org
> Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID ge=
neric handling")
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch looks sensible to me. Thank you for your effort, Lee!

Tested-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
>  drivers/hid/wacom_sys.c | 13 ++++++++++---
>  drivers/hid/wacom_wac.h |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 1b1112772777..a6c5281afa06 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -341,6 +341,7 @@ static void wacom_feature_mapping(struct hid_device *=
hdev,
>
>                 hid_data->inputmode =3D field->report->id;
>                 hid_data->inputmode_index =3D usage->usage_index;
> +               hid_data->inputmode_field_index =3D field->index;
>                 break;
>
>         case HID_UP_DIGITIZER:
> @@ -556,9 +557,14 @@ static int wacom_hid_set_device_mode(struct hid_devi=
ce *hdev)
>
>         re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>         r =3D re->report_id_hash[hid_data->inputmode];
> -       if (r) {
> -               r->field[0]->value[hid_data->inputmode_index] =3D 2;
> -               hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
> +       if (r && hid_data->inputmode_field_index >=3D 0 &&
> +           hid_data->inputmode_field_index < r->maxfield) {
> +               struct hid_field *field =3D r->field[hid_data->inputmode_=
field_index];
> +
> +               if (field && hid_data->inputmode_index < field->report_co=
unt) {
> +                       field->value[hid_data->inputmode_index] =3D 2;
> +                       hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
> +               }
>         }
>         return 0;
>  }
> @@ -2819,6 +2825,7 @@ static int wacom_probe(struct hid_device *hdev,
>                 return error;
>
>         wacom_wac->hid_data.inputmode =3D -1;
> +       wacom_wac->hid_data.inputmode_field_index =3D -1;
>         wacom_wac->mode_report =3D -1;
>
>         if (hid_is_usb(hdev)) {
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index c8803d5c6a71..b2e74d7ab3c4 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -298,6 +298,7 @@ struct wacom_shared {
>  struct hid_data {
>         __s16 inputmode;        /* InputMode HID feature, -1 if non-exist=
ent */
>         __s16 inputmode_index;  /* InputMode HID feature index in the rep=
ort */
> +       __s16 inputmode_field_index; /* InputMode HID feature field index=
 in the report */
>         bool sense_state;
>         bool inrange_state;
>         bool invert_state;
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
