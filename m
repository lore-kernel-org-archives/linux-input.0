Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DC42589A;
	Thu, 16 Jul 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209828; cv=none; b=LrEj93cxsjItGgriOo/ht8l1Vq1nlzj1fFY7awu9VU5eF7pveXNLWXK8xkvRs24JEA6NZU9MQ/ozRJJIq0OUYBOG4OmLDDji0TZgL/fvK560xJqACCX9fV7JJktHENSpWX2+pcJmojYFMbMbADC1bMk/dWrpzNBG4f/9FBOX9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209828; c=relaxed/simple;
	bh=T3n5Bae1hVntgjx1zp1AjZmd11FIjtYfJ4CKwWoha5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYLfiEY/25aU3ATSQjtiQFfw8/e14xU5mcLFGLFjVvrdDr06tMnCo0881OQitSXeUmmZXjXCyYfo8eLS8RUD43r7gD98/K2ChW6VJ3ZT4oRAYts6MZfgV8RXzG3oMuhaWfi1gC7z5MRBDj5BTAhslRkJlTUmdNN7c5EZFn4Ynps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmNGjM7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmNGjM7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F041F00A3A;
	Thu, 16 Jul 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209826;
	bh=glRJo35PxLXmQvbajphsfvpUppiKWB4U4dH0Vt0SOCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lmNGjM7I/mdftjguWgnfWH27847GkLdnv1jG4YJhSJRDdQ9Z2XvYJkuomA9Uqn3yx
	 CEmaq4ph7a0hSwickdWnLbJI8+Se/9qxAIB2OLQcqZEEJu+/VE5OxJ7clLm1QOk08M
	 5Y8QYCnd4Y7AoTYFwEimjBx1GknF0KlUqRRia59fbk6EekYLhBo18AV7RFGICmKIOp
	 KZ5ngQzmp2RLxZqlYF0+lRPSwih7iBY2twYEKDrmKpSDKF1+sWxI4lKlxySfXqiC14
	 Nq4lh/5Y6dJ2wMh/AdsCL+U/bOnLI7ksTt0UFBBjOcECAsoZnenX4rA+F/rgnVZCtA
	 kOJ0vs4XR9sSA==
Message-ID: <2d193a9f-dd0c-409e-982d-d60d4d64128d@kernel.org>
Date: Thu, 16 Jul 2026 08:50:24 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: i2c-hid: Fix "(null)" output when reading report
 descriptor fails
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, jikos@kernel.org, bentiss@kernel.org,
 dianders@chromium.org, treapking@chromium.org, kenkinming2002@gmail.com,
 raoxu@uniontech.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260716112932.4038146-1-aichao@kylinos.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260716112932.4038146-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 06:29, Ai Chao wrote:
> When i2c-hid fails to read the HID report descriptor during device
> initialization, the error message prints as:
> 
>    hid (null): reading report descriptor failed
> 
> The HID device name is set in hid_add_device() after calling
> hdev->ll_driver->parse(), so when i2c_hid_parse() fails and calls
> hid_err(), the device name has not been set yet, resulting in "(null)"
> output.
> 
> Use dev_err(&client->dev, ...) instead of hid_err(hid, ...) because
> the I2C client device is fully initialized with a proper name, providing
> meaningful error messages for debugging.
> 
> Before: hid (null): reading report descriptor failed
> After:  i2c_hid i2c-TPD0001:00: reading report descriptor failed
> 
> Fixes: 4a200c3b9a40 ("HID: i2c-hid: introduce HID over i2c specification implementation")
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> change for v4
> - Add Fixes tag.
> ---
>   drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 3adb16366e93..0e725a0f0abe 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -792,7 +792,7 @@ static int i2c_hid_parse(struct hid_device *hid)
>   					    ihid->hdesc.wReportDescRegister,
>   					    rdesc, rsize);
>   		if (ret) {
> -			hid_err(hid, "reading report descriptor failed\n");
> +			dev_err(&client->dev, "reading report descriptor failed\n");
>   			goto out;
>   		}
>   	}

