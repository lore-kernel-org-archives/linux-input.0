Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B796345CBE
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140003; cv=none; b=FPE40CGuz1kJ9EQZzNdrhVrAD6EdH5KUXuXShmDU0oTH6uSWuq2DrIk3o6mXfi0mS8t9w3FJ5+FdQmwmbF8BHt5MOFw14OCtIIEaMc5OlkzgQGHd33zzmcuDHAs4MVifY8cPcccdo34oW9+ad9qiMSfvbzLnw8pUY/T1iH6LiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140003; c=relaxed/simple;
	bh=rOXD0KsPusd1XXkcyLUIEm8KFwhh9v5q6C9CRMhKNHA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VA9nwXc/sLnu08NKeCh6woOtqehOdRgrBUUJhE6qcB8wMC83CN2WOuYS4g5jJGxtWZxDBXkBfKoBl1AgiPtfTYJ+fk6cXCiBzYfHBZeR7lGGl0KR3K8I8FCRvlDRm26vDofhCiz2LoFN7pVxE2v82HaUzMRyrfaGbgvCvES0nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZjGgJAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZjGgJAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32EC1F000FF;
	Fri, 11 Sep 2026 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140002;
	bh=kMZFx+k0s+q7FykEi0KzxBRi76XcaXyaaclDsz+NDCI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=mZjGgJAn8Kvu2jazLMSmmLcVUhp1d2xw+F00OYJbQeUTC36vpmGhojzlU8EWXNzJa
	 ofOq30nG6GLGIZpAZwOlbDby07CqM28jhEnNK8ur3HixATpajVRYBrYTYpLR1RvVay
	 pxAV7h7+ojtBhHcO59123qKrQrtGX+b/rHJIqUKTGnVFzJluHZWm07TVCj0kvr79UQ
	 xi/vuHLwT4rwyUJshqXGSorUJnBpniRmBvYM8dYW0eJRzG+yjpivg8ijqir6qs6bwl
	 B5X2CywswJXxJT3UoN8RhS5/1i9vjb4AfoVGCMnbXSOKgo9itQ/YbpPE1q28LgKjdJ
	 413qEmEzdJECg==
Date: Fri, 11 Sep 2026 17:19:59 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Andres Diaz <andresd.diaz16@gmail.com>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for G502 X Lightspeed
 USB mouse
In-Reply-To: <20260901050147.123364-1-andresd.diaz16@gmail.com>
Message-ID: <oop4so0s-1n59-80n1-qp79-or433n209328@xreary.bet>
References: <20260901050147.123364-1-andresd.diaz16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 31 Aug 2026, Andres Diaz wrote:

> The G502 X Lightspeed enumerates as 046d:c098 when connected with its
> cable. Add the id so the driver handles the wired device.
> 
> Signed-off-by: Andres Diaz <andresd.diaz16@gmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 1504de3..493763a 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4924,6 +4924,8 @@ static const struct hid_device_id hidpp_devices[] = {
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
>  	{ /* Logitech G502 X Plus Wireless Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC095) },
> +	{ /* Logitech G502 X Lightspeed Wireless Gaming Mouse over USB */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC098) },
>  	{ /* Logitech G703 Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
>  	{ /* Logitech G703 Hero Gaming Mouse over USB */

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

