Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6FDDC5
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145221; cv=none; b=ACR9BdkaYtUOErs+fkGaaRedXUCmiFGFjB5bA6P/U+EuQSreSzEoUzPBFDWHdfMwOzFMvwwTwXk9TniLHV2C1PCT48WdC63I0lYOUj3TbeVyNmhlKMicYwVnNlNum/D6sTFmno+rG3UjB3CfFi1huPB5j/ZytNW8+R7WYmXWHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145221; c=relaxed/simple;
	bh=kWB1XUy9r2myVBJ25DLYhpNuMWrh5Cg6AIeoQM7ujVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8XBJ5dOtwBUh3hiU9nJjoSnrBM0bvxxBns8uEGgqZyKmUGh8/Ucmp+4dDy4YLl/xQPUMLawNVMwp31UCwmXoQIe8OhWew2MC16sNVuJ9hwCGKdXP9S5YJ5ZdIk1boPl6zvTAJtproFtqebraQ8r0Vq/x4KvvNZX5yKJibNq8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6UYFWDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6UYFWDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444861F000E9;
	Sat,  4 Jul 2026 06:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145220;
	bh=MDDPc/wB1j2CspTt9eUCEV0gjEwATh1nEiebG4Er2SI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6UYFWDMgsabAHMghbsAkpCGo9VUHR/VWL3noAy2hgkkRmZQsR4B17Zj59SR4RuWk
	 PSjzaydF8ukY7G8IAaU0dYEpPATKlICDUnS7Aau8iydQJWXMxsWdsyWl98RcoNOx9e
	 lnOWiozZGBTYl3DbE0yDuUUrBv6r28ckxepLX+UNX94ga0B+2MScCS02IxorlrQb/2
	 UnqgU4n743cOXbEykpXHx4/PGLvphk5TEr9iGGLe0UA6yp5rdKNxS0rQUnZqN1KLGA
	 Bp95+YKdXXWde5RZEiNnz/PkA4yJVe3YkLBqS4tndmRcGYi/X0RxIcemLgiLGDhp/R
	 HkSIrjXn50XHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/26] Input: maplecontrol - remove unused mdev->driver
 assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-12-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-12-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:06:59 +0000
Message-Id: <20260704060700.444861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `input_sync()` after reporting events in the maple control=
ler callback.
--

commit 0fbd521bb62afe1470ddde2cd989f82804cfb127
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - remove unused mdev->driver assignment

The driver field in struct maple_device is no longer used since commit
1795cf48b322 ("sh/maple: clean maple bus code") which removed the reading
of this field. Remove the unused assignment to mdev->driver and the now
unused mdrv variable in probe_maple_controller.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index 79cec89ad52a9..955e01bcfa0c1 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -95,7 +95,6 @@ static int probe_maple_controller(struct device *dev)
>  	};
> =20
>  	struct maple_device *mdev =3D to_maple_dev(dev);
> -	struct maple_driver *mdrv =3D to_maple_driver(dev->driver);
>  	int i, error;
>  	struct dc_pad *pad;
>  	struct input_dev *idev;
> @@ -138,9 +137,6 @@ static int probe_maple_controller(struct device *dev)
>  	error =3D input_register_device(idev);
>  	if (error)
>  		goto fail;
> -
> -	mdev->driver =3D mdrv;
> -
>  	return 0;
> =20
>  fail:

[Severity: High]
This isn't a bug introduced by this patch, but I noticed an issue in this
file while reviewing the driver.

Does the hardware callback need to emit a synchronization event after
reporting the controller state?

Looking at drivers/input/joystick/maplecontrol.c:dc_pad_callback():

	...
	input_report_abs(dev, ABS_X,      res[12]);
	input_report_abs(dev, ABS_Y,      res[13]);
	input_report_abs(dev, ABS_RX,     res[14]);
	input_report_abs(dev, ABS_RY,     res[15]);
}

Without calling input_sync() at the end of this logical group of events,
userspace clients will not receive SYN_REPORT. Won't this cause them to
buffer events indefinitely and prevent the gamepad from functioning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D12
