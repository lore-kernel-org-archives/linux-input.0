From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Mon, 24 May 2010 10:33:05 -0700
Message-ID: <AANLkTinh9OARrU-Lk9D_c-hP8c4Ke0OvWUqJltd7hDEo@mail.gmail.com>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>
	 <20100524155901.GB3182@core.coreip.homeip.net>
	 <AANLkTin9ahtqL7jrUP4C0zF9-P3rUg7ktN93-hcqdDnj@mail.gmail.com>
	 <201005241021.02731.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35379 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab0EXRdI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 13:33:08 -0400
In-Reply-To: <201005241021.02731.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

On Mon, May 24, 2010 at 10:21 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Monday 24 May 2010 10:06:15 am Ping Cheng wrote:
>> >> This topic is outside of the _MT_ protocol discussion.
>> >>
>> >> However, it is indeed an issue with all filtered input events, bo=
th
>> >> for MT and regular ones.
>> >>
>> >> I think we need to add an ioctl to enable user land driver/client=
 to
>> >> signal the kernel driver to send all events without filtering, ju=
st
>> >> once. Hot-plugged devices and X driver starts after user has cont=
acted
>> >> with the device are two examples that the client would miss filte=
red
>> >> events.
>> >>
>> >> Dmitry, do you think it is a valid suggestion?
>> >
>> > What about using EVIOCGKEY/EVIOCGSW/EVIOCGABS?
>>
>> Those EVIOCs only give us the static values (max/min/supported keys,
>> etc.). =A0We need their dynamic input data here, the actual x, y,
>> button, pressure, etc. Am I missing something about those EVIOs?
>>
>
> Yes you are ;) Supported events are reported via EVIOCGBIT, EVIOCGKEY=
 and
> EVIOCGSW will return current state of keys/switches. As far as EVIOCG=
ABS
> goes, it also returns, besides min/max/etc, last reported _values_ of=
 the
> ABS_* events.

Oh, My God! I should have listened to Mark Twain :).

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
