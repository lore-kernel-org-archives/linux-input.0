Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D43B6C1C
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899814; cv=none; b=f5lN4bfRAZexFbE91+KTaUVDtem/B8Ych/v/ssizA6cZ/n60OCerATlEagISlGKunG3tvH4NF4SeDHW9V2pqOt+t/Aza7paKfI8dYZ7x8+hWJqVN3YH9SGuIjKlGAFTZe7QfD6SsXS7rcfmi0+tRo/A7F1IL7hTs10gJ8MznGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899814; c=relaxed/simple;
	bh=xSFFb7PWkaW97gkeM7trCyD9tBCSii9Ae975DGQazfA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Lb5m8yCHlCOc4yvFey1gMJ+4gF6I0QUfBGkKC+qYwvh4Tk/lIeSU8VYudxmQHW2zGSuhG9BjNMoE4RfCz1bz+8ytwJmEBYnGki9Ph56u4LwxFBSuWL+z+IcPrsAH/qpIexNzGyaOORLONk/2c7RDI/LS0mNjkjL3C8YPE+hI0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AISG7Woa; arc=none smtp.client-ip=95.215.58.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AISG7Woa"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xSFFb7PWkaW97gkeM7trCyD9tBCSii9Ae975DGQazfA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791899810; v=1; x=1792504610;
 b=AISG7WoaXVoFT1krIS9wbLLMMEJ/WQR3DMNL5WN/+8wEsCPRlYGI2KoqHhAhm9GFC+U8xdFV
 sRACsulGyDrIHtrXIINU5VouPm4a0Zd8Ls+MLWxgrs3xv5XjSz96ufnfJloBjzzWfOxE8OvduDm
 bAj4Zajsm+qxfGJu+T38+FaI=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b0b7d4626a6db7bb;
	Tue, 13 Oct 2026 13:56:50 +0000
X-Mizu-Trace-ID: b0b7d4626a6db7bb
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 16:56:39 +0300
From: Denis Benato <denis.benato@linux.dev>
To: =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>
Cc: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Luke Jones <luke@ljones.dev>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>
Message-ID: <424edeef-9663-4e64-a267-66a185b3df07@linux.dev>
In-Reply-To: <20261013114506.1697676-1-rebecca.mara@posteo.de>
References: <20261013104033.36079-1-p.pisati@gmail.com> <20261013114506.1697676-1-rebecca.mara@posteo.de>
Subject: Re: [PATCH v3 0/7] HID: asus: ASUS Zenbook Duo keyboard support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <424edeef-9663-4e64-a267-66a185b3df07@linux.dev>

13 ott 2026 14:45:22 Rebecca Mara M=C3=BCller <rebecca.mara@posteo.de>:

> On Tue, Oct 13, 2026 at 12:39:57PM +0200, Paolo Pisati wrote:
>> - Bind the Bluetooth IDs to HID_GROUP_GENERIC as well: over Bluetooth
>> =C2=A0 the touchpad is a second HID device with the same IDs, which hid-=
asus
>> =C2=A0 must leave to hid-multitouch (Sashiko).
>
> I re-tested v3 the same way as v2 on a UX8407AA: applied on top of
> base-commit 8099f9da59f1 (the resulting hid-asus.c matches the index
> line of 7/7), built unmodified as an out-of-tree module against a
> 7.0.11-based distribution kernel, with my userspace workaround stopped.
>
> - Docked (USB, 0b05:1cd7), module loaded with the keyboard attached and
> =C2=A0 then three dock cycles: the five keyboard interfaces bind to hid-a=
sus,
> =C2=A0 the touchpad stays with hid-multitouch. Hotkeys, keyboard backligh=
t,
> =C2=A0 volume/mute, mic mute, the screenshot key and Fn+F profile cycling
> =C2=A0 (balanced <-> performance) work. The delayed handshake re-send nev=
er
> =C2=A0 failed.
> - Bluetooth (0b05:1cd8): the keyboard device (generic group) binds to
> =C2=A0 hid-asus and the touchpad device (multitouch group) to hid-multito=
uch,
> =C2=A0 as intended by the v3 change. The same keys and the touchpad work.
>
> The screen brightness keys emit KEY_BRIGHTNESSDOWN/KEY_BRIGHTNESSUP when
> docked (checked with an evdev reader).
>
> My Tested-by from v2 holds for v3:
>

Hi all,

I'll re-send this mail as the other client formatted in html and the mailin=
g list rejected the message. Apologies.

I'm currently on vacation so I will need to postpone reviewing this.

My greatest concern is with report size: every device needs its own and har=
dcoding it is not an option anymore because no device can be fully made hap=
py (and working): xg mobile is 300, ally and new ROGs is 64, some have 32, =
some 16 and I think TP is 15.


I have yet to look at the patch that changes the report size but please mak=
e the report size variable reading it from the descriptor.

I will be beack the 18th October.

Best regards,
Denis



> Tested-by: Rebecca Mara M=C3=BCller <rebecca.mara@posteo.de> # UX8407AA
>
> Thanks,
> Rebecca

