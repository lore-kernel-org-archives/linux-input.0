Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485734EF04;
	Mon, 14 Sep 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389969; cv=none; b=Vjvz37me2ghD7SEdKv+0rP3UFnMQ4kty8nXmhK5dRVH3dtIqGJ2QIMAwXBItDpWZF4coW1ImhatSw8ZSsAeFYtCU96qbSgzUN5jElv3PbJK03nnH1/xWiAndANMtu/8r835ehV/EomKtujx/qxCZRYeTdSDebSvRYDCUUgrFN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389969; c=relaxed/simple;
	bh=eEIfxg1hqGBPT7idFQ+4Q4CbCaiYILwLaFdBsq2S1yI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R51ciiehTLgp1u5yK/EhQcCgIeeO7qFz1bHYSXbN9onUwEcb0A5lHIQhLjvGoFuBwiFC1a72z07G1E6PoBbxnLgUJdoAfQjLNC88aRGEAbxIzX/zmesw2gwRI68te1PI9Iyq7Wswx+9XuSc5MjUNHX9jqbu9MGrM/rXwsO3wIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DglQ408t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DglQ408t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50531F000FF;
	Mon, 14 Sep 2026 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789389968;
	bh=ZfpevkCIcji09WbIl28J5nn97Ckjp63qDFLiaE12/AY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DglQ408tIgi9+myMR9jWFS1ZQ0UdZ66k6wKj51bSsxmV8bq1lOHBAuh9ysD8kK/rB
	 fhwixcPetMSf2/GiVKXCWrJosswDMl5tQsAZV4Hk1oP1ux9vpJb74xYwlQPpVZeHRw
	 5N+IwQxIlTOzTWveg1cLMaS2lIHkJNLqVXSjfdAwB1ullZfVu3WQFGwiEbeO+HMaD6
	 QmZKif9KTfzLaT29oc8JHVmQ4ZLYNwLAwkfepmQWxBvt/l0wroAZf0esruGaDV6K1O
	 PAfMwOFgQ2TNlclyBnDDHkKJ30qDpY6EkVJThZkfPYXH+J75HNn9Ed5oOg9Il4xtl7
	 jsbRxXfjSExMw==
Date: Mon, 14 Sep 2026 14:46:05 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] HID: wacom: #include <linux/device-id/hid.h> instead
 of <linux/mod_devicetable.h>
In-Reply-To: <CAF8JNhKhL3pC2yvMxg87R9TKJ4-b1vQ8Y7J8hWmKOLHCp0on8g@mail.gmail.com>
Message-ID: <0n793r84-4q6s-657q-s914-6nr7o249ps87@xreary.bet>
References: <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com> <CAF8JNhKhL3pC2yvMxg87R9TKJ4-b1vQ8Y7J8hWmKOLHCp0on8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 12 Sep 2026, Ping Cheng wrote:

> Acked-by: Ping Cheng <ping.cheng@wacom.com>
> Tested-by: Ping Cheng <ping.cheng@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

