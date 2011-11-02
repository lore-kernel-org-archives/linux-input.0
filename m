From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Wed, 2 Nov 2011 11:17:10 +0200
Message-ID: <CAOazyz1KrCqm=O-ftttVQEGLbC+R_4LV_tbNaFvw1y1wV+4UMg@mail.gmail.com>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
	<CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
	<20111101124258.744fdba3f854ce81b4e0c8be@studenti.unina.it>
	<CAOazyz1N4QmrC4MN6M532_3m_gVC+7PBBOUU+Mu8Qq7_eX5iZA@mail.gmail.com>
	<20111101201142.af88469abf03d8a9779c4e46@studenti.unina.it>
	<CAOazyz03G1ofwh-GnLDECUqC1qgO0tXzSVjjdwML_JdXZR_9ug@mail.gmail.com>
	<CAOazyz1xOjJxXytp+1JzrDvd3o7f6uySu3fvpxOKz_VSEZwvEA@mail.gmail.com>
	<CAOazyz1NLwD5AA7CuLfwwy=gRyfE9o4zD9bvtsNVSQVjNUm4xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63278 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab1KBJRL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 05:17:11 -0400
Received: by qyk27 with SMTP id 27so8096015qyk.19
        for <linux-input@vger.kernel.org>; Wed, 02 Nov 2011 02:17:10 -0700 (PDT)
In-Reply-To: <CAOazyz1NLwD5AA7CuLfwwy=gRyfE9o4zD9bvtsNVSQVjNUm4xA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Tue, Nov 1, 2011 at 11:55 PM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> OK,
>
> So now we know there is a different in device firmware we can focus, right?
> I run this under windows within kvm.
> Following is the usbmon output of both.
>
> The only difference is:
> ---
> -s 00 05 0009 0000 0000 0 <-- Linux
> +s 00 05 000f 0000 0000 0 <-- Windows
> ---
>
> Or with full text (marker inline: ***********************):
> ---
> -ffff8800b4bf2180 1675152222 S Co:3:000:0 s 00 05 0009 0000 0000 0
> +ffff88012fff13c0 1543840216 S Co:3:000:0 s 00 05 000f 0000 0000 0
> ---
>
> Not sure what is f or 9... :)
>
> All the other is exactly the same while the windows keep communicate after:
> ---
> ffff88012746d480 1675206763 C Ci:3:009:0 0 17 = f2ffff00 00265c31
> e2790003 30801801 8a
> ffff8800b4af0900 1675416597 S Ii:3:009:1 -115:1 49 <
> ffff8800b4af0900 1675422780 C Ii:3:009:1 -2:1 0
> ffff8800b4af0900 1675425228 S Ii:3:009:1 -115:1 49 <
> ffff8800b4af0900 1675429788 C Ii:3:009:1 -2:1 0
> ---
>
> Any idea how to make these similar?
> Thanks!
> Alon.

My mistake.
The first chunk of windows usb capture is actually linux one... as I
assume that device is plugged in and then detected by the qemu, and
forced out for attachment into guest.

So I guess we see the Windows log after the:
---
ffff88012ff6d000 1544118912 S Ii:3:015:1 -115:1 49 <
ffff88012ff6d000 1544125856 C Ii:3:015:1 -2:1 0
ffff88012ff6d000 1544129239 S Ii:3:015:1 -115:1 49 <
ffff88012ff6d000 1544135854 C Ii:3:015:1 -2:1 0
---

Searching for "03f2" which is the sixaxis_set_operational_usb(),
where linux stops communicating with the device, Windows continues to
communicate with the device:

---
ffff880100ee4f00 1545395069 S Ci:3:015:0 s a1 01 03f2 0000 0011 17 <
ffff880100ee4f00 1545395851 C Ci:3:015:0 0 17 = f2ffff00 00265c31
e2790003 30801801 8a
ffff88012ff36cc0 1545625405 S Ci:3:015:0 s 80 06 0100 0000 0040 64 <
ffff88012ff36cc0 1545626883 C Ci:3:015:0 0 18 = 12010002 00000040
4c056802 00010102 0001
ffff880104ee3780 1545630607 S Co:3:001:0 s 23 03 0004 0001 0000 0
ffff880104ee3780 1545630614 C Co:3:001:0 0 0
ffff880104ee3780 1545681201 S Ci:3:001:0 s a3 00 0000 0001 0004 4 <
ffff880104ee3780 1545681230 C Ci:3:001:0 0 4 = 03010000
ffff880104ee3780 1545732200 S Co:3:001:0 s 23 01 0014 0001 0000 0
ffff880104ee3780 1545732203 C Co:3:001:0 0 0
ffff880104ee3780 1545732215 S Ci:3:000:0 s 80 06 0100 0000 0040 64 <
ffff880104ee3780 1545735874 C Ci:3:000:0 0 18 = 12010002 00000040
4c056802 00010102 0001
ffff880104ee3780 1545735904 S Co:3:001:0 s 23 03 0004 0001 0000 0
ffff880104ee3780 1545735911 C Co:3:001:0 0 0
---

I am no expert in USB raw packets... but maybe the answer is within.

Thanks,
Alon.
