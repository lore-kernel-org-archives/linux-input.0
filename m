From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Tue, 25 May 2010 21:52:29 +0200
Message-ID: <4BFC2A7D.50501@euromail.se>
References: <1274788379-11026-1-git-send-email-rydberg@euromail.se> <20100525173446.GA4634@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:38298 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758855Ab0EYTx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 May 2010 15:53:27 -0400
In-Reply-To: <20100525173446.GA4634@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Dmitry Torokhov wrote:
> Hi Henrik,
> 
> On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydberg wrote:
>> These patches are in response to the discussion about input state
>> retrieval.
>>
>> The current EVIOCGABS method does not work with MT slots.  These
>> patches provides a mechanism where a slot is first selected via a call
>> to EVIOCSABS, after which the corresponding MT events can be extracted
>> with calls to EVIOCGABS.
>>
>> The symmetric operation, to set the MT state via EVIOCSABS, seems to
>> violate input data integrity, and is therefore not implemented.
>>
> 
> This looks sane, however the question remains - is there any users for
> this data? Like I mentioned, I can see the need to fetch state of
> switches and ranges of absolute axis, and even non-multitouch ABS values
> (due to the fact that some input devices, like sliders, may stay in a
> certain position for long periods of time), but I expect multitouch data
> to be "refreshed" very quickly.
> 
> Thanks.
> 

There were some voices addressing this issue, and the patches are here,
available for whomever to pick up. Drop them if you wish, I will not send them anew.

Cheers,
Henrik
