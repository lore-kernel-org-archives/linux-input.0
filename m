Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264E267B89
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826327; cv=none; b=dO+qxHQLWFcF0g/cyPjojkFXsJH9cWw8TOMvTEaY/vEvQvFFeIhFG4oh6sOc2aW4DyL2meAmWud/kkHAWBPTjhiW3ACmMDuEaipGNHUWzS1x9LOWR91AYdh+YfhE2lzxL1dWOYEne9pcJ4eDiqpQ6OKcPT88V9mDBv1/vsd7YnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826327; c=relaxed/simple;
	bh=pUGP87N3dRh01nzNx34v2IKIoTsoeIUooZhSLbm34D8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EqL8uAjsah5CeRHjHkDn9LZZ3DP/9VmuhhL/wf2BBkS0bn0QNdJy9rbrYBD615ACuQ+mvclFEd/8lDJqyGqGfpZ0SdvvTF/Typtl5trTCqEWlWh9stl44i3pWGiygSJGQApdekL0Nvs+j1ABJT5G7slaFaP/xO7sZDdf2Rw+4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BObgqxSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BObgqxSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C131F00A3D;
	Tue, 30 Jun 2026 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826326;
	bh=aAbhDqaQViSWt5zPHXRyWbq4kmRvJjFvKbDf+ER8pGU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BObgqxSHtZ4QBBwZ+136wjftYDNlYOvNkz6bMTv9WcUUwUUDui2oz9EKJ1JZV7VuZ
	 6+bHtttpVWOdrxRL1EFLUSX0zuNXvgSlsricBirzn8YlALXcEn+iTCw0O5BQFGJz0/
	 RRaB/KclcZcGF7X4zAYLdSl9YZBxcjPkOdZywSZHvaYkw6ppG05TAEq11zdAL2QjoB
	 o+NyjOydHUZsiSkmGWkLp1Ovwi1707zE5X8yq0qwra9Xr2dJiN2CUzy5Mv/tqrRvwu
	 ZaykK3WRoGo3LtlJOsu5AsayQJFuPKCINoKkoVqJajtlNebS2boiu5U/HOlbupLMrc
	 aWeJbjdMlUwJQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8E606F4006E;
	Tue, 30 Jun 2026 09:32:05 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 09:32:05 -0400
X-ME-Sender: <xms:VcVDaiTy67sUgiiMVwbnvSJW7dz81qPgmKehCtu9u7dSbc0BxQ4cUQ>
    <xme:VcVDailFwUshIt4D21UAYBSWuQUCPNXqNVbwaLWPzku1SITlZB3W2BDpqchwRz5RH
    XGXtqy5IO7AZX-LTqX8__ARdk1Rq8KlnDa6NZrwpk5Qe95k9G7z4A>
X-ME-Proxy-Cause: dmFkZTEFV+HFyaGWkSwmmP37fRNIJzOiJU0gOhdvRHXHzEj9ColG3iSY6sxN82L5mGmRTd
    GK4+Ba7tPm6jaARbMINE0Ahv0mgMxjRdNhB/PFN07g/l2wD2e7LRH7zqiKhi3N6Q11FbPc
    4KbRY3KT9rG0Ia76lhBfKLrN9/wW9jf48a+zV6Ebffwep7tK7gJlIU/YHYmB3x1yf1rUIl
    c0Au3kPIat//0oWBA5cTFXUZdqt2+ijbNM44y1IMJlniizXCeBFVOWCM6HiX6y/a9KlKCO
    Lhj3Nb2s8whmySBkw56D9DxEVXYW0+FxGaT4jCzGzbS6qH8AS3y+LwN8MUpqNVWPkCyGeB
    /mpKa0Zg/II+94VAX4O//BklqNhL/TPkObW7hgXebLwKgbCq9uzXdSlpubGH70nqblYRcC
    CJmMdb8CUCmvWAcFKSpXDIGTuIgR4fEnkhINytmT5VXSAuN3x8ugNUXjak8viJez0VAM30
    5tvyN3ef1e/2sL71wGnPqPAm5Z1e9+dWdv9Cl+i+3zvLzL8A4aHxBbrwUyY3tMvaiKCyr/
    hyK77uC6ibKRuqvc0tYY1nM1kENhB6x9K6W2DAh8fRfrUbNyqf2+d7aKpQWMU9yPHQQxf1
    IwWR+7D4R81v3bbX6l0jfdXHlzGYz5zpy73o9C3qNWUQZkElCvGDjXFZKTXQ
X-ME-Proxy: <xmx:VcVDakPMoD5epYrKYdSxxjThmQJBEqNYdkkP1J2lb_Au7abo22TWqA>
    <xmx:VcVDav7fS5fvf5XWizsDEUkZVdtb1iVtxNm8vj8EXyGrJpzuIKZx6Q>
    <xmx:VcVDavjCNNocTzQpsLfPzTuGPquTOelhiCxAaEzWRX4A3FzXQ_mbvQ>
    <xmx:VcVDaseJ4y2hiPw4DlfSWPsklYLUQ216SrhhpsjTw43VDMY1OZ8HKQ>
    <xmx:VcVDavxvJVZJT1Td9vOpUIcbw3-J1Wjze6ir4__nq00bb0XUcYiCVWwu>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E6371820082; Tue, 30 Jun 2026 09:32:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APtE7QNyC7sF
Date: Tue, 30 Jun 2026 15:31:45 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-sunxi@lists.linux.dev,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Vladimir Oltean" <olteanv@gmail.com>, "Vinod Koul" <vkoul@kernel.org>,
 linux-phy@lists.infradead.org, linux-input@vger.kernel.org
Message-Id: <6114033d-ff33-4551-8af1-c82bae0e03bf@app.fastmail.com>
In-Reply-To: <20260630132838.113F91F00A3A@smtp.kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-14-arnd@kernel.org>
 <20260630132838.113F91F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 13/13] gpiolib: remove linux/gpio.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2026, at 15:28, sashiko-bot@kernel.org wrote:
>>  - When this work is complete (will require some of the items in the
>> -  following ongoing work as well) we can delete the old global
>> -  numberspace accessors from <linux/gpio.h> and eventually delete
>> -  <linux/gpio.h> altogether.
>> +  following ongoing work as well) we can delete <linux/gpio/lagacy.h>.
>                                                                 ^^^^^^^^
> [Severity: Low]
> This isn't a bug, but there is a typo here (lagacy.h instead of legacy.h).

Fixed now for v2.

>> -#ifdef CONFIG_GPIOLIB_LEGACY
>> -#include <linux/gpio/legacy.h>
>> -#endif /* CONFIG_GPIOLIB_LEGACY */
>> -
>> -#endif /* __LINUX_GPIO_H */
>
> [Severity: Low]
> Does removing this header break the build for remaining unconverted legacy
> GPIO consumers?

There are a few more patches in flight that all have to be applied
before this one.

     Arnd
