Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3184A3D37;
	Fri, 11 Sep 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144044; cv=none; b=Q10Yy7G3zc3c2HpuFzLQ5f8f984cOBCeoVS+6FlLrvyVJUydysQ6p24mbh8LDjnM107XpdhiuzIxFvgcbiArPAVMuwFAfLmV1dhDxGVvoesm4WWJyAspzIPDWmOPT4ZrjweJ7hfCw6kDruH0yx4CptU+K9x0PUF/UFDTrpw3sSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144044; c=relaxed/simple;
	bh=qMqfKSK6EJULovJEahQ/+2GQ3nvc8gCCS52IjnzLTRA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YkFB8qgAaRXO4hE1v2KjXqe8xN+MwgOjdyoCFBNXwnkdaiCy+bRlGiruNhXhWeu9rGsbakj5tODxO/9fQpMybEjpzRxu4Pzo+HqhHgUWoMNPe5DTng6SBlF3EsKB3hgqd7X96tOwjzm58gDPT4XmjhPgtxQNSBwa4YD5hkv/Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxu/RmJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxu/RmJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA821F000FF;
	Fri, 11 Sep 2026 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144042;
	bh=Ac4O+cwLOUSWgt5OZSQpHohdS/lgkWmhpJ7pdYosbS4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Qxu/RmJPzVv/GJI+BMbPnkJ0zSH7mzJzVs0VVzUfKUnTZaQMZ7eFd/zzjSv7FKSdH
	 4XagfRtBhb8r+gZ1zLwnD00s78Lcj7V525E5p/dJ30XFWzmmsDs1EZMbvMl/LI8m81
	 YYSaFETHoL796U1MJFe9B91WzOLxpYERkjJMJH22We1Vrtj2E6ir8NJ5fNrKr9jxrT
	 k7mayuQ3Ejvjw/Z05kzKfMpjd5xA1/YYBmdMFxuhp5Qp7pq2hm7lCWSbTg075ihZyk
	 D4/XzYW7C1WPfoIn9PlqoE6p+ovVe1evuLfvrZF8lTlGlL5E4zjgBFvsx0CB4UkeZT
	 eny0RusHJHWrQ==
Date: Fri, 11 Sep 2026 18:27:20 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Nikolas Koesling <nikolas@koesling.info>
cc: Benjamin Tissoires <bentiss@kernel.org>, Lode Willems <me@lodewillems.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Leo <leo@managarm.org>
Subject: Re: [PATCH v8] HID: pulsar: add driver for Pulsar gaming mice
In-Reply-To: <20260904142750.19285-1-nikolas@koesling.info>
Message-ID: <rorq0179-r417-pn20-3noo-o5n571qr296q@xreary.bet>
References: <20260904142750.19285-1-nikolas@koesling.info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Queued in hid.git#for-7.4/pulsar, thanks.

-- 
Jiri Kosina
SUSE Labs

