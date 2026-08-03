Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113E423764;
	Mon,  3 Aug 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778557; cv=none; b=JrirLDJsJpckRyiWOoHBbmWUrB/ZWSFT7PGpZuisDPBkJBdY5RGcqbrcdsTRX0mawpViDNKr3X5cHriGl2suMvKSc8wh7WnIhFKTndK7ImdTHtnCqJpGT7DvVLNEruj06KTAm9KrEVj0LQKuv16+YhgzIBnJ/1el8ZVyvFMldkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778557; c=relaxed/simple;
	bh=oN4d/ySIcEpaRBb2ej6vEald4Yu9cUUqVqVVM5BbqEE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PyUmFyzGyeP7kvtoKywmEpVlkHqUrtlldaCjNxhhIWMmtBsha/AbzMDUwOmDb7Gemu9MOs+jiY/xhClUZrEXtvO4FkU9Q/fohxaBcOqg+PpP7sVgDZYteEgvLXuNaaYdk9FrBALLycbztgrpfTqpv6+FTSGq9712slNa1fREGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtd1l5zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtd1l5zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896261F000E9;
	Mon,  3 Aug 2026 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778555;
	bh=CMDrzEPl3sTQ6LcTELZpBnQOD4VoxQasnZ8gWccAXhA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Mtd1l5zqCk75zbzhq8TmWBfPg6hD2v4BKfPMo/HsFLaVeq1d4IYd32CAvevZCuRWc
	 623VNVD48kbq/oTznFSnkZhblqS0tebe+xmLsZVrCICESiRtkqwEBbhvGdkG9Lm3uD
	 K4+VSmLMM+tNesgs0bUHt+M2Rq3QTseVt8Nq9lDqY3m4NF21bY0un0KSnSLnrAWHeR
	 qBQKBCyFX71eCKqbwK36srTXQ4tNu0APUtFimSkI7Wh2Wkwg98j5A4N6YZ30lgXxsy
	 0583vA7VTSeGdpKE10RTgfvbsN8A9c73aNSCduVoYRkkK0QuxFW95VaR7fHjArtOFX
	 6+wzcbjfsC0nQ==
Date: Mon, 3 Aug 2026 19:35:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH] HID: asus: add i2c entry for FA808UM and other TUFs
In-Reply-To: <20260612124830.984592-1-denis.benato@linux.dev>
Message-ID: <9o3s151r-rq16-21p7-6sn5-93p9ppqsnq41@xreary.bet>
References: <20260612124830.984592-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jun 2026, Denis Benato wrote:

> On newer TUF laptops the keyboard HID device uses the same PID/VID of a
> USB device that was found in ROG laptops: add it to hid-asus as i2c too.

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

