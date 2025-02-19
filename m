Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62861DF25C;
	Wed, 19 Feb 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955546; cv=none; b=T4dmDbRK6u59oZa4LrixAw78K6KS/9jyv+8psiuELggnK0fa7UQ746mf3bWQdjIteInsQ0gLcwRQn38aU087BAK/sDH1YzhHKzJtLoqVCByLsHu2HjfWKNQtWnZ8e+YMjR5o1KVOVe2owBJSD3XXVKuVTRWpuvOIGwYhnSheNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955546; c=relaxed/simple;
	bh=cmHgDmCzsuCduQoDhZN/avWtRrUOkuuqBMf+ZDBs1Zw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UuhEj4dw7dl/yGrd+lfO9d8TkqTi3GJmG2CEPuXW895m8WcwFGWmIpKgdUOcHvMXa3aCT3gwFEspyUghje1xulObOqjbJl9fvXt+GJgAHavCsctP1Lef3vlk1h7eS5F0FZXZzhO9MQ5TQRO/SUqGL68OdZSgbsGHJ5Txx7ojdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpg7hiaB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpg7hiaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36CEC4CED1;
	Wed, 19 Feb 2025 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739955546;
	bh=cmHgDmCzsuCduQoDhZN/avWtRrUOkuuqBMf+ZDBs1Zw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rpg7hiaBI81kWWBt+XS7uqj6pHP5SFY2Id5pyC+eKC/7xHdlmrURCyN9L6ctrJzuk
	 bEvS8kB3am4weGzTiT8GbKWBV4MyEl1QGboH1R52dIu6/swaqVXlTe20iW5dm2thio
	 CXuPi+ukKeN8W++lfIsYHPjd961Xu2dAHEVcSU2OI5ENAFwAIy3bl35PdvS2lsaCh2
	 k+/F4BLdYT93lClJ0dXc6594ss8IcuOz/DXp8XS9JKdIiwA7i4wPI3yT4j/Nh4rMtC
	 5JX17zduDHjUFJh/g9etnI3VlDKW6Ksdho1bZOoi8felKwmSTXqdQikgbLXyL4Q8i5
	 QblaPDF/1siAA==
Date: Wed, 19 Feb 2025 09:59:03 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: google: don't include '<linux/pm_wakeup.h>'
 directly
In-Reply-To: <20250210113612.51883-2-wsa+renesas@sang-engineering.com>
Message-ID: <9s4r832p-p35n-s2p8-o692-705270r105so@xreary.bet>
References: <20250210113612.51883-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Feb 2025, Wolfram Sang wrote:

> The header clearly states that it does not want to be included directly,
> only via '<linux/(platform_)?device.h>'. Which is already present, so
> delete the superfluous include.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

