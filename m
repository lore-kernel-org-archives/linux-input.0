Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B3233941
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696947; cv=none; b=FgBt6ZrYSz0XRsZ8AOwuRYjaW9VfuG273CDVPS3aQ4Y9bd+3MriTDwK+GSBRen4JrQ9HID03bCZDjVP+OzyMEalwzXkttd4mvssug5Po+mdg5Nif7HQTMtoylS8hw3pJpEETbnZnc9XviNCAdoJkqfLmKCnqgh1WgqD3yIkVEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696947; c=relaxed/simple;
	bh=/LjDGMwNvEmF7kS96bs/jcRXJgJhKuSLEpO4wSCHTuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYjbhIAPP2eMH7gR/t2Tw1FD7lsr+y1WzyDyL8z0D2JLpKsgkiEsZCrNN48oMl0PiUlW7UTXp6ej44gfPCshVV2ab/S4qYSvoYGNWiLhjLuUBGQaRLIclfprM3ofMkNmypUxyk/5mCs0qhArMFborZNIh4dqIW4F2J2SU+iGboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPf0HRG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPf0HRG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9236E1F000E9;
	Wed, 22 Jul 2026 05:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784696945;
	bh=CpUCD5XdZ2hf187ixiSr1XV94OCdg57pweWHVpUXVek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPf0HRG3snYB4NMebzNePd+ok7M0cY3K/mE6M9bGTPs4C1mLDEdqE5AmfMN98PQ2X
	 szdSn07dpwzuNXIilKrUurIv096DeG6zV/BARevLgxiyzn5xEhQ7smuwPRvffCfslz
	 OgfbFdlRxLC9r9kGI+/9b6UmYQtONTCVCATAloWzIur1G8x8bqexYAEIQli8R6wiC9
	 Sjll7dK68flslJQILm0RX8uPJHp1qvy0NEgr1qAVqNh/WElmKW88GZqNHJA4jDZ1WE
	 Lgpku7t+OVBn5TcOuEduZS7mfmQbePgSpXcqRABetBsz0rytyGGMQ9oXO0HKW17k8p
	 ufs3YsBFmgiPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: wm831x-ts - drain pen-down work at teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260722045853.3255262-1-fanwu01@zju.edu.cn>
References: <20260722024518.3253280-1-fanwu01@zju.edu.cn>
 <20260722045853.3255262-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 05:09:05 +0000
Message-Id: <20260722050905.9236E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Explicitly calling `input_unregister_device()` on a device alloc=
ated via `devm_input_allocate_device()` violates input subsystem guidelines.
--

--- Patch [1]: [PATCH v2] Input: wm831x-ts - drain pen-down work at teardow=
n ---
commit f1080238ec479acff6be9e5861469736f7ad1c61
Author: Fan Wu <fanwu01@zju.edu.cn>

Input: wm831x-ts - drain pen-down work at teardown

This commit fixes a use-after-free race condition by draining the pending
pen-down work item during teardown. It explicitly unregisters the input
device before freeing the IRQs so that the close callback runs while actions
are still installed.

> diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchs=
creen/wm831x-ts.c
> --- a/drivers/input/touchscreen/wm831x-ts.c
> +++ b/drivers/input/touchscreen/wm831x-ts.c

[ ... ]

> @@ -378,6 +382,12 @@ static void wm831x_ts_remove(struct platform_device =
*pdev)
>  {
>  	struct wm831x_ts *wm831x_ts =3D platform_get_drvdata(pdev);
> =20
> +	input_unregister_device(wm831x_ts->input_dev);

[Severity: Medium]
Is it safe to explicitly call input_unregister_device() here?

Since the input device is allocated using devm_input_allocate_device() duri=
ng
wm831x_ts_probe(), the input subsystem already tracks it as a managed resou=
rce
and will automatically unregister it when the provider is unbound.

Explicitly calling input_unregister_device() on a devm-managed device mixes
managed and manual lifecycles, which can potentially lead to double-unregis=
ter
issues during teardown.

Could this race condition be addressed instead by fully migrating the drive=
r to
managed resources? For example, using devm_request_threaded_irq() for the
IRQs and devm_add_action_or_reset() to handle the workqueue cancellation mi=
ght
ensure the correct cleanup ordering without needing manual unregistration.

> +
> +	disable_irq(wm831x_ts->pd_irq);
> +	disable_irq(wm831x_ts->data_irq);
> +	cancel_work_sync(&wm831x_ts->pd_data_work);
> +
>  	free_irq(wm831x_ts->pd_irq, wm831x_ts);
>  	free_irq(wm831x_ts->data_irq, wm831x_ts);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722045853.3255=
262-1-fanwu01@zju.edu.cn?part=3D1
