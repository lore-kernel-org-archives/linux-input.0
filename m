Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256003CB91E
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445689; cv=none; b=LSVMGd61nRlkRL5rLuOrQs2bu3iq0e0VY8H8OpPO5u1nW7GNb6ka5W8Ma1ttfuWC43yFKehLSGC1cuaCNuL2ozt9dAdXl3TW0DKmvA95W7xiauYd/ScsgE5eMjt4tVMm5xai5hSmKBsmK05d+2oNje2ZZUp7amx6S2GqCl3MClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445689; c=relaxed/simple;
	bh=fQi6LObdbPaT1I0LG9SIMJzBcZuGi1zGw2ytNtntm1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXKcLODmRcplW343cdcJABPdVhAhwsUFcHCg2fMcJXTzYlMEv2i14RZXq3pXDrn6W/BUsxS/ZlH4wqRgYcd4X7LU4xJIH4uOO/+nPw8iFQ73srbFdWh2TsoWYY2xShMzna7xGhkIyKOf+ZG2SPhN+brSyPJuF4y/Tk2X4fQdqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=C8cCQBeA; arc=none smtp.client-ip=91.218.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="C8cCQBeA"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fQi6LObdbPaT1I0LG9SIMJzBcZuGi1zGw2ytNtntm1w=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789445685; v=1; x=1790050485;
 b=C8cCQBeA+vDuMfWOZvOL6OkFNdThpIanA9qfMZw1NgmxA7eGxOcCjpHr+wNUkticI6sDrPfL
 IWdlfzHhGVSDjR9JQfLJYT0gVovyyO/t1pgDqsmTExgjYUWLMEAp0qfd/MQXjWQi15YwZA2xeK0
 bPPTkJSJqCi/Hi7H2p8WEI66i/QpGw3B6T6Co958hp/YL4cS2bf+zxuJwhMxzPO5rouSrj+90W1
 62H8ALdXOR6Sod2JsZ4AWgSF44yfO9BJ0NIrAhYo95elMemimqoi/cfV3+cJPIFtYiiQmSIbMhU
 RTmB1dGAc9dWFInXZ/lDsSvjpPp97Zc/mErNQ7yN36vqg==
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2131e7c511c91062;
	Tue, 15 Sep 2026 04:14:35 +0000
X-Mizu-Trace-ID: 2131e7c511c91062
X-Migadu-Flow: FLOW_OUT
Message-ID: <c49fe267-7da4-4b34-8dbd-3536a327423c@packett.cool>
Date: Tue, 15 Sep 2026 01:14:27 -0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] AW8695 haptic driver.
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/14/26 11:37 AM, Griffin Kroah-Hartman wrote:
> Clean-up of the aw8695 haptic driver patchset that was sent in 2022.
> Variables dependant on devicetree have been hardcoded, and unnecessary
> functions have been removed.
> [..]

This looks similar to aw86927.c just with a somewhat different register 
layout, but there's even the same waveform and so on.

Could it be better / worth it to do everything in one driver (aw86927.c) 
and only have different register accessors per model but shared "logic" 
overall? Or would that make testing too annoying?

FWIW I've been trying to bring up aw86224 which has even fewer (but 
still *some*) differences to aw86927, so I'm potentially interested in 
having a unified base to add it to (when I figure out why it's stuck in 
overvoltage protection or whatever it was..)

Thanks,
~val

