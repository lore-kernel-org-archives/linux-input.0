Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580043;
	b=JUNoPSBSdZb715IMfm+D707RLjrzxnphrt1vdiVxSR860XIyzgrDmFf8EDxtxN0Jz5BM
	 ZP1Gf/sX7ALqlPpRg/lgcrRa7BOmia6pSbGY88RTs7JWmDY7lTwJed5kN5CHnEZdkgkHA
	 sj7CK2A8BhBWdVhHf0nRVLuLPuqDLEyaAXgBMdljDWyAiDDAIPffayysS/LLCeGgSJFt+
	 W8bnSrSSrmbbMwR7SaAG7X6/CvgPCu6s3XEIjY80yjuNwHyhPhHGmuEQqWlvqzjaFC567
	 bSBHdtHGVEoBnNz9PuVgUA3ofLWTFkTjR73AoTuuTRsBnxGDZfvcerQwHAw3GzYV4aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580043;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hpJ36xyZPKWbN6TAd1+Vr1Q2cNa8/zsHguDy8UEegXA=;
	b=txLv94L01j16bTKZmFZV1kItKVmRwlZxSPh4TfMXaPWSwI9XQbMXbQHuopaHTfUvrw8B
	 Ytl4dGFgFMXxMBrRq728uW3t1xqQed3+qwqLNYXzLAT+xsegrsg3KcOvN2GSpwZymqhOn
	 BLIlBwXNPhhzo+WbdaPdaeKgdksnPzT3In5dPhBSjH1V0mw+rtOpjpVHAPB8RVW9FSAZ5
	 vQXbFvixVgP2fB+19HlMNpmclk0P+XE3+J/SEq3F9zlshmhLUwMsauAMM+hC2Fv8dzGTr
	 Il0RQdQQkqXlpLH8pIxM/AyZ5MltMhcH/tD+fDnlEKa5IIUw+8OF9aJf/hL3SGo90uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn4BQudr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C218606A32E
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn4BQudr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF061F000C4;
	Fri, 13 Nov 2026 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580042;
	bh=hpJ36xyZPKWbN6TAd1+Vr1Q2cNa8/zsHguDy8UEegXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bn4BQudr1SXcJpralvhX9IMeROcRXpZJSnigFWAGJ/4akfZXS2Ls8YPQkvb/vPWbY
	 YxP0EACW+z0ZCp7kIKQDVLeYMToPioJQq7t7ZxamdLZScmpZoocI9Rm6PoHWjAimRV
	 Itn1/XfYANgWQ+9VWOh7CFKMK0C/DcU+XYf8825yag1NNkmB41BmFi503nextVQmrM
	 jif4AhFkz0PHX9qpgC1/qZSw4uXsUDLXqkfoL25wocBGSCcJ4jBSvCdEbxUCa2nZMV
	 IE+URIyUP5YsaH7FzTlU9K+WJlTtOZh/Rj/yJGvq94qzRNH5jhb/lgdfuL9g8UfoWE
	 N4gpn/yvw2Iqg==
Message-ID: <aa5ac70e-1d8b-4368-9453-cfc3bdbaa2c2@kernel.org>
Date: Fri, 13 Nov 2026 15:27:19 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: letsketch: skip string descriptors the firmware does
 not implement
To: =?UTF-8?Q?Eren_=C3=87akar?= <hey@erencakar.com>, jikos@kernel.org,
 bentiss@kernel.org
Cc: linux-input@vger.kernel.org
References: <1794567868877069470.1794567868@erencakar.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <1794567868877069470.1794567868@erencakar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 13-Nov-26 12:04, Eren Çakar wrote:
> The Starcom GC-422 is a rebranded LetSketch WP9620C with the same USB
> ID (6161:4d15), so it binds to this driver. Its firmware
> ("Vision_V201_180530") does not implement every string descriptor index
> that the raw mode handshake reads. For those indices usb_string() keeps
> returning an empty string or -EPIPE, letsketch_get_string() gives up
> after its retries, and the probe fails:
> 
>   letsketch ...: probe with driver letsketch failed with error -5
> 
> The tablet then does not work at all.
> 
> The handshake only needs the reads to happen, not their contents. Once
> the retries are used up, report an index that still reads as empty or
> STALLs as missing with -ENOENT, and let the probe skip it. Other errors
> still fail the probe as before, and the retries stay in place, so
> firmware that only fails a read now and then behaves as it did.
> 
> With this change the GC-422 completes the handshake, switches to raw
> mode and reports pen position, pressure and the five pad buttons.
> 
> The change and this message were written with the help of an AI coding
> assistant (Claude Code); I reviewed them and tested the result on the
> hardware.
> 
> Fixes: 33a5c2793451 ("HID: Add new Letsketch tablet driver")
> Signed-off-by: Eren Çakar <hey@erencakar.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/hid/hid-letsketch.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
> index b52e93a..6a93245 100644
> --- a/drivers/hid/hid-letsketch.c
> +++ b/drivers/hid/hid-letsketch.c
> @@ -213,6 +213,12 @@ static int letsketch_raw_event(struct hid_device *hdev,
>   * string descriptors. But the firmware is buggy and does not like it if
>   * we do this too fast. Even if we go slow sometimes the usb_string() call
>   * fails. Ignore errors and retry it a couple of times if necessary.
> + *
> + * Some firmware revisions (e.g. "Vision_V201_180530", sold as the Starcom
> + * GC-422) do not implement every string descriptor index the handshake
> + * reads. For those indices usb_string() keeps returning an empty string or
> + * -EPIPE (STALL). Report such an index as missing with -ENOENT once the
> + * retries are used up, so that the caller can skip it.
>   */
>  static int letsketch_get_string(struct usb_device *udev, int index, char *buf, int size)
>  {
> @@ -225,9 +231,14 @@ static int letsketch_get_string(struct usb_device *udev, int index, char *buf, i
>  			return 0;
>  	}
>  
> +	if (ret == 0 || ret == -EPIPE) {
> +		dev_dbg(&udev->dev, "String descriptor %d not implemented\n", index);
> +		return -ENOENT;
> +	}
> +
>  	dev_err(&udev->dev, "Max retries (%d) exceeded reading string descriptor %d\n",
>  		LETSKETCH_GET_STRING_RETRIES, index);
> -	return ret ? ret : -EIO;
> +	return ret;
>  }
>  
>  static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *id)
> @@ -256,6 +267,8 @@ static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *
>  	 */
>  	for (i = LETSKETCH_INFO_STR_IDX_BEGIN; i <= LETSKETCH_INFO_STR_IDX_END; i++) {
>  		ret = letsketch_get_string(udev, i, buf, sizeof(buf));
> +		if (ret == -ENOENT)
> +			continue;
>  		if (ret)
>  			return ret;
>  
> @@ -264,16 +277,16 @@ static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *
>  
>  	for (i = 1; i <= 250; i++) {
>  		ret = letsketch_get_string(udev, i, buf, sizeof(buf));
> -		if (ret)
> +		if (ret && ret != -ENOENT)
>  			return ret;
>  	}
>  
>  	ret = letsketch_get_string(udev, 0x64, buf, sizeof(buf));
> -	if (ret)
> +	if (ret && ret != -ENOENT)
>  		return ret;
>  
>  	ret = letsketch_get_string(udev, LETSKETCH_INFO_STR_IDX_BEGIN, buf, sizeof(buf));
> -	if (ret)
> +	if (ret && ret != -ENOENT)
>  		return ret;
>  
>  	/*

