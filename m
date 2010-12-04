From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Enabled Acer Launch Manager mode
Date: Fri, 3 Dec 2010 17:42:53 -0800
Message-ID: <20101204014252.GA24092@core.coreip.homeip.net>
References: <1291424606-23383-1-git-send-email-jlee@novell.com>
 <1291424606-23383-2-git-send-email-jlee@novell.com>
 <1291424606-23383-3-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64035 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab0LDBnE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 20:43:04 -0500
Content-Disposition: inline
In-Reply-To: <1291424606-23383-3-git-send-email-jlee@novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: mjg@redhat.com, carlos@strangeworlds.co.uk, corentin.chary@gmail.com, corentincj@iksaif.net, tiwai@novell.com, mjg59@srcf.ucam.org, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>

Hi Joey,

On Sat, Dec 04, 2010 at 09:03:24AM +0800, Lee, Chun-Yi wrote:
>  
> +static acpi_status
> +wmid3_set_lm_mode(struct lm_input_params *params,
> +			struct lm_return_value *return_value)
> +{
> +	acpi_status status;
> +	union acpi_object *obj;
> +
> +	struct acpi_buffer input = { sizeof(struct lm_input_params), params };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	status = wmi_evaluate_method(WMID_GUID3, 0, 0x1, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	obj = output.pointer;
> +
> +	if (!obj)
> +		return -EINVAL;
> +	else if (obj->type != ACPI_TYPE_BUFFER) {
> +		kfree(obj);
> +		return -EINVAL;

Just noticed - this function (and others similar to this in your
subsequent patces) mixes acpi-style return values (acpi_status) with
Linux ones (-ERRXXX). You need to pick one standard (I'd advocate Linux
style) and stick with it.

-- 
Dmitry
