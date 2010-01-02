From: Wayne Thomas <waynethomas69@gmail.com>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
	quirky remote
Date: Sat, 2 Jan 2010 10:52:22 +0100
Message-ID: <3711715e1001020152s626739daw6cdf2d7742a0d959@mail.gmail.com>
References: <3711715e0912310013u25e921cbqe6abb7c1621109e@mail.gmail.com>
	 <20100102025312.GC5788@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33405 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0ABJwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Jan 2010 04:52:24 -0500
In-Reply-To: <20100102025312.GC5788@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On Sat, Jan 2, 2010 at 3:53 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Wayne,
>
> On Thu, Dec 31, 2009 at 09:13:22AM +0100, Wayne Thomas wrote:
>> HID: driver for BTC "Emprex 3009URF III Vista MCE Remote" quirky rem=
ote
>>
>> The Behavior Tech. Computer Corp. (BTC) remote branded as "Emprex 30=
09URF III
>> Vista Remote Controller" uses non-standard mappings for all of its '=
special
>> purpose' keys (0xffbc usage page). =A0Applies cleanly to 2.6.30 and =
2.6.32
>> (other versions not tested).
>> scripts/scriptpatch.pl reports 13 styling errors in hid-btc.c
>> ("break;" should be on trailing lines)
>> but have not changed them to maintain styling consistency with exist=
ing drivers.
>>
>
> I believe that this kind of mapping adjustment can be done via UDEV/H=
AL
> key remapping facilities, without need for the kernel patch.
>
> Thanks.
>
> --
> Dmitry
>

I'll look into what you have suggested.  The issue is identical to
that of the TopSeed remote, which is why I used this method.  If this
is the case I assume that the topseed driver (and any others) should
also be removed?

Cheers
Wayne
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
