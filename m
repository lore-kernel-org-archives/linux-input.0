Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09B3769F4;
	Thu, 10 Sep 2026 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011200; cv=none; b=iZZyK4Zf5eQr2qW3EjYWKeLdIOjn/ink2j2h8vYP+csc+egXUQ8KJQm0ZXXD2WXnSeayCgf3hk5PoM+jGO3m/RVojoKVoP25EmbHUGUDqE2Zkjv4GIBqlyQrrpOtkQG9lDxsUAYm2R12ZLSM6y55lqT2dDndIEOKwiX0kW1ejqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011200; c=relaxed/simple;
	bh=QC/xW1G15ZO4EG4F2HJM3cU89gjYGLINI4frvqCcLgo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBbWApdH7X3mBclsNMF9q8r4kazBwXmGt8PzdWaTUcNqQCAN8ovF2MvC9OnrJ1myirYImpXQYFZURVZx2cFAYPxuaYRuNJZq6CrgYZlhVPsEldItaoqXE/TQCztTN85qpgB4L+jbzlYdXaWHQksHw7wj/Ftb1zGsKMV5QV7+jCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+yq8mDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+yq8mDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20021F00893;
	Thu, 10 Sep 2026 03:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011199;
	bh=gSRjfxGXHH+HVxCNsMcZWodkkZakE0N1lhQN7BaNK+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+yq8mDWGTcLVohne4Bg49yj1jmE0SQ0AOEH4LkFnCS7xDeWG/PuIhByi2Wd+wkVv
	 ldHQRjUQFNjltf7X7TnqfRlf2PCSiM5aiIJiAfs6AIxE7z9A69lu4q5UzuMSgxsqz5
	 2/OjVXDe0O1+6SefZLheOVhOHMtsV0T6T00w9SrinjQeRaNF5MeR6piXpBMJq/uvMU
	 M3he88qTL5/eWiy8LlLvTa3hjVRQjnIej/J9bKfxvMPdTX4XOKNyNVoTCu41vLwEwS
	 9ewqFE+R4HfbZh6NeBg3oI1fm5xR7F1Fy/lThETbYAy3wTvyjqoTray8O1lMyFAPUZ
	 Op1WK424f2yKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] HID: hid-oxp: select brightness policy for the
 new RGB effect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260910032115.28669-8-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-8-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:33:18 +0000
Message-Id: <20260910033318.E20021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete hardware state rollback in effect_store() leaves the =
hardware brightness out of sync with software.
--

commit 75feb6ea7d7e2f2f49294cf7e04996cd656c16bc
Author: Andrei Aldea <andrei1998@gmail.com>

HID: hid-oxp: select brightness policy for the new RGB effect

This commit updates the effect_store() function to set the requested effect
before constructing its status command to handle monocolor software intensi=
ty
scaling. It also adds logic to restore the cached software effect if either
output command fails.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 8d07816132166..9c22c8e0703a7 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1250,15 +1251,21 @@ static ssize_t effect_store(struct device *dev, s=
truct device_attribute *attr,
>  	val =3D ret;
> =20
>  	guard(mutex)(&drvdata.rgb_mutex);
> +	old_effect =3D drvdata.rgb_effect;
> +	drvdata.rgb_effect =3D val;
> =20
>  	ret =3D oxp_rgb_status_store(drvdata.rgb_en, drvdata.rgb_speed,
>  				   drvdata.rgb_brightness);
> -	if (ret)
> +	if (ret) {
> +		drvdata.rgb_effect =3D old_effect;
>  		return ret;
> +	}
> =20
>  	ret =3D oxp_rgb_effect_set(val);
> -	if (ret)
> +	if (ret) {
> +		drvdata.rgb_effect =3D old_effect;

[Severity: Medium]
Does this error path leave the hardware desynchronized from the software st=
ate?

If oxp_rgb_effect_set() fails, the software state (drvdata.rgb_effect) is=20
rolled back to old_effect, but the hardware has already successfully proces=
sed=20
the oxp_rgb_status_store() command using the new effect's policy.=20

Should this error path also send a corrective command via=20
oxp_rgb_status_store() to restore the original hardware status?

>  		return ret;
> +	}
> =20
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D7
