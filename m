Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE923C3F40
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493970; cv=none; b=mA85R7MJ5IHJlBbKqcAV3r3B7uXm5jJHK4TxSx4bACYlu/7shsfKHV5ZOCByWgbMEeOdUTsgWWyv3sDk8PZNiPWpImquy+6s99QWUzTG0vY3QYq3FKUmfqOSxBVLtj6+v3fFOfyR+IwIQxPDq6hZqaZ7GG0qAyReNoUE5jgVf5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493970; c=relaxed/simple;
	bh=esJrD23keK+WGxjjF3543JPs0JAtCYzYLhZSadTUx8E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=SsUpshSCg/Y9M+rYyje2fypHvM78TvJBITulxdEdTB+1G5V+oSbU/IgxLbdI5XJPz2ztWTy8Ya/XQOaIlWrKJNK/1n3lZClgTFcbN8eS49sOqV+ZOWeD98pOsJXuJCsN4ofg69uxzekKyEPRFX8YuOxmFDbKQhooUgyEFi4kyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=LqXKHh7A; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TvIW1Pdk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="LqXKHh7A";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TvIW1Pdk"
DKIM-Signature: a=rsa-sha256; b=LqXKHh7AlZrUxy+QddAr7Kz+GGdbDeLcFSzdfN5K6XE0B/FZOuDUFT4GFQjwuTcveW8sk8qo5jGSJKHWjEB5IKVWdjCGjJLVDkxVKH4PvECgfLVFuyFrx/qgljA5Tqd9LLs8V5aXmURCxs4UTb553k+jMWDOuH8+bIFKYnd5x22wIN3XnNGyJc/VAHS4c0FOtz0ynkYxVOQXndrNDQtHZvrgCD/SzneqyTzWVB2gBkRM0GTRGJcY9GNWL6h8zRedTa1CCDthaLkhozGaOECSIKUuQbXnjSPBxBOYAHGLxWOYJWsH9zO+tmQ5OpxELDgxpVOdZogve8THZBsh7hQJwA==; s=purelymail3; d=rcpassos.me; v=1; bh=esJrD23keK+WGxjjF3543JPs0JAtCYzYLhZSadTUx8E=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=TvIW1Pdk4AuPrPpw0r4/5Jcdiy6fqdlKkq0YHj2/8WhARRvSZKDvJEGJxEkmGfUY4eaReDCrRPFxTgtSIt/k9So3EyK3Y65jvo1Nyf2BRM6kKVs9rg+UimDqTnM8HkdIxIG7trodrIGMzvO/P0E21QsukJ7LYFwls4Pab6bctSDH1DQh8FiJkRWC/4BQee82/KU7Z6RGp4+BdDzfF//fR51VXvNER3ezRjl0ETBQmdGapdSQvvAQmGl92xYG7ZuIUIfgwDEzGQCd+d3CR3GIEMurnD7qEOWGx5jW4HTwNbzSpeI6dR/3SRnhWkZQvqDeUO9HStRj9Po4rVhM9AcoIg==; s=purelymail3; d=purelymail.com; v=1; bh=esJrD23keK+WGxjjF3543JPs0JAtCYzYLhZSadTUx8E=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1253288177;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 03:52:27 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 00:52:39 -0300
Message-Id: <DL68726HJQCD.7PCDT9IGHUB1@rcpassos.me>
Subject: Re: [PATCH v3 0/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
Cc: <bentiss@kernel.org>, <lains@riseup.net>, <hadess@hadess.net>,
 <k8ie@mcld.eu>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Jiri Kosina" <jikos@kernel.org>, =?utf-8?q?Erik_H=C3=A5kansson?=
 <erikhakan@gmail.com>
X-Mailer: aerc 0.22.0
References: <f44b06b1-e1fd-4d96-9728-4567fe62c501@gmail.com>
 <20260810205634.209099-1-erikhakan@gmail.com>
 <9n1sr367-980n-310o-7108-2s9p5o165s2s@xreary.bet>
In-Reply-To: <9n1sr367-980n-310o-7108-2s9p5o165s2s@xreary.bet>

Hi,

This patch caused a bug with the scrollwheel in my MX Master 3S Mouse.
It took me a while to find the cause (and solution),
but I just sent the patch here:
https://lore.kernel.org/linux-input/20260904034843.1340846-1-rafael@rcpasso=
s.me/T/#u

At first, I was blaming my compositor (Niri), wich I had updated at the
same time with the start of the merge window   ;D
I hope this fix can land in this release. It is almost impossible to use
this mouse without this fix. I even tried reducing the sensitivity with
OpenLogi, but it was not sufficient.

Thanks,
Rafael Passos
