Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD213790B
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192131; cv=none; b=cHVvXK8oTd+3hFQrifKPczWYTZfNESlg5eP2Wv1WdGkwby0z3I3yvbQAtQJeriJrXNyz7QShPbuEgFLF0OBwjc8hhypBtvlevv7k+NEzdj+8fUE/SlbvY8tz16f5mUMan9scCwOyfz9R0wBfO4sybCuzVFWujQmj4Ugx6LxyJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192131; c=relaxed/simple;
	bh=SDiiUWnqhJNEqF2a6+AgblFnyJmH35ewVs1RKIuJSzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv79zdvvmz0scSO1F0aI9xTKkxxUQs5hY5gRwbF1Qt2KusyaetWJe6fMsaYa92pJpYToM8JXt3VGmdkevdLQygrsCo/twunkzZ2HWB3EVwuzDoyXv+TieDznpaVoB8ZsMYQIsLXREvDBpIpGX0kgd8D6lOiZfQn70rq3gR4Jzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU4H060+; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU4H060+"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3078e0dcd67so6167334eec.0
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 22:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192128; x=1782796928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upLE1c/n2AlRZEtEFhcrlAmqpNROOYKhcTi+a7geFuE=;
        b=KU4H060+3pri5Hy6f1aziOlHwVPPulOM1xKh/TB+yokhABTBsRDLiromRca1KImE4V
         vXcoZzyhUlV/q9VrYxoB0qaJoC6Abf+c2rvjqHVRqO98+GdMHfjfdCjIso9DRoF94baA
         qNfUBK9a/niHP4NSTCvyT4XIJtZwoFBT1PWTT9+lJK68yy8vKYDCZ32AkQ3P3fP/VzoX
         M3YpCM/JVbUtnvycWAKs6TT6O5w6FAxrsFuxTEhEHMaHlOOJCXXaZ57dNPHWLx7z9AmD
         KaM/gFVkr2DBDXPrSZ/Y66nr2mnWPPUYaSvVAgPbI60x3LhFxniBsQ/jZ3C3ua4q7gxE
         G/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192128; x=1782796928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upLE1c/n2AlRZEtEFhcrlAmqpNROOYKhcTi+a7geFuE=;
        b=K9ZyK2no6JkthZEfxi7t2owhNtZDdKTrbeZ+72e/b5Zg/9iRoOs5QM7xv/SSnbKh96
         U8XOn8MCneBZJLV6heSayOykJVJEnrnagR3CvNBQ+KDzAbS+5xYqLjSx8eYmi6l3/iIQ
         DpJSO77DLbnjw0/YwjykOLYxXqaqWwUYdBaH7IINhEW5Ibkh1OAE6X5aD/i06WXdSpde
         TkmkE5jAy9odVNhSLxCZGiW14kAITSUafOhuMpY8sHWtWCHt8Zc1qYWB1D51gQPkzK0m
         /fFsJlFQ2sUPJs35Zzllk/alj2+rDs5v1vChtE9y7ju/psM1EGthgJkj+JjdAwMBJBC0
         /Y9w==
X-Forwarded-Encrypted: i=1; AHgh+RqiwR8SQlguYc7qWoKj6rfU+DEcrUmSXg+olqt0pk6VfHbV1X8IU1RqXVuLKUVuRG7j6/rxY5o4S31rWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88oS5gNe7vcdFDRSqf533y7s0CJcqHT9WimklSKiRYAAGR9Kw
	Tb2MiI/2CuFe70rUgRRv6a/NLnRP4IL2AoDNvSzlzLm1BzR/vMGPybry
X-Gm-Gg: AfdE7cmPd3rr5dJfp65km91jWh8iJ4xqYSqSYhIqV/hvBUMETLOhLJ2H/WVIM7wkRu8
	TSwUeaPec5x6p4yGEfJ42YnS33saR81zgFJRRhwerS+8pJsv9KLvBpb3VHExLeYQe9ry0DkQ8CZ
	ei/LdGvW5hLmWtKl8cMG11t/bXYH26nLYw3HEnmriNasIj/UXwLbR2HsUDpE9ta4b7VGI/eFhXn
	irWkfFUxT1XY6O7ANBgHi7jjdi9FggDxPQ9sVLIAWwG/ekaVdH4tDmO5irywfoca0ZUB/L5NHNz
	Pi2igLz3sZ2OPJsXt4Yow6MQiMA9bcoxW4KrFl5M8bVcEuDwG9Gk/PlVciy4sd3ojmoFmoPj8YA
	X7y2bgxC18XTN3HEKswH7fSzTuvazdWIaU5+HHQJzdCqwhFPMEyNQB0etp8Y/miI9dG3ffCrdlq
	8wUIcy/ykIQ3+zJxDt0QILZ7fxeRCQhMR8xeSmwdL8grLsqcYWL6qxiQ==
X-Received: by 2002:a05:7300:fb91:b0:30c:52c5:6e48 with SMTP id 5a478bee46e88-30c5b87aca1mr830395eec.18.1782192127715;
        Mon, 22 Jun 2026 22:22:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d8d:3bdf:d563:1911])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba57db7sm12956602eec.7.2026.06.22.22.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:22:06 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:22:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - bound the SMBus block read to
 the caller buffer
Message-ID: <ajoXuK4DrgSriiww@google.com>
References: <20260613-b4-disp-2e033955-v1-1-43ab7281667a@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-b4-disp-2e033955-v1-1-43ab7281667a@proton.me>

On Sat, Jun 13, 2026 at 12:39:32AM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> smb_block_read() takes a destination length but passes it nowhere:
> 
> 	static int smb_block_read(struct rmi_transport_dev *xport,
> 				  u8 commandcode, void *buf, size_t len)
> 	{
> 		...
> 		retval = i2c_smbus_read_block_data(client, commandcode, buf);
> 
> i2c_smbus_read_block_data() has no destination-size argument; it copies
> the block count reported by the device (the first SMBus byte, up to
> I2C_SMBUS_BLOCK_MAX = 32) into buf. The RMI callers pass buffers far
> smaller than 32 bytes - rmi_read_pdt_entry() reads a PDT entry into an
> on-stack u8 buf[RMI_PDT_ENTRY_SIZE] (6 bytes) during the PDT scan - so a
> malfunctioning, malicious or counterfeit RMI4 SMBus controller (or an
> attacker tampering with the I2C bus) that reports a larger block count
> overflows the caller's stack buffer by up to 32 - 6 = 26 bytes,
> clobbering the stack canary, saved registers and the return address.
> 
> Read into a local I2C_SMBUS_BLOCK_MAX-sized buffer and copy back at most
> len bytes, so the device can never write past the caller's buffer.
> 
> Fixes: 82264d0cf7ae ("Input: synaptics-rmi4 - add SMBus support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/input/rmi4/rmi_smbus.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index f3d0b40721df..ea957aba28f1 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -177,12 +177,20 @@ static int smb_block_read(struct rmi_transport_dev *xport,
>  	struct rmi_smb_xport *rmi_smb =
>  		container_of(xport, struct rmi_smb_xport, xport);
>  	struct i2c_client *client = rmi_smb->client;
> +	u8 data[I2C_SMBUS_BLOCK_MAX];
>  	int retval;
>  
> -	retval = i2c_smbus_read_block_data(client, commandcode, buf);
> +	/*
> +	 * i2c_smbus_read_block_data() copies the device-reported block count
> +	 * (up to I2C_SMBUS_BLOCK_MAX) into the destination and has no way to
> +	 * know its size, so read into a local buffer and copy back at most
> +	 * len bytes - never past the caller's buffer.
> +	 */
> +	retval = i2c_smbus_read_block_data(client, commandcode, data);
>  	if (retval < 0)
>  		return retval;
>  
> +	memcpy(buf, data, min_t(size_t, retval, len));

Instead of doing extra copy I'd like to get the following in:

https://lore.kernel.org/all/ZxGrwObOFkNuCn_w@google.com/

But unfortunately it has stalled. Can you try and see if it works for
you?

Thanks.

-- 
Dmitry
