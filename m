Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C653E277B;
	Thu, 21 May 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373640; cv=none; b=KYOpl5xdi9b5GSKmG6WjB4COAkLnt8uIhHt67sjcr5FcEHFFM+aEpTLVh+DhOQ1P4iqOEbBY2YhwQK+WwxarwpzFuSaH4ufNJjitH2w/fYbWLaA6JviTMzcpcu7Rh2Z58V9+TuoTBJXUakm7ebruCm4QkTITnKPPLctVqxvIbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373640; c=relaxed/simple;
	bh=IIebdDhPOCVdDEIob4rXnT5pcTrbMIoe+ULp4LPdUSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwN/M4L4peJoZDf43vyNUefttwMrmBdc9S+MBz2has/4tKThefBBYLV6HNAPLDSkz52AVlBWEhGW0/LxGSGi/0Pt1Lx1MESqYVVmMKg5hX3dh3TgP7IG/P9G/83e0bjq6qr9Pn0ul0Ts9BJPvVDTZhbdvsst+8PjJfqCrWllKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QymkSgxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QymkSgxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC51F000E9;
	Thu, 21 May 2026 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373639;
	bh=eq2OjLDZuH2kur6pB1vWpM2Z17WawuiWpaET5V6xwpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QymkSgxPw8DJUagCCAUErGhEzkCHqQ2fygBTtndvt78bagWcmy8WlUG6+/5WeAanc
	 eyl5wE57K8ZlIb5H5QwBK1zmqTHp2DwZCEqW5MxEExtmQh7mBCQIV/MIWaq7g0M8Uj
	 AaqruOg4FhS9JU5QDKlZsm6NEEqtSx1OhuHELJc9I9c12carFwIMo9DPEdukJGi9X8
	 j+h6CrYn5gw6z0V2gXfGaJPFUgS9EOlI6/09Miy9PnZ/uDYY952syPWQ+iBjR+SkIc
	 1fZGikMG3qvPfZNo/TAxncThTgsy3QxOE4thdHvmUZMxEqw6adHP2Sb8BJE6GKcx6F
	 0pA2tOQYE9Cww==
Date: Thu, 21 May 2026 16:27:15 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: l1za0.sec@gmail.com
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: u2fzero: fix general protection fault in
 u2fzero_recv
Message-ID: <ag8UFDazSyHKR0d2@beelink>
References: <20260421134824.35027-1-l1za0.sec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134824.35027-1-l1za0.sec@gmail.com>


Hi,

Thanks for the patch and sorry for the delay.

On Apr 21 2026, l1za0.sec@gmail.com wrote:
> From: Haocheng Yu <l1za0.sec@gmail.com>
> 
> A general protection fault in u2fzero_recv is reported by a
> modified Syzkaller-based kernel fuzzing tool we developed.
> 
> The cause is that u2fzero_probe() calls the u2fzero_fill_in_urb()
> function but ignores its return value. When the urb setting fails,
> dev->urb remains NULL, but u2fzero_probe() continues to run. When
> `dev->urb->context = &ctx;` in u2fzero_recv() is executed, the
> KASAN null pointer dereference crash will occur.
> 
> To fix this vulnerability, I added a check for the return value of
> u2fzero_fill_in_urb() and aborted u2fzero_probe() on error. And I
> added a NULL value check for dev->urb in u2fzero_recv() to further
> ensure its integrity.

Couple of things:
- sorry, but a couple of days later someone else send a patch to tackle
  the same problem at a better level IMO:
  https://lore.kernel.org/linux-input/20260424-u2fzero-probe-urb-unwind-v1-1-mhun512@gmail.com/
  So I'm going to take this one instead of yours. I would appreciate if
  you can confirm this fixes your current reproducer.

- Your commit description is not great. Please have a look at
  Documentation/process/submitting-patches.rst The thing that made me
  notice this is the non imperative form (quoting
  submitting-patches.rst):
  """
  Describe your changes in imperative mood,
  e.g. "make xyzzy do frotz" instead of "[This patch] makes xyzzy do
  frotz" or "[I] changed xyzzy to do frotz", as if you are giving orders
  to the codebase to change its behaviour.
  """
  The paragraph above is also hard to follow but valuable for
  understanding why it needs to be fixed.

Again, in the end the problem is that is dev->urb is NULL, there are
little chances the system is healthy and the device will work correctly,
so it's best to bail out early in probe like the other patch I
mentioned.

Cheers,
Benjamin

> 
> Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
> ---
>  drivers/hid/hid-u2fzero.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
> index 744a91e6e78c..c51f6dd80635 100644
> --- a/drivers/hid/hid-u2fzero.c
> +++ b/drivers/hid/hid-u2fzero.c
> @@ -134,6 +134,12 @@ static int u2fzero_recv(struct u2fzero_device *dev,
>  
>  	memcpy(dev->buf_out, req, sizeof(struct u2f_hid_report));
>  
> +	if (!dev->urb) {
> +		hid_err(hdev, "recv called without initialized URB");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
>  	dev->urb->context = &ctx;
>  	init_completion(&ctx.done);
>  
> @@ -341,7 +347,11 @@ static int u2fzero_probe(struct hid_device *hdev,
>  	if (ret)
>  		return ret;
>  
> -	u2fzero_fill_in_urb(dev);
> +	ret = u2fzero_fill_in_urb(dev);
> +	if (ret) {
> +		hid_hw_stop(hdev);
> +		return ret;
> +	}
>  
>  	dev->present = true;
>  
> 
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> -- 
> 2.51.0
> 
> 
