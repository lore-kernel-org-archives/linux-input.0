Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B853FFADC;
	Mon,  2 Mar 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461933; cv=none; b=MQtpq2i5LxfNweKoq4TQZljdJLzsCVaS/gvMvqAbB0py6Dzjo/MvMtNSqq4QwdKbeqol90UgPgp8p7pXz6/1teCHqdHVl+X0a9sVowZbFz5n7aTFdWp5p/8vw7hbc+tDZgMSWOe5xgoxSCtV4Uh+9HUBrghEo1oexq51fUEx2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461933; c=relaxed/simple;
	bh=B9eBQQZTC0NcITPHrV+0LkA8dqkggfB4eLhtjeHIAOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGSVxpurLvxyB/oH2L5CK/u3qaj6IZ3hInkEo1BF0r+376Hnzj8LvpT/9LxggDoAPxL0m66pPf0ygN71KOJI/Xjgd3/J5U/fST7oimwmhtO/rHEY0z2+/U+UF9/Q1MRj6d5N9ujJSXBJXMwMcjFwEnmtTRLjciwAYlRxr4Ti0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDetDGUX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDetDGUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3821DC19423;
	Mon,  2 Mar 2026 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772461932;
	bh=B9eBQQZTC0NcITPHrV+0LkA8dqkggfB4eLhtjeHIAOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDetDGUXEqRMt3Ip9fSMJvWDZBH1cora37mgCl7GYzxqqm0GFnWHu+RHprSxGkUqJ
	 1C6jcYtgvzEvAzVTbQQgTf7uz5DMy5wvGmLcPsBeEakwuadOCbQRw6JxdUiLJ7msm2
	 JTS+q5qDfrnW31yHYLSimxnWfh8inzdDpwP5mKIsLMZB+cRlONQzDPBxAqysVf4H1r
	 y9WzkpCHbKf5N/Ol7XHWe4LqOGB3REtcicR8KFC33kSc0bnjxLlaNt8MblqMZEr7Ks
	 LZJc93yfM7UdpZGVDqqN37jyLn7PuLllI4XFBCdpryYleBsfqRJp6xNwnUAI6u00rj
	 3pa0B2XFITmcw==
Date: Mon, 2 Mar 2026 15:31:46 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: multitouch: Check to ensure report responses
 match the request
Message-ID: <aaWe6PxdZZb2cBJl@beelink>
References: <20260227163031.1166560-1-lee@kernel.org>
 <20260227163031.1166560-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227163031.1166560-2-lee@kernel.org>


On Feb 27 2026, Lee Jones wrote:
> It is possible for a malicious (or clumsy) device to respond to a
> specific report's feature request using a completely different report
> ID.  This can cause confusion in the HID core resulting in nasty
> side-effects such as OOB writes.
> 
> Add a check to ensure that the report ID in the response, matches the
> one that was requested.  If it doesn't, omit reporting the raw event and
> return early.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-multitouch.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index b1c3ef129058..834c1a334887 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -499,12 +499,19 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
>  		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
>  			 report->id);
>  	} else {
> +		/* The report ID in the request and the response should match */
> +		if (report->id != buf[0]) {
> +			hid_err(hdev, "Returned feature report did not match the request\n");
> +			goto free;
> +		}
> +

AFAICT, hid-vivaldi-common.c is doing the same calls to
hid_report_raw_event() in vivaldi_feature_mapping() and would suffer
from the same bug.

It would be nice if we could have the matching fix.

Cheers,
Benjamin

>  		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
>  					   size, 0);
>  		if (ret)
>  			dev_warn(&hdev->dev, "failed to report feature\n");
>  	}
>  
> +free:
>  	kfree(buf);
>  }
>  
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
