Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B828686;
	Tue, 31 Mar 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943899; cv=none; b=DOa/02uQE1MIoIKT72v6uvCnuEdKuxACgSws5PSUgYgjNW4e393baURIl0QP53pkXnNUWpv9GAtJuihhgHAGmwmQWyJUPOejT9P7rOoMkB7+6EtFZ4YpoNRDYRaWsziRXCt7YNY13tir4LMhCwUFNnvtF9mrPD5dawx1mcOVDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943899; c=relaxed/simple;
	bh=4ERxRRw20r8kgxJgml7lExVjMD6lCUQSGyGRCtcYz1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T44ARNIXmZIoy8jFnqdz33599FqmupY82YHvQIuIRX8W63Wbdn/TJXjCjHmWQe3nDs1wgKv0yCnafe9ynTOAYlrdxhTVwim/KurVfhdiopConvVFna9w4bnBlXQYqaiDZ9hHspH22V4uHTxXkWYMWmwcLovlTJP3X6KUZ0Bq3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj8LQL5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj8LQL5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98D2C19423;
	Tue, 31 Mar 2026 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774943898;
	bh=4ERxRRw20r8kgxJgml7lExVjMD6lCUQSGyGRCtcYz1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aj8LQL5cINr3yZX+P0TZe/UqUpQoGyIl8w1xxWZd+CDsxywHFAsLqtuPLo2E3FAjA
	 3IGrr7lo43l91mKem+v3Lxk58r5gUzFIaYRv5QyI/xBz08NPZFAYXoDmZE1b9rHG1a
	 +riWFTTPKrIb6NzUpPX9XSdyB6JffGca029UhVuyyUZ6lLURfcsRYnNjNrSqdW/1BT
	 D1FzFTEzqr0gynBLq2RTefhP30NS5vBlULDCw33I9b5RM005aY/ZM2/Kr8BHmV6SUJ
	 CSoqJRhoQsL7R+LtejNfM4lCQXhenzcZwZTVbiAGtpPN0Ccn/augyHGJzXBzLNxquY
	 vtEgEEcZB4Gyw==
Date: Tue, 31 Mar 2026 08:58:13 +0100
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Check bounds when deleting
 force-feedback effects
Message-ID: <20260331075813.GB3241346@google.com>
References: <20260331074052.194064-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331074052.194064-1-gnoack@google.com>

On Tue, 31 Mar 2026, Günther Noack wrote:

> Without this bounds check, this might otherwise overwrite index -1.
> 
> Triggering this condition requires action both from the USB device and from
> userspace, which reduces the scenarios in which it can be exploited.
> 
> Cc: Lee Jones <lee@kernel.org>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index d1dea7297712..5f63f1d2303a 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2502,12 +2502,15 @@ static void hidpp_ff_work_handler(struct work_struct *w)
>  		}
>  		break;
>  	case HIDPP_FF_DESTROY_EFFECT:
> -		if (wd->effect_id >= 0)
> -			/* regular effect destroyed */
> -			data->effect_ids[wd->params[0]-1] = -1;
> -		else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
> -			/* autocenter spring destroyed */
> -			data->slot_autocenter = 0;
> +		slot = wd->params[0];
> +		if (slot > 0 && slot <= data->num_effects) {
> +			if (wd->effect_id >= 0)
> +				/* regular effect destroyed */
> +				data->effect_ids[slot-1] = -1;
> +			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
> +				/* autocenter spring destroyed */
> +				data->slot_autocenter = 0;
> +		}

LGTM.

Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
