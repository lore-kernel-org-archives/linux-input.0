Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AF42B74B;
	Wed, 10 Jun 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106282; cv=none; b=ZDhYLuUtIuZxP968JWej+Yk90ZgeIj2NG80QBLTWrJBV6CuoEvIuWqkLcEM8HMSPxf3eTqx8+DdINwb1Owsj2vvhrWUrfURaSdybLvw6p1O5sqi8/HGRSaNSNcRlYlDxp3U+jWB3Oa2rJ/wl5eTglwkZt217C8PoG0cRw5mF6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106282; c=relaxed/simple;
	bh=/jfCcIQFxh0dQi3EAgG6u05P2ERyrAVCd1zWF+Vf7Xo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h5JGjIhwwXtkEQfh8yUM/ubGOqsGMszF4W4RL3SaQZn72sCn8fibxCZV0Q/ypOWKAySLuUZFpoq3JfR7fnlcYduM65epRCsAKY/LlIu7Rww+KgwLO+lx0cnNszrn+bOtDWSP/TL1wNqJVIfcLwSFEHp7fS2fBQp3aPcueCqcoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtE8vu98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtE8vu98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287031F00893;
	Wed, 10 Jun 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106277;
	bh=jS7sKww5SYpljQZZO1vqWWxXORnCW9xGcys11UNTqOc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OtE8vu98XCNenUIOW7GndYvd8x1WHcaeNfBAkYeFffmeS8A365/feGmplD8qEWMxw
	 hMugj9X+mcKO5d7Eqt2jkYqfASaOE6lRcEAbxWusN2Fkoyfix7MPmUTUzJHTWSIEQL
	 ZWRHPW5Z32smKz8e2MDHg+qZbzFJy3BpcHE8kXaTNZ5A4hCvnbjRAga13Z0FeKPuy5
	 /HAuMJF+bJvZmbrk/EeSOcRkyekb7dJukDOs42h0dWnSZrLovQppm4rYxO3cnqhSf8
	 z0+P9HaArAfPPk1GgI3kqPLxmYrnrWOZFrrwXcbLQER0w0hV1ynZUJxZZlVBREze3z
	 NQS5q8E6pey6A==
Date: Wed, 10 Jun 2026 17:44:33 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Lee Jones <lee@kernel.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
In-Reply-To: <20260523105545.68079-1-technoboy85@gmail.com>
Message-ID: <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
References: <20260523105545.68079-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 23 May 2026, Matteo Croce wrote:

> From: Matteo Croce <teknoraver@meta.com>
> 
> The log level for short  messages was changed from debug to warning,
> flooding syslog on systems with devices that regularly send
> short reports, in my case an UPS:
> 
>     $ dmesg |grep -c 'Event data for report .* was too short'
>     35
> 
> Demote it back to debug level.
> 
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

