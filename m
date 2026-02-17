Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AE371062;
	Tue, 17 Feb 2026 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353087; cv=none; b=hNOMeIN5xyopaFcnkfL/GcAspMEiXF/5e/oAETIClTP/VZ1RBxZX3kpWz1Si9Xtx0XgE2xTiltCyMiGgMzYj769HD7YKnq5V31IqAHzoVWJSSAesh6yl3cpaqOg3Whhno2setWXWj+Y80ISEKTtxVZ2u7Bt2WJN32/ktqaOQfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353087; c=relaxed/simple;
	bh=757UPfy/GV2CsJ5WBqsY8+F2rL56Jw950DDtXOYnpQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXQMVZbX5h1qUYI+DEAWFAg3wkGo5VBlsHwAVyYud25R6bEsHUhpLsuA1EoewJkGa2IxQaHVQQvoZ0/ppUFtLZAWl2o2YLi6tG9RMAgVic8PTV2vlyu6vdUaZxrI+d/3DGWIoxyPPC1NvvkMAzp6Kr9Vezz3G4Mu7pIxxY6l5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPbKKdTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPbKKdTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5506C4CEF7;
	Tue, 17 Feb 2026 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771353086;
	bh=757UPfy/GV2CsJ5WBqsY8+F2rL56Jw950DDtXOYnpQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPbKKdTSfvh1gVejkDU4FXReElH2/gEJFez827pKWLu46/eOIzkA/NhV7PfdY9pb5
	 ax0GnyFUxVN6oQqABh9hADZy5+bItw6PYZ4Y6Yjp5az1TgRn4/to2bjSrFYnU8p0ut
	 PyXSp0U2PKspZ4kYIg7LB7v1ZUD72QGgLn2k7Fc37Wo/k3Q4oFVWbHfqQcG1utwCEA
	 gz2RNzZvhn5SBgRYLdg3VGBxLwnHdnogbc4tFZk9ZENHm+AAawNrYCDgCezH5CPywq
	 Dq/BkZsvoErypl7Z0pcPJTgHEJih/epCvwKwoluHLCSk2Ap+P8cxgNrjgq4/cG+cL+
	 bnh2rPB+dprzw==
Date: Tue, 17 Feb 2026 19:31:23 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: asus: avoid memory leak in asus_report_fixup()
Message-ID: <aZSzASB_TC2RyQsR@plouf>
References: <20260217160125.1097578-1-gnoack@google.com>
 <20260217160125.1097578-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217160125.1097578-4-gnoack@google.com>

On Feb 17 2026, Günther Noack wrote:
> The asus_report_fixup() function was allocating a new buffer with kmemdup()
> when growing the report descriptor but never freeing it.  Switch to
> devm_kzalloc() to ensure the memory is managed and freed automatically when
> the device is removed.

Actually this one is even worse: you can't use devm_kzalloc because
hid-core.c will later call kfree(dev->rdesc) if dev->rdesc is different
from the one provided by the low level driver. So we are going to have
a double free.

I really wonder if this was ever tested.

Cheers,
Benjamin

> 
> Also fix a harmless out-of-bounds read by copying only the original
> descriptor size.
> 
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  drivers/hid/hid-asus.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 8ffcd12038e8..7a08e964b9cc 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1399,14 +1399,21 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		 */
>  		if (*rsize == rsize_orig &&
>  			rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
> -			*rsize = rsize_orig + 1;
> -			rdesc = kmemdup(rdesc, *rsize, GFP_KERNEL);
> -			if (!rdesc)
> -				return NULL;
> +			__u8 *new_rdesc;
> +
> +			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
> +						 GFP_KERNEL);
> +			if (!new_rdesc)
> +				return rdesc;
>  
>  			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
>  				drvdata->quirks & QUIRK_T100CHI ?
>  				"T100CHI" : "T90CHI");
> +
> +			memcpy(new_rdesc, rdesc, rsize_orig);
> +			*rsize = rsize_orig + 1;
> +			rdesc = new_rdesc;
> +
>  			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
>  			rdesc[offs] = 0x19;
>  			rdesc[offs + 1] = 0x00;
> -- 
> 2.53.0.335.g19a08e0c02-goog
> 
