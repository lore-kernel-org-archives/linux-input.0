Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA92369D72
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 04:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791607477; cv=none; b=RJo32RpZYZ1JZnXRrpLz4iiXffzCPtx2XogWPrFHp9X367yoGokRfExS3tkYa3C6JD2v6R5w/Xv6zY3zVrbRcW9ug/W2CJRRf30+L13AxbIFqQ3a948AbcQ2Z4MXxOeMrryHJa9YQxMMji0tVqZUM1epT8LNkvi0cpawCiPyJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791607477; c=relaxed/simple;
	bh=khc0UJNqOG+GrwNn+LOHYRxQX38Fwqd+fMMwxrBWYLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW2Ik29mBc4RMNzoXsb4Koqn8QHZONdKiqoFpsmUwu65virdC8PtJmXD8F/LSB9/GfBnJeoCwKY/j66cEMUNmMtmPIWMTKPEdAxDBOYxk5Zukf4UcbVxtW4UNwn5Rg5BfLtDlb3xfY7o2nDS9Z+cFjbvTlAW4AosZsgK3k/2v5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=fb/hmsKs; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="fb/hmsKs"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 06E11240104
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 06:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791607473;
	bh=M4Xpi+fsPVUJtv1GZ+D2lwbXL3gxdPpBxjqPxhMYN18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=fb/hmsKslAtuxxujSypdkUNAuWfdyzkwU1Fisa/jyATE3JhLiovxdB263yvugBIAT
	 Vm7WaQclKBqL1DyW/ef4SjvxlEQhkL8ctLwazGHiGX3UNf7kEYsdF+P4a9Q5Xi2JU0
	 6QHF3TSc7s1dcM6XKZrRKOBsWNuuLE3ZXGM5Ox2c6O8+ysSQDZ2kCeit18bvw4iDIY
	 rMw80ykEkrrtO+pKivCGvAaQHt/WQn0uzg33+UUAaysWMLrQj/2d0ioUILBdVeMHjA
	 TcsSloxKSuxRY+yCwZvlnJuU+Y+PgfNAtQqbQ3dhLU7GyhtT4fk9N3k11plAfiO3X6
	 YNz3bdrAf7uAw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j1rjq1hpsz6tsg;
	Sat, 10 Oct 2026 06:44:31 +0200 (CEST)
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
Subject: Re: [PATCH v2 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Date: Sat, 10 Oct 2026 04:44:32 +0000
Message-ID: <20261010044406.1392934-1-rebecca.mara@posteo.de>
In-Reply-To: <20261009153459.124752-1-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 05:34:27PM +0200, Paolo Pisati wrote:
> Rebecca Mara Müller posted an independent patch for the UX8407AA
> keyboard in August [1]. This series follows it in using
> HID_CONNECT_HIDINPUT_FORCE and in binding the USB IDs by group, and
> carries her re-sent handshake as the last patch.

Thank you for picking up the handshake re-send, and for the kind words.

I tested the whole series on a UX8407AA: v2 applied on top of
base-commit 8099f9da59f1, hid-asus.c built unmodified as an out-of-tree
module against a 7.0.11-based distribution kernel (Pop!_OS), with my
userspace workaround (which sends the handshake through hidraw) stopped.

- Docked (USB, 0b05:1cd7), three dock cycles: the five keyboard
  interfaces bind to hid-asus and the touchpad stays with
  hid-multitouch. Hotkeys, keyboard backlight (levels 0-3),
  volume/mute, mic mute, the screenshot key and Fn+F profile cycling
  (balanced <-> performance) all work. The delayed handshake re-send
  succeeded every time.
- Module loaded with the keyboard already docked, as at boot: same
  result.
- Undocked over Bluetooth (0b05:1cd8): the same keys work, and the
  touchpad stays with hid-multitouch.

One observation, in case it helps someone else: while my userspace
tool was still running, the re-send failed once with
"Asus handshake 5a failed to send: -32", presumably because the tool
had just sent its own handshake. With the tool stopped it never failed.

Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA

On patch 7: my original patch, and the mail it was sent with, were
written with the help of an AI assistant (Claude, Fable 5.0), which I
should have stated in a trailer at the time. The "Assisted-by: LLM"
in 7/7 follows your note, so it only covers your adaptation. If you
respin the series, please feel free to add

Assisted-by: LLM

above my Signed-off-by as well.

Thanks,
Rebecca
