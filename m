Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0E33B6F4
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739778; cv=pass; b=Quu47knnz6xP46RgnkDUEBokjnkNe3UBywoKSrHzC3V4daIiC19StvpHN+YlLVDuWFlnOn6CB8IfEROipNhayOB2dha+DolLjyl+MyzPpsyPymrHiRTGtmWA6dqiRX3JR/sLzXRP6Vqhf+aGjnZsRNV8VKG1alpV8X7TC10KY/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739778; c=relaxed/simple;
	bh=tkjOrtWzfvAkN6ASJLjJRMDquvEPYg5g2p0E9cG6xAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR9EoXxOezUfbGy/K8gbWcd8ElfNlMsYHCtZ9vv0DqTIGeksyAggSu1IZEFdsohMNh34YFzN9CzD8nyL3GFvumnKQPZl2HUo8xmKb5tvbMuWkQ9xNiem5r4h30+G4SM5aChE0nvFiSnSG43ZlQSmTetsrXF+W6vZqusOJoXxifs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M/5ZYxMj; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/5ZYxMj"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so14266091fa.2
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 10:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791739774; cv=none;
        d=google.com; s=arc-20260327;
        b=MkU7PlW3WesoSaZtiHPv57YZw0KPoyQaAg+AiyTZ0NzjLuX1O+En1OAwTzCekAMcMT
         ubJweYPo2caMpNQNTSiqOzbJqMqOKCzf3K/IrK1YBD/q0HigegTHfClBgwyJiCTe0VA1
         Y5ktTPJ6NEB878VR2SSpn/JJxdovzwyaKEn/OFxMxKzr1f92LFewd3hcS8J3BoSrqON+
         OobQy1WTQwEdtd9sljgeaL6ok7ifacDsMCTof/WQv5eXly+mBzH/eXX44m2PZkMblr9V
         7uIKtOsuNuZ5apGvKJqSMt6Swsm0Stq6+eF3ut+SBIK+sQ2/FHIK1t1MOJDeJsJRtIFQ
         duiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lCu02LFOYMeDJJjF4fmtFwaOG6AS3l/NEzfbXyNBgZg=;
        fh=7yd9CSNOEZW+cf8i8AhvqZIFfcMdyA4d1+DsLgp2vEQ=;
        b=reJoBqLVd2qzRGTn6QSqwSQjPVwccLzGCCc5u03+l03BnMtNSd72kCcZ42G9ciEwj2
         fWRaEhQl4RELvb0vOyeAzHPLdbRFVEgz8VmNL7hhC0z2++N/kjeRVxPJbzXFuosgUGqV
         49wqtPIOBpZ06xSRm+RBZ1Wt6n49gwnxqmgMuezZ/JEKOqmwbmpJ0ZGqXrGClKMaGkSQ
         HLdbirXVuhyHhpCdOXHVKkGZmEHv1xlUVrqbUPP14m+/HufvnWE0srrLAe4uBAPmm0yS
         +icwemiWr/YLjuTsk2Uh0tat0mVfe2PisplnkpVDCI1dFlFksnbLpsbe9NfiygMASE+q
         WHxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791739774; x=1792344574; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCu02LFOYMeDJJjF4fmtFwaOG6AS3l/NEzfbXyNBgZg=;
        b=M/5ZYxMj9PnXSaZWoiTkJl8Ity+azlcvU5zteYizyysVNPtEXeSGtIanr8qCd7Hm7T
         22OdcazQrc9iU/huEHvazgwTuyg2jSaCt73iAkMsTJWxyIS7YyVv+a8mfwQgT5GMt92V
         vClA8NurSz9xMTWB1YV7EvwSlfRNAhpsYw0DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791739774; x=1792344574;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lCu02LFOYMeDJJjF4fmtFwaOG6AS3l/NEzfbXyNBgZg=;
        b=xXLoSWLUcq9AsQPiRPkg2H6i0K0fvjd7UJ8HTE/l0dRojbV5z232u1HlF0GsvY8iSZ
         4gNc0EKMvV25Y/6IoEbLMOgRQCHROA/Nu+UwcckzGQPz9VVAcB9dSpX6sWHiwtjPhatM
         MU22Cen5y9N9LdD9GW0zBULfUfDulIqT+SCkAav3hpMobvyOBZjSOdzIiJY0qFMP9How
         pErcT6GAVlwbR1kabzKQh/48gi4IDsyr2WFBgbaId+pA4hiYGc14kh3rsuQ6XyJ+Xu4j
         /HTAl7e/kP9WIf2rxz3v1E9GDBR+zwUGX+4rnTG8kUqZ9s1LEfQaGrS+1NDGjR5dmSLm
         BhZg==
X-Forwarded-Encrypted: i=1; AKwUvBylvoC7NuSofPVze+5LozhR8RU/GGeILPhkSqir18Eg0E+lYAxB1ikrEyjAN/hRki4xRCfa5FC3HXqI+Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5ksw9JG9Ckd9dGMvlZ92Dxo1ARsbBOEVsBrjY2jme+oO8/mxO
	l0w3xkcgpFCN3heNbud8mhh4y8tFRDVfVYli74vcR+Zm9kZltwpKari1lDnQAc83nD1vsBMP/in
	hb0zIVrrks8bUYMWBNo9llzRKvIpIiJzMDVsVkS232Xl0MAdf/004t1koJyI=
X-Gm-Gg: AYBFou0OfdELBtGLdXWIsFIs0r54IkDDymf8o3V25ICNgGQeABCWDB6ugOWPn/rbbhn
	fb3jUYkP6w3tfBmnY1dwIStoJbEfQuQufrCiI8qdNimhUQzerG/IF8UzeOzTY/mC6DvgcKBuveQ
	b49t4PVvZGYbmALOe0EGIyp/Lts0UKEYC2+/+MEr125v5WALM7ssiWHxxN8sn8PXYbDAdoqPwmj
	FoyugUbDL9mrxkfQMv0kps1EZp/0HAm+aLh6zcojpYS0yd9iN+yYgnRNwTLw6bpA5ib/xR7eIpv
	CKVrRvGsD9HlMGRaGyA9mJFQDrndaUTRKhvPewzBbrI0lbJqxRLC1EXqEZSiTM6A8L4jKT8F6MU
	byIL6kiwA7A==
X-Received: by 2002:a05:651c:a38c:20b0:3a9:8546:ee13 with SMTP id
 38308e7fff4ca-3a9c5749725mr12016031fa.19.1791739774534; Sun, 11 Oct 2026
 10:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-upstream-vivaldi-fix-v1-1-bbc9a7f14ea6@chromium.org> <asfk_jRVjY8pXzjt@google.com>
In-Reply-To: <asfk_jRVjY8pXzjt@google.com>
From: Shashikirana H K <shashikiranah@chromium.org>
Date: Sun, 11 Oct 2026 17:29:22 +0000
X-Gm-Features: AclHuK9ZAHiF05P5Ep5pwVbDh3L0xmk8bEDd4KYnMtCBumJ8hsz-7P7vYfRjDBU
Message-ID: <CAH=natbNnhVMO0vXmhTi5wipEsfMr9wy7u_PRCXDYFaWJXqoCA@mail.gmail.com>
Subject: Re: [PATCH] HID: vivaldi: Validate Report ID and length in feature mapping
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Stephen Boyd <swboyd@chromium.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@chromium.org>, 
	"Sean O'Brien" <seobrien@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Thank you for reviewing the patch!

> Devices typically do not return short reports. Could you please tell me
> what prompted this change?

This came up while testing with synthetic/uhid devices that return
malformed GET_REPORT responses (either fewer bytes than report_len or a
different Report ID in report_data[0] than requested). When that happens,
vivaldi_feature_mapping() still passes the buffer to hid_report_raw_event(),
which then looks up a different report via data[0] or processes unreceived
bytes from the buffer.

Since legitimate Vivaldi keyboards always return the full feature report,
rejecting short reads outright with `if (ret != report_len)` (similar to
hammer_get_folded_state() in hid-google-hammer.c) would be even cleaner
than passing `ret` to hid_report_raw_event().

> I do not think checking whether report is numbered is needed. While
> transports handle numbered and non-numbered reports differently here I
> believe we always have report number (0 for unnumbered) in first byte.
> Also, shouldn't this check be in hid core if it is needed?

Agreed on both points:
1. Dropping `report->id &&` and simply checking `report_data[0] != report->id`
   (like mt_get_feature() in hid-multitouch.c) works for both numbered and
   unnumbered reports since transports place 0 in byte 0 for unnumbered
   reports.
2. Checking `buf[0] != reportnum` on HID_REQ_GET_REPORT directly in hid-core
   (e.g. in __hid_hw_raw_request()) would protect all HID drivers at once.

Jiri, Benjamin, Dmitry -- would you prefer a v2 that checks
`ret != report_len` and `report_data[0] != report->id` in
vivaldi_feature_mapping(), or moving the `buf[0] != reportnum` check for
HID_REQ_GET_REPORT into hid-core?

Thanks,
Shashikirana
