Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7357469847;
	Tue,  4 Aug 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851990; cv=none; b=ERrGjrX0QXxppDXREi/y2LnilNJv9+rx8KBVi28X4a525+TKRb6NnvGS9GWABkmIF7uVtyDn46NPRDj1gky7Kf4A5IdjcAwNbeDkuJqWN+6QYRZpyBaTzzoCDMGxi5C/l+Jza69vqIZjn6RHawFGzycLs4mGaXSRWUsgWDKxLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851990; c=relaxed/simple;
	bh=G/UwZyCHgXxZ/VUx/L5upk+G2jRSJD+tvu3keAXzAZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv3RBmg4hdVtFGlHh+S/gaE7QqHFFOA0Y5MTi0OZK1+yquFf1nnP5/+9dvDMRqezxUaHGWYM0rkWlzb97wJKz2UZhNDH4poM/xKMLr1i2qMfE3MaR3kX9RI2Xo4Wi0VmTEUcaqBCcizfl26NNa0rZLFqMgzB8Thy7kJqOK2fa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=adwZITr8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="adwZITr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785851984; x=1786456784; i=deller@gmx.de;
	bh=txx9QULAF9BwNOoonQymz7S7X5Jwuy+tasHhB9AbdTQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=adwZITr8LxqVOcQ/KrX/v3aAdxBqhdebuBLIcyrFiWAFoUoozp68sNsB9jWZxNJM
	 cK05RafR9rhnTSIuFaJLRk8Dw/9fAGCg6dHJDFjiFT1CCyWUiSCet9D+Yb3hM/NHL
	 d4y/6bZpP8z1XbZowH2qTJFW925rfncekCqEOvvxLkAaguPPuXgJ6TrxOffx+K+Md
	 l/FHfxEiGc8dLn/EkfRKgJzPC/eCsK+wE+4uaZ+fiRrr1D4lMg4VKUBsd6D27yo7+
	 7alXtjBfMnvh5QNut8wtGJgZxv9d2x4KpMp64JDN9tGhLpE2TFW01y8xoA1I/GAih
	 ypzCa0xrPDQpI5DSdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDysm-1wjWSB3VBM-0077Pv; Tue, 04
 Aug 2026 15:59:43 +0200
Message-ID: <4346aa03-1d8c-4a9a-bad3-0c4186dbc65d@gmx.de>
Date: Tue, 4 Aug 2026 15:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via device
 property
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-parisc@vger.kernel.org
References: <am_9BvmZu9g4RlUM@google.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <am_9BvmZu9g4RlUM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0DWnPdsz3MBMuBPyubCOkRVjQRaUbbxaUWax9Vxt509zCXSiKj9
 Ojz7Jd0rV/PnK13O6kRhGVZU+yYbK+2vQv5/wmA6g30HSBCNwf77/Rkg2Q3T9dTyjZiSvJu
 fOvnn91ly3u7uCiKCowjgwadUxAbh40mqnJYqb8OiSAtaz7l3BURlj/47zBPQqW7V9PjVPB
 Kbu+0q6EZEEASy07/ZN8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qr0gcTZMSaU=;eA1dF4sTxL8jXjJSo4870976yJI
 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

Hi Dmitry,

On 8/3/26 06:39, Dmitry Torokhov wrote:
> Instead of hardcoding PA-RISC specific keycode tables into atkbd via
> compile-time inclusion, have the gscps2 PS/2 port driver attach a
> linux,keymap software node device property to the serio device when
> a keyboard port is registered. This allows atkbd to dynamically fetch
> and apply the custom keymap when probing the port using generic
> firmware property helpers, removing architecture-specific hacks from
> generic keyboard driver code.
>=20
> Co-locate the keymap definitions with the serio port driver by moving
> hpps2atkbd.h from drivers/input/keyboard/ to drivers/input/serio/.
> To handle the five conflicting keys on RDI PrecisionBook laptops without
> runtime model string checks or duplicate keymap tables in memory, add
> CONFIG_SERIO_GSCPS2_RDI_KEYCODES to drivers/input/serio/Kconfig and
> resolve the conflicting keycodes at compile time via preprocessor
> macros.
>=20
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>=20
> v2:
> - instead of using device_create_managed_software_node() that has issue
>    if serio port is unregistered before it is fully registered, switch t=
o
>    creating software node when initializing the driver and attach it to
>    the serio port
> - added keycodes lost in movement (0x92 - silently ignored, 0xca -
>    KEY_KPSLASH, 0xda - KEY_KPENTER).
>=20
>   drivers/input/keyboard/Kconfig      |  38 ---------
>   drivers/input/keyboard/atkbd.c      |   8 --
>   drivers/input/keyboard/hpps2atkbd.h | 110 -------------------------
>   drivers/input/serio/Kconfig         |  27 +++++++
>   drivers/input/serio/gscps2.c        |  47 ++++++++---
>   drivers/input/serio/hpps2atkbd.h    | 120 ++++++++++++++++++++++++++++
>   6 files changed, 184 insertions(+), 166 deletions(-)

Thanks for cleaning it up.
Your solution is much cleaner and gets the hacks away.
I'll test and report back very soon.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index bf9b993f5733..cd1bca57fda3 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -22,20 +22,19 @@
>    *                 was usable/enabled ?)
>    */
>  =20
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/slab.h>
> -#include <linux/serio.h>
> +#include <linux/delay.h>
>   #include <linux/input.h>
>   #include <linux/interrupt.h>
> -#include <linux/spinlock.h>
> -#include <linux/delay.h>
> +#include <linux/io.h>
>   #include <linux/ioport.h>
> +#include <linux/property.h>
> +#include <linux/serio.h>
>  =20
>   #include <asm/irq.h>
> -#include <asm/io.h>
>   #include <asm/parisc-device.h>
>  =20
> +#include "hpps2atkbd.h"

Doesn't it makes sense to move the contents of the new file
"hpps2atkbd.h" directly in here instead of keeping in own header?

Helge
