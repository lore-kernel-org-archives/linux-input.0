Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0232B126
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850967; cv=none; b=uvJYGlPWMS8XhXbnYi8bgHDbEhWAwBQ+fmPE/Ap7dzN+7JnRxdbwycbf1FFWlwDcKGKtAbbWMmmwa3fYqMi8E5O24zqjMc8f7YpG4lQ1MwRz55cQk/73FyRnAvWTh6i+oBZQVzyCVWqT2aPNOQlYdI7DbXWx9nMBr7gq5gDKrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850967; c=relaxed/simple;
	bh=K7UaePRq9BaSpkAEaPCymyNIpn/Ox/pXqLeTP/6uCDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARZmweAJ5K2QvjZzMqqFOLTWuZ2q1J46xxOZq1VHLX1mpyC0GGMWbCbIQZ2wG0YHaMEn/watT6PUV7kavAPyRTUEBA/JELPFoNB/SXD2MFg3a6/dy9m91C1Iisf0JdOpfsqcI+UVekpIr616Hox89DmlqrfouNApUR/KpdxdMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF/VTuRW; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF/VTuRW"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1419d3416ceso3421444c88.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 17:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791850966; x=1792455766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9Ot3u6KmR57ETTt+6GZrmtSr17nrcJz4mYhNrXKLiE=;
        b=QF/VTuRWk822s+cVN+KuEO9Olxd0TSG1NeJRPTuHGYh8lVeJXto37d7RutUWJ1YcVY
         jdGv6bPcEiVSLWPNrSCDSY8RvlTiHBs5hiVsSF3RnBr1N3STIKA6tWPC+nburKFtLtWG
         sSbJ8D6a42hi8qxeOeyMtlgZcPhXjTQNIrRzV4uLNqq0jhYpMTjWktJBnvGlp37xgkez
         mZafK/GN0vapAWuLoFV/xvMyR6viT3gnxRL+wg4nRwD5QxUM0fQcV2WWTbdMN6uG/nGc
         yA5tM7X0MnpkYvyv2322g97dua1Pyh67w4YWSQ/HR0CNwts1bN0AlD9euQi+OA08p2Gc
         CJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791850966; x=1792455766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9Ot3u6KmR57ETTt+6GZrmtSr17nrcJz4mYhNrXKLiE=;
        b=OHxu2QR7A+3vI7SXR/2opHd6OIB5XpiPbfNtuzNovjXK1vOgdRvWUUqaXICLDZkHFj
         bncvGxRuc7UFgKsgiN2iNhheHIeTLc+d0d+N0tceJ1GngBrYe5eGF9Fi86GlGcQgXSP3
         UY0NNJqS5RinxOhItvrua5fJWTeXkb0RyV2FatryLVGRihZ6X8L275Fn6RF4/pVOPMSY
         D46DEcOFtqP36LHzpvl9tu/bPk4huaOIgPoRPFsiHBIL31BoWoPuJrBi6QC1S64zH51U
         aYLNl69IhCb8NxEccChnRM4zFB0HxJv19SjoBXm9N21U1ITED8j3oyxmf3ahi7Cu05f+
         e4Ww==
X-Forwarded-Encrypted: i=1; AKwUvBzqbajwEYEMamm3Krc85T0URdNgCCaKlG/jsU5rRtXMovLFoo0caykmyXTPI2Sm/kz+yOek0RhxbI5ffw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCR0RWUwstbEiU0SwrrU4ymJR0M9U+vzYcwUUqY5Wh6Cw7cd/c
	aXevz6p8KEzYXDdQriBKs7Pn9xwTnU9NMJN96zT8DPdpxgB2sh8xMKl5
X-Gm-Gg: AYBFou2k9vFg6AKcmRmTtkdVq1ixZcgINOKwmdleIPY80hgREz93fn3YzFsDGhf4eYf
	eMPuOy2O4wkY4m6RBBZ7LC7JRoRG0RiIQ/3h1N0t90Zki/vVrAsym7cSYVrPwTeyMyxE3Bj3ncz
	H3kuMzQOUyIzu1IMUeW7EFy/+I97zHnGx06yJQqdgWdRmFTlUqa+5nVadhKEKRNvyOx0LzeAut1
	cr+CIs+/0d8GxCcs3b/mL2IBZdz1VOBZ6dqCIVGtzxu6VjxSrCRMAzT5Wy7VXByZ0+Z3ADpxqPY
	co6Lnsw9+Rz+UC94gTkqG2euZSi2OVOJJopYVZiytk2nVgpXYiF2B52iPGMPkR9iOV1lDoJ9qzY
	o7/dST4QAYof3tin7HBF6PXyLpf69yUsTCh+VR2jEwAvu/5HJbnN4Kcym0ZO1o0pXmMO/poM7HK
	RcdRYTHcoNjE92Qso7zoDTRr6z4wvwgLfXpLcPzt6NVeiYVbe1blJUAlynvam4xRy695zs0U9OY
	tLUxZXgm2vjDLt/Y1CQ8DI2Y+NQ9TI8rGcZNRVh
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id a92af1059eb24-16a63b2edc7mr21744351c88.47.1791850965414;
        Mon, 12 Oct 2026 17:22:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becb11sm31217695c88.4.2026.10.12.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 17:22:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:22:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shashikirana H K <shashikiranah@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Stephen Boyd <swboyd@chromium.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@chromium.org>, 
	Sean O'Brien <seobrien@chromium.org>
Subject: Re: [PATCH] HID: vivaldi: Validate Report ID and length in feature
 mapping
Message-ID: <as1sq5X8rpdKLfHO@google.com>
References: <20261006-upstream-vivaldi-fix-v1-1-bbc9a7f14ea6@chromium.org>
 <asfk_jRVjY8pXzjt@google.com>
 <CAH=natbNnhVMO0vXmhTi5wipEsfMr9wy7u_PRCXDYFaWJXqoCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=natbNnhVMO0vXmhTi5wipEsfMr9wy7u_PRCXDYFaWJXqoCA@mail.gmail.com>

Hi Shashikirana,

On Sun, Oct 11, 2026 at 05:29:22PM +0000, Shashikirana H K wrote:
> > I do not think checking whether report is numbered is needed. While
> > transports handle numbered and non-numbered reports differently here I
> > believe we always have report number (0 for unnumbered) in first byte.
> > Also, shouldn't this check be in hid core if it is needed?
>
> Agreed on both points:
> 1. Dropping `report->id &&` and simply checking `report_data[0] != report->id`
>    (like mt_get_feature() in hid-multitouch.c) works for both numbered and
>    unnumbered reports since transports place 0 in byte 0 for unnumbered
>    reports.
> 2. Checking `buf[0] != reportnum` on HID_REQ_GET_REPORT directly in hid-core
>    (e.g. in __hid_hw_raw_request()) would protect all HID drivers at once.
>
> Jiri, Benjamin, Dmitry -- would you prefer a v2 that checks
> `ret != report_len` and `report_data[0] != report->id` in
> vivaldi_feature_mapping(), or moving the `buf[0] != reportnum` check for
> HID_REQ_GET_REPORT into hid-core?

Yes, let's harden hid-core directly by rejecting descriptors that mix
numbered and unnumbered reports in hid_register_report() and validating
buf[0] against reportnum on HID_REQ_GET_REPORT transfers in
__hid_hw_raw_request(). I'll prepare a patch series addressing this and
a few other issues.

In vivaldi_feature_mapping() itself, though, there is no reason to go
through hid_report_raw_event() at all: we already have field, report,
and usage in hand, and nothing else consumes field->value[] for this
report. If we verify ret != report_len and extract the value directly
via hid_field_extract(), similarly to hammer_get_folded_state(), we
avoid re-looking up the report by ID altogether and do not even need a
separate report ID check there:

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

	offset = field->report_offset + usage->usage_index * field->report_size;
	data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
		hid_field_extract(hdev, buf + 1, offset, field->report_size);

Thanks.

-- 
Dmitry
