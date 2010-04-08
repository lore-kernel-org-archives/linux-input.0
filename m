From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] input: mt: introduce MT event slots
Date: Thu, 08 Apr 2010 17:23:53 -0400
Message-ID: <4BBE4969.60802@seas.upenn.edu>
References: <1270685590-2204-1-git-send-email-rydberg@euromail.se> <87tyrmiqw2.fsf@troilus.org> <4BBDA555.1020003@euromail.se> <4BBE2B4D.9040808@seas.upenn.edu> <4BBE3BC4.2030503@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBE3BC4.2030503@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/08/10 16:25, Henrik Rydberg wrote:
> Rafi Rubin wrote:
>> On 04/08/2010 05:43 AM, Henrik Rydberg wrote:
>>> Michael Poole wrote:
>>> [...]
>>>>
>>>> How would the slot number for a contact be chosen?
>>>
>>> The device driver determines how to use the slots. The driver calls
>>> input_mt_slot(dev, slot), sends the data for the slot, picks another
>>> slot, and
>>> repeats.
>>>
>>
>> Is there any particular downside to defaulting to implicit slot ids?
> 
> Yes. The device driver should not have to update every slot between
> synchronizations, or the point would be lost.
> 
>> For drivers/hardware that don't handle tracking, SYN_MT_REPORT could
>> just result in dev->slot++ and a SYN_REPORT resets dev->slot to 0;
> 
> Drivers that do not handle tracking should not use the slots at all. The slot
> concept requires that whatever gets communicated over it is identifiable, or
> else it would not be possible to send changes. Drivers without tracking
> capabilities should stick to the current MT protocol, for which it was designed.

That's unfortunate.

I think tracking upsets are generally quite rare (at least for the n-trig
hardware), and we would see most of the benefit of jitter and bandwidth
reduction even if we use contact ordering for slots.  Tracking upsets would
still flow downstream, a large state change should cause the slot to emit the
new position.

I was also hoping the slotting mechanism might be a good place to inject generic
tracking support later.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAku+SWcACgkQwuRiAT9o60894wCg1lQIzcFgmUNqUpiKJSDigxNE
QVcAn3YylXnlNaieGTJyQ2UblpqR5X7q
=EokA
-----END PGP SIGNATURE-----
