Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701A4C151F
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016562; cv=pass; b=WBxParP293bap2TUueZVY2MU2zvJ4KNv1i4JMLMQh4IaR+ekOtOVF3iALBNVBfl+PEVHYxrwjX2cboxyNkp2xfIpo/0GIknV8bvyZ2CwDGLKQ3WE+pQdxU1rRW4gAY0HRKeSBI9bL8Lj+WddhxlseW3Slbbb8qvrjNOY5rBCwPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016562; c=relaxed/simple;
	bh=dHSQ8TAun/j9Xho/MQkmlAEDid5vXt4gEpS/xPyEVuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGzC1MXvthMoNnk0xoQQSvRSRit6S5BzFNItSwdfjhzSKTMFPaUJx3O2wzKkQqh2OrlaeMhCyiX1OwYMsA8WIKiARPhUHzNSRwoHnNZbEBFuB0f643FI6dJNlhfCD/bs9WY9k4OTXQiSYQGuW9hP13oBakHs0xfaZAWGOtyhY/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMQezf7e; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMQezf7e"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93ef9803765so262780985a.2
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 15:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792016559; cv=none;
        d=google.com; s=arc-20260327;
        b=JOoDHKt/tg6iloouRMoF6jZFW8Jc9/kgDfbh9mupgDpCWa6eHrEL19sIWMuIFxpYBj
         j2ox8JXEkDbfqY17+mFrS0jIfIdGYsUCgKsIQiG5JkRnra38n2SoUgr8mJqIxkRi40fG
         lPtiubZqHgtTGoD+y3bMXZDt8m6fSFfkwGZ8INT88SxVg2mo/F4WUcRRKTG+cqEu9C04
         TTdbI0+QDfX5qOBDiGZTxeVGACJLRu2ENWTQoWyr9uyzGy7/AOt+yAY70T0FR5m7oX07
         8WEtThCSEJWI67iV4Rh/QOzEueU+r0+nnJ9v7aCoGdd/F/Cn4mGhlrFc75sHyvVAwry6
         9qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a+jlPqXaLVAni2Q4f11pdb92tYHpkQCT0cVUsiJH2TM=;
        fh=Ji9jrd4zL3GjMkid6lH96L4PtVBWR9qFCnnhKDjI/j8=;
        b=UnYbqucYoGLhKHJSjxspP5SAd/Lc1poSFkn/5iL7YN1O4BecUisCPW64VzRhJ8wNOx
         wgtcUdwnoJ+AjRQgT29ETzdDmNHV/+dqUPnfH5eduhJZt/Psd8l21qBnT2E7+TB48uRR
         +DKlMJJVMwOLvZDuEUeq/kUBvmE3BfYI+WBtf5fTSXPBlaG0i/Uzlx7jid4oyNQ5MGZk
         KgzoeSgrhS8UbNw7vQVG4Q2ZB68X43V/dDFi2RgiHezWNDTQlcjeNYV9+m5dJ9i1n+58
         7vbB3R4Tr7aOY7c4LGTDCjE8JiuHUhIdItM0FpzVdm2J56CBE7JCrGKdT3OELVywboTi
         pNAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792016559; x=1792621359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+jlPqXaLVAni2Q4f11pdb92tYHpkQCT0cVUsiJH2TM=;
        b=iMQezf7evx73/yLjG+I4VeLvDL2xFBHSp53R7qnu5v8bXXOC2rLFzL39BowKHF4kBM
         H63XIsJdNpK/nYzK7TziONfVaLdLs8Yk2sxDqtBpUinOYJuWYVlW7Fu5KUjc2Ne2OWZr
         meI+hm7J+uxvZDZqRp1/a6idKdVWNjKFqae4GQ0Jn0LMFWgMtEdl6C0gnPA4YhR0r0Q4
         05s7BwQW1Izz2xmOXazMoSAbGERZC28p1YLVNyviXHlMCwKSvL4+SasZhMPYf/i8MfJp
         krDa7QRmHNnj507+gnSpFZsXBRk/xGd9upoElO+EeiadjE+rCvwa2vXQyrAcNdAhiWcP
         i7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016559; x=1792621359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+jlPqXaLVAni2Q4f11pdb92tYHpkQCT0cVUsiJH2TM=;
        b=tDiw+8aFXkJwKs5uukRGFSlpyu7XE6jaoih2YlvTpfMVbnw0/F4pC00E34hgoNYosX
         +bx9FfyTamHst3tqigJv0BwIWnjDsvRPvJb6WC8o+07mhwH0dgrtGFug8d1wRAWuPCtu
         +OJJlzByc4ZFVcM86KMSkThwLTfMTO/CLWs22TR7NIhKPdJKM+j4nLeuVRTFYlhE49+f
         BoODcAuvvTAHDtZH6o/khkJOQlf3zbHrpRX11IlKFIIoGZYsYs5DMMI1Z/+0LU+oEplk
         Ol6qQxdzdq1Ge17mq3uZXr1SdUrDheR/H1NoWbCWl6vpvOresv7tHEwX7JM6pqg7GZpb
         f/rw==
X-Forwarded-Encrypted: i=1; AKwUvBypZa2PpQ7N6IZ2+kQQif1JCLGI1QcR26Spps0W5ETq6bg4Bt2n2iyHVWEF2ZVOCsugWnKDz5GfZi30Uw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL5VQ2gj3HnUEB7APFg0f59t/9A/l0Q1nSGaKhVLpUfhO3zEOLi
	Ijlcd6BhR3leR9BgGw9SJSx6aBzZQZ2F0JnA6Ph7FFzyQgjwECIzPYjRoV+IBplnwpqTifZwa80
	r0RsaMj41PGijeEn7zisoLiHYJCp9poM=
X-Gm-Gg: AYBFou07qJ7YAeazN9XzgHxzc7Jo0IQttbJ/9GsHoaDgilNbd1Hae4fex0IWYRFrox0
	zIqLXgchcLE3FjUElrMRcOpcuoGVXRrYaCuDHLO9hIUy4/cWfKaFe4P6YS6CY/mHsBkEzdy1hM1
	3hEpCE6yVypXqXBAOQfwcQIKO1ged8w8UOhbg4VHknCUHnIIrvaRaSphiNpvRdqhtC6UtTuekLv
	F4p9vYJL3Ecbnbo5iSMHiyyjgeh4Am5BajLuR7qOJiI7YvRA5Az2KoJlEQubT8b2ugMqV5ApaTn
	EG02QChXmaUjXOg6XVxBxvBO+l9Hw8N3E7u4SPcu127t3X1jw6rla9q6
X-Received: by 2002:a05:620a:3720:b0:93e:5eaf:dd87 with SMTP id
 af79cd13be357-93ebd2a05fbmr2860841185a.62.1792016559414; Wed, 14 Oct 2026
 15:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925055346.19890-1-rokinthanp03@gmail.com>
In-Reply-To: <20260925055346.19890-1-rokinthanp03@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 14 Oct 2026 15:22:27 -0700
X-Gm-Features: AclHuK-7iMEveaTmmOXFHJA9E6TTkX0hQ4U5frlxF8tQjsuAC9ltDJ84s-wyUq0
Message-ID: <CANRwn3TtQXnLRmDXVx=FuMDXpBueHQrRk5z-QWNW_EF-KhgsNg@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: check for NULL pad_input before reporting pad events
To: Rohinthan P <rokinthanp03@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ae7f998154426e723cbf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 10:53=E2=80=AFPM Rohinthan P <rokinthanp03@gmail.co=
m> wrote:
>
> When a Wacom device interface does not have pad capabilities (for
> example, when wacom_setup_pad_input_capabilities() returns an error
> or the interface is configured as pen-only), wacom_wac->pad_input is
> set to NULL.
>

I imagine that similar problems could occur for the pen and touch
interfaces too since they're initialized and used in the exact same
ways (e.g. wacom_intuos_inout and wacom_intuos_general both implicitly
assume that pen_input is non-NULL). I would recommend creating a
similar version of this patch that adds the necessary checks for uses
of pen_input and touch_input.

> If incoming HID reports contain pad packets (such as
> WACOM_REPORT_INTUOSPAD, WACOM_REPORT_INTUOS5PAD, or
> WACOM_REPORT_CINTIQPAD), wacom_intuos_pad() assigns
> input =3D wacom->pad_input and proceeds without verifying that input is
> non-NULL. It calls wacom_report_numbered_buttons(input, ...), which
> dereferences input via input_get_drvdata(input), triggering a general
> protection fault / NULL pointer dereference:
>
>   Oops: general protection fault, probably for non-canonical address 0xdf=
fffc000000006c: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
>   RIP: 0010:dev_get_drvdata include/linux/device.h:991 [inline]
>   RIP: 0010:input_get_drvdata include/linux/input.h:396 [inline]
>   RIP: 0010:wacom_report_numbered_buttons+0x37/0x210 drivers/hid/wacom_wa=
c.c:4225
>   Call Trace:
>    <TASK>
>    wacom_intuos_pad drivers/hid/wacom_wac.c:643 [inline]
>    wacom_intuos_irq+0x2f8/0x3430 drivers/hid/wacom_wac.c:1042
>    wacom_bpt_irq drivers/hid/wacom_wac.c:3290 [inline]
>    wacom_wac_irq+0x196b/0xab80 drivers/hid/wacom_wac.c:3560
>    wacom_raw_event+0x6bb/0xba0 drivers/hid/wacom_sys.c:183
>
> Add checks to verify that pad_input / input_dev is not NULL in
> wacom_intuos_pad(), wacom_report_numbered_buttons(),
> wacom_intuos_pro2_bt_pad(), and wacom_intuos_gen3_bt_pad(). In addition,
> in wacom_intuos_irq(), return immediately if the packet is a pad report
> to prevent pad packets from erroneously falling through to pen event
> handling routines when pad_input is not allocated.
>
> Fixes: 49005b9fd052 ("HID: wacom: Refactor button-to-key translation into=
 function")
> Reported-by: syzbot+ae7f998154426e723cbf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dae7f998154426e723cbf
> Signed-off-by: Rohinthan P <rokinthanp03@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index af76e49..6a13724 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -529,6 +529,9 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>               data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
>                 return 0;
>
> +       if (!input)
> +               return 0;
> +

Please add a dev_warn message before returning. It is extremely
strange to be processing a pad packet (identified by report ID) and
*not* have the pad device allocated...

>         if (features->type >=3D INTUOS4S && features->type <=3D INTUOS4L)=
 {
>                 buttons =3D (data[3] << 1) | (data[2] & 0x01);
>                 ring1 =3D data[1];
> @@ -1039,9 +1042,10 @@ static int wacom_intuos_irq(struct wacom_wac *waco=
m)
>         }
>
>         /* process pad events */
> -       result =3D wacom_intuos_pad(wacom);
> -       if (result)
> -               return result;
> +       if (data[0] =3D=3D WACOM_REPORT_INTUOSPAD ||
> +           data[0] =3D=3D WACOM_REPORT_INTUOS5PAD ||
> +           data[0] =3D=3D WACOM_REPORT_CINTIQPAD)
> +               return wacom_intuos_pad(wacom);
>

This check is already performed within wacom_intuos_pad. Duplicating
it here is just asking for trouble as one check gets updated but not
the other. The pad function knows best what kind of reports it should
handle, so overall I am going to NAK to this particular hunk.

>         /* process in/out prox events */
>         result =3D wacom_intuos_inout(wacom);
> @@ -1475,12 +1479,17 @@ static void wacom_intuos_pro2_bt_pad(struct wacom=
_wac *wacom)
>         struct input_dev *pad_input =3D wacom->pad_input;
>         unsigned char *data =3D wacom->data;
>         int nbuttons =3D wacom->features.numbered_buttons;
> +       int expresskeys, center, ring;
> +       bool ringstatus, prox;
> +
> +       if (!pad_input)
> +               return;
>
> -       int expresskeys =3D data[282];
> -       int center =3D (data[281] & 0x40) >> 6;
> -       int ring =3D data[285] & 0x7F;
> -       bool ringstatus =3D data[285] & 0x80;
> -       bool prox =3D expresskeys || center || ringstatus;
> +       expresskeys =3D data[282];
> +       center =3D (data[281] & 0x40) >> 6;
> +       ring =3D data[285] & 0x7F;
> +       ringstatus =3D data[285] & 0x80;
> +       prox =3D expresskeys || center || ringstatus;
>

Most of this hunk is cleanup that has nothing to do with the new
pad_input check. Please remove the cleanup so this patch can be
focused on the fix.

Also: similar to wacom_intuos_pad, please add a dev_warn message
before returning due to NULL pad_input.

>         /* Fix touchring data: userspace expects 0 at left and increasing=
 clockwise */
>         ring =3D 71 - ring;
> @@ -1515,8 +1524,12 @@ static void wacom_intuos_gen3_bt_pad(struct wacom_=
wac *wacom)
>  {
>         struct input_dev *pad_input =3D wacom->pad_input;
>         unsigned char *data =3D wacom->data;
> +       int buttons;
>
> -       int buttons =3D data[44];
> +       if (!pad_input)
> +               return;
> +
> +       buttons =3D data[44];
>
>         wacom_report_numbered_buttons(pad_input, 4, buttons);
>

Same comments as the hunk above. Remove the cleanup-related change to
'buttons' and introduce a dev_warn before returning due to NULL
pad_input.


> @@ -4220,9 +4233,14 @@ static void wacom_update_led(struct wacom *wacom, =
int button_count, int mask,
>  static void wacom_report_numbered_buttons(struct input_dev *input_dev,
>                                 int button_count, int mask)
>  {
> -       struct wacom *wacom =3D input_get_drvdata(input_dev);
> +       struct wacom *wacom;
>         int i;
>
> +       if (!input_dev)
> +               return;
> +
> +       wacom =3D input_get_drvdata(input_dev);
> +
>         for (i =3D 0; i < wacom->led.count; i++)
>                 wacom_update_led(wacom,  button_count, mask, i);
>

This hunk appears to be redundant since the above hunks appear to
fully cover and protect all callers of wacom_report_numbered_buttons.
Generally we try to avoid repeating NULL checks, but since this is a
utility function maybe it makes sense to keep here. If the NULL check
is kept, I would request another dev_warn log here as well.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> --
> 2.53.0
>
>
