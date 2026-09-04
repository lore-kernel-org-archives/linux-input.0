Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CE3D9DB6;
	Fri,  4 Sep 2026 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556317; cv=none; b=kGSZcXjy6uMBTnc3HMtQVoMWf0c+IfoINqtp940JqQJSe9jlDi9nxEpTNCdzEhp8dJYdZjHimsmW/uKvBIyOsYCy5SCGotdkxousj1VDxE3ynyEfAJEYHphwd1ftDBc158/SjkuNjBieG9MbYko0wyKPShv6+vT8LLPHxh+BJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556317; c=relaxed/simple;
	bh=jAdsQN8ZDF9wbOvwOq+hlFM7kwRCSGwY8z2a6ld169M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/I73iy+73DVj8rfnoPARMnNS8yE9qkX0emztJ9bDdUb16lyRZjASbik0SyQ525YRHjS1KkK/QS1xXPM001cmVY2EZ3Tnj4EnAVv0/7jC46MeK1csYOPvRIui6r7GwoEK0GJeTs3Bk7NiessRF985J4uM7yr9evEFPQ+9ozdvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dAifU/Bx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAifU/Bx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=80YkBy/N40/LySzZOO2d7Mox9B++1wDT5cgA4S/RNiU=; b=dAifU/BxGPCfTmmGxPoZa5ITgu
	hfQCLx0q5KXEv4uznTj9BovZlq8hkmWf1OdyISHT+kwhFApKqnX7WKMVt7uuf2OTfcaCQn89Kxs4+
	hKA3d7TbcBNNKhhJs6bqwUQXElrtAGXmQB0UYa+N1IYFZzjDJthWNuWUOqJzpGDsW1eP5snmuRxvH
	pQ5cDV2st5D2i5weVWgMH1OgA3JpvHi5hJEAhyedL2+BbL5kfHMNh4mpJBLkHTfwvmmJjfvnBQ7GD
	Col7X5Yvg0Q0Rn+VaD93xZaVTSg4JxbDSh93XZscsFSnGywSDQl4RM5XVL/VOFylO2Y3rLw0C6L9M
	ClWX2r8A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bCD-00000003Inp-2omT;
	Fri, 04 Sep 2026 21:11:38 +0000
Message-ID: <1969e90f-1286-4ad7-9bbc-8f3800a44353@infradead.org>
Date: Fri, 4 Sep 2026 14:11:35 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/32] Input: yealink.rst: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Henk Vergonet <Henk.Vergonet@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260904121026.759218-3-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260904121026.759218-3-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 5:10 AM, Manuel Ebner wrote:
> Remove needless '['.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/input/devices/yealink.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
> index bb5a1aafe..de86cf7f5 100644
> --- a/Documentation/input/devices/yealink.rst
> +++ b/Documentation/input/devices/yealink.rst
> @@ -205,7 +205,7 @@ Troubleshooting
>  :Q: Module yealink compiled and installed without any problem but phone
>      is not initialized and does not react to any actions.
>  :A: If you see something like:
> -    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
> +    hiddev0: USB HID v1.00 Device Yealink Network Technology Ltd. VOIP USB Phone
>      in dmesg, it means that the hid driver has grabbed the device first. Try to
>      load module yealink before any other usb hid driver. Please see the
>      instructions provided by your distribution on module configuration.

According to drivers/hid/hid-core.c (near line 2395 in today's linux-next tree),
this documentation should have a ']' added to it:

	hid_info(hdev, "%s: %s HID v%x.%02x %s [%s] on %s\n",
		 buf, bus, hdev->version >> 8, hdev->version & 0xff,
		 type, hdev->name, hdev->phys);

so
+    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone]

AFAICT.

-- 
~Randy

