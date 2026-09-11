Received: from mta0.migadu.com (out-26.mta0.migadu.com [91.218.175.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A85921E3
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157059; cv=none; b=MD3XoBidKsQMl3sEFGV9FQUKJx8SXZDl24kL/ra8CVEpcZTfpfuYap9guKCQULRgyEiHRnvb3Lj5fyTR3oq29NIGjz3XfH9Uq4dFMIpT+npOfCqd4t4E7BMOTFp5ztt+s6SMwdLeo5uo03kK8LUAvTQx6zJAFIO+gennL2fVJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157059; c=relaxed/simple;
	bh=TdW9s9fKwVmxaIx9w5xKoMfVPfWoaFoSa21A0l1xzdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ1kJXgM2G2TvX9DY+Q8qpKcs00TLaQZx3uRtZOpgWJQ9Ll9twXk5r64xT/9GpyQTo9kKiGuHwSwqLUpG5sut5Z8puKeasLEs/X4c1BeluQgqMX4PzsE3EZ2wGkLt4Mx6wa+JYBIzbSOvkCE+2iAkHWVXtVfkMxEkjsNOCHiO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XDhDyphF; arc=none smtp.client-ip=91.218.175.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XDhDyphF"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TdW9s9fKwVmxaIx9w5xKoMfVPfWoaFoSa21A0l1xzdY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789157049; v=1; x=1789761849;
 b=XDhDyphFfu+ouIncqUDrrF2K8tpjtk4B/I9tgQoMG5PInsVdYuw1QDNuf2BtX+wh4C++C6uQ
 WjYxgPJqlmI44MbjMXt/QdUyEJOVTEk6rkdx7CI+wfD/tusHvCvDfWQ4LPTqlHFU+tVg2z2rIay
 +vetlTTxzA1Z2NRKAz85uzkk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 38ea16c8dd52eec6;
	Fri, 11 Sep 2026 20:04:09 +0000
X-Mizu-Trace-ID: 38ea16c8dd52eec6
X-Migadu-Flow: FLOW_OUT
Message-ID: <78a34a46-85c1-4428-8e85-2186ae434512@linux.dev>
Date: Sat, 12 Sep 2026 01:34:03 +0530
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: appletb-kbd: support layer switching on Fn double
 press
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Linux Input Mailing List <linux-input@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andre Eikmeyer <dev@deq.rocks>
References: <20260905143733.17819-1-aditya.garg@linux.dev>
 <cf9ff462-1a77-44c7-92fd-2b11518aeb69@linux.dev>
 <4s5p7s1n-87n6-2833-s73r-s82s45862srs@xreary.bet>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <4s5p7s1n-87n6-2833-s73r-s82s45862srs@xreary.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/09/26 10:15 pm, Jiri Kosina wrote:
> On Sat, 5 Sep 2026, Aditya Garg wrote:
> 
>>> Holding Fn temporarily switches the Touch Bar between media controls and
>>> function keys. Users who want to keep the alternate layer currently need
>>> to change the mode through sysfs.
>>>
>>> An optional double_press_switch_time module parameter makes a double press
>>> persistently switch the default layer. Its value specifies the double-press
>>> interval in milliseconds, while zero leaves the behavior disabled.
>>>
>>> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
>>> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
>>> ---
>>> Changes in v2:
>>> - Added a check to ensure negative fn switch times are ignored.
>>>
>>> Changes in v3:
>>> - Renamed the backing variable to match the module parameter.
>>> - Fixed the reported code style issues.
>>>
>>> Changes in v4:
>>> - Added missing "break;" in case statements.
>>> - Change author's email to aditya.garg@linux.dev
>>
>> Now that I see it, the case statements were ending in return. break was 
>> not needed. Sorry for the brainfart.
> 
> Please send v5 and I will apply it.

Sent here:

https://lore.kernel.org/linux-input/20260911200019.17028-1-aditya.garg@linux.dev/T/#u
