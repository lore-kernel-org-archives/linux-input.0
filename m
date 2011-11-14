From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Mon, 14 Nov 2011 14:32:44 +0200
Message-ID: <CAOazyz1EbaDdHi1hgeHqSQq=g6Sf0_4ph2paL0=oJ9+sjWq1vg@mail.gmail.com>
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
	<CAOazyz1KrCqm=O-ftttVQEGLbC+R_4LV_tbNaFvw1y1wV+4UMg@mail.gmail.com>
	<CAOazyz13OeA7-mo130+JK8JMLy0AhLgeO5m8eM9t4yBQ8LPtcQ@mail.gmail.com>
	<20111114130802.baca1cf201cac865f167eb06@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38286 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1KNMcp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 07:32:45 -0500
Received: by vcbgb30 with SMTP id gb30so403366vcb.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 04:32:45 -0800 (PST)
In-Reply-To: <20111114130802.baca1cf201cac865f167eb06@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Mon, Nov 14, 2011 at 2:08 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
>
> On Thu, 10 Nov 2011 00:16:54 +0200
> Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>
> > Got real sony device.
> > USB is working!
> > Thanks for your help.
>
> Ah, so it was a (not so much) compatible controller, wasn't it?
>
> Can you test the attached patch to see it it makes the non-Sony devic=
e
> work too? Some other user reported a compatible controller not sendin=
g
> events, and it turned out that to be made operational it was expectin=
g
> the interrupt endpoint to be queried at least once. I don't see this
> behavior in USB dumps of communication with PS3 tho.
>
> > Is there anywhere organized I can fetch the bluez patches?
> >
>
> I will send them to you off-list.
>
> Thanks,
> =C2=A0 Antonio

Thanks!
But I returned my devices, as found out that even if fix USB the
bluetooth LCP won't work correctly.

Alon.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
