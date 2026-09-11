Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239F26982C
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102542; cv=none; b=e3IBDzigie4r3olD8+o2CdPgN+Y89myOwXO3BqyRbu6VI2YqGzKqWi9wkzr3+l0oJ2g/VvZYSd/e5PMlk6TRet9tWjHHlqT7cWH/S8ubMiZ2qBCUeBYFbLuPaOKbPGwySEck+s7m4CfzRHy4U/XsCGYtUmGhjvqohQ3s18Sed3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102542; c=relaxed/simple;
	bh=gRax98XBnTeXsB4U3frQSfMdpqRTS/1n+vv0snGdib8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob0yKeh3vh74mOctMdklfmHrxbjUvD0vwCST80vg8vfqOiH7WLjMy62Ug7iCDYV798ydmDO9YejGtz8W7l92PLhfHBLtntEg8xc2sEO6mSm+Xl0CS4o3kDa+gbQf+eEpq2Cx8Fc5mE8kGBddi70XdlxM9WMt5Wwqd7MYEnK/BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pT8r785v; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT8r785v"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-804872cd1e0so29554a34.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102540; x=1789707340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jdcjf1BPsFMtJuMfKKBIV37SM+mo5KWOGPxwINTYozQ=;
        b=pT8r785v676bVjiMRQHQ/kDBl5ecjuDhTO+Pa7P90BRubUu3Poz389K+IRTKDq6rRm
         mTKuy88FvoZpKjssvXy8li/VoQw1GaOA4i0EtJzSqoSn2B/EKdi/pItiv9wOaB+I4ZFP
         OnfQf4+DAw/GvXQ8EVjHR5JodwF5f5MGSj5QZdlYXuA2ZtfPa0xgLZkv81nx2FXwKxfU
         4c2YF8o50i9LYoYPVymUMfvPN6or2b8bmPpV3IFO7cUEE4r0kHfoMDrd9vG6O93VlBVG
         PdiKxPVlzqRdjT6CHZZHcqYli/YbnzAl7WXcjXZKn4eCM5oqs14vw37/ZPIDadPmay8x
         yxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102540; x=1789707340;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdcjf1BPsFMtJuMfKKBIV37SM+mo5KWOGPxwINTYozQ=;
        b=RwTIna8gQzxXUNL9n89X6iGSygpkaL0HCXKUd91CEELpgM1mLtoGG6JVrMeVeisi3F
         m+HQlKckgNLbkUrmnTfUjASs9Mu0D6z8op1LXZquESd9fqsNbZWgbLKyTRWGUo8XFUl3
         KS+Ew4+OBTUSsDGb1SlCvpiQeVluixS9jlKRm1q9N396sJk5Xfp010rvuwZ9h5nIVIWD
         kXstOIv+o4tElw8q/K5RsxlKhGVm2ixZaa/AmbqWFNtRIMmqnqKtZSe0tFpxDnbAAynL
         ZxfD262WLVhgAPtJ2jyvbOi4eTpNUejnRk4fyTAeqmGUgCaaxKFTOdv7VdD1SivZVBgu
         qmlA==
X-Forwarded-Encrypted: i=1; AKwUvBw5JCcr2tsnrEUc3sDjoTPezlwa7ecxhrjr/H+eR4LJae9cBqyhCvN77XwA/ID7TA0896mOF5Lr96VpCg==@vger.kernel.org
X-Gm-Message-State: AFuF++nL78LlYY25rEPKdyj1hVA4wJPICVphkwAIEsIFPEWrkZNR5686
	l5xzmVxTEqO9p0aTZ7ReSiP0A8a2HpcCkZFOBReSCQHNRg8uTXm5licy
X-Gm-Gg: AYBFou2in3u4F1OnYrrUX2InvJeFxGvAy6TMLbxL34wCf3F860JLQJBWYc4ChPqAii+
	dwNVgVo5L7XB4rz2YHBr9AdkY+qURZ++MWYhZCKz/uow8OALHoeLmXUJoEuVnySL8X7D7QAqBPy
	ZuErFwE7R/HXkE2WEOrRW3TlBM+4dQaH6C6K9GUVHFw1y13OQzPKF1xlCI8kfPDXtAtB6uXO9Og
	U4qU2U+leHIEX4MKG9qQYeoKxjvttwgUOcH2PBd7MzFal2tcW7DQ1bhBPTh7YigDTE7hdB5uMhB
	5m2ZXVXC2thngUFHO8P79Me3owJlghZVoc8nPW9Nh64EGv/suhNRxnKFA12M0ej0PeXY8Lq1mkz
	nJ+KoKMWpCXSjEyPKl0wloDh6mGumZtS3zBAi2/5C3Jv4DSGPPwWg0VQ39URi9/5pbNOuZxqJt3
	vecWI0ywnpqra/jFHUmM4O2GYpRmKvB0FbPLleXhdRul4p12upB2XulroLYg883vN/oywj0aFlR
	zFSLffxe3+VlFyuxQ92cvD6YttlYG0=
X-Received: by 2002:a05:6830:348e:b0:7e9:eb13:d042 with SMTP id 46e09a7af769-803ffb978a0mr1569459a34.8.1789102539986;
        Thu, 10 Sep 2026 21:55:39 -0700 (PDT)
Received: from dhoja (S01067483c248479d.wp.shawcable.net. [50.72.244.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d1875csm1484100a34.22.2026.09.10.21.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:55:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 23:55:37 -0500
From: Curtis Vogt <curtis.vogt@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <aqOJycOWtHP5DvLz@dhoja>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <20260910171756.57EEF1F00893@smtp.kernel.org>
 <0407d630-e1b1-4a20-8e05-b0d0946585ce@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0407d630-e1b1-4a20-8e05-b0d0946585ce@amd.com>

On Thu, Sep 10, 2026 at 12:21:15PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/10/26 12:17, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Incorrect buffer formatting and report ID targeting in `hid_hw_raw_request` fallback for an unnumbered HID report.
> > --
> > 
> > commit 4526fbce2701e5a40089fba6ae186ded76bc0864
> > Author: Mario Limonciello <mario.limonciello@amd.com>
> > Subject: HID: valve-index: Reboot headset on system power transitions
> > 
> > This commit introduces a new HID driver for the Valve Index headset to
> > reboot it on system power transitions. It sends a specific 64-byte report
> > to recover the EDID service after a DisplayPort link shutdown.
> > 
> > Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939
> > 
> > > diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
> > > new file mode 100644
> > > --- /dev/null
> > > +++ b/drivers/hid/hid-valve-index.c
> > [ ... ]
> > > +static void valve_index_reboot(struct hid_device *hdev, bool wake)
> > > +{
> > > +	u8 *report;
> > > +	int ret;
> > > +
> > > +	if (!valve_index_has_reboot_report(hdev))
> > > +		return;
> > > +
> > > +	/* USB transfer buffers must be DMA-able, so not on the stack. */
> > > +	report = kzalloc(VALVE_INDEX_REPORT_SIZE, GFP_KERNEL);
> > > +	if (!report)
> > > +		return;
> > > +	report[0] = VALVE_INDEX_REBOOT_REPORT_ID;
> > 
> > [Severity: Medium]
> > Is the report buffer sized correctly for an unnumbered report fallback?
> > 
> > The HID core and usbhid transport expect unnumbered report buffers to be
> > prefixed with a dummy 0x00 byte (so payload size + 1) for control transfers.
> > Allocating exactly 64 bytes and placing the payload command at index 0 might
> > break control transfer formatting in usbhid_set_raw_report if the fallback
> > path below is taken.
> > 
> > [ ... ]
> > > +	/* Use the same interrupt-out then SET_REPORT fallback as hidraw. */
> > > +	ret = hid_hw_output_report(hdev, report, VALVE_INDEX_REPORT_SIZE);
> > > +	if (ret == -ENOSYS)
> > > +		ret = hid_hw_raw_request(hdev, report[0], report,
> > > +					 VALVE_INDEX_REPORT_SIZE,
> > > +					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> > 
> > [Severity: Medium]
> > Does this properly target the unnumbered report during the fallback?
> > 
> > By passing report[0] (which contains 0x16) as the reportnum argument, the
> > fallback control transfer will target Output Report ID 0x16 instead of the
> > required unnumbered report (ID 0). If hid_hw_output_report returns -ENOSYS
> > and this fallback is taken, the headset might reject the transfer, causing
> > the reboot command to fail.
> > 
> > > +	if (ret < 0)
> > > +		hid_warn(hdev, "failed to reboot headset: %d\n", ret);
> > [ ... ]
> > 
> 
> Curtis - can you check how the headset handles those cases?

I'll dig into this
