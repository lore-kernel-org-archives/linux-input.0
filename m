Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8F4CA76C
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340330; cv=none; b=Hv6CBTsx5m689RGoBD8dz9ueuRnfwEPiHMDOWY9p9fiSa0hPtExNaqW+knZFdxDV3byZ5EyXuycw0Ux8iqXCYWqx3vdTFdnWiaAaGjgQ7LTPAB/jd2irId4VyFH12coSgaLewYjDYLvpH2x4WZ3nLechwVfJoiVPL+lZgqKGgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340330; c=relaxed/simple;
	bh=Hsk3v6bBlP3rnGd1UNuclmvuHaubgTokW56qgJjEmO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhFd+2gl3KXbfxiSCxqZS21Swtzr9j0uA6ij8U8gDooPcJx9q0YvoCuNSsKdK1PiBaLCI8TUelDbKVGKn9xLXHsPZ2enotZaoZm1iYv5OqxYm/72VuOyHxQL6C79JgsmmJPeSRbL25XQYq+MNvgPuIJ9VwgxHPWbsL4jQIQXs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=lUoPSZCY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="lUoPSZCY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CD02E240106
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 18:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792340320;
	bh=wcDWCHzbP+KBFs/W4yJa9PnuNeRFlQGJLSt918RZE5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=lUoPSZCYhUt6CYdBeqZTP3BSFyH2m4Hkxiaf+Aj6yihVEBBYLWXHQ2Ub49Jj/+JXm
	 y+nn+iIAmCYsZ2vPib5jOe8iz3Fr5Va8uYgEqTgTkvlrZ9INKi5TD9UkWSkCk7olv7
	 6jftqwCoJP5yjFf6dA7k4mNQ/EsJyDeulQOVQ7yc1eFoNig8LnlLjbWk6D1ZT+TD+/
	 NYExPC6sUlLd6Gmo+Yyu8e+dgcTT6hVAXCxdjnO3d3nN+v+bphqGD3ZNt1Xx646HN7
	 B3bekKcozA1U2cVZ2pI7uHNsgcLQTK2x44FplqTAGUCTH8eU0BP/zwEFpc+OVhtKKy
	 uXD2WVZGlH7ZQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j73l30ynNz9rxP;
	Sun, 18 Oct 2026 18:18:39 +0200 (CEST)
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
Subject: Re: [PATCH v3 1/7] HID: asus: Fix up Zenbook Duo report descriptors
Date: Sun, 18 Oct 2026 16:18:40 +0000
Message-ID: <20261018161826.1738483-1-rebecca.mara@posteo.de>
In-Reply-To: <b22a521d-ec6e-4ac8-9aaa-d34e67ba898f@linux.dev>
References: <b22a521d-ec6e-4ac8-9aaa-d34e67ba898f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 05:50:08PM +0200, Denis Benato wrote:
> Does the zenbook duo really needs fixing the report descriptor? I think you can avoid this
> altogether on this hardware.

Welcome back, Denis. I tested exactly that on my UX8407AA today, docked
over USB: v3 built as an out-of-tree module against a 7.0.11-based
distribution kernel, once as posted and once with only the Zenbook Duo
fixup disabled (QUIRK_ZENBOOK_DUO_KEYBOARD removed from the fixup
condition, nothing else changed), my userspace workaround stopped.

Without the fixup, the hotkey interface gets no input device at all:

  asus 0003:0B05:1CD7.000A: hiddev2,hidraw8: USB HID v1.11 Device [...] on usb-0000:00:14.0-6/input4

With the fixup:

  asus 0003:0B05:1CD7.000A: Fixing up Zenbook Duo keyb report descriptor
  asus 0003:0B05:1CD7.000A: input,hiddev2,hidraw8: USB HID v1.11 Device [...] on usb-0000:00:14.0-6/input4

Without the fixup, volume up/down and mute still work, as they come from
another interface, but screen brightness, keyboard backlight, mic mute
and Fn+F profile cycling are dead (checked with an evdev reader and
/sys/firmware/acpi/platform_profile). With the fixup all of them work.
So yes, as far as I can tell this keyboard needs it.

On the Assisted-by format: my original patch (7/7) was written with
Claude Code using claude-fable-5, so following
Documentation/process/coding-assistants.rst that would be

Assisted-by: Claude:claude-fable-5

Paolo, feel free to use that above my Signed-off-by in a respin.

Thanks,
Rebecca
