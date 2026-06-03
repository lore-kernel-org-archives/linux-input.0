Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFC3F9F50
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471440; cv=none; b=dkNN6rQfePCfUjoBmpZqv26qdnKup4bNH+L3clBNLpNzbzCB8z+rrxKNOXy5awHjCVAOBvTuU5sOVVVbMGBt3EWmNXYjHKD4901ivGTuod5DSyqn582cDuL+lbCz7ynBq4Ts1qDMhq+tp5p0tJuc+I7oNDGA51c7hJU4EXt3WwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471440; c=relaxed/simple;
	bh=ZBnPRC5WBPCewS8d6WEsSSKffuAPYHcpWt4bbRKEPn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOCNM8NZMU4n5Hikp/t1z4MImFEmGZ2fAczSc6a92Hn3MnwDrZgminclXhlp5G4q61qLzCY837OGz5k9waQRW1fv3z79ZvB5yzDecefPKKUpfFrReDmov5VWfZ4RN90R38WmDe9f9PKISJVybRVczJSGv2nG+L3WWSi7vaAgHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkT2VCZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkT2VCZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E31F0089C
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 07:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780471438;
	bh=9hnBwNTxryIyDN3wnkVZ6MfI4PtQTRzH3pERe6L8LEg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=JkT2VCZ4Lp/E4C6xMVWPpreh5B+9DG/kFEFxcMoMNg5Eeqzj9C9RCMp+9kJyiA+49
	 7eVEPDrPsG86SiiSUq+mjukZQADyZx0mgooikqE0VojH7VrelprzCDnKpfwZjl9pg0
	 Ft5jeuOIiEUnSs8OE2i7z6vyLUyfy0EEKcTdRBc9fIpO0U+WCzE6Xd2wzqdd/pikmh
	 rtw1uC2fPlw5nnxWobhmQunb7CEZ4s+HwwF/qNC2k6GrUTSwg8KSTWL9VSTbswZKBr
	 P43wXe8Uy5bXn8f1CjsiXMqxftkVbKzJbzq3nOK39vgQzTRc9TfZ6FSxUDIlBSUkkL
	 breEK92HDdXIw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69e06aaf0b2so3344828eaf.1
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 00:23:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/aasqKEFMjHi/d0/GLuH6XacK7HXP6hxW5ZXY+BwjDJ+E36qOR7TuNyJE4kG0DYmVIOjVwJdCh/kIeIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjF7F5D92dgTmoabM28Pu93RFR2pjNC91tMPxfgsUngNdLiZ5
	h7PVbGBVkvpwXcCMkj2rXQ2c4/S8dqHo/KDWUaAD4JN6vuLRQ7XdL6ddaMtiLCdisQZslUXiy4L
	j6sq7NGFD+otnwbRZrDIYkb9i/UTvLiw=
X-Received: by 2002:a4a:de88:0:b0:69d:81ec:1a61 with SMTP id
 006d021491bc7-69e48090b05mr990172eaf.46.1780471438057; Wed, 03 Jun 2026
 00:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZoMD9s0Xs_VBzIKC@google.com> <tencent_81FCC0443B81A3078C17F44AB4B22DFB2E07@qq.com>
In-Reply-To: <tencent_81FCC0443B81A3078C17F44AB4B22DFB2E07@qq.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 3 Jun 2026 15:23:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ucD0aoHj0=RRjnHD1McVQH9S7kW-f5QG0YTkiHfMttQ@mail.gmail.com>
X-Gm-Features: AVHnY4JdLtCywJRsQ5DE4l54G85WxbS_Gu2EXhQmDw5JWKt881BFByhQFLTD2V0
Message-ID: <CAGb2v66ucD0aoHj0=RRjnHD1McVQH9S7kW-f5QG0YTkiHfMttQ@mail.gmail.com>
Subject: Re: [PATCH] Input: axp20x-pek - add support for AXP313A variant
To: Steven Feng <steven@joint-cloud.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:00=E2=80=AFAM Steven Feng <steven@joint-cloud.com=
> wrote:
>
> Add power button support for the AXP313A PMIC. The AXP313A does not
> have the PEK_KEY register (0x36) used to configure startup and shutdown
> timings, unlike AXP20X and AXP221. Create a dedicated axp313a_info
> configuration with NULL time tables to prevent regmap out-of-bounds
> access.
>
> For AXP313A, the sysfs attributes (startup/shutdown) are hidden using
> the is_visible callback, as they are not supported by the hardware.
>
> Signed-off-by: Steven Feng <steven@joint-cloud.com>
> ---
> Changes in v3:
> - Use is_visible to hide attributes instead of returning -EOPNOTSUPP

Adding this should be a separate patch. In the commit message you can
say it is needed for a future device added in the next patch.

> - Corrected author name from "steven" to "Steven Feng"

Please label the version in the subject as well. The subject should
read "[PATCH v3]" for v3. `git format-patch -vN ...` will do the right
thing for you.

ChenYu

> Changes in v2:
> - Fixed regmap out-of-bounds access issue reported by Sashiko AI
> - Created dedicated axp313a_info with NULL time tables
> - Added NULL pointer checks to prevent crashes
> - AXP313A lacks PEK_KEY (0x36) per datasheet verification
> - Power button still functional using hardware default timings
>
> v2: https://lore.kernel.org/all/tencent_48A497E0CA81323CFB6C7CB84428019A8=
707@qq.com/
> v1: https://lore.kernel.org/all/tencent_5F1FF80489E702360F352F889570656BF=
608@qq.com/
> ---
>  drivers/input/misc/axp20x-pek.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index d4e2fc9a937f..964b39817af9 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -85,6 +85,13 @@ static const struct axp20x_info axp221_info =3D {
>         .shutdown_mask =3D AXP20X_PEK_SHUTDOWN_MASK,
>  };
>
> +static const struct axp20x_info axp313a_info =3D {
> +       .startup_time =3D NULL,
> +       .startup_mask =3D 0,
> +       .shutdown_time =3D NULL,
> +       .shutdown_mask =3D 0,
> +};
> +
>  static ssize_t axp20x_show_attr(struct device *dev,
>                                 const struct axp20x_time *time,
>                                 unsigned int mask, char *buf)
> @@ -193,7 +200,28 @@ static struct attribute *axp20x_attrs[] =3D {
>         &dev_attr_shutdown.attr,
>         NULL,
>  };
> -ATTRIBUTE_GROUPS(axp20x);
> +
> +static umode_t axp20x_attr_is_visible(struct kobject *kobj,
> +                                     struct attribute *attr, int n)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +
> +       if (!axp20x_pek->info->startup_time)
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
> +static const struct attribute_group axp20x_group =3D {
> +       .attrs =3D axp20x_attrs,
> +       .is_visible =3D axp20x_attr_is_visible,
> +};
> +
> +static const struct attribute_group *axp20x_groups[] =3D {
> +       &axp20x_group,
> +       NULL,
> +};
>
>  static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
>  {
> @@ -395,7 +423,7 @@ static const struct platform_device_id axp_pek_id_mat=
ch[] =3D {
>         },
>         {
>                 .name =3D "axp313a-pek",
> -               .driver_data =3D (kernel_ulong_t)&axp20x_info,
> +               .driver_data =3D (kernel_ulong_t)&axp313a_info,
>         },
>         { /* sentinel */ }
>  };
> --
> 2.43.0
>
