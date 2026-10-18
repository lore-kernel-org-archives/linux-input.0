Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3C49AA4B
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359590; cv=none; b=alW8SYAGPGaNdhUjankhzaYp3PiLaYxGV7bHjDhQ5aG9BN9CduhNmWFvn+UJyVsgtCaPMDoAKGMyIx9UXAVtnEzUAJEjl9fnfnk2vuvGDCBYHIo/du/Wsl4Ngd7SQvoaD5oJlm0uYjB/PvXZVBe/IzsR4dv7q/ZKeCyCKpecGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359590; c=relaxed/simple;
	bh=eRXseqzFpIiATiZ9Ys+vyx+W6hIJyTRBGpGUgucU82g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSqV7sOSSXjRFprP9Qza+ckrPBMPT6q+XOByTw3GH42XhqAAQO3xbjcUnDqp5wEJF/PDdJLVjNh53yYQ7ynM/I59GnIrbR0jxC1TGqLzZJEjt+v5VAkRbSDshinHZBFSQ3W/ainAmxeAuHW/k+CUzl+dC0yL8nkEo0eY9RNbVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=euTIzkjb; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="euTIzkjb"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eRXseqzFpIiATiZ9Ys+vyx+W6hIJyTRBGpGUgucU82g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792359585; v=1; x=1792964385;
 b=euTIzkjb3w+2mdL81ytDG8jqb3F68vutN1m8Kuf8KgjWxKMTBvaQRyvOb+g1VXb38/B9SvrK
 jyxYopsGuDcPLgy4w/Ra/rOM9QEJFsa8KhyBiTxQ9exyhYU9jDsmpumAGUf+idKHhfI8O4DUw4i
 Qmi++IOus7FalObnul86r5mc=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 37702aebe84989f8;
	Sun, 18 Oct 2026 21:39:45 +0000
X-Mizu-Trace-ID: 37702aebe84989f8
X-Migadu-Flow: FLOW_OUT
Message-ID: <a357e58c-f072-4287-88a5-b7121e8ec92e@linux.dev>
Date: Sun, 18 Oct 2026 23:39:43 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] HID: asus: Add missing Zenbook Duo hotkeys
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-3-p.pisati@gmail.com>
 <7dfed94a-f7f9-417d-ba0d-09f199047b70@linux.dev>
 <20261018213809.GB4068315@ax162>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261018213809.GB4068315@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/18/26 23:38, Nathan Chancellor wrote:
> On Sun, Oct 18, 2026 at 05:55:02PM +0200, Denis Benato wrote:
>> On 10/13/26 12:39, Paolo Pisati wrote:
>>> Assisted-by: LLM
>> Assisted-by tags have harness:model like this:
>>
>> Assisted-by: opencode:deepseek-v4.1-flash
> Just an FYI, Assisted-by: was adjusted to Paolo's current format in
>
>   816d9992d9ed ("coding-assistants: simplify attribution")
>
> in 7.3 and it is being removed altogether in 7.4 with
>
>   1e035297ffda ("docs: remove Assisted-by references")
>
> currently sitting in -next.
>
Oh I fell behind current rulings. Apologies.
