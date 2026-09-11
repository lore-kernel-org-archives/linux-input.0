Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3995494A0F;
	Fri, 11 Sep 2026 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141496; cv=none; b=D9Oua7Wzgp+Ni/m7iF/a4Lg9CLrAVRntxtPeBW3VEjj2bE7NhUc8KvfmzkuhvPTXSpoXMnKFxnG1knFJdS6cKR8gdFeAUwZxZdsFZgErVC2c8ZQsuyrDL6yKwNZkLGvL6qidIsQMQXJv5PDSsVjbopqzNR0Mvf2hLdqMlBmBvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141496; c=relaxed/simple;
	bh=xUngvpUEXhT/hnio35QpmbvvJrS6A/gzHsG99yrLHIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FztsAqKm6KiP/93rc0iSZmqlf57ELpYzGzEU5oqHDiS6oeMuRYK+FZ2A0TWnQbfDCQFTaxJjBSn2eMKA/6snngcQmuNERIKuVXufcqpr5ArzYrkf83673pS07WsAk2wySkrTccvdjxAytwS6we5afYLml3matvfLhQ+MMUnhTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3gFmcsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3gFmcsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A671F0089A;
	Fri, 11 Sep 2026 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141494;
	bh=BrF5fXtmowJDlr7hBfnPAFpRzsQanbmoIxICxOnI+qY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=E3gFmcsgJ0yznsSn9NNgP38GNWYxgBHQfcigzhvOIt71zKDdIFFISyElhBt8CB2D1
	 PLkUYAb7gzLxjvFMK6zLuQLv46MAanhHoaj+HdBduQfEaIdIH5m1mqDU0a/zL7/Ji3
	 5Lj7g/i3eGmP0smChCEiKc/aY+nIZOVlb0vuqKCZ36TWvlhkAmQRpELFJODOiJeBOO
	 skyzmpDwZxVHfZ7H1NLL0IvxPAErHuCgEAI9X4o4+kOX+leEmsIWFIfh0O2bQ7X5xc
	 vwji2Y/tp3LaZ4v7fzdPb6FdgkMJnOYRfnF8/THbb9rndL5GsYlcvm5prHgDhWD0ek
	 rckqOQkAm7IGQ==
Date: Fri, 11 Sep 2026 17:44:51 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Oleg Keri <okerixx@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x
 Gen 11 keyboard
In-Reply-To: <20260908091926.5773-1-okerixx@gmail.com>
Message-ID: <qroqrp82-pqpr-no09-9199-qpqq38rp7228@xreary.bet>
References: <20260908091926.5773-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Sep 2026, Oleg Keri wrote:

> The ITE controller behind the keyboard of the Lenovo Yoga Slim 7x Gen 11
> (048d:83db) carries out a reset but never raises the interrupt that
> acknowledges it. i2c_hid_finish_hwreset() therefore waits out its full
> one second timeout and logs "device did not ack reset within 1000 ms" on
> every probe and every resume, before the keyboard comes up regardless.
> 
> Set I2C_HID_QUIRK_NO_IRQ_AFTER_RESET for it, as is already done for
> several other ITE parts, so the reset is followed by a fixed 100 ms sleep
> instead.
> 
> Signed-off-by: Oleg Keri <okerixx@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

