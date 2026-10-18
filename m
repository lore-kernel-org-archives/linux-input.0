Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEE3D6690
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342346; cv=none; b=qDyv2km2KgB2vtOrSHEwwGuDcoYSr5XlhT0c+14L1Qvi+SNO8fa218LLQQdwXi3aJ2zxkWc3y+guPeW4z8rrpiS1RnvSXigKjKdgrB4GUeqInH/fBJEZdfdUxiFxyu1jI7t3nYbOG5eDobZzrQxrMGXCqxPZtr4UaRH1gCf5Sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342346; c=relaxed/simple;
	bh=ENqyqEBfdywXRtbS9JtuOKLrGgK8CSPXheNFfg2Nmjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or1YP7gGleBdxplcBHvurtw8sf4fSuA7gzQYYA/hctZ5ohJH2bjmyRWGm8OXq1i8GdFqrrely1Hc8bfTYFFfLgnIvpOncBUFeXbu20nSvbaoaYBboMYj26g1l6yK6kne1cvkUGOLk0MIx7ppV2gYomkHOaXTLjEoritVcHjQHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NyH6MFp6; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NyH6MFp6"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ENqyqEBfdywXRtbS9JtuOKLrGgK8CSPXheNFfg2Nmjw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792342340; v=1; x=1792947140;
 b=NyH6MFp60fiW7hugFf2woQaq4Txw45X7Urt7x+69r1kFIhymTAwIsOeUazWpZ4/uC87jwTX7
 hQg/r+SrI5z3U4OKdRiiRM8Z/V+QyRVZnMs3gk4sk7gW7LRfq0/OlBLrVkQTdNVLqjcm9eKyBwz
 gMLPc6KIzwax/mU/xeO9Sl9w=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 93bb4c237c13c911;
	Sun, 18 Oct 2026 16:52:20 +0000
X-Mizu-Trace-ID: 93bb4c237c13c911
X-Migadu-Flow: FLOW_OUT
Message-ID: <8d47efcf-003d-40ea-a79c-20df738d02fc@linux.dev>
Date: Sun, 18 Oct 2026 18:52:17 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] HID: asus: Do not send feature reports larger than
 declared
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?=
 <rebecca.mara@posteo.de>, Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-6-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-6-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:40, Paolo Pisati wrote:
> The keyboard backlight and Fn-lock commands are sent as 64 byte
> feature reports, the size of report 0x5a on the ROG keyboards. The
> Zenbook Duo keyboards declare feature report 0x5a with 15 data bytes,
> 16 with the report ID, and do not answer writes larger than that: the
> control transfer times out over USB and fails with -EIO over
> Bluetooth, so the backlight cannot be set, while the 16 byte handshake
> goes through.
>
> Cap feature report writes at the length the device declares for the
> report, when it declares it. hid_report_len() counts the report ID, so
> the handshake and the other commands up to that size are sent as they
> are.

This has been a huge pain in the past months for me so than you for
taking care of this.

> Assisted-by: LLM

As the others.

With comments extended (see below):

Reviewed-by: Denis Benato <denis.benato@linux.dev>

If you decide to help me and unify packets alloc between devices
you can do it on a separate patch after this one and preserve my reviewed-by.

> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
> ---
>  drivers/hid/hid-asus.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index b127f5c38f60..7b17553e94b6 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -632,6 +632,18 @@ static int asus_raw_event(struct hid_device *hdev,
>  
>  static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
>  {
> +	struct hid_report *report;
> +
> +	/*
> +	 * Do not send more than the declared size of the report, report ID
> +	 * included: the Zenbook Duo keyboards declare 15 data bytes for
> +	 * report 0x5a, 16 on the wire like the handshake, and do not answer
> +	 * the 64 byte writes sized for the ROG keyboards.
> +	 */

Maybe also mentions the majority of ROG laptops uses 64 bytes, xgm 300 bytes
and touchpads also 16 bytes as the duo.

> +	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[buf[0]];
> +	if (report)
> +		buf_size = min_t(size_t, buf_size, hid_report_len(report));
> +

I think that it's worth doing this for every supported devices: rog ally,
laptops, touchpads and so on, my only question is if this code is robust
enough to handle all cases, but it's worth a try.

It's also worth adding another patch to unify all devices to use this code.

I can test on a rog xg mobile: obscure hardware that uses 300 bytes and
see if it still works.

>  	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
>  	if (!dmabuf)
>  		return -ENOMEM;
