Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E31C84DC
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514665; cv=none; b=CvcHxH52tW64xhAALLFlzHgLc+w/xT1XIrrPp1WvKiVsgTpgaFvkyxJp24kSB+DdXDv7rYmDq0PgnqgTZPVTRUOM3mJcT1Ab9x94yAzkWGTcYyGZ1cwA+oj8GA0hp1J2vM3NQuGh5jUkGb0oyh49NyUpA1Pg5q2lRUQ3O1J5iOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514665; c=relaxed/simple;
	bh=fTSRCMPteWIOJ2nAVY27/MNgpeskdUMBI2u1yKzMVBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jtFUENMBZmFAE92/Qorrr+lI+y85c3xusbYjH/DCKUC9cMeCbtDB21vEcVxpqXNKXfX4Ke3FHZWTQnooaZDj0a6TntLK359QN2DM9RLpTfCbyWJTESOb1GuXPg3YlUxLeWsRspPka0imvJZPhG5A0jSjmtbCqO+3lwgLztuGOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnwRkrsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnwRkrsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CA71F000E9;
	Sat, 23 May 2026 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779514664;
	bh=NghgXwEd43oduGLE7BhaVJ0RfbaHdDAif8sdMVtt6XU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HnwRkrsAzPcwofAs21cNub5T8VabjIOk/NP5E4unD+QbRsZSO55DPzVaC6B89g76h
	 w4y1OyyTAJtP3mnTm7dgtIymBUEq/y3pgu7NjmLTJLka1eIRh1tMKf3M1lI5IncjH3
	 F36/Iz43yZAUQgqX3dwntnMB3SU9t++3Tb7F7p7S70J6fotDRanRgyFsrKs1hpdn6t
	 w/UAhC5HWBCWRYChjRPmJ+K0s++dPoCCu0l7aJz5Hmuv9fub59Ps8l5ZAkF3FZlmDC
	 2+Gye91twt1evzZAWxbkyL/zxHXeJUAEDPMYU1WazJVzOEjxcYYfhk3DRdMk3FVCxJ
	 aDOs4+CZjirKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] Input: ims-pcu - fix firmware leak in async
 update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-4-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:37:43 +0000
Message-Id: <20260523053744.07CA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing `goto`-based error handling with scope-based cleanup (`__=
free`) violates subsystem guidelines and alters cleanup ordering.
--

commit f3d6f89d29ebee4b433ceb5d40e22c091317e635
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - fix firmware leak in async update

This commit changes the async firmware update routine to use scope-based
cleanup for the firmware object. This ensures the firmware is released
if validation fails.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 5d1df07ac2a2a..e6603aaf7b303 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
[ ... ]
> @@ -934,9 +934,10 @@ static int ims_pcu_handle_firmware_update(struct ims=
_pcu *pcu,
> -static void ims_pcu_process_async_firmware(const struct firmware *fw,
> +static void ims_pcu_process_async_firmware(const struct firmware *_fw,
>  					   void *context)
>  {
> +	const struct firmware *fw __free(firmware) =3D _fw;
>  	struct ims_pcu *pcu =3D context;
>  	int error;
[ ... ]
> @@ -956,8 +957,6 @@ static void ims_pcu_process_async_firmware(const stru=
ct firmware *fw,
>  	scoped_guard(mutex, &pcu->cmd_mutex)
>  		ims_pcu_handle_firmware_update(pcu, fw);
> =20
> -	release_firmware(fw);
> -
>  out:
>  	complete(&pcu->async_firmware_done);
>  }

[Severity: Medium]
Does mixing goto with __free() in this function alter the intended cleanup
order and cause a regression?

Because scope-based cleanup handlers execute at the end of the variable's
scope (which is after the out label), release_firmware() will now run after
complete() rather than before it.

The cleanup guidelines also note that for a given routine, we should avoid
mixing goto and __free(), and instead convert all resources to scope-based
cleanup or convert none of them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D4
