Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2642EEB6
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722438; cv=none; b=kPyHl5HG1O/BzPF0eB1AmsMC+gPLPk3IMkjrGs9u4VR/gkbpbgoYvv2FUOWkA4lNXH+97nhJ19agMlhD85L6a/LROfiNMjzeL+IW7E0tfNWbQSO0KKfBI5MlBYwb4bV7pFIQOlUX1Z6YxFwzpvUPU7AK9tFPqxq0oV+ukYEpEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722438; c=relaxed/simple;
	bh=50o2yjuO4OF0mR1P0i5dOCRPXhatoWPfABjio9Ai5FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYEzhz7e+9w/W7aNilG0IMSPk/5xFCMl3ZM/Qy/M1itf7hCWk4d0EBJlvbpQTDnL8hbaf5ExgXG703EFTCVxa6AgaRGomkhIPnr7Ui85KcOnh1510NeBLCKNoAB/3TJOg3CeSueTYagipwD7TUWNbruNSFkKjRnq+ey/fYux7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJewYTvN; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJewYTvN"
Message-ID: <a0aeb1e7-5c12-4211-be17-6ae94ef0e04e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783722435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYbg+i2jEDJxPT2fD1x1Mf6BkJQt5eeeBZvu650kDrg=;
	b=RJewYTvN+UXAqw39WA1kdWCMYDWuRs8NVcPv/0xNen6hLjti4B+X4HFsdpKBVdY6A+VtC4
	fNGTFN7QkPp1ypbf7FcGzcq8iTpAUjFg5aCb3InQf67krpuAW9MqT439l5cInxNDRYf3VS
	s1LC5izOzrvCwI9juUT/GzFNbZlL4DY=
Date: Fri, 10 Jul 2026 15:26:51 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
To: James Clark <james.clark@linaro.org>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
 <20260518093237.90640C2BCC6@smtp.kernel.org>
 <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org> <ag4QkPOCQ5LWy-U3@x1>
 <e060c4cf-59fe-42f0-bb05-adb520a6c80a@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <e060c4cf-59fe-42f0-bb05-adb520a6c80a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/21/26 6:16 AM, James Clark wrote:
> 
> 
> On 20/05/2026 8:50 pm, Arnaldo Carvalho de Melo wrote:
>> On Mon, May 18, 2026 at 10:47:53AM +0100, James Clark wrote:
>>>
>>> [...]
>>
>> Hey, this touches several tools and libs, did you get acks besides the
>> one from Ian?
>>
>> - Arnaldo
> 
> Only the build bpf failure report from Ihor on V1 but nothing from anyone on V2. Ihor did you get a chance to look at this version?

Hi James. I'm terribly sorry for long delay, I missed your ping.

The first thing to note is that the series doesn't apply anymore to
either bpf-next or 7.2-rc2, so please respin when you get a chance.

Other than that I have two comments.
Will reply to the patches shortly.


> 
> Thanks
> James
> 

