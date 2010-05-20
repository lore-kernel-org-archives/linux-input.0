From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Thu, 20 May 2010 12:46:17 +0200
Message-ID: <4BF512F9.5010607@euromail.se>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se> <1274213429-22667-2-git-send-email-rydberg@euromail.se> <20100519023727.GA21030@barra.bne.redhat.com> <4BF3D59E.1070801@euromail.se> <20100520001323.GA28116@barra.bne.redhat.com> <20100520071158.GC8080@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:35234 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751954Ab0ETKqx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 06:46:53 -0400
In-Reply-To: <20100520071158.GC8080@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Dmitry Torokhov wrote:
>>>> Will all drivers with ABS_MT_TRACKING_ID use slots? if not, how can I know
>>>> in advance if a device may use slots or not?
>>> Eventually, this might become true, but you are pointing at one of the weaker
>>> points of the current setup. There is no bit field for the EV_SYN events, so
>>> there is no way to know in advance if SYN_MT_SYNC or SYN_MT_SLOT is used. This
>>> could quite possibly be added to the EVIO interface. Meanwhile, the method I use
>>> is to detect the first SYN_MT_SLOT and select parser based on that information.
>> I'd really prefer if there was some way to detect this. While I'm not quite
>> sure how the matching X drivers would look like it's likely that the setups
>> will be different for drivers that support slots and those that don't.
>> e.g. those that don't have slots simply send events as valuators, those that
>> do may split into multiple devices.
>>
>> Doing this at runtime - after the device has been set up is...tricky.
>>
> 
> Right, I think we should try our hardest to allow userspace base
> protocol decoding decisions on device capabilities and not the event
> datastream. What about moving from SYN_MT_SLOT to ABS_MT_SLOT? I think
> it makes more sense since it is not a simple marker but carries data
> (slot number).

I agree, it both makes sense and resolves two issues. Will change.

Cheers,
Henrik

