From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Mon, 24 May 2010 19:48:00 +0200
Message-ID: <4BFABBD0.9020202@euromail.se>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se> <20100524155901.GB3182@core.coreip.homeip.net> <AANLkTin9ahtqL7jrUP4C0zF9-P3rUg7ktN93-hcqdDnj@mail.gmail.com> <201005241021.02731.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39309 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757262Ab0EXRsU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 13:48:20 -0400
In-Reply-To: <201005241021.02731.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Dmitry Torokhov wrote:
[...]
>>>> I think we need to add an ioctl to enable user land driver/client to
>>>> signal the kernel driver to send all events without filtering, just
>>>> once. Hot-plugged devices and X driver starts after user has contacted
>>>> with the device are two examples that the client would miss filtered
>>>> events.
>>>>
>>>> Dmitry, do you think it is a valid suggestion?
>>> What about using EVIOCGKEY/EVIOCGSW/EVIOCGABS?
>> Those EVIOCs only give us the static values (max/min/supported keys,
>> etc.).  We need their dynamic input data here, the actual x, y,
>> button, pressure, etc. Am I missing something about those EVIOs?
>>
> 
> Yes you are ;) Supported events are reported via EVIOCGBIT, EVIOCGKEY and
> EVIOCGSW will return current state of keys/switches. As far as EVIOCGABS
> goes, it also returns, besides min/max/etc, last reported _values_ of the
> ABS_* events.
> 

Ping is not alone. :-)

But it does not work for MT events -- yet.

Henrik

