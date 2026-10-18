Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3A242D62
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351116; cv=none; b=fHNNJXMqr3a1UVyn9eZcoJoHcGrdJW9Mc25FBL/xwZkG6XGFQ3oTevuS53j8pKpjnJaZtQvlpbCEtvCcSUgWdE+UIITGrF+s+N1rLlpxrp2qDlxtQipEQac8aMN6ik+Tnp7/uQHVE1ABnRRBIFedrglHIjAhQiZwHEtc9vp/vRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351116; c=relaxed/simple;
	bh=deDSQN5X7htnNnQdP5vUq1dHxLSrjUUk8SJC+9hzfTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWB6tA823p8Mc466LUFAF7NMcNx6Ro7qejj7bj1BiK31tyNO0AcwpW0v4kE+pQYp14PIgpkAWxOAtqjtwRemeMXJWOGV0lFZrCa5vnbGDDt1tb48R2n+ILWiJZQBD7CwOFoAohsObUSw613LYl+jpTvbv9U4M3ysmM2Ox1Xc+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=FB6FhrFp; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="FB6FhrFp"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1CAEC240104
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792351113;
	bh=gNaqpXcYk1sW2dIQNDaq37foF4xP6KPL3OfDqoRrjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=FB6FhrFptSDcZpZ1pijzjsYyxqWJZgErMErxGW+x6e+8mR/0efmx4hjxcx672DGpy
	 7wgXFlqG+GybWVMZGI/rWf5cgCf4LY79cvpwCZ7s1DrRAx18p7nBkS/xdTHOV0ZIE/
	 UgiKFg6LYiasX6XLnNBOEBfHL58uwCo68DWkS+hanb1Kj/HlD4KdsAHiH2PQt4giWT
	 QJERcOxtGmilkS7MSNJqXPQAghyGCw0fy2AzoeNH8HmRbmsl42ERqoRY3LZEEYhmMn
	 m4mvfaabnd6uiWCjatyFYKFFuPrgSlKu6cgJoYhZ2VkNL/RTbSqlWlWw+rKL48UMF4
	 l/+zejdsHKlpQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j77kb4ffrz9rxB;
	Sun, 18 Oct 2026 21:18:31 +0200 (CEST)
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
Date: Sun, 18 Oct 2026 19:18:32 +0000
Message-ID: <20261018191823.22123-1-rebecca.mara@posteo.de>
In-Reply-To: <4bf9e6b0-4f6e-4faf-a2b6-a57143ef3f23@linux.dev>
References: <4bf9e6b0-4f6e-4faf-a2b6-a57143ef3f23@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 07:10:57PM +0200, Denis Benato wrote:
> So this patch is based on an arbitrary wait that is based on the
> assumption that some other device gets initialized...
>
> Can you try making this deterministic?

Since this part came from my patch, I went back and measured it on my
UX8407AA before trying to make it deterministic. The result: there is
nothing to fix, so please drop 7/7.

I built v3 as an out-of-tree module against a 7.0.11-based distribution
kernel, with only the schedule_delayed_work() call of 7/7 removed and my
userspace workaround stopped, and checked whether the keyboard stays in
hotkey mode (keyboard backlight key changing asus::kbd_backlight, plus
usbmon on the keyboard's bus for part of the runs):

- docking: 10 of 10
- loading the module with the keyboard attached: 2 of 2
- rebinding only the touchpad to hid-multitouch while docked: 4 of 4
- s2idle suspend and resume: 3 of 3
- reboot with the module loaded after hid-multitouch (rootfs only):
  2 reboots, 1 cold boot, all fine
- reboot with the module in the initramfs: 3 reboots, 1 cold boot,
  all fine

usbmon shows hid-asus sending the 0x5a handshake on interface 4 and
hid-multitouch sending feature reports 0x07, 0x03 and 0x05 to the
touchpad on interface 5 some 10-20 ms later, and the hotkeys keep
arriving as 0x5a reports on interface 4 afterwards. The same happens
when hid-multitouch reconfigures the touchpad on resume or on a rebind.

I also went back through my notes from August to see why I believed
otherwise. The conclusion came from a test where I rebound the touchpad
and the brightness keys then did nothing. At that point my test module
had neither the descriptor fixup nor the forced hid-input binding yet,
so the hotkey interface had no input device at all and the keys could
not have worked in either mode; my userspace workaround was stopped.
All later tests that day already included the re-send, so they showed
that the whole patch works, but never whether the re-send is needed.

I am really sorry for the extra work this caused, Paolo, for carrying
and adapting the patch, and Denis and everyone else for reviewing it.
This was my first time this deep into a driver, and I should have
tested the re-send on its own before sending it.

Unrelated, in case it is useful: with the series applied, the keyboard
backlight stays on while the laptop is in s2idle suspend.

Thanks,
Rebecca
