Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059F310784
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513873; cv=none; b=TVi+5dH1lLdbXzHQS1mOWLaj3GesryU+OZ6Fn1KnrJvskRXDJSRyWIk3R8AEE3wToxlNpOTgBAKno5I4zxS4trbiPbjCdPde9xTQ5O7pcaeqfp3mGEB44yb5CwENn2n1BNXHbkhiVxpSRw5LmBhVIaPQj7UJnlR78k/MKNd7WW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513873; c=relaxed/simple;
	bh=f0DJX35WYe/Q/8Gxu7Ao1YMwEKFrvc3Z9o07etHD5N8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YtrUX4r1X5BDjcNfPDJPHPowkwuYn5WFGnYQUKJe9+7REmso2rStoXUr6VqzR3HqzdMNGmYNo41Dj1bQQdAqyMg8h0KM5BF2WTumlVYYJthGechVQYsFuSAbt9GyWxjFGLBbi5peE7Y2KGR60669fT2K0qBJb7NNpreATEpSUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er7ajpZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er7ajpZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEF1F000FF;
	Fri,  9 Oct 2026 02:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513872;
	bh=zmEsAUeAyk2z9hFg9GIJ6Iq8SLk9Geb7rkfuZYJfwm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Er7ajpZ3Rr4iC2aevBuz1scA5QtAxMldv5NPL0yfH3ISC9cGnfpmbGBmzZmpq0jdn
	 usNa5enClYYDOtgaXViFXZ3kxIlfI/oSDsCSXEi0d6vDNPv3RGwxbXkm6f0LSIGRIJ
	 Y+acwdi2C9w4pRAqhjI4nebY79DbtGx4/aTgdur5R0Xjz/H4CRxTYeFtQWeAfiy2+j
	 HJ4Mtvju5s6pSi1S3JvnvkjuJbtYzqryOP8K+YjbfN3rkjekh1Bk7TMXCJmLCxN1QJ
	 sC2aBYkil4492cIUQdvuhjOT3sRzoeiM3u6LHBH7MAjEg7Elb/p0UHw+XscVRrJUPg
	 ArZWlPdW5GajA==
Message-ID: <sashiko-outbox-164733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] HID: wiimote: replace spinlock pairs with
 scoped_guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009022844.2790778-3-rafael@rcpassos.me>
References: <20261009022844.2790778-1-rafael@rcpassos.me>
 <20261009022844.2790778-3-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:44:31 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: incorrect preprocessor directive indentation
--

commit 6b73789c825ec316d85d88975b55b4fcb3448d0c
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: replace spinlock pairs with scoped_guard

This commit replaces manual lock/unlock sequences with scoped guards in the
wiimote driver. This is a cleanup that does not change behavior but aims to
make the code safer to modify in the future.

> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-de=
bug.c
> index fc847c2a1c1f1..b8027bb236089 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -7,12 +7,13 @@
>  /*
>   */
> =20
> -#include <linux/debugfs.h>
> -#include <linux/module.h>
> -#include <linux/seq_file.h>
> -#include <linux/spinlock.h>
> -#include <linux/uaccess.h>
> -#include "hid-wiimote.h"
> + #include <linux/cleanup.h>
> + #include <linux/debugfs.h>
> + #include <linux/module.h>

[Severity: Low]
This isn't a bug, but could we remove the leading spaces before these #incl=
ude
directives? The extra indentation violates the standard kernel coding style.

> + #include <linux/seq_file.h>
> + #include <linux/spinlock.h>
> + #include <linux/uaccess.h>
> + #include "hid-wiimote.h"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009022844.2790=
778-1-rafael@rcpassos.me?part=3D2
