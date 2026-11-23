Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465360;
	b=KON4Ub0cz8GzsA9bpOsHaEri8krkJjG+pc5AZdejP8lDJNJQBOl0omQWcCCKms2pO91q
	 8AcrbC9w64pomXY+Nb2ZmKh6c6V4Xjl9XeuNrbNnIsrPzGaDf0C8I/1F/vroYmm5mF6vI
	 uLQivzuxiKMc6ndf5j00Y+UVNfJ6P3hqL66R6nlKZVzzyXX9+RIR9x7WPSdFiLc7qUW2a
	 Z9mW3gAVMdAnkKhxD3ipQP13RjyJKtuBXMAVDF7cEpmmrhpyzo7wmUb6M2lN1NaG5xn4J
	 Mr0vczA9TrSNr0TpHbGV9XElghuSb4n+v3+MoNp5GSVj23AXlIHQfkXZ2jaSgmB3mCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gCLRRKTFKXK2HkutDnNQ0o/EWQjNEj+82Vy1QomspIo=;
	b=FW/9V2pium4h9Jxw1v4vK/nLSKbqhqTSi7PhwzvGZipZMMM8UjZ4LU5oIntvJNnRLXFS
	 uFfIKfc8CG+1dqJGXwFenF1Qbx4vDRicjdG6nIqFeBWUnfyKRq6OE/H4vh4l/pIWQVQnz
	 XNC2ybxSPQnGWPPLmjBkSZqLYl7vsusK5LztXejlmOrqxxMuRRnGq+vnXTHYx/6KA9yfB
	 fQEfnDOKDska6srnQmASkdovG6iiVG9ZCmJeK6hvFYhJZcOh3J7DeRRxC2xCjbZs43wGd
	 iMMhxhSMYFdTo9RmVVYlP7ll9OW17yF4Wx8DjRx1rfHv5UOkTVz7Go8JnsVCsEd3mAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ppqht/oh";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EB606A326
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ppqht/oh
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so10071637eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465359; x=1796070159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gCLRRKTFKXK2HkutDnNQ0o/EWQjNEj+82Vy1QomspIo=;
        b=ppqht/ohwWl2aULz1yr6gbfVi6RFEHnBDhC+ETkHvKC8uwFFxj3pwj67/MkPMLnmrG
         NQc+56GMEIAKsTSB6tqvcnHnpR8+RqLBG3esAvqmB2z3Qr/GOkV76vRPQq0wdfLTgcEB
         3V0qbatuXHoaxwYxrkidodjS661LvtWMIRO7zbwZy6nckja0r0K25Tr+SiHlDETxpTm1
         HHUPJ54w+YijJDyvsTXu4qNNgHvEmqqDeb4bpiumh/WwXBlM+3PZ/qWaQ9OwEnSxms1v
         J6u7s+jvmvR9CUP3AwZQtUZNHx/NuPXnB+n83AuV6rF4RDD4eqD5OAm3HT2JUgqUAtC6
         +fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465359; x=1796070159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCLRRKTFKXK2HkutDnNQ0o/EWQjNEj+82Vy1QomspIo=;
        b=COot2mtKvmk0rc7T5kcu4VZ/0iTxEM25SsGvt9aGQim++UdpSSUStuvSARkTG9w83h
         ejtE/YmGWqA4m+czevsNYa3md4KVkYHxjzg+4p+wd7pvE0f8GeYBFkT2IYrnG3P0ddEC
         VKZm+GBOmqbGrk5QkeEBIW7vJXDp2WGuqu4+YvbnWOMyjOTijA4CU9/Ywi7UTzY0sVQ3
         frEcdV1bWvR+PnUtPVFAMpCpoP80rU7pFprrGJHJX2Us0NS1T3MNytWlpTka/4jZoiDU
         3ZVbsjV/KLFBReBNjonwnDrgnfdFdECxBRwaKpAPSfrs7zW5GyZnpxH2raGVQT1qI69i
         V7zA==
X-Forwarded-Encrypted: i=1; AL+hErGmXrFxqwE5/ru/nKbJJknGHcvWTZ0YECOJNC4LBkqFslSEyj0kcuhB00rxrd+ma9dLZbBQs71Q15A7Jw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ieMpUIRsVyCvVEpfdFtSP8FOFOxkg6qSQGa9pCH/D7tVXFLmh
	LWUjkFY/c19PyHyAVNjd6c+u0X7A5KxPPPk+5zRKEqazONLsa37KgUPQ
X-Gm-Gg: AZFdTZe83LVYVrZ4vqhkBvoBHCL9laaRFDDHI4o8HectDa6woL/GM1TVPYLwqiCBvIs
	kx3XgloTBZdLoMrz8c6ecJ2/m9TY/CZHLQrhZrAfOptiHE2Y07teS1qrAtT5t9N43PurgYCFnv8
	GLnMOcRU8lS/DS5HjtL198B4AoCGTb8DinE999Hlcs3yLWURTdesSHDUInNPnwE99Q2I1ISVwvO
	yA4Ni+Mxjq2spjCtbdGChWHqxf0jUMc9WplDk9uSIz2egdsRvbU58gyzGkMIe+S+xa7lRRT0fao
	v8M3yyPA3faJ4Jx0EfWtWC474dDEteHaR8/dowTuyuNn8tcQASS805oZVuIIhYxhzqBH+zgCU/p
	+1bZHW/Tigcp8o2+zzowm4qTAW2Ca89s6kpeLLJ4IAEqTfi+HoFO0mQZckig8f5F0Xf28V1Z0cT
	mMuDoPEryOkWj5MrvJSqQJ6N8okhekuak5WiwAOtJoVCX4UqhAms00RVzNzEQ/Lby781o8MpH+G
	VPzreJKpqF27JuCElZb4KlPAHt5PtrdWvkB5gkMYfTbCQKjxJWYK82F1ph5qnFSbbpilGVcYI5j
	aTOiLiPGudfs3R+KRbglskJFQiYj0IkHEnc93+xbIc3WixUif+qTqrjAXW+1C4u98ArKGd0=
X-Received: by 2002:a05:7300:b597:b0:386:9e36:df0a with SMTP id 5a478bee46e88-3869e36e011mr13076842eec.13.1795465358637;
        Mon, 23 Nov 2026 12:22:38 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm32126987eec.25.2026.11.23.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:22:37 -0800 (PST)
Date: Mon, 23 Nov 2026 12:22:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Carlo Caione <carlo@caione.org>, 
	Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 07/10] Input: axp20x-pek - skip IRQ handling during sleep
 without input device
Message-ID: <awSgh5DW3V1cLYCa@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-8-lee@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-8-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:13PM +0000, Lee Jones wrote:
> On Cherry Trail systems where an ACPI GPIO button device already handles
> the power button, axp20x_pek_should_register_input() returns false and
> axp20x_pek_probe() skips axp20x_pek_probe_input_device().  This leaves
> axp20x_pek->input NULL and both irq_dbr and irq_dbf zero-initialised.
> 
> axp20x_pek_suspend() and axp20x_pek_resume() nevertheless pass irq_dbf
> and irq_dbr unconditionally to disable_irq(), enable_irq(), and their
> wakeup counterparts, manipulating IRQ 0 (the legacy x86 system timer)
> across suspend and resume.
> 
> Skip interrupt management in axp20x_pek_suspend() and
> axp20x_pek_resume() when no input device was registered.
> 
> Fixes: 8a78050ee257 ("Input: axp20x-pek - revert "always register interrupt handlers" change")
> Closes: https://sashiko.dev/#/bug/linux-5ae6851f-784e-481c-900b-2e1686578c89
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
