From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v2 01/24] input: Add ff-memless-next module
Date: Wed, 23 Apr 2014 14:12:59 +0200
Message-ID: <1398255179.32091.1.camel@linux-fkkt.site>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
	 <1398175209-9565-2-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60382 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbaDWMNB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 08:13:01 -0400
In-Reply-To: <1398175209-9565-2-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

On Tue, 2014-04-22 at 15:59 +0200, Michal Mal=C3=BD wrote:
> +/* Some devices might have a limit on how many uncombinable effects
> + * can be played at once */
> +static int mlnx_upload_conditional(struct mlnx_device *mlnxdev,
> +                                  const struct ff_effect *effect)
> +{
> +       struct mlnx_effect_command ecmd =3D {
> +               .cmd =3D MLNX_UPLOAD_UNCOMB,
> +               .u.uncomb.id =3D effect->id,
> +               .u.uncomb.effect =3D effect
> +       };
> +       return mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private=
,
> &ecmd);
> +}
> +

This mean you are building the structure on the stack

1. Are you sure nobody retains a reference?
2. That is needlessly inefficient

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
