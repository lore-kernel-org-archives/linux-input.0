Received: from mail.mcld.eu (mail.mcld.eu [84.242.69.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CA36493A;
	Tue, 14 Jul 2026 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.242.69.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025219; cv=none; b=W24MQZX9FqSqmFzADvibWvvPXmQL2PrxwTpXulgrnZKdDVvUbtoVPkIMzmcrO/7xakvHZImxWE+Ui1WYsIfAbxUkCB8r8Q5C3nCiR/EgeEJVbXfdgwEDhC9DvwvW0cGKVNgfdC+biQ48O49yZoVD6KsB+Iqp1MU8Yrgf/wPtAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025219; c=relaxed/simple;
	bh=EiBkPFmX6ZlUTXNXMXRsYxbbSeVzCil42hLJ2nqhf+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z72toxRcIqko5eBuqy4cJGPTr7AJl2zxdsogeEcyc4Zo+z5q6JSN5R/kCQSOYHRPkreBLdkWdmB8rDctbMJPjBmO+6QYrti/Jop+fw7aqJSLYgaDOuseL9VCCBGtfwX1vhhFIhB/hlOJFr7qiSNxW4WbJSqTENipiSp9hl3dKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu; spf=pass smtp.mailfrom=mcld.eu; dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=zbqcnr1A; dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=MrAE2EjD; arc=none smtp.client-ip=84.242.69.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcld.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="zbqcnr1A";
	dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="MrAE2EjD"
DKIM-Signature: v=1; a=ed25519-sha256; s=202501e; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1784025130; bh=PBAWNSn+POBNh7abV6eh/6i
	d54nQurK2nsza7ZzfGOQ=; b=zbqcnr1Ald5M5R11vzvOXOBwk7Y4W+MQ9FjTs6tQHyeTJet/ZT
	SSPtgp7mlSYoXDM/Ifps6UEBNubJnhN5RBDw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202501r; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1784025130; bh=PBAWNSn+POBNh7abV6eh/6i
	d54nQurK2nsza7ZzfGOQ=; b=MrAE2EjDLH5GrbPPbcygoz2mMFHD9PFUXsI+ge7PyO2bJ3sw5u
	dKL7aTLz3wwBjbwg7yZ1l9vo+OpgbayB59nHDAO4q3E5cRpMC8fnrx+7Kldb5v5TeN3Pg9s0Zjm
	puGG6x3DWO4xB0zlH8cepZU5wKqszF/ul0YJ4f0yNVckzHJrNJ8cKVs6XpnvWRgX1w6GZr9dqxw
	8bZWzeVqQB2i/CK/9inA+7Xkra8uYMwQEiv+tkp08qRdqGFJhrmOYEG3EKPoNNxcTDjRh9yA7Q9
	plV/EnCliT4+BALnUVLAsOzgzIuo5LVW63QvauM4r2SQ9/cvRz36/hKVEpjCL56ju4A==;
Message-ID: <54844d1b-636c-4896-8994-f4e960e57944@mcld.eu>
Date: Tue, 14 Jul 2026 12:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
To: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Cc: bentiss@kernel.org, hadess@hadess.net, jikos@kernel.org,
 lains@riseup.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
 <20260714005441.472898-1-erikhakan@gmail.com>
Content-Language: en-US, cs
From: =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>
In-Reply-To: <20260714005441.472898-1-erikhakan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Just tested V1 again with both of the receiver versions I have on hand 
and the input issues I described happen on both.

btw, thank you for pointing out that you can check the FW version in 
fwupd. This greatly simplified testing.

I do have one find -- when a device gets powered off (yanked battery, 
switch moved to the off position, switching devices), the battery stays 
in upower. Unifying also does this, disconnected devices stay. Either 
this was intentional or a bug. Either way the behavior is consistent 
with the existing code and isn't introduced by your changes. I'm just 
not sure what the correct behavior should be. Sorry if this pollutes the 
discussion, I'm completely new to the LKML.

I'm not sure what else I could try, I'll keep your V2 on my system and 
let you know if any issues pop up.

Regards,
Kate

On 7/14/26 2:54 AM, Erik Håkansson wrote:
> Hi,
> 
> Thank you very much for your help.
> 
> Unfortunately I don't have a Windows system easily accessible, so I
> can't check my firmware version in Options+.
> fwupdmgr says:
>> Current version:    MPR05.03_B0020
> so perhaps that means 5.03.20.
> 
> Let me know if anything pops up if you dig some more,
> Thanks,
> Erik

