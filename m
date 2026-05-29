Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115932D0D4
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090489; cv=none; b=YASH1Hv/noqMbmwSjT1OoSa//uew4umLhlPvGtC0Z9CW582OXlBM4R51ddcfOiGLOQnwdSgoU2cevyaGU6DVbI2EvMnZyQW7hh/Myow/hYiFvL+HrKWUbOm5haXp++NbldeT5GO+JM6ohQAsIvzdKfZvCDD717ycxX1i90YM3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090489; c=relaxed/simple;
	bh=0lVNYjLEUNOylrDmCmQrYmtZ2GlOw+1H9dVCcihGSPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBqmXkiIe4bhztHZRN+gIsLKEt17STLbezzSHpOtKJhkXJIgwa/ImoV8Naz8sjF9QIRxmbtXJwpFSfUOPNCmC/2m+eMaDBwYqTyRPZaUW3c4GhJSDwUIaamLaJPklW0tVBQ8PnbS1k71eYGU7Vs5oEB1YqxUYApLy+z8xnw7/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scr584Dc; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scr584Dc"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-135e7f4a295so6588795c88.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780090487; x=1780695287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHJD+WGMvI6ScOAGyvVweNtpM7wQC4AEbQ6AWYBlBPM=;
        b=scr584DcLKI0SBNmQ9BPbZyhebgYT9ZaHWDCubBX+MRbwhXRHP2Dwh5yFqNeUc81tx
         y17RzR4kxtrZlhWiI7+9O2TWSLxRQsgn4/F5oxlc/sScv8AFUGM5fqUYY+zWgLjN6mYi
         5Wv+BCRyU4I0N630z0WWgLlihk6RkWu6PPiwe1BxO8uwoKTH3MOqRmMB5Vs1y5HA+ddE
         EdH2MZ5PLNO0dkKzu6cvBdIwQiLXwwQ/RYhtSXq5DCrFDcYPXqfULH6KP9mAERDmM8Ol
         yIXIMou5MMqhzpya8+4kprLseclceiwRTGqVGc3ZCU/swXjwoD1rS6LHkydkrR/w9zr4
         omeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780090487; x=1780695287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHJD+WGMvI6ScOAGyvVweNtpM7wQC4AEbQ6AWYBlBPM=;
        b=UMUkBJwVmDR33uRnR8/OH0E0SpLhKS5zCJM9ttLk+553/g+0TKb6X3T2SuCIBExWZ2
         ypP5IcV6izG26UI3ogdMRe217/VqhkPwCQfstW7uVvikAld9NJn2mb0Wr+fTalyWI8V1
         ewLuEe13ZThDJs5mDpQ/em4E3wXfdyEbSXLOtZ9QRl3KNTfNGZyd/jTnPgItuKbTrNnu
         +dlpuGOmWLYB04lnfyMnUsmVSO+bPZchVHmVPRBDlmQWc23cS0B6xjn2C9bSOJzuzpAA
         CWA9hGT2N6NrxrMblRevP9hYghbHPg0f23s61ZVlE3qWGTY2ioIIaBjkwXS4Ox3PMLY9
         w99A==
X-Gm-Message-State: AOJu0YzC6Z67NX9fgb9s1nWgPG4yP5mrYJdOajjPvDyFAvQuIRTfNl3R
	VZCfx/46/tcF8QdCszWF4gllSiR6zuNBNFt+yf6BL3WuNqtvxEXAgUR2
X-Gm-Gg: Acq92OEVCyXD25KFRxqG3LZZ4Y8/Rd4muQXgYZpe/fcA+cMqQdI2vWkATxLmqP6N/h5
	12MKW5SztiAMTVdtsCBkylLgjskMi3sGSz16cwhsJjN2FQFK6DZMQrxPTtmUT3W1XsIMM9QkAFw
	w7CAGPNoCXtQp5DNphyXanfMdLkhWXnfJ6i0liZpTVbUjBsvt85EJpKpZvk6P9Uy5hOD69SWXT9
	2pHVhqAgQdUblDlMCTGHGy/yj07W/JSunbiP79av5H6nTJReKhZNHhwsE/3u6Rr2YRV0K/Mfm2W
	rD+VRfCA1VCM/rYRkxK2S7nBf6sn87ntcVagBO63ShxoDLsblJUo/dmULoz1e6G0dTpMoMkK0bS
	jVYvpkuDxmF205G1AqRGI3AQHysRgSJtjpMEyrFB0JcOFwfvVYHrB0QThwW1dtxekf+qvs4tGHz
	puu9dC4SdGEPU1UAdcrA7OJLdUzPOLMYudVQNExM9ZjwSYnJjNfYmZRHhIx6lmpfnkcA06EpjOr
	Fc=
X-Received: by 2002:a05:7022:ebc9:b0:134:d3bc:b4b4 with SMTP id a92af1059eb24-137d43bc909mr444225c88.4.1780090486836;
        Fri, 29 May 2026 14:34:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bcfsm1970283c88.10.2026.05.29.14.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 14:34:46 -0700 (PDT)
Date: Fri, 29 May 2026 14:34:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in
 wacom_wac_queue_insert
Message-ID: <ahoGOBmkc7i5ttxS@google.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
 <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528175945.2987781-1-jinmo44.yang@gmail.com>

On Fri, May 29, 2026 at 02:59:45AM +0900, Jinmo Yang wrote:
> wacom_wac_queue_insert() calls kfifo_skip() in a loop when the kfifo
> doesn't have enough space for the incoming report. If the kfifo is
> empty, kfifo_skip() reads stale data left in the kmalloc'd buffer
> via __kfifo_peek_n() and interprets it as a record length, advancing
> fifo->out by that garbage value. This corrupts the internal kfifo
> state, causing kfifo_unused() to return a value much larger than the
> actual buffer size, which bypasses __kfifo_in_r()'s guard:
> 
>   if (len + recsize > kfifo_unused(fifo))
>       return 0;
> 
> kfifo_copy_in() then performs an out-of-bounds memcpy, writing up to
> 3842 bytes past the 256-byte buffer.
> 
> Add a !kfifo_is_empty() condition to the while loop so kfifo_skip()
> is never called on an empty fifo, and check the return value of
> kfifo_in() to reject reports that are too large for the fifo.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
> Changes in v2:
> - Instead of a size check at the top, add !kfifo_is_empty() to the
>   while loop condition to prevent kfifo_skip() on an empty fifo
>   (Suggested by Dmitry Torokhov)
> - Check kfifo_in() return value to reject oversized reports instead
>   of a separate guard
> 
>  drivers/hid/wacom_sys.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b35..489ca68f1 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -54,7 +54,7 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
>  {
>  	bool warned = false;
>  
> -	while (kfifo_avail(fifo) < size) {
> +	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
>  		if (!warned)
>  			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
>  		warned = true;
> @@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
>  		kfifo_skip(fifo);
>  	}
>  
> -	kfifo_in(fifo, raw_data, size);
> +	if (!kfifo_in(fifo, raw_data, size))
> +		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
> +				     __func__, size);
>  }
>  
>  static void wacom_wac_queue_flush(struct hid_device *hdev,

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
