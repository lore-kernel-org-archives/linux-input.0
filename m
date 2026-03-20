Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028B3CFF76;
	Fri, 20 Mar 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026776; cv=none; b=BGHD3NF5235+PjaXk5s9GoCYO4ZWUSVSOcXg/VJC2OPqjAMnOwnmEJENrnBxR/KlrIRWdxKoTytZA1AIlYnI1W/lLLwmbVo+Anz/SWxZdI793FSHRS+he6nGDstUjdfHd9pshsRPLPSXHK51TejTH2vekveYGwhZceHTSdfOr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026776; c=relaxed/simple;
	bh=pNYzBr/drIndJkG6fX1g/4ff2U2fqhGyKwr64vMw1eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7yuawOmjCkcxYWi7TxFPM/sV9zPyJyVpgyZo4FXrojEF3Mkz/+BoxPkEHH0Rgj4hRhkuAHu03z+nO1CtuEVUAHS9K3ROJCDeb6pY3v2w20+jvv3iTXZd2UpDR2NIRFTBnrJY6Tpo0jevYGL2L93dr1mLolMYuU0eJMu2lLXIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=TmbaeVkL; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="TmbaeVkL"
Received: from [IPV6:2a02:f000:10bd:e301::1d7] (unknown [IPv6:2a02:f000:10bd:e301::1d7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 3D473534012A;
	Fri, 20 Mar 2026 18:12:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1774026772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N5BzX53f6eFhS3H12DtEB7Vnl4MeBHpXEgkfitH8icY=;
	b=TmbaeVkLNNvJd6t0NgHGyloRr6oI1i5ldJnYL2zn0xCSe1z0QcNv8gs++dfg9B/Dw6DlFp
	8ADSAdDw+MUdy6fFnx+HTK8EqGHWQ658nPzG+3UGT+pI2GdHOhIXL+7HcpErQBWnIltZlA
	IOF9j9Th/+uwDEXpcwzaK/KyvIyCDP8=
Message-ID: <f31d10ce-a3dc-4599-8201-8a78aa2fc65f@ixit.cz>
Date: Fri, 20 Mar 2026 18:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] Input: synaptics-rmi4 - handle duplicate/unknown
 PDT entries
To: Casey Connolly <kcxt@postmarketos.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
 <20260320-synaptics-rmi4-v7-2-379360de18d0@ixit.cz>
 <fba73d66-4300-4c4d-9bf6-4b38a4e847d7@postmarketos.org>
 <3dca0fc0-fe1c-4f84-b336-856f55a6e3da@ixit.cz>
 <55dab1d8-87af-4285-9ab1-924bf392c78d@postmarketos.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <55dab1d8-87af-4285-9ab1-924bf392c78d@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2026 18:03, Casey Connolly wrote:
> 
> 
> On 20/03/2026 17:54, David Heidelberg wrote:
>> On 20/03/2026 17:49, Casey Connolly wrote:
>>> Hi David,
>>>
>>> Nice timing with the series, I hit an OOB access (found it when I
>>> enabled UBSAN) with this patch the other day.
>>>
>>> The pdt_scan_state->pdts array should actually be of size
>>> (RMI_PDT_MAX+1).
>>>
>>> Additionally, I think rmi_pdt_entry_is_valid() is missing a bounds check.
>>>
>>> Kind regards,
>>
>>
>> Thanks a lot for catching this and for the detailed notes — that’s very
>> helpful.
>>
>> Since you’re the original author of the commit, I’m completely fine with
>> you taking over the b4 series if you’d prefer. Alternatively, if it’s
>> easier, feel free to just send me a fixed patch and I can incorporate it.
>>
> 
> Uh sure, not sure this will apply cleanly I just edited inline it's a
> 3-line delta. Also figured we can drop pdt_count since it's unused.

The pdt_count is used in

Input: synaptics-rmi4 - support fallback values for PDT descriptor bytes

thus should be moved there I assume, but can be dropped here.

David

> 
> ---
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c
> b/drivers/input/rmi4/rmi_driver.c
> index ccd9338a44dbe..c7d2f68e65487 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -494,12 +494,39 @@ static void rmi_driver_copy_pdt_to_fd(const struct
> pdt_entry *pdt,
>   	fd->function_version = pdt->function_version;
>   }
> 
> +static bool rmi_pdt_entry_is_valid(struct rmi_device *rmi_dev,
> +				   struct pdt_scan_state *state, u8 fn)
> +{
> +	if (fn > RMI_PDT_MAX)
> +		return false;
> +
> +	switch (fn) {
> +	case 0x01:
> +	case 0x03:
> +	case 0x11:
> +	case 0x12:
> +	case 0x30:
> +	case 0x34:
> +	case 0x3a:
> +	case 0x54:
> +	case 0x55:
> +		if (state->pdts[fn] == true)
> +			return false;
> +		break;
> +	default:
> +		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
> +			"PDT has unknown function number %#02x\n", fn);
> +		return false;
> +	}
> +
> +	state->pdts[fn] = true;
> +	return true;
> +}
> +
>   #define RMI_SCAN_CONTINUE	0
>   #define RMI_SCAN_DONE		1
> 
>   static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
>   			     int page,
> -			     int *empty_pages,
> +			     struct pdt_scan_state *state,
>   			     void *ctx,
>   			     int (*callback)(struct rmi_device *rmi_dev,
>   					     void *ctx,
> @@ -522,6 +549,9 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
>   		if (RMI4_END_OF_PDT(pdt_entry.function_number))
>   			break;
> 
> +		if (!rmi_pdt_entry_is_valid(rmi_dev, state, pdt_entry.function_number))
> +			continue;
> +
>   		retval = callback(rmi_dev, ctx, &pdt_entry);
>   		if (retval != RMI_SCAN_CONTINUE)
>   			return retval;
> @@ -532,11 +562,11 @@ static int rmi_scan_pdt_page(struct rmi_device
> *rmi_dev,
>   	 * or more is found, stop scanning.
>   	 */
>   	if (addr == pdt_start)
> -		++*empty_pages;
> +		++state->empty_pages;
>   	else
> -		*empty_pages = 0;
> +		state->empty_pages = 0;
> 
> -	return (data->bootloader_mode || *empty_pages >= 2) ?
> +	return (data->bootloader_mode || state->empty_pages >= 2) ?
>   					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
>   }
> 
> @@ -545,11 +575,11 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void
> *ctx,
>   		 void *ctx, const struct pdt_entry *entry))
>   {
>   	int page;
> -	int empty_pages = 0;
> +	struct pdt_scan_state state = {0, {0}};
>   	int retval = RMI_SCAN_DONE;
> 
>   	for (page = 0; page <= RMI4_MAX_PAGE; page++) {
> -		retval = rmi_scan_pdt_page(rmi_dev, page, &empty_pages,
> +		retval = rmi_scan_pdt_page(rmi_dev, page, &state,
>   					   ctx, callback);
>   		if (retval != RMI_SCAN_CONTINUE)
>   			break;
> diff --git a/drivers/input/rmi4/rmi_driver.h
> b/drivers/input/rmi4/rmi_driver.h
> index e84495caab151..a4ae2af93ce3a 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -46,6 +46,14 @@ struct pdt_entry {
>   	u8 function_number;
>   };
> 
> +#define RMI_PDT_MAX 0x55
> +
> +struct pdt_scan_state {
> +	u8 empty_pages;
> +	bool pdts[RMI_PDT_MAX + 1];
> +};
> +
>   #define RMI_REG_DESC_PRESENSE_BITS	(32 * BITS_PER_BYTE)
>   #define RMI_REG_DESC_SUBPACKET_BITS	(37 * BITS_PER_BYTE)
> 
> 

-- 
David Heidelberg

