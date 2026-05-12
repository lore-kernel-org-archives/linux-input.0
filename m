Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A7453497
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566076; cv=none; b=EqDxLgtPM/q4322j88Ph5CcH6BI7qSPlQM1AvvnyJ+lEVh1HS898PXVmoCTIqG7iJJKhPq3OcG/bgcyVY9yVhlFKlXRkm6o750MpiutUKYbjr3Z+/D2VFo6RQb7eV6MP5F93JzzleQlDrJJvcIo9JscLPAkpUvRvHudQ8AvJTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566076; c=relaxed/simple;
	bh=RA3fn/9t5pxWnMYFdn6IeYak1A2TAUUyhNtU8rlB9DY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oCIHc1CkNasUp7qdH1ZGf5YqprN38iAG0phUco8DdXL67qQwXQiaNtmzDze/tlZ5zImQIVGuIJ8NZiC8vVjFEL+CHD0glsDvYnv9h/TCoyJfI64tuhS7DNmuq67UdUftokwdAK1t8cYlXjq4nNv4XaDc7nFzjh/pULeQWJ+bn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDeFUd4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDeFUd4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD0C2BCB0;
	Tue, 12 May 2026 06:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778566075;
	bh=RA3fn/9t5pxWnMYFdn6IeYak1A2TAUUyhNtU8rlB9DY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bDeFUd4eT72BDqDQYx9hG4zSQq/z7mfzKFp2Gl9NoaMxBwndvlyBUqbvZ0laRxYWv
	 UpWctT6nRztxHjAGa13EsLu5QbjiGwhetQjYSU02P+dvKKiWckAxg7C7rmW9ZBmkcW
	 BFuIKKFJA4DdtZrHg3b0focDHG1/6gseld7uEKILVvrYicEQwKN6dFNvfD12mHiM0G
	 a3xmszXZ0OotKdi2oGNPOwCJHc8VcNZ3WLCZealj91CeY+RGHngRDRNJv459Omo8RQ
	 WvCr9ZCi7+sZxOul5/0GBMRv3uejc51DtFzjAzFookuGw1uLFBbKMgnOqB/T2F9bgZ
	 ZSptDFF7Cb3YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] hid: Pen battery quirk for Surface Pro 12in
Reply-To: sashiko@lists.linux.dev
To: "Harrison Vanderbyl" <harrison.vanderbyl@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <2702fbde567457ea0835ba12cc29421590e688aa.1778498477.git.harrison.vanderbyl@gmail.com>
References: <2702fbde567457ea0835ba12cc29421590e688aa.1778498477.git.harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 06:07:54 +0000
Message-Id: <20260512060755.18AD0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Macro value alignment uses spaces instead of a tab.
--

commit c48c3082a15452ea3cc6ed81c88834aa52ab9d60
Author: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

hid: Pen battery quirk for Surface Pro 12in

This commit adds a quirk to ignore the battery on the Surface Pro 12in
pen, which uses Bluetooth for battery reporting instead of I2C. This
prevents a phantom battery or device hang.

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -459,6 +459,7 @@
>  #define USB_DEVICE_ID_HP_X2		0x074d
>  #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
>  #define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
> +#define I2C_DEVICE_ID_SURFACE_PRO_12IN  0x4376

This isn't a bug, but it looks like spaces were used here instead of a tab
to align the macro value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778498477.gi=
t.harrison.vanderbyl@gmail.com?part=3D5
