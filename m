Received: from mta1.migadu.com (out-215.mta1.migadu.com [95.215.58.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4573DA5B0
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344076; cv=none; b=ay8oy4NXG+LO8X1XMqqfCxI9F1MKPMmvTPKMan2TzwYwziHrDce43me5tLYcLmDGd5Cj4stTI9n5+TpyrNvouH+bk79N3/Os1e4TYma3wf86eiMZUOmIVe/kkfzZaRxaVYbq0bTsqY+Ht5i25TCwxTPmO0PVDe9liSu4HKIh+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344076; c=relaxed/simple;
	bh=H+PskeUCKGMKv9twhK/iCWSZr+47PTCOzzhq0XSay1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clztdn8TuUVmML5vAIHd9BRIOQkKYTLZl4f6WYrSKWrYozNou/tdsKsZAEhACGg8LdGtPjiVk3jBsfUSZ6S82xpnbs4yPzN2uSucHrimLnw9R7WYE7v+F4g/GGJ+84XEu+0st5xivBsGlLoC1t7lvtnPKXjt5QBB/zu7VC+SNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V4b+iajM; arc=none smtp.client-ip=95.215.58.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V4b+iajM"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H+PskeUCKGMKv9twhK/iCWSZr+47PTCOzzhq0XSay1g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792344073; v=1; x=1792948873;
 b=V4b+iajMyW19wdAmOHvjYyZ2RhE54INmsBAHQ1sit3V0jR7XbjjEIU3zGZubg91dfhi0UIRn
 lIXm82+TLaD3cX6NXUGPE53AL72VPskGX/b2zWEUtBhkrrZO2Dizew+14OmNnWzmK6Fw7Hq5orm
 u6Kr5VKSl2ew8TtEBls0xD6Q=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f53ce2717b6b9747;
	Sun, 18 Oct 2026 17:21:12 +0000
X-Mizu-Trace-ID: f53ce2717b6b9747
X-Migadu-Flow: FLOW_OUT
Message-ID: <30100025-870a-42b2-8943-4474b0cf454f@linux.dev>
Date: Sun, 18 Oct 2026 19:21:06 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] HID: asus: ASUS Zenbook Duo keyboard support
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Luke Jones <luke@ljones.dev>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013114506.1697676-1-rebecca.mara@posteo.de>
 <424edeef-9663-4e64-a267-66a185b3df07@linux.dev>
 <20261014132242.118388-1-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261014132242.118388-1-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/14/26 15:21, Paolo Pisati wrote:
> On Tue, Oct 13, 2026 at 04:56:39PM +0300, Denis Benato wrote:
>> My greatest concern is with report size: every device needs its own and
>> hardcoding it is not an option anymore because no device can be fully
>> made happy (and working): xg mobile is 300, ally and new ROGs is 64,
>> some have 32, some 16 and I think TP is 15.
>>
>> I have yet to look at the patch that changes the report size but please
>> make the report size variable reading it from the descriptor.
> Isn't 5/7 what you are looking for?
>
> asus_kbd_set_report() looks up the feature report with the ID in
> buf[0] and never sends more than hid_report_len() of it, that is what
> the descriptor declares, report ID included. The Zenbook Duo declares
> 15 data bytes for report 0x5a, so the 64 byte backlight buffer goes
> out as 16 bytes, like the handshake, and the keyboard answers it.
> A device declaring 64 or more sees no change.
>
> No hurry, enjoy the vacation.
I just hadn't watched the patch yet. Now I did and yes: you are right
and if that works across devices it's a great thing for this driver as a
whole!

Thank you!
