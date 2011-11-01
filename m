From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 22:14:10 +0200
Message-ID: <CAOazyz1xOjJxXytp+1JzrDvd3o7f6uySu3fvpxOKz_VSEZwvEA@mail.gmail.com>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
	<CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
	<20111101124258.744fdba3f854ce81b4e0c8be@studenti.unina.it>
	<CAOazyz1N4QmrC4MN6M532_3m_gVC+7PBBOUU+Mu8Qq7_eX5iZA@mail.gmail.com>
	<20111101201142.af88469abf03d8a9779c4e46@studenti.unina.it>
	<CAOazyz03G1ofwh-GnLDECUqC1qgO0tXzSVjjdwML_JdXZR_9ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44112 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab1KAUOM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 16:14:12 -0400
Received: by vcge1 with SMTP id e1so6077243vcg.19
        for <linux-input@vger.kernel.org>; Tue, 01 Nov 2011 13:14:11 -0700 (PDT)
In-Reply-To: <CAOazyz03G1ofwh-GnLDECUqC1qgO0tXzSVjjdwML_JdXZR_9ug@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Tue, Nov 1, 2011 at 9:24 PM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>> and is it an _original_ controller?
>
> I am sure hope so!
> How can I determine?
> Written Sony all over.

Well, found this[1] thread.

This is gasia copy, it has some differences...

One of them relates to sdp:
#ifdef GASIA_GAMEPAD_HACKS
    req.vendor  = 0x054c;
    req.product = 0x0268;
    req.version = 0x0100;
    req.parser  = 0x0100;

    strcpy(req.name, "Gasia Gamepad experimental driver");
#else
    get_sdp_device_info(&addr_src, &addr_dst, &req);
#endif

And I guess the other is at initialization time.
How can I find this?

[1] http://ubuntuforums.org/showthread.php?t=1190061&page=93
