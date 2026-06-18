Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93583EC2DE;
	Thu, 18 Jun 2026 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778503; cv=none; b=a5w3Q8tkifFCE0SjxLMMkO2s2r7MrHTXQ3GSgfKVgkHqaheXUczxOmznAEJ9qFOinu2sf7eyFclfkvO0CcdFD2LKzM3oSlR/Mhvc3AUo/PHCY9sCymzYaNj1/oewxpwI4qTD9uD6uLgeqn2i+asmw9QJnftInaRVNZabSWty3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778503; c=relaxed/simple;
	bh=i8dWBPkCV6sup7wlqT8WOT+UPSuyifLBXLyItsJrmsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEk+6qBu7ydg3Q80JAC6fbMiFmgr/DXdLUYIQ1om8KSqnODp31QFtbqPUtSFNLEvVdzwNl9Fnt8PXcygUt7mOT9PKlc2EAnhvdl37dxNAmgOvcmMjcO7PhPuKac+bpNMGIDsAcuwWu2IIDH2EZpWxbckTWJFaSyG6ghbA71+y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkKyzQ3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkKyzQ3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B61F00A3A;
	Thu, 18 Jun 2026 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781778498;
	bh=mdkOSpTviP3MSb2ZciB67ICpP7W47zUs7U01uoqLdz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dkKyzQ3FefxZkbUxQkpL5DQ0l43bOGs++1t7Yq8MSJbyOc5K9sL+aGkU4azSwKWgi
	 NqBkAHe9Xfi39O6NgQGOcn+L7DbalegLv6I9f1gvJyvTbBDTH7ccentIy3ah5sKZLX
	 JbokO6XjA+XlJBGyxahtFhkrVFOD3AARSQ2MDSBIcHDGz9T3g9eoUdCCcJPbvMAiHA
	 dTwcDE0XI69BLqv5ck3dWaouEYXU8m4IUr44Lu0TDhRepgKH0//MlOGJMFDuW0GfLq
	 qjYDXMb8keEdHZGyy74N603T9cj5z4zZ6XQp9ssVqzxg8lNcuHCnhekZxdlQseOsPw
	 YNuJPbsv9y5jA==
Message-ID: <bc8fb162-98e5-4d32-aebc-9b1370195c6d@kernel.org>
Date: Thu, 18 Jun 2026 12:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lg-g15: cancel pending work on remove to fix a
 use-after-free
To: Maoyi Xie <maoyixie.tju@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <178176639579.3377656.12792307991044339915@maoyixie.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <178176639579.3377656.12792307991044339915@maoyixie.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Jun-26 09:06, Maoyi Xie wrote:
> lg_g15_data is allocated with devm and holds a work item. The report
> handlers schedule that work straight from device input.
> lg_g15_event() and lg_g15_v2_event() do it on the backlight cycle key,
> and lg_g510_leds_event() does it too. The worker dereferences the
> lg_g15_data back through container_of.
> 
> The driver had no remove callback and never cancelled the work. So if a
> report scheduled the work and the keyboard was then unplugged, devres
> freed lg_g15_data while the work was still pending or running, and the
> worker touched freed memory. This is a use-after-free. It is reachable
> as a race on device unplug.
> 
> Add a remove callback that cancels the work before devres frees the
> state. g15->work is only initialized for the models that schedule it
> (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so guard the
> cancel on g15->work.func to avoid cancelling a work that was never set
> up. The g15 NULL test mirrors the one already in lg_g15_raw_event().
> 
> Fixes: 97b741aba918 ("HID: lg-g15: Add keyboard and LCD backlight control")
> Cc: stable@vger.kernel.org
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/hid/hid-lg-g15.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 1a88bc44ada4..02ef3e2094b4 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
> @@ -1374,11 +1374,27 @@ static const struct hid_device_id lg_g15_devices[] = {
>  };
>  MODULE_DEVICE_TABLE(hid, lg_g15_devices);
>  
> +static void lg_g15_remove(struct hid_device *hdev)
> +{
> +	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
> +
> +	/*
> +	 * g15->work is only initialized for the models that schedule it
> +	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
> +	 * cancel it when it was set up.
> +	 */
> +	if (g15 && g15->work.func)
> +		cancel_work_sync(&g15->work);
> +
> +	hid_hw_stop(hdev);
> +}
> +
>  static struct hid_driver lg_g15_driver = {
>  	.name			= "lg-g15",
>  	.id_table		= lg_g15_devices,
>  	.raw_event		= lg_g15_raw_event,
>  	.probe			= lg_g15_probe,
> +	.remove			= lg_g15_remove,
>  };
>  module_hid_driver(lg_g15_driver);
>  

