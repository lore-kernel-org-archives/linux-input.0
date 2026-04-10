Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D523A1682;
	Fri, 10 Apr 2026 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823138; cv=none; b=KyVXBNVK/bn1euWmnbCDs1RSIoCerKG3IjAimnOF138P0WM20y67Ee++iqLm6H8ScqhxmeRL09dIXECV/7tyd/PVqU886ri0+nP/p9f793zn0H8WNTUglnGCtyoEyy9Y2uC3HSBmrCBIEXw75qQAmZW92k/AIeDg3uMeq6cf6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823138; c=relaxed/simple;
	bh=Ws7PU4u48tcbCA6e+U4VrWHQ8dXEDZGqG/FohnVFl5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4Pf3ygNOo6RhmmvVAnOuA+ju9ps4OhQFLR5kXAl7qc9aerlt55dv3xn9YS4/t6S8Oh25jv3KuIobvLdYgVhx/aKAefkJzKFxz4/4zjj5M9DvLbGOElscIrUxltp1Q8Lelv8zlj+LJUhe/wuzrXfVLbAhIgjYdG9NqboUlr4nMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCpihr5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCpihr5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F268FC19421;
	Fri, 10 Apr 2026 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823138;
	bh=Ws7PU4u48tcbCA6e+U4VrWHQ8dXEDZGqG/FohnVFl5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCpihr5QAqJ2+xuies3FlL3o22yY4vN8jSZoHRUQwhvOqzzKPwS1l/U9LH8tiH+sY
	 4HbRr38EO687Od1t74WdlZLGlWRdaUSprP0S3JVPjhddRIA6NcJwXu0CA7FuA8lNcD
	 HT7VFKrcF3bakvkP/40dF2Bf5/8arH8kSVkWAPjiBHVCEbBj8ylnpuV6TgJtRrhSIP
	 VpPTyg/CMvBg2nAkwci7hUuMkhewxT2gCYmru4IZNNQbRUzjN+HYOe+Z18bwmkC21D
	 Rj8SVWcc6MtNc5ASkNh+SnQHxCgluVhpp7Mu7ye/pbkLRdL0jlY7L1yZtkxf8ZB7vj
	 e3DoBxis6PHJg==
Date: Fri, 10 Apr 2026 14:12:14 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT
 related user initiated OOB write
Message-ID: <adjoPVarY1NHAmvd@beelink>
References: <20260324143651.342273-1-lee@kernel.org>
 <20260324143651.342273-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324143651.342273-2-lee@kernel.org>

On Mar 24 2026, Lee Jones wrote:
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
> v1 => v2: Move handling to .probe()
> 
>  drivers/hid/hid-logitech-dj.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 32139b2561c0..a8082199d13d 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1859,6 +1859,7 @@ static int logi_dj_probe(struct hid_device *hdev,
>  			 const struct hid_device_id *id)
>  {
>  	struct hid_report_enum *input_report_enum;
> +	struct hid_report_enum *output_report_enum;
>  	struct hid_report *rep;
>  	struct dj_receiver_dev *djrcv_dev;
>  	struct usb_interface *intf;
> @@ -1903,6 +1904,15 @@ static int logi_dj_probe(struct hid_device *hdev,
>  		}
>  	}
>  
> +	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
> +	rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];

We've got an issue here: the driver binds on several HID devices that
can have no REPORT_ID_DJ_SHORT in the output reports. On those devices
(like the mouse/keyboard emulation on the receiver itself), rep is null.

And of course this segfaults in the test below.

A simple "if (rep &&)" should solve the issue:

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 838c6de9a921..7c09faedefbd 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1907,7 +1907,7 @@ static int logi_dj_probe(struct hid_device *hdev,
        output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
        rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
 
-       if (rep->maxfield < 1 || rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
+       if (rep && (rep->maxfield < 1 || rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1)) {
                hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
                        DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
                return -EINVAL;

Cheers,
Benjamin

> +
> +	if (rep->maxfield < 1 || rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
> +		hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
> +			DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
> +		return -EINVAL;
> +	}
> +
>  	input_report_enum = &hdev->report_enum[HID_INPUT_REPORT];
>  
>  	/* no input reports, bail out */
> -- 
> 2.53.0.983.g0bb29b3bc5-goog
> 
> 
