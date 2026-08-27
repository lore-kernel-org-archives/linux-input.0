Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C73DA5DA
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873422; cv=none; b=SFWRs3sSOBo3XiaGPGz6VA03tMEPSiR9KYIHuZFL3nFXzWjyrL79FNuX/Z4EABNfiRGMLhM/oOoAKox4vx7lp8mbADtbyrpGC7Q7BaZ7yDvLD9Ca/9TkFSF9FhFppp3UpGLSVN8RLb2iVz0y4L9PKnkb3YO2kbMIpRf9yGVMlqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873422; c=relaxed/simple;
	bh=7EPyDCa0DPop8/gCMMZBMezgL96jUbgtPW2S2F9jDbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTw6IKc26sfJB3HgPepSAWmgcmiN6uxQ8T8KgHxrSd+q3OuxIWu6xrf/RsELBlK2v1TXRf+K953cQrWkOPYOdwMh9WDcewEkC0vR4FoUZndegv0TNqWvehvHaS8j/Q1SND0ZeMCJIR8e3gjOkkrCnNnBydUyP5N7J0XxH+EXe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/+haEy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/+haEy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416711F000E9;
	Thu, 27 Aug 2026 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787873420;
	bh=Eiy92LP2hA/zxo20wYEYKkGIZM/E9m1TwGhiQ/5e4sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/+haEy0mv2PDnOxD/8m91+Ftkr2PTXRg4NZCp1qS/yBfMu+MhY3e1bkc0TDjZdqN
	 4dWxd+WnUHO9KzvitQwLi5FBTf1PAzqt3xof+O/mzMS6c/XfQteLVwh7RrmkbWUAZl
	 b3A7G81tpalebZ9M/ELkTQzH426hxG2tTdnWuC17ZPpB5MFFuBk3nWUecwDxbEfNz+
	 4vwJ0j7chDm2FX7/hoevUsdKFrQKQPHxvXNB15wqFtJB5wngRzWSlqttfo6jglL0cI
	 q1yyDddC5T3E/LRYuuGZ6oBdvS5cuj2zoLyAHgl6MLCneudCgbzGDmRK5qn1PrsurT
	 sJUO9s+b9lQ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: drv260x: Restore configuration after
 device close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <684969b0f53a9e5f83636b219c139e904e74e14f.1787872237.git.mauriziocasciano7@gmail.com>
References: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com>
 <684969b0f53a9e5f83636b219c139e904e74e14f.1787872237.git.mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 23:30:19 +0000
Message-Id: <20260827233020.416711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Repeatedly opening the input device causes unbounded kernel memory=
 growth via regmap_register_patch().
--

commit 7b2939fba808d6cd89b89de289b90816dad3fa8b
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Restore configuration after device close

This commit restores the actuator configuration by reinitializing the
controller when the input device is opened.

Link: https://lore.kernel.org/linux-input/20260827182855.DE8E91F000E9@smtp.=
kernel.org/

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 6c5c4c53753b1..f26a9052edd2d 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
[ ... ]
> @@ -426,6 +424,21 @@ static int drv260x_init(struct drv260x_data *haptics)
>  	return 0;
>  }
> =20
> +static int drv260x_open(struct input_dev *input)
> +{
> +	struct drv260x_data *haptics =3D input_get_drvdata(input);
> +	int error;
> +
> +	gpiod_set_value(haptics->enable_gpio, 1);
> +	usleep_range(250, 500);
> +
> +	error =3D drv260x_init(haptics);

[Severity: High]
Does this code leak kernel memory?

By calling drv260x_init() on every open, it will repeatedly call
regmap_register_patch() inside drv260x_init().

Since regmap_register_patch() dynamically allocates and appends to the
internal map->patch list on every call, could this cause an unbounded memory
leak if a userspace process repeatedly opens and closes the device?

> +	if (error)
> +		gpiod_set_value(haptics->enable_gpio, 0);
> +
> +	return error;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.input-v2.1787=
872237.git.mauriziocasciano7@gmail.com?part=3D1
