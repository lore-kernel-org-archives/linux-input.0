Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D3224AF1
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145222; cv=none; b=BVWxYYkSsIJrJ6dheHY9BlVQlroypcziOcJEyatWOhbq77EDNWz5vksZAtUVaTnKvbXxOfOtH8j3Y9lsEWmI19nAeHBDhJTLFtmk7k6YJXuwYR+gxLS3wdOpo8VX5uzzkbMeM9Xdi4BpBRvTRLmsTWG3e0+l4EvRVWRLW0E8qH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145222; c=relaxed/simple;
	bh=+0R3ImQsS4sxuIqBhKJpt5a7M4ZWnqiK65c2cQZIh1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVj9LnGK3/AqMmypUpyvFsYtpasZ0YhpIXWqBBKBWQBHuRWn84Z6ssZjG+jK8FeJY04hQNc2rGsQKqXw2Yk6SJH5DU6qrrDHQUtdvNrY3Is7UlNwnhSD397W6s0msRWKtnJvNCW63qsQ6vEkdTXOs0Qpu0l34R6+y8PtHEjbzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSmpONJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSmpONJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB901F00A3A;
	Sat,  4 Jul 2026 06:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145221;
	bh=aCTJsILqBLfpUE6xp0sGr5aA77V/7zXFWpJDrtRccNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jSmpONJZB9TeDj+NHh5XUU22FyNDpCsPks8mK9xpx2o+aVk5jKDHNx9hw94dxaA8y
	 owHtAUdUQdTN7f99ECXQ4+uIZ9nq8F41r5K9c/Usz7cMa0y5kXorzR29234R5uVH7m
	 EcmevuiaQGYeVpE/RXvyT+Ye8WnC0scjx41krILdw6ANI9TCTkQmlENnuChKQfdcFa
	 jnL1f82vpIdAWapPN4cMjcwLy9YZlahNLMnhrVJtn8TETCEX90Tf2aNAgglqXtJoxt
	 cyBpyM7enmvhQI7KVZh+jvyF08s8H6vk3lBAfBOPTTVJcqR9Yy1n4NucB3SlFMNAhA
	 RfznQT0BRvi4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/26] Input: maplecontrol - stop polling and clear
 callback on close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260703-b4-maple-cleanup-v1-5-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-5-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:07:00 +0000
Message-Id: <20260704060701.0AB901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The event reporting loop in `dc_pad_callback()` does not call `inp=
ut_sync()` after reporting a group of input events.
--

commit 5b43e607496d623e78583ef58f7527944fe7a924
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - stop polling and clear callback on close

In dc_pad_close(), pass NULL instead of dc_pad_callback to
maple_getcond_callback() to both stop polling and clear the callback
pointer when the input device is closed.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index a498fc322c4d5..c66b2614e2982 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -74,8 +74,7 @@ static void dc_pad_close(struct input_dev *dev)
>  {
>  	struct dc_pad *pad =3D dev_get_platdata(&dev->dev);
> =20
> -	maple_getcond_callback(pad->mdev, dc_pad_callback, 0,
> -		MAPLE_FUNC_CONTROLLER);
> +	maple_getcond_callback(pad->mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since dc_pad_callback() is
involved here, is there a missing call to input_sync()?

Looking at dc_pad_callback(), it reports several events without ever flushi=
ng
them:

drivers/input/joystick/maplecontrol.c:dc_pad_callback() {
        ...
	input_report_abs(dev, ABS_RX,     res[14]);
	input_report_abs(dev, ABS_RY,     res[15]);
}

Without input_sync(), EV_SYN/SYN_REPORT events are never generated.

Will this prevent the input core from waking up userspace readers (like
evdev), causing reported events to be indefinitely buffered until the buffer
overflows?

Since maple_dma_handler calls dc_pad_callback() on every data transfer to
report new joystick states, does this omission break event propagation and
make the joystick unresponsive for applications relying on poll() or blocki=
ng
read()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D5
