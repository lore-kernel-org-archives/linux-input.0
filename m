Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD04404BF6;
	Mon, 29 Jun 2026 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738977; cv=none; b=b/DG8kWg5N+P0bU40vz5nO4z5W29/YLdcstUZSgQK7M3spi4mV1jOEvMAQqKeDOC50rZMq/rNWfj8Xq1fOdfspDqFFG1PzSPXBwZNAZHqqTCYDkOrcYb+24jPK721og8Gecn2GbCtLyol8zE2h+gADirsD60LlN02IqcSEiiFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738977; c=relaxed/simple;
	bh=UA2k1r36UA3BJR+NavU2JcUvOjCd1n5ZB7uCc67I2qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ogUwvDnp5xeYXu5XQl9zi+E1sQxHYqbo0PwiYIe1BLX9mPC9dY6glk9hbOBNw+xEWdJ+sq8zimlnl/bQBXSO+UFWdFvfS8qU9VpJQI52eOhcopLWfEQR+PbM64LEoHvuqIJL+SaKxp+SX4q7bj9vlSBTh4L8HEEP4z4BEGiGxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.39.63) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 29 Jun
 2026 16:16:02 +0300
Message-ID: <df0ed02b-038c-43c2-a84f-b8225f2ffcdd@auroraos.dev>
Date: Mon, 29 Jun 2026 16:16:02 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: picolcd: prevent NULL pointer dereference in
 picolcd_send_and_wait()
To: Jiri Kosina <jikos@kernel.org>, Georgiy Osokin <g.osokin@auroraos.dev>
CC: <bonbons@linux-vserver.org>, <bentiss@kernel.org>,
	<linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20260517120639.38003-1-g.osokin@auroraos.dev>
 <886s5548-p183-3nr0-4836-85968p1non0r@xreary.bet>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <886s5548-p183-3nr0-4836-85968p1non0r@xreary.bet>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 6/29/26 11:46 AM, Jiri Kosina wrote:

>> In picolcd_send_and_wait(), an integer overflow of the signed loop counter
>> 'k' can theoretically lead to a NULL pointer dereference of 'raw_data'.
>> If the loop executes more than INT_MAX times, 'k' becomes negative,
>> making the condition 'k < size' true even when 'size' is 0.
>>
>> Change the type of 'k' to 'unsigned int' to prevent the overflow and
>> eliminate the out-of-bounds access.
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Fixes: fabdbf2 ("HID: picoLCD: split driver code")
> 
> Next time, please make the shas of commits a little bit longer to avoid
> uncertainity.
> 
>> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> 
> Applied, thanks!

   Hm, I think we (with the help of Sashiko [1]) arrived to the conclusion
that an overflow should never happen with the current ranges of the loop
counters. We have re-resolved this issue as false positive internally...

[1] https://lore.kernel.org/all/20260517125108.BC3FDC2BCB0@smtp.kernel.org/

> --
> Jiri Kosina
> SUSE Labs

MBR, Sergey

