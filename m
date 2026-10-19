Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0A481FA1
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390375; cv=none; b=H0Mo4rqXnfxGQmTsnQVsaiR84c5cCUymDj3Y2F0i39iuso8DK6nviu/dkHL1JUaSjOPHckgPA8BEXIotTR0SUJ4JZOYcMNBUw1VeSNF1sdurB17VOJbOa3Gm/f3+0q4kpPQPsWE1ih+tfbgwBOkOrjrDr3iPh8L8Jw5W0pFs/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390375; c=relaxed/simple;
	bh=z9719vW99s7XpEaYsdK9kQvyLmiQ7+Mufa0HWi7oNlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVhAC7UsLKnx1RDiExNdBJLpGya+AsQ6JYcKxSV+0X+0E6cQx/VqVvsDagx1Mn2wFlKhdDrEoV57pLob6gByn8cjT83mOU4xdstrZZGB4fPuNesq2MfAWvDwDjbLrCEjWCa+rgR6J9H0aeO9GoPhlKvPPFX0/E1eCgqFH982Xmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cb2ANTdN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cb2ANTdN"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 865D1240029
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 08:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792390365;
	bh=ICb5VkJ4GZ/U8bO+57EeSU8sTEfGWBPcWTn9xorZDgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=cb2ANTdNAa3y4edS8y1WROtu0Saq4yBdF55ybcnVFHmZ2sGj0RUNLYbz4gqrv9EM3
	 eHgxTlexSdoGRXRzbobjjzXXbANdfZOBFp+hz4ZXbFgoHZ96XEPhd1asGvJLbs7zqP
	 38Uk5r4FxvVypnTIKGw8k2L8Q+K2ZEUDdSjN6rTR8TETgSM/QEjAnL7NtftidrZaaD
	 2axpd76pb1WbuZ8la2uW02RvnXBxW5S6sI4xDkq74p2hPknCPp4nFajDRScIE/2QBR
	 NhV9eHtDR5STxldsXW2cCLLqRXN/N4g2z9RA3i/4+xf8yHQ1H0nFGPrReqjiFXDpqs
	 VsETs7Cyq9geQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j7QFS1JyHz6txj;
	Mon, 19 Oct 2026 08:12:44 +0200 (CEST)
From: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
To: Denis Benato <denis.benato@linux.dev>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH v3 7/7] HID: asus: Re-send the Zenbook Duo keyboard handshake after probe
Date: Mon, 19 Oct 2026 06:12:44 +0000
Message-ID: <20261019061209.415930-1-rebecca.mara@posteo.de>
In-Reply-To: <23dcbde2-26c3-4288-aa71-3bb3107e3f45@linux.dev>
References: <23dcbde2-26c3-4288-aa71-3bb3107e3f45@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 09:48:21PM +0200, Denis Benato wrote:
> Well you know how this things go... Only who does nothing can claim
> to have made no mistakes.

Thank you, Denis, that was kind.

> So I am concerned that hardware isn't entering s2idle properly...
> Are you sure it is?

I checked it this morning on the UX8407AA (Panther Lake), keyboard
docked, with 30 s of s2idle via rtcwake -m freeze -s 30, reading
/sys/power/suspend_stats/last_hw_sleep and
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:

  without hid-asus (hid-generic):  27.6 s hardware sleep, S0ix +27.6 s
  with v3 loaded:                  28.6 s hardware sleep, S0ix +28.6 s

So it does reach S0ix, with and without the series. With v3 loaded and
the backlight set to level 3 before suspending, the keyboard backlight
stayed on unchanged for the whole time, no change in brightness or
pattern. So I guess it is the second case you mention: nothing tells
the keyboard to switch the backlight off on suspend.

And if you ever need something tested, on this machine or anything
else, feel free to ping me. I enjoyed this and learned a lot, and I
would like to keep learning.

Thanks,
Rebecca
