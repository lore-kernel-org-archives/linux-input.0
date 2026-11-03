Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699905;
	b=Evbe40oydmxZzz0bsuYLZkpO6RvFEDMAXK9+LLqBLjrAe4lHynDqxXhpWbWLOtCVmrB/
	 vUvUMHrn/c6TjqySPCyHc96w1NFQ5IXuONfMQ0psFpJTnNCcHS/H6QiuDW4sSPAg4COfF
	 J8OnNU10BVzNhp6lnnrGtw6Rw6AfeQrPiCKYfOcvUomqWGEyLytNGvVjGfUV4CIeaNpqL
	 LpK4pYUbf+oGmJ0OMCVB1KYSxidbhDAKQqumJytFIdGjBUzkwu116XjXYCfJb5BXu3S5x
	 QAshEnwarVQzk5SXlmCmPjRVJ0WBCDNzzDl/I9b92G40PDZ/BdPiqsP2yJ5uY8uFbgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=o1l0ybp/wLFt/F4zJKLBbBtJhS+ZACVIUqUnoSjbmw8=;
	b=nbs0YEvt/bI48TeVEoWOfpjbkr/eVFaA56HTHYadd/nLYVXsVuSbTv2++WGUZA6pmKOb
	 P3NXynk2wtd0uQnqNrWgdmO1mNa225eHK/yc+LecF2Cp4TdxGXQTQaZkjCviRI2YQPwFH
	 KWmQ125vLrBR46tY+zGGC/PLnirV7gjP3REtY9EKjmxxa4Kf/ynxGjNsq9Xwdtm+x+vU0
	 OaDohYz0VprHcQzuqmEY4dtKS9QS37VEPiX1PK1XlKor/UPIUW3YLxPTe+5zbhdfwZU3K
	 TlsZyKD4QxxBf6+RNOhkEqlIu+x0i21+z51Q7cTgvs/b26J5JcCXhiSfF2/G+dbkfbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VI2fSFNd;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA3606D81D
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 09:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39CA3606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VI2fSFNd
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df8fe8513so3414184f8f.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793699904; x=1794304704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1l0ybp/wLFt/F4zJKLBbBtJhS+ZACVIUqUnoSjbmw8=;
        b=VI2fSFNdPLaiNCoh32ApnOMV5kcLYHDY45DogC5AJ05Rtj0rSY3Uw8zvJo89rXS3Vc
         5SoEgxKwOQn8g/Q1Fk4rFPp0CD6qVnTAALVzhibTy9PdWXsxUgKp9K0TglK5Zbn5nQ+S
         MMk6iPJLXztz1yjrLLsdUR4JFrCiRTyqAJWMMJZzqKn0+0yNka44ct2pN2Tefnw3w94n
         AToW6lSO6OgkcnxsuMU6QKMHDrSJHe5J3rjiFZ4QXQwDMSizA7fQt/+amy8Ro4WIBjhN
         AIoXy1lLpyFtQhT1gklVCLIXQ0fclRFbHdq/MhECJMlwVAOEdjrj/A9BuBGR1bL9E06d
         yQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699904; x=1794304704;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1l0ybp/wLFt/F4zJKLBbBtJhS+ZACVIUqUnoSjbmw8=;
        b=sl3CmxBX8zcZQd12cz1Q9v+u853BuA9VxhX5IEKOBtDIFOs/K+q86m/IpTuN/bvNGp
         4GkLoq/WUby10WVkoZzu65n1z0l9Lta0swiY0riip6MMgb+1bOclWCALQHdvnrZKFd2i
         ZRaS8Vd0R/Jo0M38qPRilb+u3VTNWriAgDil8rozzVWxqSFJVCs2lW6NrN4QRfuqdfBH
         8BJ7XBYtXcJTZlkEOzO1DbdxilDB8wrgnhy/lJM6vugRG8YQ0k02wrKbwfxfOAPsSqar
         qAK2cK4n58RtlBjB3L5IUv3sIDD7RZYOeLJ2gHM/3Z1eJ9wQKNHSEv6cHICNwM/pL8BH
         YdaA==
X-Forwarded-Encrypted: i=1; AKwUvByxl3mQzvFh6AxfdaSLWcjSt3WBcz42eGisZXKgfLrDlC5o0VdAoyHNagrsFgf+I984OnaDkoGHW2xA7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yXt6NNy046w1MmPjR7dSr0wLxN4G0K3TuoOs//ZqqsUsNgbUf
	zAGwch55i2VbxICAtWkJFL7FbsK3qxAyakmKuHvaqyV+cteY6ra4q5hWsQi3IN/wI4g=
X-Gm-Gg: AYBFou2RM+Xj5hT/TRmDUnr1jyyKH3hzJ5W0hIu5kjY3Qj0ZEHzyeE3QtY7xevoe+ri
	WXJK9D0mTxEfES5AGOOU5sUCEyDTTDBdGRNPms+ZthWtyExmgQGuLItqGLBrcSjeTe0qJpQvZqO
	QS9l3wDF7HxLB6XsgJqAPmwyEELZThVf/ShFb1bVFKL7vVjeTQCe/tGb9J79O4trUcOGIq/PqKi
	ex1wzM6BmoxFAS/UMHY25EAKtk5GJC38ZyRUhiTOzVHlj3CMreHyUNIRoD3aIbbeRoKcGA3byVC
	hjzirpN+qG+Qrdc6n+6f3+X2YqW9T9t6ZHci3/TpBJsRryJKJ6j3pw7bF4H4XG7gWdNs7WWe5vE
	rU+C27/U850mjzVW0ZlAhk6d3AvWsDmvlRsW4pfJK/lptmogyCoHIYjRcvrYnENHELN3WkVCROC
	enw+hihINwF430j3igwPDKPbytabgntZEMl2HpPsa+3t7jQs8GyVjMqqvctP+yWh3sfnkk6HZZz
	KT9NpqGCNaZc5HElE0/PratcBeGrZUScLuKrdnoIMbo9uwxQVULhAG6PxUarsMAt3b5oVtB40g8
	4g4AEcPlsKNewBI3M2FZFcD/jAiuix3qKSAcjoC9ffY22n/fQ9u7hfqIsArOtXH2mYm9lyNdKeW
	TKir+ALA=
X-Received: by 2002:a05:6000:2b0e:b0:48d:eae3:b9df with SMTP id ffacd0b85a97d-48e6e50c88bmr21777860f8f.35.1793699903396;
        Tue, 03 Nov 2026 01:58:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:95a2:4869:9f46:45f0? ([2a01:e0a:106d:1080:95a2:4869:9f46:45f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm22710550f8f.15.2026.11.03.01.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:58:22 -0800 (PST)
Message-ID: <cf6437a4-b7ee-4b4b-acd2-bac3ea3f14fa@linaro.org>
Date: Tue, 3 Nov 2026 10:58:22 +0100
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
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] Input: goodix-berlin - set default resolution before
 parsing properties
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Hans de Goede <hansg@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: Val Packett <val@packett.cool>, Hendrik Noack <hendrik-noack@gmx.de>,
 Ferass El Hafidi <funderscore@postmarketos.org>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Jeff LaBundy <jeff@labundy.com>,
 linux-input@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
 <20261103044708.2461481-4-dmitry.torokhov@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261103044708.2461481-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 05:47, Dmitry Torokhov wrote:
> goodix_berlin_input_dev_config() currently configures the default
> 10 units/mm resolution on ABS_MT_POSITION_X and ABS_MT_POSITION_Y after
> calling touchscreen_parse_properties(). This unconditionally overwrites
> any axis resolution calculated by touchscreen_parse_properties() from
> touchscreen-x-mm and touchscreen-y-mm device properties.
> 
> Set the default resolution before calling touchscreen_parse_properties()
> so the default resolution remains in place when physical dimensions are
> not specified, while allowing touchscreen-x-mm and touchscreen-y-mm to
> override it when present.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/touchscreen/goodix_berlin_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
> index b0938a4f3fec..5cf453427eeb 100644
> --- a/drivers/input/touchscreen/goodix_berlin_core.c
> +++ b/drivers/input/touchscreen/goodix_berlin_core.c
> @@ -626,8 +626,6 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
>   			     0, SZ_64K - 1, 0, 0);
>   	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>   
> -	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
> -
>   	/*
>   	 * The resolution of these touchscreens is about 10 units/mm, the actual
>   	 * resolution does not matter much since we set INPUT_PROP_DIRECT.
> @@ -636,6 +634,8 @@ static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
>   	input_abs_set_res(cd->input_dev, ABS_MT_POSITION_X, 10);
>   	input_abs_set_res(cd->input_dev, ABS_MT_POSITION_Y, 10);
>   
> +	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
> +
>   	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
>   				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>   	if (error)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
