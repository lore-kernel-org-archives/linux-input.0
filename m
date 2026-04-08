Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA634AB0B;
	Wed,  8 Apr 2026 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686350; cv=none; b=AzdEIWgk0W/sE3DtLAIzcrNDGuaIh8Bf+nM5DnqS1hfN2pCio00oMZ0FDrHWWGa79yR8bCeFony5UetlpsD/NT/E10Ze/qjmse7vz9A4b4tkUTvJ9xBesyZaBtxVLG48v8uiTlfzKmKhPfDTlOJ1UGRDCl8L1oEGe4GKmjUHkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686350; c=relaxed/simple;
	bh=pqwV+oJ3w2K/hYZPQb/pIQ5pclPK+IroLz874iSGfJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIejQgd3npuih/zmxXIROyGTVX8XIzI630GztJ90M697SWb7Z6qMS38VOOViP4ojFpHwXASLsoO5Ma/QCLXe7P00ku+0soQjTSJdudL+c4t8eMZQi+/2yx7Dh28AF3IgBDaiClnwInlGPOVbDINzFo2PeLE3MrHX2ELubDUW3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XyB8k6lG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XyB8k6lG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4frckJ54RTz9tVN;
	Thu,  9 Apr 2026 00:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775686344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1becq35fIReczOnVJOiksebaJpra7TLnWBbLID2w5I=;
	b=XyB8k6lG5pK/56x4cbIoKwj0/W1bdMtiw6v+9+1EMIphInL51//TsySSFPCqhG6SYLpuXf
	P9u32vVp3pPzWzfzx7g4sGUaiY9Y6qbw/bDanoUtOpKptukeS1R1qiqzCmg75Zqz7aruMg
	1AoMkdEqE77tGW1unL7BJvbnsVqTi6j7ChSzWf3yLlOrKk44aMYDQ0FPH4qCfGR8meNkNk
	cxtaNKb1hFwF7+Rl136mZ/VCize5DZi+CvlnvlKIMa5Z+LGPi/SVU0Zql76XON2Spsbgti
	e5wtSoJ0hSZiFMBIs2iUBfi7g03QoldtxlLxn42k62XrqbnLYcy3bDXBBoEj5A==
Message-ID: <cb0617fb-76b0-4241-8fba-982a5ffa4525@mailbox.org>
Date: Thu, 9 Apr 2026 00:12:22 +0200
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
Content-Language: en-US
From: Rosalie <rosalie@mailbox.org>
In-Reply-To: <o488s484-r1os-6736-o800-7on55687757s@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 17iizibys1oukqinzkfsm5m1h9k1863y
X-MBO-RS-ID: cc05d464b3688a79a3b

Hello,

Yes I do apologize, and I'll be mindful of either doing a series, mark 
dependencies clearly or do a pull request.

I didn't expect to be sending this many patches at all in the first 
place, but one minor annoyance of the code bothers me one day and then 
another day someone else mentions that e.g a device name is incorrect, 
so that kinda led to this chaos.

Apologies and I'll try preventing it in the future, and thanks for the 
advice,
Rosalie

On 4/9/26 00:08, Jiri Kosina wrote:
> On Thu, 9 Apr 2026, Rosalie wrote:
> 
>> Hello,
>>
>> I've sent 'HID: sony: fix incorrect Squier name and remove non-existent
>> device', though I will mention you didn't apply 'HID: quirks: update hid-sony
>> supported devices' cleanly because it duplicated the vendor and device ID
>> defines in hid-ids.h for the Wii instruments so it will not compile, I'd
>> advise you apply the patches in the following order to prevent issues:
>>
>> 1) v1 of 'HID: sony: add support for more instruments'
>> 2) 'HID: sony: fix incorrect Squier name and remove non-existent device'
>> 3) v2 of 'HID: quirks: update hid-sony supported devices' but without changing
>> hid-ids.h
>> 4) v2 of 'HID: sony: fix style issues' (if you want this patch to be included
>> that is)
>>
>> alternatively you could also do:
>>
>> 1) v2 of 'HID: sony: add support for more instruments'
>> 2) v2 of 'HID: quirks: update hid-sony supported devices'
>> 3) v2 of 'HID: sony: fix style issues'
>>
>> I hope this doesn't cause too much hassle,
> 
> Thanks, I will look into it. But going forward, you really should either
> send this as series, or clearly mark the dependencies. Sending it as a
> followup fix in the same thread also works.
> 
> Or, even better, send a pull request against a git branch if the
> interdependencies are tricky.
> 
> Imagine you're getting higher tens of patches a day (including e.g. quite
> often v1->v5 within a timeframe of a few hours), and you are somehow
> magically expected to untangle all this.
> 
> Thanks,
> 

