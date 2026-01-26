Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAB257821
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466083; cv=none; b=ZIMeLFGUGQ/9s9eM2mvg8t4n9AsGlZf3QryuCcwd7d1gE4uGYlB1jSZOPrhBtPaQZbP4OV5u3a7lnjnyXnjA/xCmI2ThdaAAU9G6vDcNU/luBTX+pg2uc5V7EBGw9z0dE3axVikzsl75cbFVhZORHX62fGu9l2kMmf4wGXD37ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466083; c=relaxed/simple;
	bh=GG2fWDPjh+3LpQrShyUteOYkEIvpcbrxj9ofSRO45CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJVILms/m52cM8JWXRt6hm0HxxbhBPVICZBiynMaBNi5Qyp0LDYxEaSH5TPQUKiNSDE8vDcZyQXYHFfyTWlwEzKjtGn1s1CHUwLQ+QtgL/UymM/P3Y8tS8J3WhbotA6TW/euw2WUfy+rtWSdSIAlSDum3pRRZuVGobwUtd6a+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitmath.se; spf=none smtp.mailfrom=bitmath.se; dkim=pass (2048-bit key) header.d=bitmath.se header.i=@bitmath.se header.b=WO/KATvc; dkim=permerror (0-bit key) header.d=bitmath.se header.i=@bitmath.se header.b=jSvrt6nc; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitmath.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bitmath.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmath.se header.i=@bitmath.se header.b="WO/KATvc";
	dkim=permerror (0-bit key) header.d=bitmath.se header.i=@bitmath.se header.b="jSvrt6nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769466008; x=1770070808;
	d=bitmath.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=f3UcvhXJeEMFAR6N7okv9j6pQxF6yrI4G93XG6Ihl38=;
	b=WO/KATvcKp29EaJs8tJHoeDz8tNPyRMKSjQvbb1MCL7ROcGmLEVHZlLtzFSbIBrmtcR/L2eQmVzEJ
	 9tNgTgx61667wIiQbRMFMuuUX/Jo6em4pi59QqBUIH7boXNsz/1bVPrvE2HIpbsaCe1+Xp+ratjXFw
	 NfhUaJpsEAhfUcpwDdA3qhNUI86ajL7GWX2b4qsV1Ta3emu+0dcDp8ohZWwoSJ/NKOnh8mdK2gdqnN
	 4cMg5665piikJfyLq2NtQGZqBgv1NU26RqcAyNkNTEMB3a/WBoBQ522exuDqY+RvgNByORaEAfa8Ul
	 a5ASFtuvfVgdSvFmeX3CZ+RDC3wvyrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769466008; x=1770070808;
	d=bitmath.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=f3UcvhXJeEMFAR6N7okv9j6pQxF6yrI4G93XG6Ihl38=;
	b=jSvrt6ncktYx9fFv7wa82dUzyAiD8bTCZkxo4dhhNihuhI30PLelifiPU3AsNTgIoDjWPxcdHlijU
	 aFRyZtfCw==
X-HalOne-ID: 2b6c3170-fb05-11f0-bacb-81a63d10fb2d
Received: from [192.168.19.13] (h-94-254-62-230.na.cust.bahnhof.se [94.254.62.230])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 2b6c3170-fb05-11f0-bacb-81a63d10fb2d;
	Mon, 26 Jan 2026 22:20:07 +0000 (UTC)
Message-ID: <d1a09240-9a0f-486a-872e-8b528ff7e272@bitmath.se>
Date: Mon, 26 Jan 2026 23:20:57 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bcm5974 trackpad broken after USB reset
To: Liam Mitchell <mitchell.liam@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>
References: <CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com>
 <38ea07c1-50ce-4342-aba9-fe2f4bc6c503@bitmath.se>
 <CAOQ1CL6G6eDcX+Qth3D531h72wW3RmvecCWjr5nAT-UdDWg40w@mail.gmail.com>
 <6880b5ba-ee76-4a9e-a116-16843a737b34@bitmath.se>
 <CAOQ1CL74A+WLY_f+QJHQqV=Wvq8yzJktLZ2ByZ4vjfUSsra9EQ@mail.gmail.com>
 <c2f1a90e-d6cb-480e-8f11-240b231adc84@bitmath.se>
 <CAOQ1CL7royHBeeY-Qr-xBhvXkWy1cJZ-tcT1kS1Dfu_z3emN6g@mail.gmail.com>
Content-Language: en-US
From: Henrik Rydberg <rydberg@bitmath.se>
Autocrypt: addr=rydberg@bitmath.se; keydata=
 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 nQ==
In-Reply-To: <CAOQ1CL7royHBeeY-Qr-xBhvXkWy1cJZ-tcT1kS1Dfu_z3emN6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Liam,

 > I did a lot of experiments changing modes at different times and this
> is what I understand:
> 
> 0x8 ("normal") is pause/off. If this is set, no messages of any kind
> will be received.
> This is not the same as the default/init state (sending 8 byte
> packets, HID?). Even though the first config read returns this (08 05
> 00 00 00 00 00 00), if you write the same bytes back, it will stop
> sending the default 8 byte packets. I haven't found a way to re-enable
> this default mode other than USB reset.
> 
> 0x1 ("wellspring") enables multi-touch packets, how the driver has
> been working for 18 years.
> 
> 0x0 (suggested above) also enables "wellspring" multi-touch packets. I
> noticed one major difference in my testing; that it seems to survive
> suspend-resume without issues, whereas if the mode was 0x1 on suspend,
> it will resume, report 0x0 in config and send default packets again.
> 
> Another interesting observation is that the first packet received (60
> 02, "control response ignored") comes reliably 120-140ms after USB
> reset. Importantly, if you send 0x1 or 0x0 before this is received, it
> will be ignored. It will update the config but won't take effect. From
> this state you have to send 0x8, wait 1ms then send 0x1 (or 0x0) again
> to enable wellspring mode.

Looks like you made real progress here, great stuff! With this 
information, we should be able to provide a proper fix, agreed.

> The above will be why my mouse doesn't work after reset and why adding
> msleep() in probe() fixed it.
> 
> I think a more permanent fix could be to set mode on receiving that
> first packet (control response) and/or on receiving default 8 byte
> packets.

I like that, expecially if 0x08 never needs to be set, as touching that 
bit would require some sort of rougher handling. It was a bit uncelar if 
your experiment with the 0x00 mode went between 0x08/0x00 or 0x00/0x01.

> I looked at the history of the module and saw that the first packet
> has been ignored from the first version so I assume it works the same
> across all hardware versions.

Yes, the setup timing was never considered, and your suggestion should 
be a good fix for a lot of devices.

Thanks!
Henrik

