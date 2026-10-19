Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B94C6520
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416970; cv=none; b=MLAeoa8yq4AVMualC+J+8S25Qw6/dtn32I767JXDMtiuA3vr4mMjCt69DfKr++68r+y+Fj8aokyce27ON5K4n1wfM+oE9peJAqfXJ+XrmfPUnHOoDLk24gTsKZjI2MdlM554BZurkITTKVfUv84CUVW5uwaLgYwujKhKeEuEaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416970; c=relaxed/simple;
	bh=Ps7Go3xP5HMjfsfq7Eq3Svlmz9WqBPCZvkB2NJg83GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6u+TR6U4yKzUBBgZtssVM8KYDhwkchhZnSiXh/WUV2ANQ0jK/WMTtbd/x87v2rmrVPhn6ttq7q/Bg/6W+noxutVI41762hUXLx1Le0O48BIouXrqRdNXMJ++aynBxmXk8sWUNRSSIb3UtuxZLP2zFFdX+bwP8wupwEpsu2dhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=U/HU94tg; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="U/HU94tg"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id EA070240027
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 15:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792416966;
	bh=hNbyYL6sFBG2U8Y87Q4AqsX6THkGWQP8zQyGjqptp6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=U/HU94tg1PC5ajDmaIXcp6DW0Z9cmGkaSlNKH+OZn9roOk8+nBlhOcoJu9IqWC67U
	 DhaA1PMb7xBFf0mOCzMkd/cjI0UYGY1WyPJnDGbSKHze6UI1ZoqSb38EhklZIk9cbu
	 YKaJ2KH22y/eWxmVgHb625pL39X+HW+gTSRIe7VWrOJs2cjFDbb0jFg9qsznab+d4M
	 sFBOrrrZKBtVQZqzPe7KBSDpqHWU6CwQRuTXqruV9xEZvoSIQUs9gLfuxD5HFwfS6k
	 /17DJLgNvxFFGKV2iPRugAI5i5TLxwj9THEIM2MI2WQ8z7GjkkEmq2PazQXMEsoUzH
	 f5czHQBqqWG8A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j7c512T7gz6txf;
	Mon, 19 Oct 2026 15:36:05 +0200 (CEST)
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
Date: Mon, 19 Oct 2026 13:36:06 +0000
Message-ID: <20261019133557.14092-1-rebecca.mara@posteo.de>
In-Reply-To: <07076668-3291-4eb6-888b-0e6c518ef21b@linux.dev>
References: <07076668-3291-4eb6-888b-0e6c518ef21b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026 at 01:03:34PM +0200, Denis Benato wrote:
> Very good to see it sleeps just fine. So yeah a command is missing...

Thank you for the roadmap, I went through it on the UX8407AA with
BIOS UX8407AA.308. I have since updated to 310, the latest one; its
ACPI tables only differ from 308 in relocated memory regions, so the
findings below should hold for both:

- asus-nb-wmi only exposes the basics here (kbd_backlight 0-3,
  throttle_thermal_policy, charge_mode, screenpad); no TUF/ROG lighting
  or power-state attributes.
- In the decompiled DSDT, WMNB answers 75 device IDs. None of the
  TUF LED power IDs is among them, so it is not a firmware that claims
  "unsupported" and accepts the write anyway. The kbd backlight ID
  0x00050021 goes to the EC (SLKB), which does not reach the detachable
  keyboard, a separate USB/BT device.
- The LPS0 _DSM in PEPD only notifies the EC (MS entry/exit 0x9a/0x9b,
  display off/on 0xb7/0xb8, entry/exit 0xae/0xaf). With
  pm_debug_messages on, Linux calls all of them on s2idle (screen off,
  lps0 ms entry, lps0 entry, and the exits), so nothing is skipped on
  our side.
- With dynamic debug on usbcore, the keyboard does go to USB suspend
  ("usb 3-6: usb suspend, wakeup 1", and "wakeup 0" with wakeup
  disabled), and the backlight stays on in both cases.
- The backlight only goes off when the keyboard loses the connection:
  lifting it off the dock during s2idle turns it off immediately.

So the keyboard simply keeps its backlight while it is connected, and
I guess Windows either cuts the port power in Modern Standby or MyASUS
turns the light off. I have no Windows on this machine at the moment
to check which.

Following your advice I did it in userspace: a systemd-sleep hook that
saves asus::kbd_backlight and writes 0 on "pre", and restores it on
"post". With v3 loaded the light now goes off just before the screen
and comes back on resume. If it is useful to anyone else I can post it.

Thanks,
Rebecca
