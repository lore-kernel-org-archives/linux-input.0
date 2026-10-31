Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471417;
	b=kCYaA7bej6+gKi4zsFKxRH0N8OAmnI/ct+H4Tbnp6aqIOwhjsLEMZFrzLl4MuuEkxzdp
	 9LXVLHTULc83TVFGbMbjvMLiBgZVu3C1xdP9ksHXssqeQwKrm9OJc5ytDxF/+7ElElk27
	 Zxrn3I1+ZjSw2tbvkkj+6SRxtv/onLnfaizPB1ujtd/iGao3SmYmp8LNl+yabmA2Sjbbd
	 iviQjEbdfD+mU+8yZ8sehfuQ1fF4DKZhrHLFuldGeT4/TDzdIjpnxu8BV5gUOtVGnRNVG
	 37b43wgFr5rq/GAZsYZbjiF8DLKAY2X/20VXHtdNm3KjB0E1f5wAPYhqBcjKbTSXXYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471417;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AsvtGasltz1LM3kzdXZQA2MXNQaYwUDHmgXhkb7YbX8=;
	b=U8XyKhlwAKJS6p8e7bcf1/NKyD0guFXHz4g8rkVLAJ3HCR0hi83ljMXznN66gUmrtWJ0
	 7fkF/44yA/yFKnd3mDMaRniQGsJY1YTsx7eS8brTc6/ofsehbNSLko4jxFoGrani3SKD8
	 jQpa6pojut8NZdCiG3PftnZZmxpG/iYCy/Ob6W4jbjB6JK43vnkGeQYqdjgpM48Poemwt
	 v1LalUyuMKluuixao3IZzSKSfAeKy0KB61dx9mJSe3fEWSx9KmSi/+vukyeIO/o0NRsDb
	 BEr4R/d1E7gmbpEksAOOCybuyjM/5Uof8Zyg7/Xy2Q25qA1meNwlYksv6P3d1KB3P/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=YT+f1J7z;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCB606A322
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FCB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=YT+f1J7z
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 90ACA24014F
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 19:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1793471412;
	bh=AsvtGasltz1LM3kzdXZQA2MXNQaYwUDHmgXhkb7YbX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=YT+f1J7z7kYPvg742rKyFI4X4/RKAcZ4qB0+QfYoP+jGE0EkT4TyRJEne1lw4qZjq
	 HdI2H3B90Ryw05rIakGD8HutzQHIGVws2N5ASZqYJKD36NYchkT66rH3kVJ3mDi+le
	 TJsW9zPNaoz2KOA1ztpxlBwdYaSCjFJngfu+Di878B46YpkhgZWIeuLmWUGfTmSjNJ
	 jqHrYpPSIdkGw00UUX6P5iKhyfHAu2K+vCgouUFUpYtYCluRa2yEPMpMcK/RE3tJIr
	 jSmWAAll5bZxIncnUejXjdrWk4wb8tB2GCtVOWro6uSniTrCs4z2BomPLGKLGaXNAq
	 OrA836lHQJfkA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jH62n1RB2z9rxG;
	Sat, 31 Oct 2026 19:30:09 +0100 (CET)
From: =?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>
To: Denis Benato <denis.benato@linux.dev>
Cc: Paolo Pisati <p.pisati@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schwartz <matthew.schwartz@linux.dev>,
	Denis Benato <benato.denis96@gmail.com>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Khamunetri Clark <khamunetriclark@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Ivan Levchenko <me@livan.pro>,
	Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v12 01/17] HID: asus: size feature reports from the HID report descriptor
Date: Sat, 31 Oct 2026 18:30:11 +0000
Message-ID: <20261031182956.2250899-1-rebecca.mara@posteo.de>
In-Reply-To: <20261031174130.208240-2-denis.benato@linux.dev>
References: <20261031174130.208240-2-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Denis,

as asked in the cover letter, I repeated the Zenbook Duo test on v12.
Everything that worked with v11 still works.

Setup as for v11: hid.git for-next (hid-asus.c f6aa1be09ad5), your
v12 01-12, then Paolo's v4 1-4 and 6-7, leaving out 5/7, which this
patch replaces. Your patches applied cleanly, and Paolo's went on top
of the reworked 01/17 without conflicts (4/7 with the same trivial
fixup as last time). Built out-of-tree with W=1 against a 7.2.6-based
distribution kernel, no warnings from hid-asus.c. UX8407AA, my
userspace workaround stopped.

- Docked (USB, 0b05:1cd7), captured with usbmon while reloading the
  module and pressing the backlight key: 5 SET and 2 GET, every one of
  them report 0x5a on interface 4 with wLength 16, all completed with
  status 0. It is the same sequence as with v11: the handshake and its
  read-back, the 0x05 function query and its GET, the initial
  brightness and two changes. The backlight key and Fn+F (platform
  profile) work.
- Bluetooth (0b05:1cd8): the backlight key and Fn+F work, no errors
  in the log.
- After docking again: the backlight key and Fn+F still work.

Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA

One small thing I noticed while applying: 06/17 adds 14 lines that
contain only a single space, and git am warns about trailing
whitespace. checkpatch will probably flag them too.

Thanks,
Rebecca
