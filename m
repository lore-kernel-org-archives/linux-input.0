Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18D1FCF41
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042376; cv=none; b=ilW99+5oCTn/bF/F60ejPNGEx2ILrqUmj/q4YFhKb4Anc/5jNKt3w8OCgGVHWT8LzebPwGVaPpOe4zvX5nlUYIt+5wAdzQ2dpyXMV65qQjuhcNipj4XqOervhbXe1C6694dxSc9Pn/zNo19CjMkuQIfCvBAh2amQ9dCJAQkQszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042376; c=relaxed/simple;
	bh=XNC5w7epAUR8vTY+EFc882zdPztNr+QOcezl42tLC0A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=rXmH9PHJac8UYEgkFswk4d9crJAklTWiezo5/K4zBDia8dUGkwBG1itOnvQ1JPqg+vadFTfsZO0f0JDE4eAE5oRuwXhZ0mvMchmgMkwljTv6PEnSDillSQL15m/bjJ4RG4a+EtNjDpL4MnUhZd3TTuSNMfhfTvsjhHcBucWkJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZkj+OPe; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZkj+OPe"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-353804b591eso8612368eec.0
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792042374; x=1792647174; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GH2n+ldfA9ef99RNFEAwu4ZYJGshxq44G7IMR735/Tw=;
        b=eZkj+OPeR46Vx+xdLIg6z2qKary5KWxkCXTa2fCLnBN6Zc9afGzUG0uxXe2CIQOanw
         cvvI0XwQ+sSSYTHHV6XyY99fietD45h0OQE6X6YkRtt6MVF1kiWkHSnJDlhC5zb9lCZ8
         Jh+9fxOU/MpYf/JAsjcWRXh18hCW2LY4PUK3AECIgEBmIYvl4bVYVbZ1pTldf1V/XO0w
         t4nD5ly2CiSKFiA0zPeknV4AoxqazXej6R7Ai1FIdDYgQnPOnzzdgl+JRe/7FKrn1ELd
         KzAD2HNXRz4+Abg7T4NF0ryAoqCHxn0WNjGzS9w62IWoxPWbVVk0kBfQFIwlNrHXLYwo
         kvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792042374; x=1792647174;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GH2n+ldfA9ef99RNFEAwu4ZYJGshxq44G7IMR735/Tw=;
        b=MCs+5/KiuWXoMn1aohB9S5WfvNYAeFYHQB3t5fsPXShQcWfS4VWF8o0B6ZG6qWxwh1
         NzgecmvHCEKPDUXgx3aHqa0sFCb8yE3tCibyvpFdjIWEpRwqvZ2xwzFGV3GSM03jgMzW
         XoLxlAXkeUd1ocj0iHd/yEJBVSERJpiL/I6MVEDF4GnMWa0aF+Tv+X0mFSnNIKLUO6pT
         PvL9hE/rx7xu3IZvRrz0NZjd0RKpUocPp7ZnO9YKGmkoWZzS5dHxuF5yShhONcI5Vw6X
         VZe+AS2+A0k14DMPepqglXnDMUY5WCZZzubBl6E04DWTW5TeP59tDZ4XvAzweiPWCAxq
         vLKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPyfXAJyVDN5doQxHsvVX207QJOKSOGf9LqB72BaoetuPIRLgHQsJqxoI9Npnst42hAxkxJiEVI9QvVg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSyYR6Rrw97EvJHV9qJKnlIVK0TGHSKIxnw5/E5RlRyLRtb9Ak
	HrNqSvVCWM5wNBJ9Wxt4lkYkOVwJ1ItbmCNF7lDabwagRg+3m1LUpt4v
X-Gm-Gg: AYBFou3SkdcuxcSGZXcawzBsDTMWj81rqmNcs7WM8jzjCQzJFTx6oraVFt2j+RXWPMv
	PVszJwzHTV+G6gi2zkiL7tyzTzHV9fFxepBpHoMA7fMLYsJcwUC9MnObKStc/WXFXoPQqFcgmlc
	BK80Y/x8SbwB5ni/hSFiKhQMAqCuoezNAI9x2QS0X4alN8Hdt58POInjLQdRvTzW0GJpq7x0dpO
	LgVFYRxZyw6hDSAGea9mZ9wsV/lMF2OJpur1pTbIri2rKYwhsWJFxomoZtQysUBuS+AojCf+Q5C
	N3zchABBZ9Ke9hZz92WnUMpJxLWfSVTrvc345kDnnTS/nKOctNaGVPDFLSEKo0UGz6bBZPkBJHk
	tU7TvYR1hx2stPHhEv/x3iIyMcaPk8BNtvG6JmhiMkdxhRpqgCbR8taEYaD+brFxW9P+KlEqBc/
	UBb1sJhsIRQ/Uoiwea93rjzaZxWTtvlrMKbuXWSAW9h6jkbzO9OFScm98NM7QOowji9UvTDKB2t
	1hayq5O2L0jmD6+CpaWkK3jP9ErB01xyDgT70GqVaR6oOGP
X-Received: by 2002:a05:7301:6e98:b0:33c:e74:4624 with SMTP id 5a478bee46e88-3537e112919mr25558252eec.27.1792042374072;
        Wed, 14 Oct 2026 22:32:54 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:821:261c:74c2:4177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35c89429484sm22777131eec.23.2026.10.14.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:32:53 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:32:52 -0700
Message-ID: <01c8cf7d695261ba8270ff57aa8f2a6f@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhengping Jiang <jiangzp@google.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Archie Pusaka <apusaka@google.com>,
	Shashikirana H K <shashikiranah@chromium.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: vivaldi: avoid redundant feature report reads per usage
In-Reply-To: <20261013192318.1828453-1-jiangzp@google.com>
References: <20261012220225.3594376-1-jiangzp@google.com> <20261013192318.1828453-1-jiangzp@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Zhengping,

On Tue, Oct 13, 2026 at 07:23:18PM +0000, Zhengping Jiang wrote:
> vivaldi_feature_mapping() is invoked by hidinput_configure_usages() in
> ascending usage_index order for each usage in the top-row physical keymap
> field. Because fetching the feature report at usage_index == 0 already
> reads the entire report from hardware and populates field->value[] for all
> usages in the field, calling hid_hw_raw_request() again for subsequent
> usages redundantly reads the same report N times (e.g., 12 sequential BLE
> GATT reads taking ~2s on Vivaldi BLE keyboards).

A minor note on the commit description: drv->feature_mapping() is invoked
by report_features(), not hidinput_configure_usages().

> diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
> index c3c9fe9e697b..2d85555289d8 100644
> --- a/drivers/hid/hid-vivaldi-common.c
> +++ b/drivers/hid/hid-vivaldi-common.c
> @@ -33,21 +33,22 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
>  {
>  	struct vivaldi_data *data = hid_get_drvdata(hdev);
>  	struct hid_report *report = field->report;
> -	u8 *report_data, *buf;
> +	u8 *report_data, *buf = NULL;
>  	u32 report_len;
>  	unsigned int fn_key;
>  	int ret;
>  
> -	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
> -	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
> +	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP)
>  		return;
>  
> -	fn_key = usage->hid & HID_USAGE;
> -	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
> -		return;
> -
> -	if (fn_key > data->num_function_row_keys)
> -		data->num_function_row_keys = fn_key;
> +	/*
> +	 * Read the feature report only at usage_index == 0, as a single read
> +	 * populates field->value[] for all usages in the field. If the read
> +	 * fails, subsequent usages will not re-read the report and will rely
> +	 * on field->value[] being zero-initialized.
> +	 */
> +	if (usage->usage_index)
> +		goto parse_usage;
>  
>  	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
>  	if (!report_data)
> @@ -72,7 +73,7 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
>  	if (ret < 0) {
>  		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
>  			 field->report->id);
> -		goto out;
> +		goto parse_usage;
>  	}
>  
>  	if (!report->id) {
> @@ -86,11 +87,20 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
>  
>  	ret = __hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
>  				     report_len, report_len, 0);

It looks like this patch was generated against a downstream ChromeOS
tree (__hid_report_raw_event() does not exist upstream; mainline uses
hid_report_raw_event()), so it does not apply cleanly.

> -	if (ret) {
> +	if (ret)
>  		dev_warn(&hdev->dev, "failed to report feature %d\n",
>  			 field->report->id);
> +
> +parse_usage:
> +	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
>  		goto out;
> -	}
> +
> +	fn_key = usage->hid & HID_USAGE;
> +	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
> +		goto out;
> +
> +	if (fn_key > data->num_function_row_keys)
> +		data->num_function_row_keys = fn_key;
>  
>  	data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
>  		field->value[usage->usage_index];

If reading or parsing the feature report fails, we should not be
updating data->num_function_row_keys or populating
data->function_row_physmap[] with zeros: vivaldi_is_visible() checks
data->num_function_row_keys to decide whether to expose the
function_row_physmap sysfs attribute, and on a failed read we do not
want to expose a bogus all-zero keymap to userspace.

Also, keeping "out: kfree(buf);" at the very end of the function across
parse_usage makes the control flow and cleanup awkward (having to
initialize buf to NULL, jumping over the allocation on usage_index > 0,
and using goto out in parse_usage even though buf is no longer needed
once the report is processed), and it prevents using __free(kfree) for
buf.

Since vivaldi_feature_mapping() already has the entire field in hand,
why don't we bail out immediately when usage->usage_index != 0, fetch
the report once at usage_index == 0 using __free(kfree), and iterate
over all usages in the field right there?

Please rebase your patch on top of Shashikirana's patch extracting the
feature report value directly via hid_field_extract() before
resubmitting:
https://lore.kernel.org/r/20261013-upstream-vivaldi-fix-v2-1-ecc20329d24c@chromium.org

With that in place, vivaldi_feature_mapping() can simply become:

	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP || usage->usage_index)
		return;

	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
	if (!buf)
		return;

	report_len = hid_report_len(report) + !report->id;
	ret = hid_hw_raw_request(hdev, report->id, buf, report_len,
				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
	if (ret != report_len) {
		dev_warn(&hdev->dev, "failed to fetch feature %d: %d\n",
			 report->id, ret);
		return;
	}

	for (i = 0; i < field->maxusage && i < field->report_count; i++) {
		usage = &field->usage[i];

		if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
			continue;

		fn_key = usage->hid & HID_USAGE;
		if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
			continue;

		if (fn_key > data->num_function_row_keys)
			data->num_function_row_keys = fn_key;

		offset = field->report_offset + i * field->report_size;
		data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
			hid_field_extract(hdev, buf + 1, offset,
					  field->report_size);
	}

Thanks.

-- 
Dmitry
