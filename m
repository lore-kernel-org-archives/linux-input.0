Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C504C957E
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864004; cv=none; b=txrg2JIoL0Jwj+2gqh12ft8IFttFO0RFkHZpuvzilx+JqqOQFdUIJrI/7C7RhGcaEOjo8qDu3H8uXFsjWa6vIOGzTzt7WZgLhneKiNkWeBwe9gQFMXwzXp5FgbNGK6VM5lZfqUKSVHT45iuvypRxoSZdavvS1u1kFj9MNl4Z0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864004; c=relaxed/simple;
	bh=OiVysNEgsyQnDPicyZCIbn7ptWIuM2b8X8IKLQzCgoA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DwB1uauwzIK9w2v7bxkhrGU6VmXsTqQlVkzWyc6sgNo7ZGKua9zCwQO8nEAmqGSgZpSfV216Qp0DdvsOquma47daO12pGyOD+wMpighMIi8/zstZnXK82q/GajVs89AXJU3755yWBhomlR6HvIeBLWGHCBTfB2w+bWndTDjmt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+ft09wy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+ft09wy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC6CC2BCB0;
	Fri, 15 May 2026 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864003;
	bh=OiVysNEgsyQnDPicyZCIbn7ptWIuM2b8X8IKLQzCgoA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=W+ft09wyTofapPm3Wtw5zSPuYvjAl8GEbXqbi7u5X2AdComFOTn2CWpdW6Dem2rU4
	 Ge9cwrAZVeD9EnNjLQorqujjXfiCMuPFIE5Jq5br85EBkBCMHFdF6yM4TWffpJRf/8
	 dJYkw00EcUqk41HDuk0kuzxDHa0mbtdMOXlB8GAhXDF1lxC5FAWN42XlSZ9S2ihfRq
	 riJmSRaqDAD6m93bKi1L+m4bnndjyI8vn/RjdAUPAiIPaz+dzr34F+IcEcYx4QgMmx
	 iXq/mBtXDXNqGo/q9hU7uErevdpNfbjuo493ZzVSIXLkXZxhfHW2MRRtyh5ZT7z4+V
	 s+Ntn64857u8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Input: Use named initializers for arrays of
 i2c_device_data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
References: <20260515164848.497608-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 16:53:23 +0000
Message-Id: <20260515165323.BCC6CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit title incorrectly references `i2c_device_data` instead o=
f `i2c_device_id`.
--

commit f1077bbdac0316b24fea0fef5850a04e87106e2d
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

Input: Use named initializers for arrays of i2c_device_data

This commit updates the I2C device ID tables in various input drivers to
use named initializers. This improves readability and robustness, especially
in preparation for a planned change to struct i2c_device_id.

> Input: Use named initializers for arrays of i2c_device_data

This isn't a bug, but is there a typo in the subject line? The patch modifi=
es
arrays of struct i2c_device_id, not i2c_device_data (which is correctly not=
ed
in the commit body).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515164848.4976=
08-2-u.kleine-koenig@baylibre.com?part=3D1
