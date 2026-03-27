Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B033DCD86;
	Fri, 27 Mar 2026 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607680; cv=none; b=gMv0xA+oE9BrOFzdmpBPphE+MxbIJdroKWeiJMLwGgTiCiyPqyGMkf+WiGW+gu5IvCW463abcJnW0lq3lJtefPlZb2PFrn2yHEWdQIJmTNdGSyGmkjcUFuA+vRORjd8CsZRxTjTEDCNa1zR9I50ed+eOlGkMhMdt9lVAdw721qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607680; c=relaxed/simple;
	bh=4sUKYgBOEs3FD3rjP6cVlv/E0i5DPhetm8gwMcWWtqk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tG0vHPBkZIGw2DrSJMb26tW6rBlUDZhJVSK9gNBkBWO4DdVt1uSJ3MP3KqUcGsRjW9e8xoS1clOpd0taphjlUZVVZSkSu8y+bQ+49fFcIiOjR7fi5rdzffzlbidjq/R3DZppPRkc5WNzuIfnJ+cGYiIldc7XV0wwWRsTkKK4xp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQMtiach; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQMtiach"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83ADC19423;
	Fri, 27 Mar 2026 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774607680;
	bh=4sUKYgBOEs3FD3rjP6cVlv/E0i5DPhetm8gwMcWWtqk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fQMtiach/q2xAdGKAn8NvdBGb6YjU7OTgOX/yjAjtre7DhzJKtwNkQlNjAxsCDIsx
	 wbOC/+ZG9vUmRWCSkFT1iqwqiCTovDqIYiR81KlpA+m2UPxgygCIDusKOHnH9DrPtu
	 5TPWNnZYPMJ7GoBgtZLaisHdiDnyB54OmwwvHFEfU/kTYPX3AV2v5k1oUX7P9jcayG
	 nqqTmviflmhFwt2yvGD1PFvX5RGGvE7hjyoYJBSHb9U5I4AbIpQ5mS+0PplTq/2qi3
	 9C3uTs8czXA067mNQCol8TAcAy/WHgzuKmvRExsbmljK7/Z0QqkEbQE7zybY0Mt0K1
	 Wk8rFUzb4YDIg==
Date: Fri, 27 Mar 2026 11:34:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] hid: usbhid: fix deadlock in hid_post_reset()
In-Reply-To: <20260324142507.74873-1-oneukum@suse.com>
Message-ID: <8q66o2o4-7844-6p76-9964-7pr205p190pr@xreary.bet>
References: <20260324142507.74873-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Oliver Neukum wrote:

> You can build a USB device that includes a HID component
> and a storage or UAS component. The components can be reset
> only together. That means that hid_pre_reset() and hid_post_reset()
> are in the block IO error handling. Hence no memory allocation
> used in them may do block IO because the IO can deadlock
> on the mutex held while resetting a device and calling the
> interface drivers.
> Use GFP_NOIO for all allocations in them.
> 
> Fixes: dc3c78e434690 ("HID: usbhid: Check HID report descriptor contents after device reset")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Thanks Oliver.

Did you find this just by code inspection, or was this reported with a 
real device?

Thanks,

-- 
Jiri Kosina
SUSE Labs

