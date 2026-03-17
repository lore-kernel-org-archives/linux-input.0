Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6213EE1CE;
	Tue, 17 Mar 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765771; cv=none; b=FZWMsl8jFNPIbzqyTIkInOLHEZ2oLN/08B2vzJV1lFLeSIUZDbZNxABJjCqleFw5CQO5e/O35spZfxcMvmU3JztO1fU3N5wmccsHIkJkWngUq3B3Y7G9wtSqHK+eRxPCFHELRp41Q+4LFQgw9AThLJITxdrWVrrQNbtNfF3t87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765771; c=relaxed/simple;
	bh=qeKcP6Ws+BdY5o0u8siE0h0RfvOnU6h5Yap+DKObUL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYlAMoNHX/NOaWUTe6efBJlDgHnYCjrXiuOHcCQ8UetcJeVTU2yj3KHPePikbeC87CtKRNs3Hy6NR6pYQv9Cug0vxHr7gp0LHoiDwZpQUfm5H+1XFs22TSWJZBlFx3296CArKXN8myDZZU1tTLpQjAlLJa55j2kvW6QrB5VmpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dscS7GSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dscS7GSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FEFC2BCAF;
	Tue, 17 Mar 2026 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765770;
	bh=qeKcP6Ws+BdY5o0u8siE0h0RfvOnU6h5Yap+DKObUL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dscS7GSo/sVypNSZ+CsdSFM56kW4YphRESSc3nUl1VvmeliFCYYbq8oeZJRGiIlW+
	 J71ZC8uPuF5EwNcBQKYp88k/PiIVzdlXyuVhoAztN2ClcloRDBe+EJU5JJHed6siaK
	 fFCTqqcevH1NCVFJ8sfc+vMtIT8iblWd7xdCDPIw7v5baoC2IOYPCV4JmReuEunTs4
	 NlKt16jZUQXiHGliWybmoZS515xMT5Fth+HEle/hnSXKUV5V3EXFflF80v01eElnhV
	 47YccJuZJPVtbt+MvF9VytvU92ycFxDn+G7xwzFHM5WfwUbftkAqWURLBZjL1q7crH
	 NGvTlMFMkgqkw==
Date: Tue, 17 Mar 2026 17:42:25 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related
 user initiated OOB write
Message-ID: <abmEJJ9vWz5fiZy6@beelink>
References: <20260317162426.1533573-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317162426.1533573-1-lee@kernel.org>

On Mar 17 2026, Lee Jones wrote:
> logi_dj_recv_send_report() assumes that all incoming REPORT_ID_DJ_SHORT
> reports are 14 Bytes (DJREPORT_SHORT_LENGTH - 1) long.  It uses that
> assumption to load the associated field's 'value' array with 14 Bytes of
> data.  However, if a malicious user only sends say 1 Byte of data,
> 'report_count' will be 1 and only 1 Byte of memory will be allocated to
> the 'value' Byte array.  When we come to populate 'value[1-13]' we will
> experience an OOB write.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-logitech-dj.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 44b716697510..885b986c7a12 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1282,6 +1282,12 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
>  		return -ENODEV;
>  	}
>  
> +	if (report->maxfield < 1 || report->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {

This is all static information. So this should be checked in the
.probe(), once the device has been parsed, not for every single call of
logi_dj_recv_send_report().

Cheers,
Benjamin

> +		hid_err(hdev, "Expected size of dj report is %d, but got %d",
> +			DJREPORT_SHORT_LENGTH - 1, report->field[0]->report_count);
> +		return -EINVAL;
> +	}
> +
>  	for (i = 0; i < DJREPORT_SHORT_LENGTH - 1; i++)
>  		report->field[0]->value[i] = data[i];
>  
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 
> 
