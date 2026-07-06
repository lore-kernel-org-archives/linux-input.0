Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9E40A921;
	Mon,  6 Jul 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343715; cv=none; b=F5o0clVRkPNOIOrKaXTgjNsfUrRxVBeVrqyzWbiGgmm+J/Woy5vf2dTvyBt29do6S0iSyDR8+MVf7q0HNoHwQrl2N2YizGz2JVmh7xTKkkzSbwkqYoMfcgBJQyMp1A5aIeqMwi6Eqlx8F4Jz48MglYL1eJbDGMjpUUglyr0rKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343715; c=relaxed/simple;
	bh=x1w3I/q6YB2PAZQ3+vqNNYuAquzjC+Fpzy3jPahTZM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5VIQfEDZ0C6uWfIgspxc/yT+ToXSb5ZV+AAzPW18yMXvUYzrw4Fep/ik4WL/2hcc6g6LyKH8UVm9FR9LGTg9j9HUwHi3xGH/enBxPFQamZGyajbK+y0kqFdz6jgT8+gEg+AuzZXYvYWcYZL3JIBSki7qV+aYMEB1jm14mqvDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av/sC3f1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av/sC3f1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC31F000E9;
	Mon,  6 Jul 2026 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343713;
	bh=+CW5VXs7qixejPLnfylkALm0A28ZAhRQ18edXH+D6l0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Av/sC3f1aVT6IuEXXdalz+MbyZxl4TMdaw37AFNjtDhFHEBzsF6GeE1YaoDBDrYDw
	 4dUdnYDYSp5mNQYW1jf8XXP4ZqU9++IuSzukvFPxX1c4r0Kbn/OCLYG7mcIy3jGmHN
	 1GGFIn54byGWcqMvo5foKd6iXO9YgAffmm47kdW1rY3VPKysEpsRW1jbFsL/yYZ6cM
	 kVtxmP2xsD993BFbZSbCOS/w1uL0rIq/6mfnFZGCFT7K0ZaTkRqOtn1ArQU6bdzW9C
	 l88LKfk7L1miKyqwQLO1GtGIrFzFrM8cA3G+BQYneRzbr5nHSebcQ0xBTNY2zo0h++
	 EelEcJzDKse9A==
Message-ID: <73e40a61-c842-4982-9e6f-d6a13bdf742f@kernel.org>
Date: Mon, 6 Jul 2026 08:15:10 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: i2c-hid: Fix "(null)" device name error logs in
 i2c_hid_parse
Content-Language: en-US
To: Ai Chao <aichao@kylinos.cn>, jikos@kernel.org, bentiss@kernel.org,
 dianders@chromium.org, treapking@chromium.org, kenkinming2002@gmail.com,
 raoxu@uniontech.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260706122910.3943372-1-aichao@kylinos.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260706122910.3943372-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 07:29, Ai Chao wrote:
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
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
I think it would be good to track down the Fixes tag that this goes with.
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

