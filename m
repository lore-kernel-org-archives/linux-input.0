Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0C357CEC;
	Fri, 11 Sep 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145138; cv=none; b=I4ERPIu/EV5nhDG17JV61d5oVMgQ2cWXhhR9heuGTbq256q1Dae1DLYPki07z9wrC0p4leIjOqUMEIiscTIergNsvboAe3jHrZNIBP+anjNgIjFDty/mF6SuAh9PolNdz5Mc4V9UmEsHaXybvWDmkrTQ8KyK7okaLDzHJ6oi/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145138; c=relaxed/simple;
	bh=m8uoNNrt+Dm8NpcA9Z/eGfox+DbN2jnefFupKJtAhtM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G9tl9Jeou8AmxSFINoj0jUwFMXG40iWsEU0X/+zBVv8V6YfrRhR1AOqixp3n4Jkn0nqfLkKhMrHxZDldGzJKIjB/thlEgnNzm7GBbRQobW0fpQlKt3FvBIlLnxV5cucYkRp8b2HIom7yFJ08MwL5seRznd0iaLmaC4FIZD557Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Dec26m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Dec26m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35D11F000FF;
	Fri, 11 Sep 2026 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145137;
	bh=ZwM/MvepTWPwju4uEY6gRB6//NK30WodpXwAjUG4iQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=h5Dec26mL8sO1uLvcXCHJEpgfU+8e2G7nsW9Hj8lrDpopYSxZVdTIqODnqV7TKlaQ
	 SmxNn0Fx1X60PfQ1LS8vkjjK66eu2Ym6YbNqYJxtikmFHLLCPWEgV62DOvcCKc97RQ
	 fAVNjfuyF25aktr/evXYlAk1enAKviGCyNFImiO7Bw7Y0KAjF8o5VffRIUL546eTLw
	 oG4kVdMWIps3VYzgrrHPMblzzX7wRl5JLm7bgLgZEmap5vWyhf92P/csOLCOQzLxpS
	 Iw4/N44Ncamb2Ywuv71SuESZb4wQqiSD+PAAbPDpoG3fYrJ40OwwKzqhPhugXRiljK
	 HcjDq8OSy3GWw==
Date: Fri, 11 Sep 2026 18:45:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <aditya.garg@linux.dev>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Linux Input Mailing List <linux-input@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Andre Eikmeyer <dev@deq.rocks>
Subject: Re: [PATCH v4] HID: appletb-kbd: support layer switching on Fn double
 press
In-Reply-To: <cf9ff462-1a77-44c7-92fd-2b11518aeb69@linux.dev>
Message-ID: <4s5p7s1n-87n6-2833-s73r-s82s45862srs@xreary.bet>
References: <20260905143733.17819-1-aditya.garg@linux.dev> <cf9ff462-1a77-44c7-92fd-2b11518aeb69@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 5 Sep 2026, Aditya Garg wrote:

> > Holding Fn temporarily switches the Touch Bar between media controls and
> > function keys. Users who want to keep the alternate layer currently need
> > to change the mode through sysfs.
> > 
> > An optional double_press_switch_time module parameter makes a double press
> > persistently switch the default layer. Its value specifies the double-press
> > interval in milliseconds, while zero leaves the behavior disabled.
> > 
> > Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
> > Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> > ---
> > Changes in v2:
> > - Added a check to ensure negative fn switch times are ignored.
> > 
> > Changes in v3:
> > - Renamed the backing variable to match the module parameter.
> > - Fixed the reported code style issues.
> > 
> > Changes in v4:
> > - Added missing "break;" in case statements.
> > - Change author's email to aditya.garg@linux.dev
> 
> Now that I see it, the case statements were ending in return. break was 
> not needed. Sorry for the brainfart.

Please send v5 and I will apply it.

-- 
Jiri Kosina
SUSE Labs

