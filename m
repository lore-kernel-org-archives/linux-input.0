Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019996;
	b=4P7qzq6bcFoyPvTgiKwnrrisYhclHAtsqM4sTDW0mc7x1zKhnKqvhDaP2KlzPhAR7rgD
	 IzaQaoOPj4tm/FA8naFezWQXAE1KG/rMaA7IcNjR+DAPfC+yUVwMWOSASDbTm1hifJqb4
	 H5nJILSNat07IDvp4WuVahbd+n4qAiFu2ePE1QU6mpRdpcLwRtoap/uigtZMPMAMPGdoz
	 nnAxM9NOhobJWpUjQpAkyavq7K0kUNkm0nfwHUXlNnicts8tq1fHt6PwZGD3QTYwyCpFo
	 Hd0by9kKaCxTIghor2NeM77NVqhEPmvVwQIwpgRO2S6qp7brDoWttCUE0TTQG05aA4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019996;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i3H3ODk8t4vuJojMP7D9sXwVaJyr5zdevY2GAdMtBIA=;
	b=FRIGK+X0Dp2XTxr/vd2MwurGAgv+qbWEVvDsuPY+qwojxIxLljMarRj7nOYbEfLgIUMp
	 8it7dgj++7TkZt7G7vyEiBEdX2NLYcKbxhsyP1Hak833D4XxxrHXnUR+azwGEpoBpEBON
	 CwMSsgfrp3XycoiiPxQfbiMmksmWPDa3TVMdx50SMeL/JUDzsWmN3Y8jAOo+t1+k7ciFF
	 diceoynYPMJd9niNRDN3bS3JJ7PCqXSchmNdxiYVW2KIsidyd0fF1pqMrwwdvTeR1x6/+
	 oizFPQXVvdRlDgYAQQmIiIMURcSf/yQlKD4eUlBPvpRxFvBrMnatEFGMPQ8u8of40kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=ZHMdUcsP;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB5606A31D
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 13:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEB5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=ZHMdUcsP
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 86644240101
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 14:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1793019980;
	bh=i3H3ODk8t4vuJojMP7D9sXwVaJyr5zdevY2GAdMtBIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=ZHMdUcsPXES8g+f04x42ann2lK30ccWN+nvrsecHwITV5x/iFfo8HCrLt5HN/4gz4
	 1vEMNIwxV9OppfK6vibcNO01PHGmBv0/KyD/EXiYQR+JPg8wHrHDaLZeF0FlhWxzNo
	 NnBc7cwZYQ0BBNsX3viInS2FO1KiQol5DRBtWh2gtIa5cxWHLpO7jLzOnVDbLkbQhs
	 BTRv/Tqa3Pf3GMJMM02d5EaX3k5LJ5hvKfjf5TjgkUEPGvNpE5n+gOoNO9/c44wVu8
	 zpW2kRfJ7m0JspSBSq42HZKoyFxKKtV6fXhV6248nOurfotJ4Y6xW7ijoC2Pnjw4Q7
	 VR05opNE9H37Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jCv5P1sx5z9rxG;
	Mon, 26 Oct 2026 14:06:17 +0100 (CET)
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
Subject: Re: [PATCH v11 12/18] HID: asus: size feature reports from the HID report descriptor
Date: Mon, 26 Oct 2026 13:06:19 +0000
Message-ID: <20261026130606.212382-1-rebecca.mara@posteo.de>
In-Reply-To: <20261025235232.129945-13-denis.benato@linux.dev>
References: <20261025235232.129945-13-denis.benato@linux.dev>
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

in the cover letter you asked Paolo and me to try asus_report_len() on
the Zenbook Duo. It works there, and it covers what Paolo's v4 5/7
("Do not send feature reports larger than declared") was written for.

Setup: hid.git for-next (hid-asus.c f6aa1be09ad5, the base of your
01/18), your patches 01-12, then Paolo's v4 1-4 and 6-7, leaving out
5/7. I stopped at 12 because 16/17 change asus-wmi and asus-armoury,
which I cannot swap on this kernel. Paolo's 4/7 needed a trivial
manual fixup (include context and the enum hunk); 6/7 and 7/7 applied
cleanly. Built out-of-tree against a 7.2.6-based distribution kernel,
UX8407AA, with my userspace workaround stopped.

- Docked (USB, 0b05:1cd7), captured with usbmon while reloading the
  module and pressing the backlight key: every feature report goes to
  interface 4 as report 0x5a with wLength 16, zero-padded. That is the
  handshake SET and its GET read-back, the 0x05 function query and its
  GET, the initial brightness, and two brightness changes. All
  transfers completed with status 0. The backlight key and Fn+F
  (platform profile) work.
- Bluetooth (0b05:1cd8): the backlight key and Fn+F work, no errors
  in the log. This is where, as described in 5/7, the 64 byte writes
  used to fail with -EIO.
- After docking again: backlight and Fn+F still work, and the input
  devices keep their hid-generic names.

So from my side 5/7 can be dropped in favour of this patch, and Paolo
can rebase the remaining Zenbook Duo patches on top of it.

Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA

Thanks,
Rebecca
