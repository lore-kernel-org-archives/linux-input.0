Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC21C69D;
	Tue, 17 Feb 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352544; cv=none; b=Eae9MzlpCJoFWFTdMAHonisKST6d2QvOHbmZtJZkgaU0ODr0hCLI/nAaxn6S6q4F6TLPxRlY2vM4PAYiSQJQQ6HgNSCuFfTiE3K2uyWglgkCm8uJFIgaJxAJ3QhDxq9yhM5NGOc3rOVGk3yQclK2lHB/IaK3KMgSj+N/rh44hgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352544; c=relaxed/simple;
	bh=UZ4T8wqAdqtRsgXEIZFO9ft20OVlRtiSPFdEAIpsVEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePRgfWrLGIyTUwQZwis5C6YBU3P3Tks+Z1RElJv0wZKugrCW+bknL8ukog+JkrEts4dMW87O+f/6w+AYnAH1yTu1z1XBUgjCbOi51ulRt6ZkYHh+u+F0YQQ/OshuTJko2ihxBcXy88FS6Qvwfr1f0qjKmqLq/o8xbhgYFsrbJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGGWa4Sg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGGWa4Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E4BC4CEF7;
	Tue, 17 Feb 2026 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352544;
	bh=UZ4T8wqAdqtRsgXEIZFO9ft20OVlRtiSPFdEAIpsVEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGGWa4SgPhANYLabl8E7S639LTVJ7PM/aM2bCa019lBO59ndICCVI8Sd6Bc1HWJ64
	 oogc0b2owGW7HbTw/5Wcw/Jvk4YTQ5bfg9es3utoZmpVwyMiPhhJcYu3dn9bVnA65o
	 hZiVzg/Jj5H1zWztWmLxVkUy7uO2vHYpM2tlZckkWTmH5OEpD5jlvbPx5Lfzxpz8nZ
	 lwRVNkVR+hCNDB8JDePn9A2gAS67EgVF3dTy/2cQEzDDQwnXHQgHBgO/hFGIbgp4BC
	 OelihN/Pxxh+jjtRvrF1CFw/D+HLVfciE9J0AIP1Z8AXh/DSk8LZRsGBS3476TgHKC
	 EIpQDHnf26sew==
Date: Tue, 17 Feb 2026 19:22:20 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: apple: avoid memory leak in apple_report_fixup()
Message-ID: <aZSxeusondD26uN3@plouf>
References: <20260217160125.1097578-1-gnoack@google.com>
 <20260217160125.1097578-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217160125.1097578-2-gnoack@google.com>

On Feb 17 2026, Günther Noack wrote:
> The apple_report_fixup() function was allocating a new buffer with
> kmemdup() but never freeing it. Since the caller of report_fixup() already
> provides a writable buffer and allows returning a pointer within that
> buffer, we can just modify the descriptor in-place and return the adjusted
> pointer.
> 
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  drivers/hid/hid-apple.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 233e367cce1d..894adc23367b 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -686,9 +686,7 @@ static const __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		hid_info(hdev,
>  			 "fixing up Magic Keyboard battery report descriptor\n");
>  		*rsize = *rsize - 1;
> -		rdesc = kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
> -		if (!rdesc)
> -			return NULL;
> +		rdesc = rdesc + 1;

I might be wrong, but later we call free(dev->rdesc) on device removal.
AFAICT, incrementing the pointer is undefined behavior.

What we should do instead is probably a krealloc instead of a kmemdup.

Same for all 3 patches.

Cheers,
Benjamin

>  
>  		rdesc[0] = 0x05;
>  		rdesc[1] = 0x01;
> -- 
> 2.53.0.335.g19a08e0c02-goog
> 
