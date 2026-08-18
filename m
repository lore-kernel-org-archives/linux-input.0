Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6C33CE86;
	Tue, 18 Aug 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054911; cv=none; b=WyJvbKSuv01vhsioO5k8Svvp/7wWHbMN24fP3576N4Gim7yY6WQiVXehBuoIZw4x/OUgwEuov0H/Ost9SUGrAif6u9boTML5aHxJCCAOxC5QX9Q5zA+Mb1tXEkUSZvN086IYd6SYKFXSKCoMWXybHLwYsfmtLo6i4i0OqvIQQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054911; c=relaxed/simple;
	bh=ice2cXpmeFD74oyXDG7Jm+YeAsMX0Kr1S6Z4XFmg1G4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZbUYQRhC7x9VrS6QnsqWSRjC2GIuLPoMZIAxX/LJ2EwS6PqGbGYMW5jz6m/UyxfRDCSUDwy7qXuCa7pJvjgs+PGtv/hCg5gqeS1Sg6oJ0HHuvKYY0AHGQYa6m7Y+NVSI0BwGEVrv3YF6AK7X4Zpjhi4Oe5yhjFRj0nJuPVMxSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=pYGARc+t; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="pYGARc+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sgaJugQQN0jFSW3/x2Ei/owejKNyTf2phr0GdBbz+Po=;
  b=pYGARc+tkruSHtxzQT9zay+RkPSJtGxT/K/wQ5iaISG9tlC9AK3Vj+Vs
   Nu6OMRnJcIzSVKvAZfO5AfeeMabFu9YFgDQWM0AaU9tvqo1qhIT5241oi
   oYS602z+OUTnw4hAkb9pL9iyQs2p5Ek0ZEU1KR/AURvAkcNAWrDgncOLl
   k=;
X-CSE-ConnectionGUID: CYjMaZSYTRS4sRhcUVklEQ==
X-CSE-MsgGUID: yx6Ek282Rr+RFKjrGDxB6A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,230,1779141600"; 
   d="scan'208";a="290534621"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 14:08:17 +0200
Date: Tue, 18 Aug 2026 14:08:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>
cc: dmitry.torokhov@gmail.com, Julia.Lawall@inria.fr, bentiss@kernel.org, 
    cocci@inria.fr, corbet@lwn.net, hadess@hadess.net, jikos@kernel.org, 
    lains@riseup.net, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
    skhan@linuxfoundation.org
Subject: re: HID: add documentation and Coccinelle script for FF registration
 race
In-Reply-To: <20260818120428.2546810-1-ribalda@chromium.org>
Message-ID: <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com> <20260818120428.2546810-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 18 Aug 2026, Ricardo Ribalda wrote:

> Hi Dimitry
>
> Looks like media-ci is not particularly happy about this patch:
>
> https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/108127901
>
> /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /builds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch /builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/ribalda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include/generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/include/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/uapi -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-media/users/ribalda/include/generated/uapi --include /builds/linux-media/users/ribalda/include/linux/compiler-version.h --include /builds/linux-media/users/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1
> Position variable r.p2 on line 20 must be attached to some other token using @.
> coccicheck failed
>
>
> The following change fixes the issue for me... but you probably want to double
> check it, I am not proficient at cocci.

I would also like to improve this, as suggested in a previous mail.
Could it be detached from the documentation change?  Then I can take this
part and fix it up.

julia

>
> diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
> index 479f5d1e3184..7cf84936db13 100644
> --- a/scripts/coccinelle/hid/ff_race.cocci
> +++ b/scripts/coccinelle/hid/ff_race.cocci
> @@ -9,7 +9,8 @@ virtual report
>
>  @r@
>  identifier probe_fn;
> -expression hdev, flags;
> +identifier hdev;
> +expression flags;
>  position p1, p2;
>  @@
>
> @@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {
>    <...
>    hid_hw_start@p1(hdev, flags)
>    ...
> -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
>    ...>
>  }
>
>
> Regards!
>
