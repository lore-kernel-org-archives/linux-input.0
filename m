Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F54320CAD
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787798950; cv=pass; b=p8TYpUo//8z01CIq6k2TTs+bp0aDjf1uaqbFzO+tdp1FIULd4EAyghdjGek4dLIiqW1JSiV9ts6z0yaOrzHRvWpdZCNeu07vV/wa0KnINj+tlz5rBY2pqTEMG8R+C93euNyum0fvg44JZGW9HiHDtyGa4fynxArXSi9opnIuSCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787798950; c=relaxed/simple;
	bh=XAZ8RuL3OK7yi6FMYBI3gHxaw8VoKbKdqDDnFO/Y2UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlN7LzGNpUlmylfVzdgmh9Dd+JLM0VQi6CPhHxUbklhj4Fr1R2JOsraSsCbw96+8nPIoxC9RdakcVjvaD4fousay4sPhf5REZCH0W3ymN1Lf+QzqeMOWltIMccYopuPc4U0gdfwV+JGmllKnTPQsqPqMs46DZYQxjoK9w6nHiFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6QR19nw; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6QR19nw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c26d7e951so35854766b.0
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 19:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787798947; cv=none;
        d=google.com; s=arc-20260327;
        b=O44CuYH2LOQTaa1fVn2mwheKw5tGxBORCMyphFIwvrpDCwGaNOepMgiTTXxJxWzRuP
         PqTf/VBB6NlQL6OQIPQ5ksjaQZVAQi5S4r/mi6M7vqYhPrTdBRykCfW8tj6iEdwXVqxB
         hK7wPr33Qu+2Zl5WyNS76fcMs0YYv8+77BqkhmSvAzdtVuO6eoVUEgMnpO4iOm3mNXCN
         rjdhpN0TmCRwolunHRtTjgsxdXbP4MLOiIfC8GCVlZEHwiTlNhPXzKhMfuAhyty2Bgah
         6tBO30T43AQTg1GSsvBM07andskwNEEFA8s7hnYSOOSwpWb08GFsvXGCJOX4p/HHtpkN
         Dmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jf1DTrgu9DEKlBhdg3fT3vRoxhwl7YfgT/79bwlhJuA=;
        fh=PZGWaY9NMTBjbTvl8hI0lSUroED59fqyJdh2VFVMJZk=;
        b=WWWy9CyU4lUznzLMMniwArkrDrKUHlexxBtaFodgz/LLp0fR+b3IrXPi8kxQ2zAa9X
         z1Q+f8bsjBENUHjCDydKthBk1TX9Uziz2gZWeH2nikouBXBKiXws5kEvpkBSH7DvsN1r
         5YBVlR10e3ygmPA3MFPdHG1KPd5md42A+V1XodN+/dGCDrYpM3OAVS5LiQJVxkRx570C
         ACflDuCfiGH/qTlB12B/FBRBLproxgHs7kH4z9SGZKIU0yEPw6Prtn8UVCDng+Bu1lxS
         NxsM0hOAmg1//c9Oo9JeSiDtOlYx0sn5NkYvd5al8IVmfypu2CSUwkXU69l41QX9sqr8
         +ILw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787798947; x=1788403747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jf1DTrgu9DEKlBhdg3fT3vRoxhwl7YfgT/79bwlhJuA=;
        b=K6QR19nwiAIZ3ViQHDHBST53D+dh5ra8R9K6IcTAbgoAv/WDWjizO7UeFsbBat7s9P
         1wwxB7UVrInMfbUYfZktgzoNaUupp390SLDWRFy2MnpGMPSK8VoXNNvvQlmV359s7LQ2
         CTj2+hkj34C0jaMqbgtaAYNOnHV9Rmv5bfFWCL9oTAGxayPm3zVX7vGbI7XLItrIe+H2
         TVONJF1WGn5kixpGfHniufRAJtGEWBDnWIT4JngacTBFVpv6WQIuVCvO3w531liePPVq
         baopi3Rkz0A+f0Idr/qoUwPJ2UnhUmgF+PKPI3pL4DqpK9iUcQ/e4pBfblylOD5EElic
         UXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787798947; x=1788403747;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jf1DTrgu9DEKlBhdg3fT3vRoxhwl7YfgT/79bwlhJuA=;
        b=Th7/PWSR0dd1Yr9YNbK8ogi2OowY2oJI9ugtgOD46xZL2O0lLIEegbA+DXfN8MI66X
         OBPPNw51ZuWi0d+6RW8AnOz+R+3Niy93xO8vD/vaA6j5ey+VljG0Es7uZ4Fy23FpRNUm
         sL1ZCNZMPqGxJbtojSwTCgMHkGAXNmORZ6kHWQX2oba/InWpoIDPIR6z6CZUBwfcRpy1
         hhyABa3YRTsaMgfaLbnRLlqo+ZXVBPtgHQSDWaAZTkHsMH0em3Xz4RMtjt9oa+IU0M1u
         +7QVhHimOyB4SiGZ2faC6BOnCRn5uBWYipMIesR01ImnunITt6JGG4uphouD5Fhi+gSy
         9xXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoScLdUUcdFbDBlL1W+mClOvmm16keVQi/C1/7n3wQSJjjeCEsF4gYBjCYL5l8On5pAN3oe0GIuTEzifg==@vger.kernel.org
X-Gm-Message-State: AFuF++lbV5lk5/YjPZh7kc6BlcQCN25vCwCh3BEz7hx4dye+D9yqn99U
	ymOl+MfpoXxgOnyuU8FL1hFNz+hiPc/CndWTD4QHA9vUqiAcRIVlINpRk7eNv8qRuHwaVPsm2FA
	Gf/IF0c+4fydJGKw8IWJIlBpApGZzvCc=
X-Gm-Gg: AR+sD10O9ZH6vAVa9vGtNGHHOCNV4goAkoOVMSh1UpNTmw2g6Ss9Pd3ksmUFWTTprYj
	JxAdA7qbb6jVcu1/W6/KApfbglvekygnQHYEPnQqC5jlGoQePmzNDZ3TiNTSSsnGSumSJxUZvUI
	0jOCX+bMyiq1yA14GSTCHDhY030fAFwyPynT9hFze+mhMBnVJb+fWUilBpHtKxC2fkn5G+r+EE0
	mMEAOPogyTXtJI00wLGjG56AVEUJnNhDpF75B2iAIe5JiSn1CXyU6jhfC2cKf4+j3awxSIptKSU
	LMNGU7d01fl4PdTLx9dP47/DU9bm1bw8WOq6f+1js+bF3BdJYBXvCezbTocgmSm1an31xbrcueV
	vcw==
X-Received: by 2002:a17:907:72c6:b0:c21:34a3:4df9 with SMTP id
 a640c23a62f3a-c250bb58ab3mr1197654466b.3.1787798947202; Wed, 26 Aug 2026
 19:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825151242.576456-1-lee@kernel.org>
In-Reply-To: <20260825151242.576456-1-lee@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Wed, 26 Aug 2026 19:48:54 -0700
X-Gm-Features: AcwNN1ViTpD87lwJhZjfJSN8xPZt6UzWagIl4Wm_TDAxjtQ6p7vKzNnVpx5ye3Y
Message-ID: <CAF8JNhKWr7v7tY-tH_CGeLUQQpidx2_7J49c17TD0bw6xEi9BA@mail.gmail.com>
Subject: Re: [PATCH 1/5] HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Thank you for your effort and persistence! We (Wacom and Wacom's
customers) are lucky to have people like you working in this
community!

In addition to making sure that you know your contribution is greatly
appreciated, I am giving you an initial testing feedback so you know
you are on the right track.

I manually tested a few older and new Wacom tablets. Some of them have
touch switches, some don't. They all worked well!

Two more details I'd like to share.

The first one is about the touch-only tablet. In all the models of
Wacom tablets, there was only one model that is touch-only. It was a
Bamboo Touch (model CTT-460) released on September 24, 2009. So, it
was more than 17 years ago. However, the quality of Wacom tablets are
so high, it is possible that some people are still using those ones
;).

The second one is about the type of touch on/off switches. There are
two types of touch on/off switches: it can be a soft key or hardware
switch. The hardware touch switch is easy to understand. The soft key
touch switch is actually an on-screen display in the shape of fingers,
where the touch on/off is controlled by the driver: [1]. This softkey
touch switch, somehow, is not reported to the userland by the existing
driver. Your patchset doesn't show it either.

I will do more testing to figure out the root cause of the softkey issue.

Cheers,
Ping

[1] ttps://github.com/linuxwacom/input-wacom/blob/master/4.18/wacom_wac.c#L=
2063

On Tue, Aug 25, 2026 at 10:09=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Replace the lookup-dependent 'wacom_wac->shared->touch->product' referenc=
es
> with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
> 'hdev' is already available (via container_of) and represents the touch
> device itself.
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v7 -> v8: New patch
>
>  drivers/hid/wacom_wac.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index a29bf051ada7..4436faf2d2bb 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3953,8 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input=
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
> @@ -3963,9 +3963,11 @@ int wacom_setup_touch_input_capabilities(struct in=
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
> @@ -3997,19 +3999,17 @@ int wacom_setup_touch_input_capabilities(struct i=
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
> @@ -4039,8 +4039,8 @@ int wacom_setup_touch_input_capabilities(struct inp=
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
> 2.55.0.887.g758fc8c411-goog
>
>
