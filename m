Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D238422F
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913926; cv=none; b=S4PhuECLahzJn0+1pKqfbmbLYpBcDR1Q38fldeJ9beYInK0k9XAH0Rh8DC0jf68yySCZaQGUiGVk+XlkPp0gq99ZYzgt8076uPYC5DH3E/ogLMrfogtmo2fuURgpIvO/fjL/oTdkpR3VEXIP18Ah2ZmMUh66NLkI/gQlsCQg9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913926; c=relaxed/simple;
	bh=N4//OBVNGsKj/i+4jkWI/PIZiBgVARKAjYKLYZdPUJ4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Numo9Mia9BK6OtK8FiWwaHF/BRYNiWwllZQYmwXj17hzZajHLSWu6dk3eblvmh3tu+F83xG+sI4JDsHWt3KTwQjrLhjWBNz1M8YdWx1t3rnOLC41oQD56Y8IsAl+qa3q/pXDqaeylEOdzpu5akGa8w4X9FI40Rk++CLQtDu8/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev; spf=pass smtp.mailfrom=ghoul.dev; dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b=ZvLFb9xT; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b="ZvLFb9xT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ghoul.dev;
	s=protonmail2; t=1787913736; x=1788172936;
	bh=Arqne3nbSe+5ZeHEigAEU+L4k/Z7lCBK3b7SPge5ayg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZvLFb9xTMmh1fSCpo6vs0slLzvprMpTeXQQSJgupT36B8uk2F1XhnN7cRDbRWODqO
	 YNWfLf+36B0abTt2nPTUV1q/fOF5O+SQD+0xNMCKauaWxkSwXBwv1DegY7Bz+1o/Gy
	 ZGJYoXT9k7rSjNrVXOZYSGnllwCUBEBzB95OVL+tbbyH3ChPUJNHJ8sgiyhZrsXW4p
	 LZ8yWcc0X2xtAuCe1Ol3r/IhEvtq5GGq4fpb/fRb27dP947+7fY2qv2TyMa3sV+hSM
	 4a+lyemJC3oXAwFEaYZt6wwQV/Nu6OF9HW3MvNv36zfXM+0HgZs3YRB6QB2xglhGKP
	 zyGGE41NnNsig==
Date: Fri, 28 Aug 2026 10:42:10 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Denis Benato <denis.benato@linux.dev>, Antheas Kapenekakis <lkml@antheas.dev>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>, regressions@lists.linux.dev, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ahmed Yaseen <yaseen@ghoul.dev>
Subject: [PATCH v2 0/1] HID: usbhid: skip interrupt IN polling for devices with no input reports
Message-ID: <20260828104159.62399-1-yaseen@ghoul.dev>
Feedback-ID: 177610485:user:proton
X-Pm-Message-ID: b22a264b94d2d5a2cd1438a923e522816256e6da
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On some ASUS ROG N-Key keyboards, a second input-less interface is
exposed for RGB control. Polling this interface causes keypress reports
on the first keyboard interface to be dropped: a lost key-down drops a
letter, a lost key-up leaves the key stuck. Any hidraw reader opening
the node is enough to trigger it, including SDL/Steam Input or a plain
cat.

This patch skips the poll if no input reports exist for an interface. A
device with no input reports has no benefit from being polled, so
instead of adding a new quirk, I have opted to skip it entirely.

Devices other than the ASUS ones are unaffected. HID core already
discards whatever arrives on the interrupt IN endpoint of an interface
that declares no input reports: hid_get_report() matches nothing, so
neither ->raw_event() nor hidraw and hiddev are ever reached.

The affected machines are 2024-2025 Strix SCAR 16/18 (G635L/G835L) and
G16/G18 (G615L/G815L) laptops, and the bug is widely reported across
distributions, so I would appreciate this being considered for the
current cycle. Reports:

https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-strix-16-20=
25-with-cachyos-during-gaming/30823
https://github.com/ublue-os/bazzite/issues/4590

v1: https://lore.kernel.org/all/20260605113952.38435-1-yaseen@ghoul.dev

Changes since v1:
- Added a short comment above the condition in usbhid_open() explaining
  the reason for skipping there.
- Added Cc: stable@vger.kernel.org; v1 was not marked for backport. The
  bug reaches every tree carrying 4ac74ea68f64, i.e. v7.0 onwards.
- Added Link: tags for two of the downstream bug reports.
- No functional change: the hunk is byte-identical to v1 apart from the
  new comment, so the Tested-by and Reviewed-by tags carry over.

Since v1, this patch has been adopted by three downstream kernels, with
no regressions reported by any user since:
- OGC kernel: from v7.1.3-ogc5 (2026-07-21) onwards
- Nobara kernel: from 7.1.4 onwards
- G14 kernel: from 7.1.4 onwards

Ahmed Yaseen (1):
  HID: usbhid: skip interrupt IN polling for devices with no input
    reports

 drivers/hid/usbhid/hid-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
--=20
2.55.0


