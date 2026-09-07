Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE15B5AB;
	Mon,  7 Sep 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742197; cv=none; b=u7akVRVHnpu879KbARm8egQTwZ/ZVE8ObpxhM3BguOxoEn5VLU3PGxRrVvZjn6GvVZ/OF/sG/U3IOpQ4hFB0bfTN2rpP5uhPWjgByZV5V8nIRKV+zoPBfU7PYUSLK3vKuBC6ekgiizY+IMJsqtuoZbO/WjU62SgQBRjirZhaeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742197; c=relaxed/simple;
	bh=tB61nY8GJOyvyQ5RsOs48QoD93sK+C5mpi3Rv4ue8E8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LFSlO90dErFK0gDj60aYGmY7FgOXAMy9oyTvAfzRRklPTnII6M8gvkogc7Nf35Zmk3cmSB4dqgNlFIPYbAFKreSQZIv6bwPqB14hAZjoEcLylo3iCOgFMcAQbeyhGLhYgLK9IYYzpyDRHPuogv9ud/Q+3QySDfYvYODHJ4Jhc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZjzeX+xv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZjzeX+xv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5y1hSDZ9UuIL1kWSizTmd0FH5VoivWT5UoBaVu6sPqw=; b=ZjzeX+xvLO+BswX3whyyWALnvo
	LILMat4B7Sbk80Dyd+tmHy0jWXEKhHLEmlOthLmmEVMih/gIU06NNwdQOw2/Kl4bVgafF/HxfIx+Q
	FZM71O32Hl1RTthkmGi2jUSHMKgNdjeoYl5wL3yrn5gf/67HOCWqr1/9V5GyhuxywvrElHKMjmoDS
	cpDpoyVO3bvgGB8j8F8bR/hliz739ui+5kmIyIf9q9iPTmHzGiDa1f6KR+92y2C6s66hiZyDWDR18
	VC212ugJ5GPq2MuCoGOlD1rMgWSIMsBaRXnIVrkkUO/iwekl3Sb+H3GvRPEI5FppMwvOk9Sumq/MR
	sK+NSajA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3NYV-00000005edQ-36HC;
	Mon, 07 Sep 2026 00:49:51 +0000
Message-ID: <a488363b-d60e-4570-a4cd-e6df82252909@infradead.org>
Date: Sun, 6 Sep 2026 17:49:51 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: yealink.rst: Fix typos and wording
From: Randy Dunlap <rdunlap@infradead.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Henk Vergonet <Henk.Vergonet@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260906095502.1116994-2-manuelebnerli@mailbox.org>
 <06cc9fc4-28ba-4076-917e-5ac30336806a@infradead.org>
Content-Language: en-US
In-Reply-To: <06cc9fc4-28ba-4076-917e-5ac30336806a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/26 9:33 AM, Randy Dunlap wrote:
> Hi,
> 
> On 9/6/26 2:55 AM, Manuel Ebner wrote:
>> Improve readability.
>>
>> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
>> CC: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> [v3]
>>  fix wording
>>  droped white-space fixes
>>
>> [v2]
>>  add ']' instead of remove '[' as randy suggested
>>  fix a couple more issues in the file
>>
>> [v1]
>>  https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
>> ---
>>  Documentation/input/devices/yealink.rst | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/input/devices/yealink.rst b/Documentation/input/devices/yealink.rst
>> index bb5a1aafe..de1460b6b 100644
>> --- a/Documentation/input/devices/yealink.rst
>> +++ b/Documentation/input/devices/yealink.rst
>> @@ -120,9 +120,10 @@ Reading /sys/../lineX will return the format string with its current value.
>>  Writing to /sys/../lineX will set the corresponding LCD line.
>>  
>>   - Excess characters are ignored.
>> - - If less characters are written than allowed, the remaining digits are
>> + - If fewer characters than allowed are written, the remaining digits are
>>     unchanged.
>> - - The tab '\t'and '\n' char does not overwrite the original content.
>> + - The tab '\t' and newline '\n' characters do not overwrite the original
>> +   content.
> 
> In looking at the produced html, the backslashes above are missing.
> This fixes it, although I don't know if it's the best or only fix:
> 
>  - The tab '\\t' and newline '\\n' characters do not overwrite the original
>    content.

I think this would be better:

 - The tab ``\t`` and newline ``\n`` characters do not overwrite the original
   content.

> 
> With that fixed:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
>>   - Writing a space to an icon will always hide its content.
>>  
>>    Example::
>> @@ -205,7 +206,7 @@ Troubleshooting
>>  :Q: Module yealink compiled and installed without any problem but phone
>>      is not initialized and does not react to any actions.
>>  :A: If you see something like:
>> -    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone
>> +    hiddev0: USB HID v1.00 Device [Yealink Network Technology Ltd. VOIP USB Phone]
>>      in dmesg, it means that the hid driver has grabbed the device first. Try to
>>      load module yealink before any other usb hid driver. Please see the
>>      instructions provided by your distribution on module configuration.
> 

-- 
~Randy

