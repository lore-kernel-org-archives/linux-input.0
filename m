Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695723;
	b=m7WDjqOlSTdtiu6+LfQw5vZhPd83LjKtyPYfrjVHMnC/FMWqd6Ex0qL/L7fGyWbIdsID
	 eF3BG4tS8Kypv3ALKK+pW6pqoxBJq734fCMtzBrBpJbaGoYBFzpwI7qtzSmly3UR9ZIvv
	 OdEKetxI/JCmKQdnBvz9hnoHGnaU6CwNyad9t5BLak0no+Z3wVE5c/MqtgNwHhNykKlLK
	 ZxkqbuYcqYRWk3mp7gh/b6HkYDqluVdvQCp8IdN7KHPnktN3Bsd01fq6BmqdEJmTstlE4
	 itJB5CPDi0fcOJX0/z0MGtco4ryER94VDpkDsJ3DPUxUW8FXkS4j048ECaBqpIarGIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695723;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uhCvOoxtCeAdKm3WB8IgSXc0b1+4DiB9XnYag5mIGwI=;
	b=S0eKlDVpBHa5LrcNI60uAyqAX2NlUgwTCiMm5GPS6jw8X6dqSAlz3WEO1VcEhrI8m1yC
	 mLeSuzHcifqARo01WMJoik88g4AbXo3kH/Kh+9eZiI3YK36TAQKAXq69TzRn6vRPsLLRi
	 2BDTz3H8cb8tjQg566mnnXuIuUufKNCxuA7thiX2GTKakvBxjRYNOSkeIvFh4NGdJx05C
	 VSiGhNel1cH5YgCH56ISeg16a++kgYbazBBSLRYr0h/IpCj5VoHpuac+bIC6q7oaKRxzH
	 t0RFYkWhxAC+egl9xTLsSfsTG2zyI9Dgc7SdyzxFnFRquTKNaW2JeYdnrcUsBcsXWDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1ywzaDZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA6606A326
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1ywzaDZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7B71F000C1;
	Tue,  3 Nov 2026 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695723;
	bh=uhCvOoxtCeAdKm3WB8IgSXc0b1+4DiB9XnYag5mIGwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k1ywzaDZ3eisNUuVmVX1qXzFDuCeOM247w5wNBAcwjX7OUKeCbXtQRAQZxxmUJU9O
	 aCT4nq4nkuSU2n6PYv90cGd9GzZfmWQzx4SHXzxqR6XYBFRdOOuXTlibPrwUm+htu6
	 G8bH3y26H544avkPRIQp3IVEGLJyqIEyDpTSAVnLaUUih94oYzOrgj5bovzEvIORwC
	 Exa/tf+HwuoMHLwGjtpCC43tRBCVhGVuobzA5jPd7A9kQjhQk+GzOIF6AnOkRidghn
	 SZuVbDt22gsvjE1z3gUPVDD1io0vxc1mDszUhehPJCqpE3I6fbUMdUkGPEHGrhoecb
	 0aOrtx+5nGSUQ==
Message-ID: <sashiko-outbox-194881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: joydev - avoid signed overflow in the
 broken-axis correction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanglei Zhu" <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103084135.426629-2-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-2-zhugl3@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:48:42 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Input: joydev - 32-bit overflow in joydev_correct() subtraction
- [Medium] Input: joydev - s64 truncation before clamp() in joydev_correct()
--

commit 1426ece8bea8b467a9629c0559c54b6693b90b43
Author: Guanglei Zhu <zhugl3@xiaopeng.com>

Input: joydev - avoid signed overflow in the broken-axis correction

This commit casts the coefficient operands in the JS_CORR_BROKEN calculation
in joydev_correct() to s64 to avoid 32-bit signed integer overflow during
multiplication when user-controlled coefficients are set via JSIOCSCORR.

> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 32459fd8a7c18..947d7671a59f6 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -74,8 +74,8 @@ static int joydev_correct(int value, struct js_corr *co=
rr)
> =20
>  	case JS_CORR_BROKEN:
>  		value =3D value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
> -			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
> -			((corr->coef[2] * (value - corr->coef[0])) >> 14);
> +			(((s64)corr->coef[3] * (value - corr->coef[1])) >> 14)) :
> +			(((s64)corr->coef[2] * (value - corr->coef[0])) >> 14);

[Severity: Medium]
Can the parenthesized subtractions (value - corr->coef[1]) and
(value - corr->coef[0]) in joydev_correct() in drivers/input/joydev.c still
overflow 32-bit signed arithmetic before being promoted to s64 for the
multiplication?

When joydev_ioctl_common() processes JSIOCSCORR or joydev_event() handles an
EV_ABS event and calls joydev_correct(), both value (int) and corr->coef[i]
(__s32) are 32-bit signed integers. In the first branch, where
value > corr->coef[0] and value >=3D corr->coef[1], if value >=3D 0 and
corr->coef[0] and corr->coef[1] are large negative values such as INT_MIN,
evaluating value - corr->coef[1] overflows a 32-bit signed int before
promoting to s64. Likewise, in the second branch where value <=3D corr->coe=
f[0],
if value < 0 and corr->coef[0] is a large positive value such as INT_MAX,
value - corr->coef[0] underflows a 32-bit signed int.

Would casting value to s64 inside the subtraction, such as
(s64)value - corr->coef[1] and (s64)value - corr->coef[0], avoid this
overflow as well?

[Severity: Medium]
What happens in joydev_correct() in drivers/input/joydev.c when the shifted
64-bit product exceeds the 32-bit signed int range before reaching clamp()?

Because two 32-bit signed values multiplied in s64 can have a magnitude up =
to
roughly 2^62, the result after >> 14 can still have a magnitude up to rough=
ly
2^48. Assigning that s64 expression back into the 32-bit int variable value:

drivers/input/joydev.c:joydev_correct() {
	...
	case JS_CORR_BROKEN:
		value =3D value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
			(((s64)corr->coef[3] * (value - corr->coef[1])) >> 14)) :
			(((s64)corr->coef[2] * (value - corr->coef[0])) >> 14);
		break;

	default:
		return 0;
	}

	return clamp(value, -32767, 32767);
}

truncates the upper bits before clamp(value, -32767, 32767) is evaluated,
causing large positive or negative results to wrap around rather than satur=
ate
to 32767 or -32767. Should value or the intermediate result be kept as s64
until clamp_val() or clamp_t(s64, ...) is applied?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103084135.4266=
29-2-zhugl3@xiaopeng.com?part=3D1
