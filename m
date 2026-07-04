Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D652EA154
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145565; cv=none; b=fHCbtQe2KNnewwJz4qnZyLVOrsL73nuM5nkdyTKkNXY+g5Qi1HoT4hjk1uLiSMkvw9CMEI3B+u4GSRSPrSRFCxakXCKNBuEg/u7b7dlmp2L9Icbh0YGCaZEBZjfQpH8OanB49cMMGZnjNZRCPImqchVmLPfjTDVfzH7DsMaDIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145565; c=relaxed/simple;
	bh=UVrDq5ZEDa5aJMta9EyiheBO94Kp6mzoXeM6hTCVBik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=or/nxbUEV4g+lBrlSgHMKb1VdPMN0nLtjBr4VEPadREOYGEdIyjAnLODLngyz4Wwb8h00eEKh3WYoWWoJ0cxQFFuooOLwocX9hMgFUnW+FYwO2YbFamQrZ9GsTQEAx/Hhi1evFjEBcP3P1cjEIOIEAy74PI6fP8w2vEYIOu5JlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dplaqoPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dplaqoPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73C81F000E9;
	Sat,  4 Jul 2026 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145564;
	bh=T9gfOaDuAypFdmuUgOf8TvaZGtVaNKeI5MSN57rZl0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dplaqoPMN42tQg8gvsQvWsnFowm+QoAUH4+v55OFlIM2PRdbDiVkFTPJaXyIeduNE
	 gIeIBUFnPLoCdpS/tTSE5wyH16QhSqQrgmm4QArIJ/4hBDdM/mv3uDipkiQF8L5n/b
	 VmojSBVxNETNrUlRB4b1DtLc/xLpl49EumwXqz+MkyO3nbqhMv5V/ZzI4vPM6e4Dw5
	 JXrvDnhvxopG2sVkXcyGmVCO29mh/k5gg9eH1eQ1SPx/IZIHBly0Sflu6NTI19xgAy
	 uQEY3ixwN6TRGTu/gszZO4ZF1udgfg3sVi8tDO0EwGi4FZQ6oTG2f4zl/3HfHN5K/K
	 Ejzez/a4MGSOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/26] Input: maplecontrol - fix style issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:12:43 +0000
Message-Id: <20260704061243.D73C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `input_sync()` in the event reporting callback, preventing=
 event delivery to standard userspace clients.
--

commit 85e64697864750aa3ae1b20ac7b36084615ece73
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - fix style issues

This commit fixes coding style and formatting issues reported by
checkpatch.pl. It switches to using BIT() macros and removes
conditionals when reporting D-PAD events.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
[ ... ]
> -	input_report_key(dev, BTN_SELECT, buttons & 0x0800);
> +	input_report_key(dev, BTN_C,      buttons & BIT(0));
> +	input_report_key(dev, BTN_B,      buttons & BIT(1));
> +	input_report_key(dev, BTN_A,      buttons & BIT(2));
> +	input_report_key(dev, BTN_START,  buttons & BIT(3));
> +	input_report_key(dev, BTN_Z,      buttons & BIT(8));
> +	input_report_key(dev, BTN_Y,      buttons & BIT(9));
> +	input_report_key(dev, BTN_X,      buttons & BIT(10));
> +	input_report_key(dev, BTN_SELECT, buttons & BIT(11));
> =20
>  	input_report_abs(dev, ABS_GAS,    res[10]);
>  	input_report_abs(dev, ABS_BRAKE,  res[11]);

[Severity: High]
This is a pre-existing issue, but does dc_pad_callback() need a call to
input_sync() at the end of the event reporting block?

When the maple bus periodically invokes this callback to parse the hardware
state, all axis and key updates are pushed to the input core, but the
function returns without finalizing the packet. Modern input stacks like ev=
dev
buffer events and wait for an EV_SYN sync event to wake up userspace.

Without a sync event after these inputs are reported, do the events remain
buffered indefinitely and fail to reach applications?

Could an input_sync(dev) call be added before the callback returns to ensure
the state updates are successfully flushed to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D25
