Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A745478D
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666847; cv=pass; b=XHyJ3bAKir1/6/OPsn4/VWAgZzCqlx4bsQawUKdiOKKc8b71M6AnQhhN8VZ3HMj1zY+E2BnRWhlZYbVcBGYqu/fMlCVDV6KG74umPRGhpzojZ4r+AmddQe7fB5OBBafkwctMjP592CtptjZLdMTvuKqQbimT9QEjXeK/wTs86U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666847; c=relaxed/simple;
	bh=K8esQz0erXS6bGlAw6aJNUJk7GErsgbvc0G/Rp0dxj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEPsvKecIUT+4VYn75iY/AWngB+CsF5EMrbjECQzyhuFkgJZyZrCB+72r0BLa/bnUaZcW8MN1A4RVAC8ZF7CLawMNPnYS+3h/+te/Se95RdMXRtyjiCvEo2kWsZ0ZMjkq85O0EUvDXYjmBX93rd+CO2qpkHRQvQil4O0HxpsIdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecnBhb/x; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecnBhb/x"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4764484296eso31040b6e.3
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 09:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775666844; cv=none;
        d=google.com; s=arc-20240605;
        b=J8D3F0N61Lj2usaWIif0T0s5b5rDTHqrElXa46pwDc3oq5seq9O1qqcxeel2fosxc9
         +T92EjnqezeHy6Fq/I0NPBqc19d+No9LystojF3P1rOYVIfSZ8ZtjnRqbKVFPByoqUQu
         9YPJl0hVHYZhL1iU0VHx60bGrt6RgyUkXjhmGYSWVOphq4csnVxyl+YelGs7l8BgpKTW
         dGOaJlYINJHFxBkDZvTIzVjp8ceikFlGgNgJCdcmFXL0TGwDqvSDtCnofKBlN21u74rj
         CPt6mPassO7FcLob/+FlXxvU9BOAbqkT7FsAcm1pJQNkJmDSH4dRoAFRLGMQ57VroWXy
         4IvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AyjzpoRPw31ppN6FUcWjUlW/qa3XxaYlFsUMn/6q1sA=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=UFi/Fda3DdAnWrWwdhjjdIOqqJRjFPRNWnkli71n082NAhQbiec/CotKh/BqyKImms
         4whi3b2xLNlxH2pA/CraLsAEq4YZag+gaYFmIzxQAf0C12ngWU586dSkM43iZTLIYMs3
         nlNVcrnMreKB4FYeW5UEyeH0MKuWZG23qRL7U6OETt7nEzpmEBmmmjQyWpDz3YcrHUwz
         18DMOrGnjkunxBrbEyjygAFWWKXDrRAigTg/FrmBSHYMqKqz4RS9tSngeBvKYB8Odr1p
         Z+o+BmkVd/Zl4jrFjwuFIUtfwrXJx84e7km/nktpQzGMz0u236RV4QeRdF5HJm3HMxkT
         nG/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775666844; x=1776271644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyjzpoRPw31ppN6FUcWjUlW/qa3XxaYlFsUMn/6q1sA=;
        b=ecnBhb/xU+bopVmbVR3/mGveOphStaZJ+rEi6LEOAlcoaToLNf6zlc++4sw2h2vKDd
         r1Id3kMpxfVfucWeO/Di/7klfctjm/t6gnvmCxmslMwFmMZKjgVaseHyoyPj4UFueIQ1
         7r8JJgzdDCKaNZIg8tav4wg3mhjl74t4BeMuVX4N9nz3DYn2sA5lxKwbjCyxQJ+5rSvU
         OUrgyoNowXIsdyowTppbAfRpcVMy+ssyMK/MhO8xHUvwqJisaqMqJNdzF1xLX2d46m5j
         GmE39H+ZdxwOEW4aWSMg74sAqDhuJg2mqXCSebSQRgpPGAsScfV+rljTQNQga7LVVTiN
         +2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775666844; x=1776271644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyjzpoRPw31ppN6FUcWjUlW/qa3XxaYlFsUMn/6q1sA=;
        b=IZTXQrpjUZO+ykAdR6VdMM6e/lcJpyBUVxKxrfYRwYTFM+2Nb5JS1YG5bokdzdmiRu
         OV3CA9beaRjxxlJEqcnx37KQTRx58gSZIn/QiO6Jbnhm1IZDX+vnuDEtpHgiXIFBUpE8
         BgE05lsQkRdXSjBQ/TdLj0OIj1h/DjEF7dxuKHRp5W9FYoD8KnnipKdJdZmZN8vvYuq0
         04cI4GCR0H3Tgs9UXlPmOWdn5yrG0pyXRs6y3o4iw+lN3RZ7/auTmkE3Bxr8x4lN434r
         9MQj8UfVlbzxesQ7Iq271P35eQmm1wAiGU+2pfb0sPkr6L58V9HHY4YJ00BZI5KHUXIb
         5Q9g==
X-Gm-Message-State: AOJu0YyRH45J3giOMAv6cdcM4m5tywMMmrR6j8XPHRuYmDGNPi7e3qCK
	K+E/dQe3BedgyyZuUfWov8PHUNjevRGCXmS9TeQsIJVwepF9F3MKx/GLjgi/9KsbgMdDPe357Wc
	Gom5mnt1An5kkZZeHpiEcDEn1fadod5Q=
X-Gm-Gg: AeBDiesSay/acpIiSfJQtAoMQVWby1vi9/2fAajBEeaClkF4TvoibqadZfDA0Yiid/N
	mgLJRsPOPqp+W7S0rygF2akefyceJ8FGk5WqxkdImQxXsNrCHYC6xNcJcuZSC3GLswXPmcmoxrS
	gZRclBxQ2Sq6UqTlIdbee1N77N9lTW2eG4GZT8F2Tj6f9GlbnoRN7uEdKlX6KD5qlxxlaOehRTZ
	uZjLF3WnKip5MSWPkmvCALcaEpV65ky7MFTNnxxo/y+mfyFxO1Js3AH5OYcDJra/rvQ+SVUKFhu
	SLkW2beekQ==
X-Received: by 2002:a05:6808:1511:b0:44f:6a19:433e with SMTP id
 5614622812f47-46ef60f033amr10551882b6e.15.1775666844420; Wed, 08 Apr 2026
 09:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adXkf6MWzlB8LA_s@google.com>
In-Reply-To: <adXkf6MWzlB8LA_s@google.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 8 Apr 2026 21:47:12 +0500
X-Gm-Features: AQROBzANs4vC1m8agT-Ic-wxF10BE0AE76hcz1M3TQ7TAdWFIvcGeUyUyLq2Qto
Message-ID: <CABXGCsPEfLgd9pqV8YLfUDMSCjRrLsvUHxsqvhqZTizc2Cf4sQ@mail.gmail.com>
Subject: Re: [PATCH] Input: uinput - take event lock when submitting FF
 request "event"
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:16=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> To avoid racing with FF playback events and corrupting device's event
> queue take event_lock spinlock when calling uinput_dev_event() when
> submitting a FF upload or erase "event".
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Mikhail, could you please try this one?
>
>  drivers/input/misc/uinput.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index e24caf6fc8e8..d32fa4b508fc 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -25,8 +25,10 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/fs.h>
> +#include <linux/lockdep.h>
>  #include <linux/miscdevice.h>
>  #include <linux/overflow.h>
> +#include <linux/spinlock.h>
>  #include <linux/input/mt.h>
>  #include "../input-compat.h"
>
> @@ -76,6 +78,8 @@ static int uinput_dev_event(struct input_dev *dev,
>         struct uinput_device    *udev =3D input_get_drvdata(dev);
>         struct timespec64       ts;
>
> +       lockdep_assert_held(&dev->event_lock);
> +
>         ktime_get_ts64(&ts);
>
>         udev->buff[udev->head] =3D (struct input_event) {
> @@ -147,6 +151,7 @@ static void uinput_request_release_slot(struct uinput=
_device *udev,
>  static int uinput_request_send(struct uinput_device *udev,
>                                struct uinput_request *request)
>  {
> +       unsigned long flags;
>         int retval =3D 0;
>
>         spin_lock(&udev->state_lock);
> @@ -160,7 +165,9 @@ static int uinput_request_send(struct uinput_device *=
udev,
>          * Tell our userspace application about this new request
>          * by queueing an input event.
>          */
> +       spin_lock_irqsave(&udev->dev->event_lock, flags);
>         uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id=
);
> +       spin_unlock_irqrestore(&udev->dev->event_lock, flags);
>
>   out:
>         spin_unlock(&udev->state_lock);
> --
> 2.53.0.1213.gd9a14994de-goog
>
>
> --
> Dmitry

Applied on top of my v2 patch, built and tested with Flydigi Vader 5
controller under Wine (ELDEN RING, Resident Evil Requiem) -- no issues obse=
rved.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
