Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44F3624A5;
	Thu, 26 Feb 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104701; cv=none; b=m8e4seDoQPIL/aa0tR6++OfbaF6Zx8wIN6Dxon09DTOZfNdSv7NMqU+YvcS2Sj2lNQV9vEgiHnSPeDiPG7kCiG0VAsOyquuZKGsbyOf1jNORrcLW0ji2r88fUjWoj4OTqgPGNTgeSU6XOag8l3lRxOQFA81zM9bcNUfAN4EXNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104701; c=relaxed/simple;
	bh=IkuCNROmTgo+spkIEdT15GSdhabkpsrR4l8+6f+wIgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVvNtazNFxyksdOsDNh47V/SumlXlP4mayyh7+HhfEKdAcknBzmNAXwoAN1gUZA8Ry31aYA/aIZuszQXZPHvy9iyf3KJSaIEVlLEGOBt0WboigVZ9QBE9Pxmjez/DuigyZPYV7MPa2R8NleUTrARFoAfEXkogTAKQRQrsTMJImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMaNvHRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMaNvHRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D14C19422;
	Thu, 26 Feb 2026 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772104701;
	bh=IkuCNROmTgo+spkIEdT15GSdhabkpsrR4l8+6f+wIgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMaNvHRqh5R8mK4CXT7lHEv86FIBuUGq10+zVmwG11V3hp2O1TvcLWgyQ2kBnZVAM
	 MiSAuAeagkYtiLCdEV6I2oTpoavUzGTrfEu4KO0XU6M0EXI8EzaScQfbHHJfRhyfxa
	 BskTCxtfwJbKVyuUa1iGg+VxP8tBPGa1f8u1lMfmFLTRV66hWRvqM+IwbjwPnhukN3
	 RDqpzX5t4hk1g4o/E5V+T12H3YGk5h5huHnS46hCtkDHthoxpdEOf84cjLnMrsx0/l
	 /q8E8K5io8JylkaNsyNtGkVMJGgvLlqwTNxgtOm+XZBqsvTzPISg3x+ec7aM34FwrH
	 Z0BotpLUo9ntw==
Date: Thu, 26 Feb 2026 11:18:16 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	David Rheinsberg <david@readahead.eu>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <20260226111816.GA8023@google.com>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>

On Tue, 24 Feb 2026, Jiri Kosina wrote:

> On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> 
> > Long story short: that patch is too intrusive as it makes assumption on
> > the behavior of the device. We need to understand where/if the bug was
> > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > implementation.
> 
> Thanks a lot for the analysis, Benjamin!
> 
> I asked about that here:
> 
> 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> 
> So let's wait for Lee to clarify. Until that, the patch stays out of the 
> branch.

Thanks to both of you for looking into this.  I appreciate your efforts.

This is very much real world.

Is there a way to add an errata for the PS3 controller?

-- 
Lee Jones [李琼斯]
