Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982640BCAD
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278269; cv=pass; b=WqKBPQ5HRfFQ2S0XyIH8SKwaz3Xu1Ccnp2ZieAqtUhTMoU3hsgCV3fLPGfJkdnWlFbqhhjlVymiYdJeXY1gcnaIuubqDTCNEn9ORfl/QItMOug9raAEu0aReqEuAxQiemuu/qGKauyteHD+ifDgDXpEGTgJ+jal2XsCxPHic27I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278269; c=relaxed/simple;
	bh=LGO4QPEZD4tJNdCuCHdQdsMS8+RzFkzYI9X0O6NCqO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAu+yKbEvP/G4ENpmOEe2Ts5EoWibQvYCN4UjI1qetD2uNS0DWhD8wLOkjU2w4a9SNQ6cb4ujr77P8rN/+/He6AXRJbgkyC/0yOA6w031lOP6L+w/qwYpaAwwHKZD12ILGqzjXlabUVw7OdKpRmGHW8h8rBbgT7IzS4X3lXgFPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oysREbCg; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oysREbCg"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-784a1696a21so45575137.2
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 08:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788278267; cv=none;
        d=google.com; s=arc-20260327;
        b=pIExuCdn3kaU1chdLumOsEWcXXsaoo5CYDlqvcIE7kH0CLrk7ol6rBA1lEWrOXtSoR
         iiM5AbybNyEMPAkBIMVffbZ+1FARt4zItSyDIJ07r6jVi+vC3wwyLJv2tuet6vS1mxqg
         dHMWbFbXTsbputdIsQ8PYI+5qfmDqC6uJYijalObwIK4pstZViSM530N0gGCsmVEwUbX
         bGddQkFI/Zvzage80QTYk+q61JUTccdWBH50jcw2+pgcBcBobwkkTuBJiDJ3Sj+H4BPD
         flPeQ+lf18eaFmqNJMJjJXY78JUxSPLqbutW/G8/Cuj85NPDD9KRMcqyrepzHYxIQ5aW
         JMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RoXKQvXjgiKqIUHVbbm0BfOC/USzZLLHG1ls27syuEg=;
        fh=nCOLXCgVKjXncsmDao7a3j5z6tleF1Nf74261Y+4IgY=;
        b=O+t21r5jyoVI37bB4aC6u9zGHogHNhcWwJgOu+Fej2fP8HcJzJ70UHgRUASzk3Kyty
         DfOPqqMM4hmv8YRs3p1Pn1v7G924BTIJwqX5e/43XBWsZkqtRSw59n1hE35lCDelXP55
         +xsi22vgLCbOtoWe2NA7CYYi6T8NhIPaxz+k5u2VL7ks5ahzNTGI4csutP3yvbeo7JCN
         fqI3egBcp3ewOKUbHCgiAKMD1i72uWr4rc1yn8r244OWVOfAC4OJHPNwy7VT8HL6wrC6
         XYiXM0pEXa8hqxGbRoYWxLUiJ8fDv+j+2z4yhSeuAmIPqwRCr1DzGMPLoqCU+y9sXjS0
         P+wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788278267; x=1788883067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RoXKQvXjgiKqIUHVbbm0BfOC/USzZLLHG1ls27syuEg=;
        b=oysREbCgArG9Y3QdTRV0lu/5KZOM2WIau1KDCEumHgDk3gLOJ/z0jlXzbDGzxY0t1I
         Ue8DrKosLC9MWoArQ7/CZVa4t57IUPm2m+fgKLmRtN39K4FH4WhXP/MvSItlEp3+TeNX
         c5p2SK/BUdAUFC3/hZi0nab3VYUSgmx1iL+hFaKVNrZ+qOnygjBonn8kPxs1yMayRd7e
         r+FeFb/UN1JfqWsDWvTNOGziqIHLWGeQLHyo3Q2pKawwZWywY4fAUYyCBh2mbdhhNGZ8
         EO1qgwzMHQcH619BXDQphsLlvL7J9iquH+/JkIqMVeVMxPeH9U+KIkZaiTRYnpLWSGfj
         8x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278267; x=1788883067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoXKQvXjgiKqIUHVbbm0BfOC/USzZLLHG1ls27syuEg=;
        b=Nmn9C1U3RzhL9NWM8s3foYDiDSEgVFHTn91cjzUY7MDArPgCgeY/sOu3gXRJehZwqv
         /BZnEqWdQiAOVriXr/IgGvLiLINYlPpyFYOpPJAFBx/hb3Xm6JPdEGzNkqxv4RafqQA3
         qEo9gEoYcCj3QyF1DHQbCrnoAv6elJ4Y6H3CqOeuf4I9bpbd9P3gH6CKH4WCZlbffep5
         EjfeDaJk7IzXvhTx/8otTLrRMgNFyCAY7xd0znIiHCURmv+a8utr1QYmJ6kp+5fswwdu
         EZPiYW3o89UCoaWKU3pR/Ue73H1eiWwdjSe60snfv4wi2toDyhJNoO9pUeaRovoULqzg
         ZFsA==
X-Forwarded-Encrypted: i=1; AHgh+RrBKFu/EOYjZZ9h0W9EOvasRQ3V5ryfKUG1p+Gedk1r1pBfA44UUUMTFJrevfzdcDJyHAUA1GrJInef4Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kzKC3/rTjmYAWXLSb9NvHHNyJqrKOUrHZmljWvy+/H8u+Ww4my
	L/bWGllATKeSqTu+77BB70cmrnCplAr7oR863gs1dEMJt9rYqAihQGSQb4Pb6uj9giXqx12+pCo
	4UWVE5EfFm4edBn1nG6wmCZK4KKYgnto=
X-Gm-Gg: AR+sD12pz6pLuB7XQBMEjMVQKDe4f1V9FBaNpwEyVWXDT/54iJtoIVbPI5lfSbPGcHw
	hZMyMPV0e4T8QGUaAh+xzgTecpG7YcxxXKJGhi6AdQeVd7rOnwB8y1s/jNvlwajmVLm9gjJWgNl
	9a7ei0NELLFOCrFS7wWPpnIYs34EHvT4S7dbAnGpF0s8F4rKZARSupTVnzLFm3bP5dYk3EI2eiP
	m4sKKbjqu8fj9l85SP+je78D9Is8fiY5VgbqGtHmo4PfLTkyy+GSyv0/XXxbuuQRaOINfeWfEXc
	GLxRqobmRMoon3RXO07vjCvAWRQkTfACN9w4iE7khY+Ze3vdkuF9kOcEqAD8zZxPYL+gCQbdngO
	+emk=
X-Received: by 2002:a05:6102:2b92:b0:784:a169:194a with SMTP id
 ada2fe7eead31-78599051f0emr16194428137.10.1788278266962; Tue, 01 Sep 2026
 08:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788222001.git.mradityadash@gmail.com> <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com>
In-Reply-To: <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 1 Sep 2026 08:57:33 -0700
X-Gm-Features: AcwNN1W0m4Ib34PML6CQ2EODgklRtSrXz623ENRC4RuSjDFoDzq1Hu4wP9yQ6VM
Message-ID: <CAFqHKT=7xMJAvTt3__6CtBiS2duGu6eoHq4FWiGONMvjFE2CtA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration failure status
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:36=E2=80=AFPM Aditya Dash <mradityadash@gmail.co=
m> wrote:
>
> The driver stores the firmware result byte as an index into the
> calibration status text. A Legion Go 1 returned 0x08 after an idle Stop.
> The status table has only three entries, so a later read returns -EINVAL.
>
> Keep the defined values 0x00 through 0x02. Treat larger result values as
> failure before storing them.

Hi Aditya,

The 0x08 thing seemed odd to me and I meant to dig into the docs sooner.
I think the real reason for the bug you were seeing is a mixup of what data
bytet means what. There is an off by 1 error with using data[1] since
device_type is really the 0 byte for the information payload. data[1] is th=
e
reason code for the failure.

From the docs:
Byte 0: Device Type:
    0x01: Gyroscope
    0x02: Joystick
    0x03: Trigger
    0x04: Joystick Trigger (Currently Unused)
Byte 1: Calibration Status:
    0x01: Calibration Successful
    0x02: Calibration Failed
Byte 2-3: Failure Reason:
Gyro:
    0x0001 - Not stationary, timeout
    0x0002 - Connection status changed
Joystick:
    0x0100 - Joystick not fully deflected
    0x0200 - Joystick not centered
    0x0400 - Joystick not rotated two turns
    0x0800 - Connection status changed
Trigger:
    0x0001 - Trigger not fully depressed
    0x0002 - Trigger not returned to starting position
    0x0004 - Trigger not pressed twice
    0x0008 - Connection status changed


Since we're matching on cmd_rep->device_type(byte 0 corollary) I think
switching to data[0] is sufficient to resolve the bug. If my hunch is
correct a trigger and gyro calibration will always succeed in the
driver as it stands. I won't be able to validate this myself for a
couple of hours on actual hardware, but I'll respond after I do.

Thanks,
Derek


> Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Aditya Dash <mradityadash@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index deed7acd2dc4..59b457683357 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -648,17 +648,22 @@ static int hid_go_light_event(struct command_report=
 *cmd_rep)
>
>  static int hid_go_device_status_event(struct command_report *cmd_rep)
>  {
> +       u8 status =3D cmd_rep->data[1];
> +
> +       if (status > CAL_STAT_FAILURE)
> +               status =3D CAL_STAT_FAILURE;
> +
>         switch (cmd_rep->device_type) {
>         case LEFT_CONTROLLER:
>                 switch (cmd_rep->data[0]) {
>                 case CALDEV_GYROSCOPE:
> -                       drvdata.gp_left_gyro_cal_status =3D cmd_rep->data=
[1];
> +                       drvdata.gp_left_gyro_cal_status =3D status;
>                         return 0;
>                 case CALDEV_JOYSTICK:
> -                       drvdata.gp_left_joy_cal_status =3D cmd_rep->data[=
1];
> +                       drvdata.gp_left_joy_cal_status =3D status;
>                         return 0;
>                 case CALDEV_TRIGGER:
> -                       drvdata.gp_left_trigg_cal_status =3D cmd_rep->dat=
a[1];
> +                       drvdata.gp_left_trigg_cal_status =3D status;
>                         return 0;
>                 default:
>                         return -EINVAL;
> @@ -667,13 +672,13 @@ static int hid_go_device_status_event(struct comman=
d_report *cmd_rep)
>         case RIGHT_CONTROLLER:
>                 switch (cmd_rep->data[0]) {
>                 case CALDEV_GYROSCOPE:
> -                       drvdata.gp_right_gyro_cal_status =3D cmd_rep->dat=
a[1];
> +                       drvdata.gp_right_gyro_cal_status =3D status;
>                         return 0;
>                 case CALDEV_JOYSTICK:
> -                       drvdata.gp_right_joy_cal_status =3D cmd_rep->data=
[1];
> +                       drvdata.gp_right_joy_cal_status =3D status;
>                         return 0;
>                 case CALDEV_TRIGGER:
> -                       drvdata.gp_right_trigg_cal_status =3D cmd_rep->da=
ta[1];
> +                       drvdata.gp_right_trigg_cal_status =3D status;
>                         return 0;
>                 default:
>                         return -EINVAL;
> --
> 2.55.0
>
