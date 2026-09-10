Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547658E2A4
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066405; cv=pass; b=LsClt5O4p3fqXBTcpWDxgK/jGQaFF7Fr91ZxG12uSeavp6VtmavqoAeA7xMZrUeMQV4WAwRuLnIj0sFwCcUR+p+IgYwpXUqIcMc43MHh0v4WCWVgtbqB8Ssvs+mXXPVkI28o+fhVpuP5qtemhmYur8ba9ufo5kYQHlGjI8/XUiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066405; c=relaxed/simple;
	bh=VvXoNF3sMeo2fpv2qDY0aBbxOZBUbISC5Fqd+S82nYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhub+ADRCw2XUjeZBQ15PvgvHnvncFTzkBEn3AdXZCbO8y2Be6HssfT96EMpBrJJve0BmQzqujyqokW/JWqoDXwFLjP/Sj6g0fYkBT7PgnfdCqsqGDX/UQAgHXmw79vv52ZbXaZZm3WCftgQBJRspq0ri6vu6JLVoePr2QxARDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMdhZ8K3; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMdhZ8K3"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15d3so17258566b.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 11:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789066397; cv=none;
        d=google.com; s=arc-20260327;
        b=Ya8/ODHTigzrgcwA/vmhP23x/wbqh+sVoqfRKjcFR3iENILzxD0PWQzmk7C7M8Qn8F
         PcZiQRlKK3KAphVPQaJ3soLwwkXZZbx+uGorBnDKpKwldWgyPCM77EuUzz6UlZyImiw/
         SZOrEhL4MDLBWLKFnlpVarjtmDYyoFCCFocT3peI89JTzLFpa2cxJ4f0tRfabBEma8jY
         1OGK6EkgExN2TEqb+CjM3muOz4lNeuPNRXIoft29e//RjK2BPmJjjcQTJZ8rBS9VIQ0n
         T4iWRGa4Py0oHDbEpX/DEMq1dCedzeXWw/6r0CyCI/CijrrqzHi8ZZZ66a90MmfdiMGd
         3yPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJedgFbA0a5dZ7UM3Qt2A8RF0LRRqtbYOuDEXTxhdkg=;
        fh=BeXGrPhnszmDKxGzlxTV9cWQ2vm6iM2EZCiFrZnMB1w=;
        b=VaSnIJmoMc+hFbn1yotvBozs90uiNwEWD6x6p4qCfUsIhSt/FTG2n6jVyWVNE19154
         u/nv9iDQfVJUhx0VaVMXGAQ+cxNd2C4ZbY6Q1i7aD64Cu9EfGMbG8VCvm40GfGFc3sPi
         7jFXDCamDSUEg2BcaPZi0YxCQrJ5cNnsyHsvQBCSYnwFQRC83g2Qb7vV1PpAcGzbgWJI
         EZrPyERiFw5+hDUsZzGWzOAQLB8rwMB/0AvjfAlasXp+6blSD0mSgoFEutjBmabuLTRK
         5hciqPELeixl+9y2XDN2v7NdL+PIvo691GT7y+b90o55paagcl5W31kaQbEPdJYhEROL
         9F3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066397; x=1789671197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJedgFbA0a5dZ7UM3Qt2A8RF0LRRqtbYOuDEXTxhdkg=;
        b=AMdhZ8K3Z/qcyQ0KXyhN9VufTLn54TfCpOZV4MHMe2MQRHj0s/b9KJqeT7sPyQOIXo
         JkfnshlGeOLSvYdZwn8fz/lJebqKRGPNrew5AgwQ5umh6X5l967lgkyFw2sL/YdifmNB
         0TvZM9pgkKlcSmH3UKZdfIN5n4qt7eU9xMgOC4xdsUxaVvqUFlxvItUShsN3bRi0zhFS
         3igpwt5MFVmLZ8D0Ub4qa56ngpjr/XI9iBaj09BFtWvflQTl0SuKE/IrW3sfJZnKmPQb
         Ftds0Vt6lKiyz5bSYtefWcfLqtbHBI6Ch/7OrwVbzAQcJCpR7ZfFjUelGEtgjTAb+W7k
         PxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066397; x=1789671197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJedgFbA0a5dZ7UM3Qt2A8RF0LRRqtbYOuDEXTxhdkg=;
        b=H1M/oZIhoP0vCnXJ2deC6wiVxGAJVAiwhFaZybxKbTA8eERTO8lR7REn09r+y5jJUG
         S8246GtX4aDzrY+Tz+7RbHovEQKHSGhN4Fj4mwz6uYr9k5dfmvDPF7Uy5B/T0wthgQtm
         U7WFqIszBCMNjodn0oX7tYUPkiF+4b96okFi7jWoBxyo/JpYu3T7yuYH369788zIBIoP
         CLx42vxmvhBaeanMIiTBD2Ih4yRwKh6Avh0VU5M05K3Jd8eVdsQURGIm+hGSfSQzLIwQ
         LzUDmG6TOIG/0PRSqoXJc1iEnkOilK+AMeCFPPJSVRLaUWNe9ZHr0QCSq+pFY4OLjoG+
         keFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMvgWKuyMS22tTVnK/I0qeXQuiCtORXV6A1/8kdz8lvLjgAjFIICj8lx+9JCZZSFnzCkaVXnFpx0UkDw==@vger.kernel.org
X-Gm-Message-State: AFuF++l1X2dNXHOAs3GyHoQNyVMvICJ7N5iN1BZpbvt1fjwY6OqsHSAF
	GA8/dHkg0xqV+1fUPuPBCFg51s97EfUI4elNW7k/ui82NfyzNIgj0+abI/e3+DJ/FcElER/50fh
	D2H1LRZY0+Qe4NjMdrPT60gbI3N/bx4s=
X-Gm-Gg: AYBFou20Thi0oRE7TWJ0zz9vWQCbEM7D3t1C58xCxDwObDjuEh/zyAdBUjjhaT1L9IS
	F1qGuWAWhPXoXtsIv8JjCJI8GbGaEa4OBsCrpjy4FTjJtpSn67aeHv2GQN0upV7WqRymfobSajP
	oLOf4XS3dSkIcP7kxsJVY0+HfxldM/LU/SLam3F7JOUjD2fNPmifkV0+rVPABcDIpfcuYN8r5YS
	dBbb1ctwjpPNLteod/Cha9ze90bJqmiK6Kq6uUtTbwiwfnsp2BAGO8Oz2pLBeTU0yCdlseE70xE
	YShUiSSRZiB05CFQV+zZi2SSOI1U5SsJK9L2Y8WSGCv6yuTSlNFl7eGotOpKij7rdMTrQnU/Sys
	xkhsefX3AvbRk
X-Received: by 2002:a17:907:97cd:b0:c25:b706:e59 with SMTP id
 a640c23a62f3a-c29666f49e8mr191366b.17.1789066397017; Thu, 10 Sep 2026
 11:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Thu, 10 Sep 2026 11:53:05 -0700
X-Gm-Features: AcwNN1WtBzIj10yYVWNSv1D2MgnrM6PZMOlbKADR-R4JWexEKJoN-9DMVJ_y5ok
Message-ID: <CAF8JNhKJES5xkXd4VQxwp_sV_jUsgLsqFz+OJADL0-neY-W1Cg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested the whole set of v10. Status stays the same:

Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

On Wed, Sep 9, 2026 at 4:27=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Replace the lookup-dependent 'wacom_wac->shared->touch->product' referenc=
es
> with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
> 'hdev' is already available (via container_of) and represents the touch
> device itself.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v7 -> v8:  New patch
> v8 -> v9:  No change
> v9 -> v10: No change
>
>  drivers/hid/wacom_wac.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95..7cf2b4de52be 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3966,8 +3966,8 @@ int wacom_setup_pen_input_capabilities(struct input=
_dev *input_dev,
>  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>                                          struct wacom_wac *wacom_wac)
>  {
> +       struct hid_device *hdev =3D container_of(wacom_wac, struct wacom,=
 wacom_wac)->hdev;
>         struct wacom_features *features =3D &wacom_wac->features;
> -
>         if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
>                 return -ENODEV;
>
> @@ -3976,9 +3976,11 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
>         else
>                 __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>
> -       if (features->type =3D=3D HID_GENERIC)
> +       if (features->type =3D=3D HID_GENERIC) {
> +               hid_dbg(hdev, "generic touch setup\n");
>                 /* setup has already been done */
>                 return 0;
> +       }
>
>         input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>         __set_bit(BTN_TOUCH, input_dev->keybit);
> @@ -4010,19 +4012,17 @@ int wacom_setup_touch_input_capabilities(struct i=
nput_dev *input_dev,
>                 input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
>                 __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>
> -               if (wacom_wac->shared->touch->product =3D=3D 0x361) {
> +               if (hdev->product =3D=3D 0x361) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 12440, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
>                                              0, 8640, 4, 0);
> -               }
> -               else if (wacom_wac->shared->touch->product =3D=3D 0x360) =
{
> +               } else if (hdev->product =3D=3D 0x360) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 8960, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
>                                              0, 5920, 4, 0);
> -               }
> -               else if (wacom_wac->shared->touch->product =3D=3D 0x393) =
{
> +               } else if (hdev->product =3D=3D 0x393) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 6400, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> @@ -4052,8 +4052,8 @@ int wacom_setup_touch_input_capabilities(struct inp=
ut_dev *input_dev,
>                 fallthrough;
>
>         case WACOM_27QHDT:
> -               if (wacom_wac->shared->touch->product =3D=3D 0x32C ||
> -                   wacom_wac->shared->touch->product =3D=3D 0xF6) {
> +               if (hdev->product =3D=3D 0x32C ||
> +                   hdev->product =3D=3D 0xF6) {
>                         input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
>                         __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>                         wacom_wac->has_mute_touch_switch =3D true;
> --
> 2.55.0.979.g7e5102b832-goog
>
>
