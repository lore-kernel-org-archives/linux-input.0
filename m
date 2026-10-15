Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5C53FD2B
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082893; cv=none; b=gYnRTUu1L9cb5unfK0ElcDlv+m8F+Yap7z59qDRqJH+m5+9lIuyLghCKlQntnhz8UYfU1nKxNwdu603eJs91FzByg3OdVLpfkjrsFGjLmna7geCmS9OnIedu7IGZpdc3i0xiyX4gIKAlS/cDyKoqTjNGMLPzORjjCerxgCHEL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082893; c=relaxed/simple;
	bh=bgUANRDyb/Z7AmtbQkG5HQSKgESRWxooGbeq+dpUzgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co/IZMLPB5WrxiNUV7RGNA/Kix+056TzC4e3FH809l06JMKsJTiOstHrIgxxs//rsRmJ1hrLqpTrrnO9jyVq8F0GoeT1SWZI3MW5ZLCvmmsAxWCKzzrlQ0EPJkD0loH4WBgFNHm02MxfGfW//va9ZX6zIh4YoFZl/xLTlN1BwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAbjV9da; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAbjV9da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5B91F000C4;
	Thu, 15 Oct 2026 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082878;
	bh=P6yQyTcJqOo0Bee0NaZEc5/LSfpng5jmABNvj9xA8LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WAbjV9daBD30Ni2h7AuANjEwrBkpaGSiYqnRzF+uNcZz3w7lMJGEu+W0gQ5J739Sl
	 EpJHw5p0a7bht6n+1WSw/zuDRTN5xAprzn+8n37163JhO+whRuA8X4yP3J9QfK9CbW
	 yIbbh9yM4tzgH3qJvmnzta6BThnhrhNhaLwbbXSz4sGgFKtJ794ZPY+9NV6Gmsr143
	 ej8PjJdttjqSXrtc5SJLXAIU1r6GSMhSglymlLgiUE7xP3eJegPePSg8NjpZ+17/82
	 G/75DQzLSIYU0Q2jftAdh+WTHUYPk5jomnxT2IWcysbTYhZyAh3JyCxAioc++ktR2b
	 W9FuqnuS/36Yw==
Date: Thu, 15 Oct 2026 18:47:54 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v5 0/3] Latest Roccat HID fixes
Message-ID: <atECwbWrAQFpbELS@beelink>
References: <20260929065743.134635-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929065743.134635-1-dmantipov@yandex.ru>

Hi Dmitry,

On Sep 29 2026, Dmitry Antipov wrote:
> Now d76994443eed ("HID: roccat: fix locking in roccat_connect() and
> roccat_disconnect()") is landed, and these ones are expected to fix
> https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e and
> https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f.
> 
> Dmitry Antipov (3):
>   HID: roccat: use device_is_registered() to check whether device is available

The Sashiko report is actually more concerning than anything. Given
that, I don't think we should keep the patch in the series. Unless you
manage to fix all Sashiko comments, but it feels like a lot of effort
for little gain.

>   HID: roccat: fix device access in roccat_release()

I took this one (see other confirmation email).

>   HID: roccat: use kref to manage device instances

I wanted to take this one but it doesn't apply cleanly with patch 1
dropped. Can you respin it on top of for-7.4/roccat, please?


Cheers,
Benjamin

> 
>  drivers/hid/hid-roccat.c | 63 +++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 26 deletions(-)
> 
> -- 
> 2.55.0
> 
> 
