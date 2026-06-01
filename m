Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065F3E8665;
	Mon,  1 Jun 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337761; cv=none; b=jMOSYGkZ0ZEOEx+jpYBP/0lhJeS+BTkCL5qINg6jioxdIz1mP32CEzyLye4pMMv1LlLO18txPHn1BwGFmUJRknENCtPtBD7K4UTzCGOtWkU+kYLLmHbOPYWlDqVk1nkmqHhqQrW/c5OJp2tAHzHGHm4xlqD9TjhhwrbmEP++otU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337761; c=relaxed/simple;
	bh=63AUlqPeTzCmWylGXCdRwy5SZ0D3QG80qKIjBBSv1rg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HNPeURIZBJL+Z7ZRcw8pManEc7b32QYy5cULNuKJZcrgstsL3VnCgul/4Lpzpr64v+GZiceBAQqO34fvdpaseaBlgB8UHM6EGo5daI2n+ULTqO6G7AWEmNzU/U8iHbi348FfdIABhxBidVZDr1dK2GI5Xc6TCEU5lXRj0rPkd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ+iOrHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ+iOrHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417DC1F00898;
	Mon,  1 Jun 2026 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337758;
	bh=dB5DrM7U4Xjp+o4+YfT+97VvnqckIdRiuePwCBSXwTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GZ+iOrHCY+U8cCZLya/nE0E5Jae4DEVLmqQbNUqfaKPEpvzAE5jAujZzOzaCtjpDL
	 AP471hlvWfNueUimsJbkRAZ9eAnx6+Erm2Bunoq7XwK18pTGD57vv2oyQukselojdh
	 FaPkMZdnM2oZJP9c4++0nu9lU3Y1CPQMczU1RNiZCZ7JMmHtksGG/cOyKMt7WCzEpD
	 eO7RqquU699eM8JDPF8ro/b2hNXdWlwXTpD7/bu/Yo/Stlf1xXqj70OiVl2adlbz6B
	 eL4kqRZhqaEnhgRPqoMb8fsdm6zVtD46OZuW44uQnRQt993wi/o+u/cOBR+E+QHtdC
	 /Q3loEW+xiVyQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260519160420.1597193-2-u.kleine-koenig@baylibre.com>
References: <20260519160420.1597193-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1] HID: i2c-hid-of: Use named initializers for struct
 i2c_device_id
Message-Id: <178033775702.12858.6999563265143752129.b4-ty@b4>
Date: Mon, 01 Jun 2026 20:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Tue, 19 May 2026 18:04:20 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/i2c-hid), thanks!

[1/1] HID: i2c-hid-of: Use named initializers for struct i2c_device_id
      https://git.kernel.org/hid/hid/c/eda0f9e57087

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

