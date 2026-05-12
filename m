Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C237D127
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599401; cv=none; b=cVfikK4CV1wG8nEbyhCk/hRkhdqNmzbpxNsS5T+LRt6ZfijRxSspkPNZxWUqzQ2t3biG4Ajdr59ExNWjN+sIxkBbhAlsPKwuaWrcI9sTwnD9kug0zBEcnO2fScmGu4/W5EFVt8t2Tr0nTrkpH7iYkYY0QWGCQCBT8nX5xVAsI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599401; c=relaxed/simple;
	bh=/UkKjwYjyshmyPxem5PYB7LJxLRsfkJ44wUHzZ41xa8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o9odkDyxNh8itDfoneAMf2VDTScqFdhtv9OIJWjzmJpQpc3zss2l0O65Q9SX8ZHkIVK7szImqIBE3UVPayz9VSbSP7q4WIl51cF1j7okl7Y/CxB2rVytHLW1FcyfYucXOmgqEC1q8whYZC/dgCdUwNKYwB+kZzHqbkSuRBwC3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN3svMYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN3svMYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8D0C2BCB0;
	Tue, 12 May 2026 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599401;
	bh=/UkKjwYjyshmyPxem5PYB7LJxLRsfkJ44wUHzZ41xa8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gN3svMYvF/6om39IJypcdcsQ6YFNDKO3iT2o93ggrVHXDJ61yM0B96qSDtw7dHmld
	 jXDph+cBSJ9TkYSruGod1VdIQSEVZZLVrp16J2+ike1xgzWPzCJo/DqkoZ8I6Aj4Uk
	 2VZvmmfj0X7JpAOMogXm0SBB1IEtvKm9RCYdlkiR31fcj8o6E6ygRaL84WFTJ+/ciR
	 b6jGREvz03AA5iUsZpuxj5mMvUQcdiktFVxoDhCCce+PqXtK30u0/Azgp7MuWLmNdQ
	 sXbetgfoCCJkiGP9IIVtQeKQNBDE0JbvRvmZXklCL2ZnoVXhuo7ypFn3LhUk9V4YVK
	 Q5co8VhJZLJHg==
Date: Tue, 12 May 2026 17:23:18 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
cc: bentiss@kernel.org, jussi.kivilinna@mbnet.fi, linux-input@vger.kernel.org
Subject: Re: [RFC] hid: hid-sjoy: race between init and usage
In-Reply-To: <20260303094906.1214359-1-oneukum@suse.com>
Message-ID: <92p809qq-o910-n817-r948-706o0s709r5o@xreary.bet>
References: <20260303094906.1214359-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Mar 2026, Oliver Neukum wrote:

> The driver uses an initial IO to set the device to a default
> state. That initialization is currently being done after the device
> node has been created. That means that the single buffer used
> for output can be altered while IO is in progress.
> Move the intialization before announcement to user space.
> 
> Fixes: fac733f029251 ("HID: force feedback support for SmartJoy PLUS PS2/USB adapter")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

