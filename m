Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECC2475D0
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777263746; cv=none; b=YR33nDc72Hd8UrD3iNY4mRwnrS30bbiHc5Se1Gv1YsanxzQoV7mFn+bCqxYPwPg59FG7WPq1x7DRMDuvrHVZ/LmftsU2CaQLEpgpXMUENqTng4s2YNo6ms+PYOVYnLkpi+uPImkN1z4JCMELFEPnQroJ8f4rdDjpLABHP+l07n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777263746; c=relaxed/simple;
	bh=lYtdJpAVnrQx6hQrJHr3GIXpHVS64/p+fZZmQi4iHFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSdj+j2TcNYHakdA0mlhwnejrzQ1ae+UDtrAe3zXbuHWVSnsa1Exo95mJcObSwKpyAaWeFf89k1Ha3jIgm75X+XbrQiIRU5U5q4mkNANfJ7zxS4vQJjEPhCQq83hJvMCdn/9Kp1QBfBDP9WqQoUOS7ewMKfydX6p91X2F/Lna/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWWZhX1W; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWWZhX1W"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c15849aa2cso12765151eec.0
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 21:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777263744; x=1777868544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzyBMDbqDtHLceRRTtVjP+zD0ZzRT+OcDwaRwtnQ8z4=;
        b=SWWZhX1WDFWpKQNWLEGiYEIRA0MmeBIDiiPE0KcWMS/c5vWvJcgSirN9J5wr9uAXGj
         RQlSdRJ0MKJ1OVExyXwds9m+39lcKJ1IWFVOgIJdIM/DMW9xyGARCKhwnZVyOJldKT8o
         LMbmlQy/X+DCj+H432tLBmyaY9Xn9renpByBaO3OrEOSH1ReYZBzBfK5OMaySrhURBNS
         XYiOxtyfhH3yuRbHOTJPDiz2LM2pw3fHLWXKVf8vfLpXQ420NaCaUkBZRGtflUXOsoNX
         DjtLF9+Gk2grg6SyWsTtqEB1/WGJ5hEQrzJB718zDgPkprtiM+pEm68LccVOEPo5R5tU
         msiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777263744; x=1777868544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzyBMDbqDtHLceRRTtVjP+zD0ZzRT+OcDwaRwtnQ8z4=;
        b=Fjqx27+LmUwJihr1iXpopTRfjmaTrcSS6re1Dhwt4VKhUS7VxMnKKAAIg2thoA9ESt
         pO96RvoNCK9rh8+LNhPdTt5Pu8Jp/dPLktAtvynYgtIP9CgxtFA6U7N+OYliw1MAQGHz
         keLWEoPCoBxB/xxxD6BFG2ErCtG6gUN1kXVCHu502iaH/zzBtT+fGqts+POU0lzwx21s
         c0O5G4mqt/B+zxS3Z4W6iWha4/lkXntZYh9+lZwtlbUj6Rcqlr7xoqneXhhgUOhRgBS0
         JlV2yyFFDdtB4M7QhI3WmyjRocb9V+1oCj3l7x9uoj7WWdXgHHlNQq1hB3/bQYJmPwwu
         kWMQ==
X-Gm-Message-State: AOJu0Yyr0lzFbSuw+6fq2JnYpBByW2pX9ZU2Q6HPTyCQiu5KrkQWR16s
	l6M0zb2xKf+ZDm6Oobvrq8wIE1Hw/T/7XbO0mqEi8N5QxOMPAifcNuc+
X-Gm-Gg: AeBDievlLnzeWp8vltKs43YhXGs8fwPDVp2hpa7rGeTUVdwjo06HcTc3ld+wOUXOIF7
	gnOUTvv2Wi2P85Q47DOH+gz/+rBP/grkT+SnYWw2QiJpLSeRnYlh4LzCUyEj/ee4zq6RgHKaTW2
	zFQFRD9CD4fLh50PUSg8Fm1GpsaiBE6lj349DwMw0B0FAZIRAqS8Ij91y+pdhk+du/jed+6EmA0
	F6xaSb19C90Jb7ezUrtQprGSXAytdKlagtWPYsaibdx5JMaVCE+Qhw1IeiPQLnP6+LkGDd+5BNG
	TLWqOfsKB7Jdf/hf2j8ORd+Qpzs4eDubNdqmKkO8qEFFRvXumtN3SCz9DzYHv5gtDgZfZXq3e/A
	7Fp+2HozdC3klUp99NzpPfZ8LRReFvWBoeBENFT3WsIhyt065JQaAfQZ6HN2n5PJHQArC8GwP2n
	R3gBIZKB6yHclctR9Ti4Uh2LkZFQzQJAAQWPcNYsnWTOheiLaBv1qzCgab2/mHKhy4juLhniKTW
	ASyxoiGYZNp
X-Received: by 2002:a05:7300:2d15:b0:2c9:ee15:a0d6 with SMTP id 5a478bee46e88-2e47901662fmr25039325eec.29.1777263744426;
        Sun, 26 Apr 2026 21:22:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:da2b:741f:93fe:403])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2ce98csm40493914eec.20.2026.04.26.21.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 21:22:23 -0700 (PDT)
Date: Sun, 26 Apr 2026 21:22:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Subject: Re: [PATCH] Input: xpad - reject short Xbox One packets before
 len-relative share-button index
Message-ID: <ae7kWV1Km1qoEeq3@google.com>
References: <2026042014-freestyle-deluxe-48e4@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042014-freestyle-deluxe-48e4@gregkh>

Hi Greg,

On Mon, Apr 20, 2026 at 05:53:15PM +0200, Greg Kroah-Hartman wrote:
> xpadone_process_packet() receives len directly from urb->actual_length
> and uses it to index the share-button byte at data[len - 18] or
> data[len - 26].  Since both len and data[0] are under the device's
> control, a broken controller can send a GIP_CMD_INPUT packet with
> actual_length < 18 (e.g. 5 bytes) and reach this code path, causing
> accesses beyond the actual array.
> 
> Since len is u32, 5 - 26 wraps to 0xFFFFFFEB, and data[0xFFFFFFEB] can
> dereference about 4 GiB past the 64-byte usb_alloc_coherent() idata
> buffer.  On a KASAN system this is an immediate splat otherwise the read
> will either fault on an unmapped page (DoS) or pull a bit from arbitrary
> kernel memory and report it as KEY_RECORD.
> 
> Fix this all up by properly bounds checking the value provided by the
> device.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 4ef46367073b ("Input: xpad - fix Share button on Xbox One controllers")
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/joystick/xpad.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index d6fc3d6006bb..7d99fe0ecf91 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1110,10 +1110,13 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
>  		input_report_key(dev, BTN_START,  data[4] & BIT(2));
>  		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
>  		if (xpad->mapping & MAP_SHARE_BUTTON) {
> -			if (xpad->mapping & MAP_SHARE_OFFSET)
> -				input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
> -			else
> -				input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
> +			if (xpad->mapping & MAP_SHARE_OFFSET) {
> +				if (len >= 26)
> +					input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
> +			} else {
> +				if (len >= 18)
> +					input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
> +			}

Thank you for the report, but this is quite ugly. I committed an
alternative version of the fix.

Thanks.

-- 
Dmitry
