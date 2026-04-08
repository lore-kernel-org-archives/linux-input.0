Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C22153EA;
	Wed,  8 Apr 2026 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685726; cv=none; b=WWpjmWpKhoAFIfXTil7MTzPObtnrv/hVRxHmrwHh9rkcasgZ+e4S1od2h9aEkMq64VhFXJ1/WycFjCMFFXIHUF44K2unxwWntFEjAos3mO9+tsXmteUprWiww0YjG3UKAWW7XaroV7KC1F0Tk7j+GLgkbhX0iC2JAtNvzqcl7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685726; c=relaxed/simple;
	bh=zNJ89rUBocPNREEYZorwZd3wZhFyvIfEhauTjTZ1JcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uavFSXarVFwuciIx2MtKgpB2wXpn/FUrsPDpLt93MRDS5zbB0S60r00sARS3aytVFgyTqkrte4Bq3BSEH1pA8ZI1+UgUn8DC4QeonxCZn8RLU5adqqG6AjNL52mKIvtyziDIQ1cpKxUjyEIQ5tRiyYX1P1fC3a5COyRq4DIkaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FAJ3STaW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FAJ3STaW"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4frcV85ry2z9v7l;
	Thu,  9 Apr 2026 00:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775685712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HipFRZtT3tbiDF4dczkJVRjL3Eikm4gy+Np5zxRG2gY=;
	b=FAJ3STaWCEiu/tBNH9KOfYp67s9CceTWY/8j/ropFpQ2yGFF8xDz0+3oPgmoR2REL6SPaS
	kiKLD+piZA/gozJ8JUSbIuKv7Qel1a5RbmuJRV2pw51NBKjJv7+prpeElC7OPJNdt4QD9S
	ryHl4xh89lgmgxBgRHHljR4d2PkjfU9MsBuaxE4IaztrQCG1NR7Y2hyaFX5igBFlod8eo8
	xd78j9+zIR9RbGOLB4ybTYPZQIDgGmCBF/B1KE4qgBp+gqQq6lpa25CudoRnYnePwJsvdV
	Y1IHUlaYR0O8XytYie6ha6X6ykhlTFNUYuGX4PlMkm8WbL598Mguu8TUYzU+/w==
Message-ID: <6893d7ea-f585-45fa-aa53-cd7a10fec34a@mailbox.org>
Date: Thu, 9 Apr 2026 00:01:50 +0200
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
Content-Language: en-US
From: Rosalie <rosalie@mailbox.org>
In-Reply-To: <37nrpop7-rn05-pqo6-3951-171nr8nq441o@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rz4mfrg9cq5f3fqphgqgdutqop8o9bka
X-MBO-RS-ID: e4ec7c313267f135d58

Hello,

I've sent 'HID: sony: fix incorrect Squier name and remove non-existent 
device', though I will mention you didn't apply 'HID: quirks: update 
hid-sony supported devices' cleanly because it duplicated the vendor and 
device ID defines in hid-ids.h for the Wii instruments so it will not 
compile, I'd advise you apply the patches in the following order to 
prevent issues:

1) v1 of 'HID: sony: add support for more instruments'
2) 'HID: sony: fix incorrect Squier name and remove non-existent device'
3) v2 of 'HID: quirks: update hid-sony supported devices' but without 
changing hid-ids.h
4) v2 of 'HID: sony: fix style issues' (if you want this patch to be 
included that is)

alternatively you could also do:

1) v2 of 'HID: sony: add support for more instruments'
2) v2 of 'HID: quirks: update hid-sony supported devices'
3) v2 of 'HID: sony: fix style issues'

I hope this doesn't cause too much hassle,
Rosalie

On 4/8/26 22:41, Jiri Kosina wrote:
> On Tue, 7 Apr 2026, Rosalie Wanders wrote:
> 
>> This patch adds support for the following instruments:
>>
>> * Rock Band 1/2/3 Wii/PS3 instruments
>> * Rock Band 3 PS3 Pro instruments
>> * DJ Hero Turntable
>>
>> Wii and PS3 instruments are the same besides the vendor and product ID.
>>
>> This patch also fixes the mappings for the existing Guitar Hero
>> instruments.
>>
>> Co-developed-by: Sanjay Govind <sanjay.govind9@gmail.com>
>> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
>> Co-developed-by: Brenton Simpson <appsforartists@google.com>
>> Signed-off-by: Brenton Simpson <appsforartists@google.com>
>> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
>> ---
>> changes:
>> v2: correct squier device name and remove non-existent squier usb device
> 
> Rosalie,
> 
> as v1 is already sitting in hid.git#for-7.1/sony for some time, could you
> please send this as a followup fix instead?
> 
> Thanks,
> 

