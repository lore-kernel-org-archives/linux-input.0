Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94C2F290A
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145446; cv=none; b=fqQUJ0SNzb37EQwD6ifO3gZ0yun317ys2YV2MHLvlXplrul8XpiW6orCacMZKiBnCy0HSOKszNXNL4SzATJOPbG6WnHB0YjZA+WWugNwopzs1ea/2kl7TP0XDZdF1lPCS2NCk5evRy3We/vjZDcxIopCZrvDdeoKuzVdqGZ17TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145446; c=relaxed/simple;
	bh=4aTBB1HPaOl0HaQhXWnZPXXoWUF7JI09fsiV6XuKNVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ucWx3JpcosIJCrNEOcartRjdsbXVXcbJSAvNm07KgKphU4q84cL1jEmavxxFRY34wkawccjcMkoogE7y6FoGPQs1Tf8OImFxdBnFyNnCfbDULhCsxlmLkl7DZHBfCX7YH9D3IxxHlaDL0LGPWDDpixCsNaSOgG9GCkygUGIrzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6LVOVRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6LVOVRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036701F000E9;
	Sat,  4 Jul 2026 06:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145445;
	bh=kJrKDnMcjlbAYv0GPOKN5uVGpJ0JC5LXRnIWSWlxij4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e6LVOVRLCKk4QSahFBAqwBbfWWhmo0O4YKLoT8qN8ttik7p8ZqYD1gOwv3gG6XlcA
	 LlIlhlay51MemR3H81978FXS571bSvQwBxQqN7ZOqx/D8XsL4N24UtqZPsVfiRabge
	 O2B5wiHugO25V08cCNND4i/qTth1737SeGUN7BRNqT9XdWiiFkVKqjsQ0R6arMZvKU
	 BOYhPur4Fn4wVG5rC0V0+43lOFOz5mf4CqUZTfKuemVNc1d16QPI4Ht60QCCfEs7Oz
	 falzZYPTMeoN2PjomoiiLCJj/URC4UTZnTvjw+7aUvYlZSZp+wiB3XVjQBVWx+zdyG
	 23Mr9a7W0363A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/26] Input: maplecontrol - only enable present axes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-3-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-3-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:10:44 +0000
Message-Id: <20260704061045.036701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The event reporting callback fails to emit an EV_SYN/SYN_REPORT ev=
ent, preventing userspace from receiving state updates.
--

commit d051181458cb7495a31496a5fdf31e5e286b6656
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - only enable present axes

The driver was unconditionally enabling all possible analog axes and hats on
the input device, even if the controller reported it did not have them in
its function data. This patch moves the input_set_abs_params() calls inside
the capability check loop and corrects the D-pad (hat) axis limits.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index 6293b6e8148b3..a498fc322c4d5 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but the event reporting callback
fails to emit an EV_SYN/SYN_REPORT event.

Looking at dc_pad_callback() in drivers/input/joystick/maplecontrol.c:

    ...
	input_report_abs(dev, ABS_GAS,    res[10]);
	input_report_abs(dev, ABS_BRAKE,  res[11]);
	input_report_abs(dev, ABS_X,      res[12]);
	input_report_abs(dev, ABS_Y,      res[13]);
	input_report_abs(dev, ABS_RX,     res[14]);
	input_report_abs(dev, ABS_RY,     res[15]);
}

Without calling input_sync(dev) at the end of the callback, won't the evdev
input driver queue these events indefinitely without waking up userspace
readers? Does this prevent userspace from receiving state updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D3
