Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA413F1077
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807530; cv=none; b=KsYgcODq+peWdsAlMbs19o0/O31edFVfdcDFm/kUQzYe9C9ZcVezjJUq/GbPjLnjrJPKOvJyBNwXQC0LyMu/o+V3BFpi+njeNjvOnr3mMvI6Y7hxizGmop9YIdkvDiWu80b1QTzjJ+1DWBGHn+H8nrkcrbsvwV4fZe/03/jy7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807530; c=relaxed/simple;
	bh=e7P5GTH78TzKPlryB9jlnQ7BLMx53JLA1xZ/jvRnfkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sAGI+5483tRENe3ejjlYPqnpy1yWCL6yoktHAhLJcH/yp1gFMDCdtg8O8XgoGQivoTQ74LnbS6ZEuqFA+J42+NGlc0SgogciyZOAVrtugyXOVLhCrKUVnHD3t/SbT4dhqZc0MbrHvYq/4rpTlGOl8OpJrZNqRqy2sx8TBESCUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVfxf8iQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVfxf8iQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B70D1F00A3A;
	Mon,  7 Sep 2026 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788807528;
	bh=b3sXrT2MEzBp1xs+zo3G79dwJN+84gfZTimyPYE6juU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVfxf8iQSoIDmyGqgekt7PNuRFigR31GG8tmafMjn/XNV4cVu0gVrV/+iQ8h/cho8
	 b2pAU3UiL9rHqHjDVMmgkI20oTsPz0XlO6+VwlvDtXSwvz+43rIvDjgphnwKVnaVvD
	 Isd4GQlrQC/IWc7ttD6yFZdbDM+JsfL8oBagFdNZoEYYF9pHUvsNRmHexqIVFSZjIv
	 d/0yeTwm6kZZtg5ys2nxYzlBA5GMnunkHjImJWYFtoKQFSHS5f/znyawsbmrtY7ara
	 pLEPwqtUzhWVBUE/FNGKNUKKi/+wEwkZ/U5Q2ZeZuEt5zYzmQt6P+cniWmZemfvnLm
	 UlXvoooGzqKPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] Input: aiptek - validate raw macro indices before
 updating state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miguel Garcia" <miguelgarciaroman8@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
References: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 18:58:47 +0000
Message-Id: <20260907185848.1B70D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent access to sysfs attributes during device unbind leads t=
o NULL pointer dereference or Use-After-Free.
--

commit e5588eae75b51cb3ffbe74aca6501e040a49e90c
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date:   Mon Sep 7 18:49:59 2026 +0000

    Input: aiptek - validate raw macro indices before updating state
   =20
    aiptek_irq() derives macro key indices directly from tablet reports and
    then uses them to index macroKeyEvents[]. Report types 4 and 5 also save
    the derived value in aiptek->lastMacro and later use that state to
    release the previous key.
   =20
    Validate the raw macro index once before it enters that state machine, =
so
    lastMacro only ever stores an in-range macro key. Keep direct bounds
    checks for report type 6, which reads the macro number from the packet
    body and uses it immediately.
   =20
    Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac=
.cn

> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index baabc51547b83..6210cd99d6291 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but can concurrent access to sysfs attributes
during device unbind lead to a NULL pointer dereference or use-after-free?

Looking at aiptek_disconnect(), the driver data is cleared and the aiptek
structure is freed:

drivers/input/tablet/aiptek.c:aiptek_disconnect() {
    ...
	/* Disassociate driver's struct with usb interface
	 */
	usb_set_intfdata(intf, NULL);
	if (aiptek !=3D NULL) {
		/* Free & unhook everything from the system.
		 */
		usb_kill_urb(aiptek->urb);
		...
		kfree(aiptek);
	}
}

Since the USB driver core removes sysfs files after the disconnect callback
returns, world-readable sysfs handlers like show_tabletToolMode() remain
accessible and can race with the teardown:

drivers/input/tablet/aiptek.c:show_tabletToolMode() {
	struct aiptek *aiptek =3D dev_get_drvdata(dev);

	return sysfs_emit(buf, "%s\n", map_val_to_str(tool_mode_map,
						      aiptek->curSetting.toolMode));
}

If a sysfs reader calls dev_get_drvdata() after usb_set_intfdata(intf, NULL)
has been executed, it will fetch a NULL pointer and dereference it without
checks.

Alternatively, if the reader fetches the pointer just before it is cleared
but accesses it after kfree(aiptek) finishes, couldn't this trigger a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907184959.1567=
893-1-miguelgarciaroman8@gmail.com?part=3D1
