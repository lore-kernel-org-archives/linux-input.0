Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B973537DE;
	Wed,  8 Apr 2026 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688070; cv=none; b=JwxRHe5ogVr0TvFrj7cSPUHgs4OIr8sdP2gCZo/33hEEbGFTEoQ2c+vlklzuwpZzT8lUFAqtpFF5DJkMAiQSVy5sO/mm8KfMX7Cdir4zN7LLwOJaYeXgSJ2LrUvldkcKWH/2/Ta+NQbry/5K8xLTtmfMiL7DvKlp64AFv3i4150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688070; c=relaxed/simple;
	bh=MFpmF+fS86FqLy5U9kqC0FYwMNicLW8/9ZUTri4yibE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsSdkzcT5vcQCCmmgtBRi1VIqcZCY7GqDcRvXxcNab06HwmC0tYqzl9Bjq5JBiPNQc90Prq8CHBC25tJUKRD+7YNVYAvhlGtk990z1JZCYPo4KDx3CXavPPfgfLX0PHthfq9Rr5D+3wOvVyYEmDVfFExDpuXjAaxc2GpEZjbLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MAXX2MdX; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MAXX2MdX"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4frdMP07Ckz9smv;
	Thu,  9 Apr 2026 00:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775688065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYtG06tf5qJZp23lhRf8B1VNUSXJU36VX1p6qSJmhcM=;
	b=MAXX2MdX/27Tr60ePy4Xv2xM3JGICcTHSn1NaMfBJNqVCS01fQtrPcwb3W/x8nxytCf+tM
	5TiVsruomU3uvgHUWKLKTNVR7OxGrzkOlUkj73HLxBwGNS9wFwgAlginq/SPo0A1/MXGz0
	ze+qu9YstoCHDs0NApBoku9N21WUmPDb1Mt0xt7Q9u3zpJAsjaViQnOnNyszTBJy9ZkV9B
	9K29WQftZYb6ocnfj41Lnn9Nmv4m7JvWjnaCM4uc1TA/FmEiG3809m8c1hWPhTUp1nXrkV
	5+htdXnCgHJ8OWyM2/5nGyWAvO0jAjvgTwAlV8yB5JW2NUd2tNajBWP4YpJ8BQ==
Message-ID: <21996a49-6408-4fbc-b11f-0d9cc503ad10@mailbox.org>
Date: Thu, 9 Apr 2026 00:41:02 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] HID: sony: add support for more instruments
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Sanjay Govind <sanjay.govind9@gmail.com>,
 Brenton Simpson <appsforartists@google.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260407194636.9671-2-rosalie@mailbox.org>
 <37nrpop7-rn05-pqo6-3951-171nr8nq441o@xreary.bet>
 <6893d7ea-f585-45fa-aa53-cd7a10fec34a@mailbox.org>
 <o488s484-r1os-6736-o800-7on55687757s@xreary.bet>
 <cb0617fb-76b0-4241-8fba-982a5ffa4525@mailbox.org>
 <r803963p-778n-84p8-3046-s7118rr376pp@xreary.bet>
Content-Language: en-US
From: Rosalie <rosalie@mailbox.org>
In-Reply-To: <r803963p-778n-84p8-3046-s7118rr376pp@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c76a484980f18a08e3f
X-MBO-RS-META: 73a4ex81uad7tdhob7b8urcfzowxeimz

On 4/9/26 00:19, Jiri Kosina wrote:
> On Thu, 9 Apr 2026, Rosalie wrote:
> 
>> Yes I do apologize, and I'll be mindful of either doing a series, mark
>> dependencies clearly or do a pull request.
>>
>> I didn't expect to be sending this many patches at all in the first place, but
>> one minor annoyance of the code bothers me one day and then another day
>> someone else mentions that e.g a device name is incorrect, so that kinda led
>> to this chaos.
>>
>> Apologies and I'll try preventing it in the future, and thanks for the advice,
> 
> No worries. I've just update hid.git#for-7.1/sony and I believe it's now
> in proper state with all the patch dependencies correctly captured. If you
> see any issue there, please let me know.
> 
> Thanks,
> 

It looks fine to me code wise, and it compiles! but you forgot to apply 
a patch you applied earlier to the for-7.1/sony branch, namely 'HID: 
sony: update module description'

Other than that, it's fine, and again I apologize for the chaos,
Rosalie

