Received: from mail.mcld.eu (mail.mcld.eu [84.242.69.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0C368D51;
	Sun, 12 Jul 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.242.69.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879589; cv=none; b=ZtdaLN86s2mEo3OiHqHCF6nClTaoZyMh/Hg4U8meEdk//RVD3ITrY7rmVwSTIp4xt+cL7b7yEZW0/q4hAFpG+prV55H7z8NijJCYGeIyzXHioQxYiML/LNmknTRI3Hya02X/6NQuANifFBUOEAhcn+dSdNvyL4relpAafh/LVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879589; c=relaxed/simple;
	bh=NqbZQr932MmiUXcXork0/8gR86DPj1umO+X26Lu1gHo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Sod7FGkxvnbd6zz4ilSj1zOXitxkgckJlhWT0OshfNSIT4J2DO/uIC+SV7ytHylO2jf9UZ/syCg8aj9ROvJCnfpBFwJhloiJXmET2wugq+6/xT2PeVO6wh/Lhhhp5Dxyz7QavWB5J55Em5+4bAfiOGpOPloox+t3rLAnP3bhUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu; spf=pass smtp.mailfrom=mcld.eu; dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=MGAw7fmE; dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=O+VJGMkP; arc=none smtp.client-ip=84.242.69.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcld.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="MGAw7fmE";
	dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="O+VJGMkP"
DKIM-Signature: v=1; a=ed25519-sha256; s=202501e; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=From:Subject:To:Date:Message-ID; t=1783879434; bh=Z5pXRRDkzHwNRFImn0V1zYj
	0VeqdaZ2hnQ41Z9iSJ3o=; b=MGAw7fmEWHiM6cZk5ZRsvxF3zYcWFNpElggyt45VGpuqnHPIf2
	1Bdi5jCCQ/tKU7KkGsfVWwf1Q05L0Zn0kJDQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202501r; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=From:Subject:To:Date:Message-ID; t=1783879434; bh=Z5pXRRDkzHwNRFImn0V1zYj
	0VeqdaZ2hnQ41Z9iSJ3o=; b=O+VJGMkP/HDDGrhgvXuLVH4/I3L6QfcDktbh2pRBanLKaij+dK
	2V8JohQAHfrphkPrw8rL3h42Lo3HNP306RwQUPQlTxcQ5PFvnoAepMvZZqF6HbK0ylBEtr9Tirg
	haaeBE4QSXkdlkSrs5r17iYkv8rbQVZGVwG5Oe/wnbuB0OnhE2tt9KlqpEb7o6oEC79yGJMylcn
	gahOG5Ce38hzq/ztraoDJi+RR+5sI7M/47oClQ4qWnxyn9DDbts4HqIvV2VdEW8QSiZsfgA22V8
	f6R0hCicwvwY64rNmIOQ3L3cppaX9x67CGgc6PmAwXShWBNLrjr7Y51Gb4zcHLWlC0g==;
Message-ID: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
Date: Sun, 12 Jul 2026 20:03:54 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: erikhakan@gmail.com
Cc: bentiss@kernel.org, hadess@hadess.net, jikos@kernel.org,
 lains@riseup.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260712003051.338194-2-erikhakan@gmail.com>
Subject: Re: [PATCH 1/1] HID: logitech: add Bolt receiver support for Logitech
 HID++ devices
Content-Language: en-US, cs
From: =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>
In-Reply-To: <20260712003051.338194-2-erikhakan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Erik,
I tested your patch on my hardware and found two issues:

1. Both keyboard and mouse inputs stop working correctly. The mouse 
becomes very sensitive and creates events that shouldn't happen 
(sometimes scrolls on its own) and the keyboard's keys are scrambled. I 
verified on my hardware that if you pass the first two of Bolt's 
interfaces (0 boot keyboard and 1 boot mouse) to the generic HID driver 
and only handle interface 2 in the DJ driver, you can keep the extra 
functionality (like battery reporting) without affecting inputs. The 
existing bInterfaceNumber >= no_dj_interfaces check never triggers for 
Bolt. no_dj_interfaces = 3, but the receiver's highest interface number 
is 2, so interfaces 0 and 1 fall through to the DJ path. Here's what 
fixed it:


if (id->driver_data == recvr_type_bolt && intf &&
     intf->altsetting->desc.bInterfaceNumber !=
				LOGITECH_DJ_INTERFACE_NUMBER) {
	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
}


2. Bolt devices stay behind after unpairing in userspace (using Solaar). 
The existing driver code doesn't handle Bolt's unpair events so devices 
stay visible after unpairing. Here's how I handled it:

if (djrcv_dev->type == recvr_type_bolt &&
     hidpp_report->report_id == REPORT_ID_HIDPP_SHORT &&
     hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
	struct dj_workitem workitem = {
		.device_index = device_index,
		.type = WORKITEM_TYPE_UNPAIRED,
	};

	kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
	schedule_work(&djrcv_dev->work);
	spin_unlock_irqrestore(&djrcv_dev->lock, flags);
	return false;
}

Hardware tested:
- Logi Bolt receiver (046d:c548)
- Logi POP Icon Keys
- Logi Lift Vertical
- Logi K650

Happy to do more testing.

Regards,
Kateřina Medvědová
