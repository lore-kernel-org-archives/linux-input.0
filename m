From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch unification
Date: Fri, 7 Jan 2011 10:48:24 +0100
Message-ID: <AANLkTik7--frFi=9avRMeBHAdrOm+YvvGG-FURKy0JX4@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110105174927.GB2146@polaris.bitmath.org>
	<AANLkTikCqufvOgYqqBZLjfmtSdsgyQV4L2HyvEP07+vf@mail.gmail.com>
	<alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
	<20110107011444.GA7262@core.coreip.homeip.net>
	<alpine.LNX.2.00.1101071040470.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43936 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab1AGJsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 04:48:25 -0500
In-Reply-To: <alpine.LNX.2.00.1101071040470.26685@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 7, 2011 at 10:41 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 6 Jan 2011, Dmitry Torokhov wrote:
>
>> > In case the patchset doesn't impose danger of regressions for alre=
ady
>> > existing devices, we could merge this new 'unified' driver only fo=
r newly
>> > supported devices, and finish the unification in 2.6.39.
>>
>> Yep, let's merge the dirver and all new devices in this round and th=
en
>> get ready to convert already supported devices in next window.
>
> Fully agreed, as I have written elsewhere already.
>
> Benjamin, when do you expect to have the patches for .38 ready? The m=
erge
> window is already open, so that I could schedule the merges properly.

I'm doing my best to have the v3 today with only the 3 new devices.
After, we may have to find a consensus for the not ideal
implementation.

Cheers,
Benjamin


>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
