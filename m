Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9C3CF1EE
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587647; cv=none; b=dzMXKoVNcdaUhymWDpKF+EwRwsESem07IGf8aZZZ2N25n2evHVTrnuloPaOCngAGYDBNYoJ6oHSRJ6PmvZeCn7s1aufsy//jBS2YF9ZXvjNQBkDDDiB4ia8AdyfDUqEYdel5VzBO0EGNyXsVKiolymZt5bTwrtTMHrJfTStyXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587647; c=relaxed/simple;
	bh=qTeHnUCShDZC2eKO9aC0YwTx5JsxlQDXcNDjOtG5eIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJOdYNYtVx3D15o0StjpPtU0Q3lB52E6i2wGk4ACirwxd1QBOo636kyLRHyVrtiPkgEF0P9vatWHq0HEjjxyKBIl+DNoRoZZ4vhz1sUFtgdw6gdH6mIu8otkPAiBTot7tAWsg11H7qtQd+wGb3FLYd9D2259YsZdYocX3TuBiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhT/6dVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhT/6dVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640521F00AC4;
	Tue, 16 Jun 2026 05:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587646;
	bh=5vusplSMw7FvYyFHlTGctytjJk2LZJEJEUmKYhOWN9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IhT/6dVeIO9n5h/Stq+S7/e5NLaBDC05b+weJdjy7Ek2QEyjUBrnOrRPymokbznVl
	 l4wlqyoYoeWFaxtK0V1eRv3G/MqSFZEcseRO/UmRfN5bN49uLwaDrYz/wXbJDom+rf
	 DZ0nKeehvG1mxEmEByIf4HY1b/fzLFbdjUAFQjy0bBbr9VImtjUv0ENP+fyhYC9JWd
	 llvLdZ5kjXPjXm1GK3hUPj0XyQglfopke18xkQHsvSDkjcAu9XUIAEnp9h/OsWZjGF
	 2UzQQcir/Q7SDRFRLADTw17lu45wZ6qezWFm7Dv2BEF7FC4CA2A34sgFZFbOp0t5Fw
	 EOJdZ+CnHFTYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] Input: mms114 - replace BUG() and fix alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616050912.1531241-5-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-5-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:27:26 +0000
Message-Id: <20260616052726.640521F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in `mms114_suspend` leading to stuck touch state.
--

commit a5a14734d553a190d315dfdcd845e9a868df4005
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - replace BUG() and fix alignment

This commit avoids crashing the kernel by replacing a BUG() call with WARN_=
ON()
when userspace reads a write-only register. It also corrects parameter
alignment in several function calls to match kernel coding style.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index c59aec8f2febe..bf01eee0560a1 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential race
condition in mms114_suspend() that could leave the touchscreen stuck in a
pressed state:

drivers/input/touchscreen/mms114.c:mms114_suspend() {
    ...
	for (id =3D 0; id < MMS114_MAX_TOUCH; id++) {
		input_mt_slot(input_dev, id);
		input_mt_report_slot_inactive(input_dev);
	}

	input_mt_report_pointer_emulation(input_dev, true);
	input_sync(input_dev);

	guard(mutex)(&input_dev->mutex);

	if (input_device_enabled(input_dev))
		mms114_stop(data);
    ...
}

Can mms114_interrupt() execute concurrently after input_sync() but before
mms114_stop() disables the IRQ?

If a user touches the screen during this window, wouldn't the interrupt
handler report a new active touch state right after these synthetic release
events?

Because mms114_stop() then disables the IRQ, would this freeze the touch in=
 a
pressed state throughout suspend?

When resuming, releasing the screen wouldn't generate a release interrupt,
which might leave the touchscreen stuck until reboot or until that exact
slot is touched again.

Could mms114_stop() be called before synthesizing the release events to
prevent this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616050912.1531=
241-1-dmitry.torokhov@gmail.com?part=3D5
