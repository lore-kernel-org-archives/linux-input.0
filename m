Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405013246E1;
	Fri, 27 Feb 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197905; cv=none; b=OJSGvfCwSDxav5Pf9AEr3kRnbarGJoQ3xrgZ7R4XjjfEpZ4peFZwAPHUUbhlSUEd1eKtRvihyX3IIq5DUNKaTVxJqNTYHOuGyfBvNeksuWXGUsLZahrokuFCwQJehtRHB1aB4UGichEQvQ4V0iL8gfiM12HoOXSG2za6uhZYtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197905; c=relaxed/simple;
	bh=ytVlhoNo68CMWjD26uKMlK5IQaCrHXZ1FKnkDAadSAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pBB+xoL7kl9SfXI5ocxGB4xxR6zk9Uu2OLU8rHhDCi8XirIrt+h5VmFECROR8Nt0EpLz3xJWsf/xjN0rv9QxlI3zuE9avjt9gynwTGGNtAgeCO0XAIw7OiffC5Pkb43A0nfA/3EF4alIkl8JqrUdGXZs+Zv6uJeHhDc/ZdecvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7xwkQRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7xwkQRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA98CC116C6;
	Fri, 27 Feb 2026 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772197905;
	bh=ytVlhoNo68CMWjD26uKMlK5IQaCrHXZ1FKnkDAadSAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=E7xwkQRYvc0qGCO7ZJw0/YyFL8dDpMQKzaYwRtWuRg8+JB8YLrAH4+f6sGyTD512l
	 LHNaIcRZDjvsP5y1Gst3VQGv7soVfB5S0fuqke+OYAhVMsiomnIcKuzYu9hXdcugaU
	 CyZQfzCACvkmGt+gTwUkNOvvZTZkA1JM8kG/vrPuohDbIf49EngTSpXYPnDnSkWbOi
	 NLQBjs0thESL2Rn0oZYDYHUd/hFINMMnkKimM0SW9Qdxvx8YMbrGAlQ0nOcx8nRMNz
	 UyIZrHG51fPfEOX0xkx1oM7vBF4Fu/vVpKXO/iMg10RwkTp/adDdqeFVS0uPiQgERf
	 VpHXNO+SZI6KQ==
Date: Fri, 27 Feb 2026 14:11:42 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/2] hid: asus: always fully initialize devices
In-Reply-To: <20260216175539.12415-2-denis.benato@linux.dev>
Message-ID: <1orn1p93-3172-6099-281q-9n74rr5155o7@xreary.bet>
References: <20260216175539.12415-1-denis.benato@linux.dev> <20260216175539.12415-2-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 16 Feb 2026, Denis Benato wrote:

> ASUS has more devices other than laptop keyboards which needs
> to be initializated: the init sequence is the same as keyboards.
> 
> ID1 and ID2 are USB report IDs that are correctly enumerated:
> send init commands to all devices that supports those reports IDs.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>

Applied to hid.git#for-7.1/asus.

-- 
Jiri Kosina
SUSE Labs

