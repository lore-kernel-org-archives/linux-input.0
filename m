Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571B2EA154
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145345; cv=none; b=qNvvXood+jMZ4L9H56JK7cG4JtD6HuRmWSqUqjyIIp92ySktc1M29YDAFtx0qg9R+3al0Fj9QymUIHKvGYLEWHehieW3X8vkTElRvQWQJ76iPoSuNHVE2IB2CNv20rT0KPOdb2KJ3EqeW52UD+4R0cSTRGtnvq0D6jzpxtdt5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145345; c=relaxed/simple;
	bh=DocF3sD5CT4EhUZhGDf8lwaj1jCA2p438/7hjhgPQWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jYk+uj971V7GkmAmkQLjBnlJwnVPSDs+zLTVWN8YliCb/LWJrED5o0wo+2Zy8YxbkJqTLigLzPrHyPfKRU+aR445+3n/IrOGHN/xTNo+0PJ9BhdCQLJ/CeNQnqUolcwjX1xHRH176aMbRDcZ7XfMYmBxTURsocZiDyuXcfzpuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYe4TZbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYe4TZbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD481F000E9;
	Sat,  4 Jul 2026 06:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145344;
	bh=1/6VwDKnBw0Kk7w/fy1nhNM8CtAqGxtzKJQJSntmogo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kYe4TZbgNhwKrN+ySNGa8R/Qx2ljR3kzpukRzjgCl5LW47je9hhEX+npm5n20RyaW
	 Vv54JM1kNSp7scCflPWHZMQ3nF72w6k4U19fdcR4rO1nF3gEu4qKIl7aat+ZMpsGuW
	 t3Nn9IqLWEcv36FEaMz1643uJZK+DHtSwrSe+t6uHYQCfUhZjj+8W9pG1mfuT88xup
	 N6QJc8yXkyMTQm0W3kUE/zhm39khgLN/4Kds3KJpbGlYojXz/otePZn05pxeKlGcs7
	 SPi19vwQ3aOxw2j7Lp//21oUrApJYONJPBg5cAF2MdScxOKzehLjN7gwc3hsxjhLD5
	 g1ENUxlhnEQvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/26] Input: maplecontrol - remove redundant drvdata
 resetting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260703-b4-maple-cleanup-v1-10-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-10-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:09:04 +0000
Message-Id: <20260704060904.9BD481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing `input_sync()` in the event reporting callback, causing =
events to not be flushed to userspace.
--

commit 049ef41ae581c4ec81e962190335026e0500fa08
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - remove redundant drvdata resetting

This patch removes redundant maple_set_drvdata(mdev, NULL) calls from the p=
robe
error paths and device removal functions. The driver core automatically res=
ets
driver data to NULL on probe failures and device removal, making these manu=
al
resets unnecessary.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index 6293b6e8148b3..79cec89ad52a9 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -62,20 +62,19 @@ static void dc_pad_callback(struct mapleq *mq)
> =20
>  static int dc_pad_open(struct input_dev *dev)
>  {

[Severity: Medium]
This is a pre-existing issue, but I noticed something while looking at the
code nearby.

In drivers/input/joystick/maplecontrol.c:dc_pad_callback():

	input_report_abs(dev, ABS_RX,     res[14]);
	input_report_abs(dev, ABS_RY,     res[15]);
}

Should this callback include a call to input_sync(dev) before returning?

Without input_sync(), won't the reported events (buttons and axes) be queued
in the input core but not immediately delivered to userspace?

This could lead to delayed or dropped inputs since they would only be deliv=
ered
if another event forces a sync.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D10
