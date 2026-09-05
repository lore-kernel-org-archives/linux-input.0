Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DC17C203;
	Sat,  5 Sep 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643828; cv=none; b=q8yEFV5dQTLJNkVw/aO9SR8/8/xbsQImG87Q0casxSGPoUgZ+HdZ+GQjiYUkQCXUgsFApCucOoir4yh8fPB4frcmMnVLfAGax3tJGmqoNo7C+kH3fh4p7fvhAp23usu6i+v1v+ydD3VqkNc53sP2jseU6XYAkcxqw5o4fJIuM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643828; c=relaxed/simple;
	bh=ADIeX0b/Z1MSFV35rrSlUD6o4B7Qsu/LwJr8u30uiBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skytHB8M56wZqtXbYar86JHGeNYK3bn8ZnLIwH4Geblqb0Nmj9NlOqMEin09BxZVEW2CmYRAoMQRnfmRcd7IQtWpaqP64xbSSn82TvswJYaNDBMYWruMrGwmwo4yBGYJhceB27CZv5WVr4wwj5NtvA4rI2WjmXoJ49tIkgaITsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bENKsbHd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bENKsbHd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gc5MQtXVsiNYPaYMh7CzDXLqpr76YYaGFfFr/RDjf9Y=; b=bENKsbHdHc7z9DqmCCxhoBgEkp
	4U6F6cXEPlgO5EQKQNkhcEj4hwWgaf6tWZypoSl+QGkrM2D2oDhZpooKxr2o7T8OBKm+d0DxauomJ
	ixqSBif68UoCzaEOhB5HoD1MzHi2ujJMypC3nTf0yPMeCG3yiEzQq04zJvS1FObK9Vvcjle/JzN/9
	ZJw3uVDDCAaOCIjrAPCmZVlHH0DshPDxUa0rRbLnTqw3nBC/cfyTtBkOVFJ42CczHqiTnzV3bmNTI
	2GfqYE3ESAd3q9kZELSiQk7TXEB3IHb7PMngunWQnB333R809Tge1ROdD6Wd0lqQsKPVlThLZEPPq
	59gNoI+g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2xxu-00000004QUT-09mS;
	Sat, 05 Sep 2026 21:30:22 +0000
Message-ID: <7f1f350f-29a3-4bf2-b08a-f0bdc285aa43@infradead.org>
Date: Sat, 5 Sep 2026 14:30:21 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: yealink.rst: Fix typos and word order
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Henk Vergonet <Henk.Vergonet@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260905063335.792618-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905063335.792618-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/4/26 11:33 PM, Manuel Ebner wrote:
> Improve readability.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> ---
> [v2]
>  add ']' instead of remove '[' as randy suggested
>  fix a couple more issues in the file
> 
> [v1]
>  https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
> ---
>  Documentation/input/devices/yealink.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
> index bb5a1aafe..79ac21690 100644
> --- a/Documentation/input/devices/yealink.rst
> +++ b/Documentation/input/devices/yealink.rst
> @@ -81,7 +81,7 @@ Format description:
>  
>      Icons or pictograms:
>      '.' : For example like AM, PM, SU, a 'dot' .. or other single segment
> -	  elements.
> +          elements.

Why this whitespace change?
Does it make a difference? does it matter?

>  
>  
>  Driver usage
> @@ -120,9 +120,9 @@ Reading /sys/../lineX will return the format string with its current value.
>  Writing to /sys/../lineX will set the corresponding LCD line.
>  
>   - Excess characters are ignored.
> - - If less characters are written than allowed, the remaining digits are
> + - If less characters than allowed are written, the remaining digits are

s/less/fewer/

>     unchanged.
> - - The tab '\t'and '\n' char does not overwrite the original content.
> + - The tab '\t' and newline '\n' char does not overwrite the original content.

s/char does not/chars do not/ at a minimum.
I would s/char does not/characters do not/ and split that line
into 2 lines if needed.

>   - Writing a space to an icon will always hide its content.
>  
>    Example::
> @@ -205,7 +205,7 @@ Troubleshooting
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

