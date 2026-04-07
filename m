Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9391F37D3;
	Tue,  7 Apr 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570400; cv=none; b=Haa5fFGmrABPr+NfEBHh1WcpCqTUmEqfrTn5ksKAD2jjpEL8kpljOsC+zJ6DP5VLA+17e8hXAu2vxQXSmJcMWrJO8f17x7ffSMf2WewW7gDhA0WelNh8PhraD6Xvum+eO48zouKrDZiADbsHsWm2ap/sgO7rjs+gLOe+YZ+vH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570400; c=relaxed/simple;
	bh=jbmo6TexSbEcoRdlaixuW+CRJp5pJOh4qd6rxz1IDOY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWF4GCGy3tHXD2bpjRLip78ZZ/Bz8Mqc1B17kcJ2bx+VNV0oABN+MTODuNvOcZIj6c8J/XBJH1fUiaf/xWxAx7wGFZoChR9Mi7JHUrYN4Gfi5DVrQHrKHLg5H6WtIA0IKIMn9TpFoWlGbpEQgXKtxAlSPiHlSdMsc0Em6VZsYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p55xoDrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p55xoDrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EF8C116C6;
	Tue,  7 Apr 2026 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775570400;
	bh=jbmo6TexSbEcoRdlaixuW+CRJp5pJOh4qd6rxz1IDOY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=p55xoDrTiGgEGYnGEqtmoCldgbGPbjSRHnZJgvKEwjxdUmk9SZiu7SY/GPNpC0NEe
	 obTw7ebFBlV9qr24BGUO6gn6cUj3bEd0YZewENlDmF62C3nq7bz/L+9UTbwB/0DpFU
	 LWTWCWP6X1bAdRRPE6hVk1R3rr1EohfBH+eBqukQ2u2Z21XR9o+dkqzCUG3GfhRGiR
	 vlEkOwo5V9b3/LLVMGG3Lt/ARN+mCPuAMQqTWNR6G2o9e719WkdIf+ZYeJI08guUi9
	 4fEEenBaPwetX89MROHD+BDX4U958IA0YYpDCr536K6omBkNsJoZuAiDdWzOeFZPAj
	 YnbaViYZsJQ9g==
Date: Tue, 7 Apr 2026 14:59:55 +0100
From: Lee Jones <lee@kernel.org>
To: Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: logitech-dj: Standardise hid_report_enum
 variable nomenclature
Message-ID: <20260407135955.GQ3795166@google.com>
References: <20260324143651.342273-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324143651.342273-1-lee@kernel.org>

On Tue, 24 Mar 2026, Lee Jones wrote:

> Since we will need to differentiate between the two report_enum types
> soon, let's unify the naming conventions now to save confusion and/or
> unnecessary/unrelated changes in upcoming commits.
> 
> {input,output}_report_enum is used in other places to let's conform.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v1 => v2: New patch
> 
>  drivers/hid/hid-logitech-dj.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

During a previous submission you indicated that you preferred pings over
[RESEND]s - so this is it.

This submission was posted 2 weeks ago.  Could someone take a look please?

> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 44b716697510..32139b2561c0 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1858,7 +1858,7 @@ static int logi_dj_raw_event(struct hid_device *hdev,
>  static int logi_dj_probe(struct hid_device *hdev,
>  			 const struct hid_device_id *id)
>  {
> -	struct hid_report_enum *rep_enum;
> +	struct hid_report_enum *input_report_enum;
>  	struct hid_report *rep;
>  	struct dj_receiver_dev *djrcv_dev;
>  	struct usb_interface *intf;
> @@ -1903,10 +1903,10 @@ static int logi_dj_probe(struct hid_device *hdev,
>  		}
>  	}
>  
> -	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
> +	input_report_enum = &hdev->report_enum[HID_INPUT_REPORT];
>  
>  	/* no input reports, bail out */
> -	if (list_empty(&rep_enum->report_list))
> +	if (list_empty(&input_report_enum->report_list))
>  		return -ENODEV;
>  
>  	/*
> @@ -1914,7 +1914,7 @@ static int logi_dj_probe(struct hid_device *hdev,
>  	 * Note: we should theoretically check for HID++ and DJ
>  	 * collections, but this will do.
>  	 */
> -	list_for_each_entry(rep, &rep_enum->report_list, list) {
> +	list_for_each_entry(rep, &input_report_enum->report_list, list) {
>  		if (rep->application == 0xff000001)
>  			has_hidpp = true;
>  	}
> @@ -1927,7 +1927,7 @@ static int logi_dj_probe(struct hid_device *hdev,
>  		return -ENODEV;
>  
>  	/* get the current application attached to the node */
> -	rep = list_first_entry(&rep_enum->report_list, struct hid_report, list);
> +	rep = list_first_entry(&input_report_enum->report_list, struct hid_report, list);
>  	djrcv_dev = dj_get_receiver_dev(hdev, id->driver_data,
>  					rep->application, has_hidpp);
>  	if (!djrcv_dev) {
> @@ -1935,7 +1935,7 @@ static int logi_dj_probe(struct hid_device *hdev,
>  		return -ENOMEM;
>  	}
>  
> -	if (!rep_enum->numbered)
> +	if (!input_report_enum->numbered)
>  		djrcv_dev->unnumbered_application = rep->application;
>  
>  	/* Starts the usb device and connects to upper interfaces hiddev and
> -- 
> 2.53.0.983.g0bb29b3bc5-goog
> 

-- 
Lee Jones [李琼斯]
