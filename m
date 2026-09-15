Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9D44684C;
	Tue, 15 Sep 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499725; cv=none; b=PMgmP5j/ESK7ADzpLHQM/K2RTvMgF3c1MdavozhaHiTRJl4w7E1A2sdBlDqqCpEVr+Otea3sJG8/H8lBRwkvW+AHgLvjCE+NaRvoC0U5Znsr6yOu7H1ABp8/ooLMBbymbYX4GnGRBT12dd/p+WaYrNjiiRCQspjWal0S3/mtiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499725; c=relaxed/simple;
	bh=+p4Pe8l6gPv+qJ5UUvxNKXvNNPnPxLvLnb+ZeAt43o0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=orXUuUnutpK3qO8BvJSpXVO+3jj3yTHXzF45OCAObmB6Mv5YN7LfbwhG61tEEhRRAJWo5X+FtOaYK/NM3CUz0EkKzIK0OlJ2jiXbadBMvUKZXH6rQ9U08u4fb/2wqJ/oktkJ8m8+MMu8i7+ypkWz9iyQv6aMLK4A3SmOw0jmIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LHYM4Pux; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LHYM4Pux"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B0782408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1789499722; bh=J7bvaUuK8XqR9uPaoGKtHpVy706V1CKIxuS8QVatddU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LHYM4PuxnK6ndG7uQCKwtYknFVse3Jr6ev7PRQvYelFrYPMzPvYqEW1HFW+/Yrrsk
	 YAWVkwltuK/nwfnowew2t43MWOT17N2VmI2uX5O38PLwwov8P2uaojcdQCGcAkcpqT
	 5YBRu0Py3h6KWZQ1MBXix4jn5hV0gQW1a19wKBcxKNRMOKz1pdX2r+jmZhoMyNUKbZ
	 85n/E/cuWk7zEqDoAe8d9S1nxgg+/CWK83qS/P2a0Jh/i4y/IApfFAp9ivhSOvULlV
	 YIke1kQb1TGGj/XPTmqmSC2a6bTFY8Zj/yGCcPB4RlcyJsmRWfW5i+W4+M1fkPEuVr
	 OPVhTjJUS908g==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B0782408B4;
	Tue, 15 Sep 2026 19:15:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebnerli@mailbox.org>, Henk Vergonet
 <Henk.Vergonet@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: yealink.rst: Fix wording, quotation and typo
In-Reply-To: <20260908115551.1345764-2-manuelebnerli@mailbox.org>
References: <20260908115551.1345764-2-manuelebnerli@mailbox.org>
Date: Tue, 15 Sep 2026 13:15:21 -0600
Message-ID: <87o6dy8gxi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebnerli@mailbox.org> writes:

> Improve readability.
>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> [v4]
>  fix quotation
>
> [v3]
>  https://lore.kernel.org/all/20260906095502.1116994-2-manuelebnerli@mailbox.org/
>  fix wording
>  droped white-space fixes
>
> [v2]
>  https://lore.kernel.org/all/20260905063335.792618-2-manuelebnerli@mailbox.org/
>  add ']' instead of remove '[' as randy suggested
>  fix a couple more issues in the file
>
> [v1]
>  https://lore.kernel.org/all/20260904121026.759218-3-manuelebnerli@mailbox.org/
> ---
>  Documentation/input/devices/yealink.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

jon
