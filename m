Received: from mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B12DCF57
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619762; cv=none; b=NLvTSv3zG5KOm/eQUDb8Oe0o9JFNv1LLKuyFImjzRMSbwp1ONXIERaDzxH1/C1Ovxd0/MoheILKvxeFQc68XYLYbUkxZ1YnUSYrxVQX6GrHXgeC+FiBOQWLF3hqISPxp0ga45wHNWIUV7aZvPi3ndUwjlbqROiP9ZCvnh+NPlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619762; c=relaxed/simple;
	bh=KMsll9iQFNSUTrh8N8anWA8Wgq6/rLAsmD1HO/f5UgQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J5u0KS74jjaGghmVX0NNXr6eh9atw52maudq3oR9Ywoya2HqdVKUAul/0kQ/AD38YLk5wtkWWhDROFCD6a8VkcJvUjP0iTtiaSM36yHRJp16qnyDtvBLIr+lrGE6iE7oLl28elyNG1D3Ib0PPB3KHq27ila9T6QbHC1P5kdFhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AhzBn0S/; arc=none smtp.client-ip=95.215.58.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AhzBn0S/"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KMsll9iQFNSUTrh8N8anWA8Wgq6/rLAsmD1HO/f5UgQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788619759; v=1; x=1789224559;
 b=AhzBn0S/kJPwc+139MuoUD1UXTazKXpX6Ov5E0ppE8MZ9SQyoZtIjasdnjb1QSvthF7Zxdjz
 91RHYBLLMnDISnp/Ui5+uXfu8MKupjLnKQVapxdplCfA6rcjggLf0gr/NGBY6NGEYjjBTDbkDGd
 c8RJfJ2fOFuNBoexwCRHjN0g=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c050fd726f4a85f9;
	Sat, 05 Sep 2026 14:49:09 +0000
X-Mizu-Trace-ID: c050fd726f4a85f9
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf9ff462-1a77-44c7-92fd-2b11518aeb69@linux.dev>
Date: Sat, 5 Sep 2026 20:19:06 +0530
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: appletb-kbd: support layer switching on Fn double
 press
From: Aditya Garg <aditya.garg@linux.dev>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andre Eikmeyer <dev@deq.rocks>
References: <20260905143733.17819-1-aditya.garg@linux.dev>
Content-Language: en-US
In-Reply-To: <20260905143733.17819-1-aditya.garg@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 8:07 PM, Aditya Garg wrote:
> Holding Fn temporarily switches the Touch Bar between media controls and
> function keys. Users who want to keep the alternate layer currently need
> to change the mode through sysfs.
> 
> An optional double_press_switch_time module parameter makes a double press
> persistently switch the default layer. Its value specifies the double-press
> interval in milliseconds, while zero leaves the behavior disabled.
> 
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
> Changes in v2:
> - Added a check to ensure negative fn switch times are ignored.
> 
> Changes in v3:
> - Renamed the backing variable to match the module parameter.
> - Fixed the reported code style issues.
> 
> Changes in v4:
> - Added missing "break;" in case statements.
> - Change author's email to aditya.garg@linux.dev

Now that I see it, the case statements were ending in return. break was not needed. Sorry for the brainfart.
