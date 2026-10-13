Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78E4F054E
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891926; cv=none; b=RACmsJcoFDGTEFbbD085q/KG49+dq9lhDQkGVwN6nXBNjLiUOKhrbzq2I73kAzp4bymWjCe3Cblceds0w1eCwWcenJ4zzURkZehSDB+6SQPsFYg3pPMQGxpVM6V/K6U5tI+S/tkBdM7GtJQ9zSmkt6u+kItlvU7pHU+9SlypMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891926; c=relaxed/simple;
	bh=DW9VZYiIz2jZl9G9f0EJAJnFkD0S6kYZevh3dInOFHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kx2nsCoLE3Be944WnV+7/tKFGURTy9FuVLTZwQePiaE2vtgc89e0DMHZlM4mJNnmYOg5g3K5hSFvm9FDN82fNmNyewE6/h+YI+1FgTGbIHdaMCSbCHO2YBqQgodBsk5zg8771S1ETK0pNmgNgSBpudgX+6RRBKIESUI8cwHYpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=dIjDfNFL; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="dIjDfNFL"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id BAF6D240029
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 13:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791891914;
	bh=3ohy64po8Dee9GiUlGcmLCcwyXaGcrqpR2q4QSJWxLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=dIjDfNFLhuYyvgBtVWzugocA9YSus8DLedqYxAciNYd27Sx3aldHXgWMfIfg75YCJ
	 sIZ6JkZpwPWBvVIQlqICwoaJUkF2ibn3JGE6nYLaogJb76ytfRwcW8Ce/ndpfzcSFK
	 ud1+xobwbcyRtXAKxknRRSgcGgIW/YYcS83T2R7haW/9NBY4RegTRFDZCIK0FmKSS/
	 ZMcVsIEF83JjKUX69ydy77TmZr95rQR4gGL7uUZl5bkZcTr2yS7MAGMJ/Cs43qKS60
	 tyN4RA6O6HxdvUjaHJypQlaq1ya/89PchU+7/jdBPxJtu1GrvBm0tOE1JS5W1CzzqX
	 IhY5gNE/nltJw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j3svs09kbz6twR;
	Tue, 13 Oct 2026 13:45:13 +0200 (CEST)
From: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH v3 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Tue, 13 Oct 2026 11:45:14 +0000
Message-ID: <20261013114506.1697676-1-rebecca.mara@posteo.de>
In-Reply-To: <20261013104033.36079-1-p.pisati@gmail.com>
References: <20261013104033.36079-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 12:39:57PM +0200, Paolo Pisati wrote:
> - Bind the Bluetooth IDs to HID_GROUP_GENERIC as well: over Bluetooth
>   the touchpad is a second HID device with the same IDs, which hid-asus
>   must leave to hid-multitouch (Sashiko).

I re-tested v3 the same way as v2 on a UX8407AA: applied on top of
base-commit 8099f9da59f1 (the resulting hid-asus.c matches the index
line of 7/7), built unmodified as an out-of-tree module against a
7.0.11-based distribution kernel, with my userspace workaround stopped.

- Docked (USB, 0b05:1cd7), module loaded with the keyboard attached and
  then three dock cycles: the five keyboard interfaces bind to hid-asus,
  the touchpad stays with hid-multitouch. Hotkeys, keyboard backlight,
  volume/mute, mic mute, the screenshot key and Fn+F profile cycling
  (balanced <-> performance) work. The delayed handshake re-send never
  failed.
- Bluetooth (0b05:1cd8): the keyboard device (generic group) binds to
  hid-asus and the touchpad device (multitouch group) to hid-multitouch,
  as intended by the v3 change. The same keys and the touchpad work.

The screen brightness keys emit KEY_BRIGHTNESSDOWN/KEY_BRIGHTNESSUP when
docked (checked with an evdev reader).

My Tested-by from v2 holds for v3:

Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA

Thanks,
Rebecca
