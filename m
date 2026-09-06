Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F118C02E;
	Sun,  6 Sep 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712397; cv=none; b=RdIJxe2gGlJF8FAWwgdqk5pSF1I1zJIN7tKNxw/Tmjksd3xyRhwH4HagsdAG1t5PdRm4FzEODnlIwu8YzsksgfjSrYFGd0966Pz0op8Gnkul2DOID2a+qFzq7lDppxBgFlxqFJs1Y0rs+zlM3fNB7bOqCekcfJ2QJrI0y93a+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712397; c=relaxed/simple;
	bh=Tie5WgjU5KyJKEnl6PZshbAyDG1ICfU1FixfVzf8BIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnreh63PqVc+adCVHSmqN/7UjUdgWx0qGbySGNUI387sjaV+dfWGZXG5h2eFkhWlB6yVRZg/eCOH334t2bko4RsVyDCtz9tBFl4VOCg6WsY4hf2XTVK8U/xDiLsHdF6oGjm8cFHmnbRZW3ZP7usit+qNcdYvhG0EV2+GmR8eKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AD2Abu1F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AD2Abu1F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IsLASocooih29G5Sb0KQIMEiPt/sx4znIp07c1gmSYc=; b=AD2Abu1F/qzk6k/hapSBkTxm15
	pQnkxlQR/rGSaF1oUc5vZPqpXS1kYH9mDIsTcuc95oO6+i6Q33qmxnDWHw4TPl9tYlT+qV7gdcCxl
	Opo0ftMR04ktgCSkOLnKNtvzQgDwlIiAs2sqqR5pbFlXC6L+DCC03ycRglf55XO6ogIHCmTp0VMeW
	r950UmbhoBjHP+CGswk2bDpZ4HNmj1W0YY7KGfpwDiFIp8+8VOoxm+C8aXQ37hxxatLa/vOi8Kxmb
	QnP/XmkUdm9aQkjCWOZUUvpXD/KDEN388p+rANtkVJeaO31ljZAL6sj9LWzgJU81e5RNzF0US8psj
	v+7d7SbA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Fnq-00000005BJS-3vH8;
	Sun, 06 Sep 2026 16:33:10 +0000
Message-ID: <06cc9fc4-28ba-4076-917e-5ac30336806a@infradead.org>
Date: Sun, 6 Sep 2026 09:33:10 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: yealink.rst: Fix typos and wording
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Henk Vergonet <Henk.Vergonet@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260906095502.1116994-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260906095502.1116994-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/6/26 2:55 AM, Manuel Ebner wrote:
> Improve readability.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> ---
> [v3]
>  fix wording
>  droped white-space fixes
> 
> [v2]
>  add ']' instead of remove '[' as randy suggested
>  fix a couple more issues in the file
> 
> [v1]
>  https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
> ---
>  Documentation/input/devices/yealink.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
> index bb5a1aafe..de1460b6b 100644
> --- a/Documentation/input/devices/yealink.rst
> +++ b/Documentation/input/devices/yealink.rst
> @@ -120,9 +120,10 @@ Reading /sys/../lineX will return the format string with its current value.
>  Writing to /sys/../lineX will set the corresponding LCD line.
>  
>   - Excess characters are ignored.
> - - If less characters are written than allowed, the remaining digits are
> + - If fewer characters than allowed are written, the remaining digits are
>     unchanged.
> - - The tab '\t'and '\n' char does not overwrite the original content.
> + - The tab '\t' and newline '\n' characters do not overwrite the original
> +   content.

In looking at the produced html, the backslashes above are missing.
This fixes it, although I don't know if it's the best or only fix:

 - The tab '\\t' and newline '\\n' characters do not overwrite the original
   content.

With that fixed:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>   - Writing a space to an icon will always hide its content.
>  
>    Example::
> @@ -205,7 +206,7 @@ Troubleshooting
>  :Q: Module yealink compiled and installed without any problem but phone
>      is not initialized and does not react to any actions.
>  :A: If you see something like:
> -    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
> +    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone]
>      in dmesg, it means that the hid driver has grabbed the device first. Try to
>      load module yealink before any other usb hid driver. Please see the
>      instructions provided by your distribution on module configuration.

-- 
~Randy
