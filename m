From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Thu, 20 May 2010 09:08:58 +0200
Message-ID: <4BF4E00A.30206@euromail.se>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>	 <1274213429-22667-2-git-send-email-rydberg@euromail.se> <AANLkTikpmYwEYh5Dh-p3478cDMVo9hXOsDkt54ltHW6J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:43230 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752980Ab0ETHJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 03:09:11 -0400
In-Reply-To: <AANLkTikpmYwEYh5Dh-p3478cDMVo9hXOsDkt54ltHW6J@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Ping Cheng wrote:
> Hi Henrik,
> 
> I am trying to link the protocol to the actual multi-touch devices in
> my "mind". Hope it helps you to point out the mismatch between my
> imagination and the protocol.  Please see details in line.
> 
> Ping

Hi Ping,

first out, thank you for your detailed analysis, it aids in removing ambiguities
 and defining the borders of the protocol.

> Am I right in thinking that SYN_MT_SLOT represents to the actual touch
> area/finger on the surface? There could be more than one (x,y) (a few
> points that form an irregular shape) that represents one finger.  The
> following example shows that slot 0 (finger 1) touched three points on
> the surface while slot 1 (finger 2) only has one point reported:
> 
> +   SYN_MT_SLOT 0
> +   ABS_MT_TRACKING_ID 45
> +   ABS_MT_POSITION_X x[0]
> +   ABS_MT_POSITION_Y y[0]
> +   ABS_MT_TRACKING_ID 46
> +   ABS_MT_POSITION_X x[1]
> +   ABS_MT_POSITION_Y y[1]
> +   ABS_MT_TRACKING_ID 47
> +   ABS_MT_POSITION_X x[2]
> +   ABS_MT_POSITION_Y y[2]
> +   SYN_MT_SLOT 1
> +   ABS_MT_TRACKING_ID 30
> +   ABS_MT_POSITION_X x[3]
> +   ABS_MT_POSITION_Y y[3]
> +   SYN_REPORT
> 

It helps to think of both TRACKING_ID and BLOB_ID as labels of a single
identified contact which occupies one slot. To represent a set of contacts as an
entity, one needs to add a label to the slot, representing that entity. As
pointed out in a later reply by Peter, the BLOB_ID serves this purpose well. The
name is slightly unfortunate, being a bit too generic. Let us use this
discussion to pin down a more exact definition:

ABS_MT_BLOB_ID is a label which groups contacts in close relation to each other,
such as a hand.

With this in mind, the sequence becomes

SYN_MT_SLOT 0
ABS_MT_BLOB_ID 11
ABS_MT_TRACKING_ID 45
ABS_MT_POSITION_X x[0]
ABS_MT_POSITION_Y y[0]
SYN_MT_SLOT 1
ABS_MT_BLOB_ID 11
ABS_MT_TRACKING_ID 46
ABS_MT_POSITION_X x[1]
ABS_MT_POSITION_Y y[1]
SYN_MT_SLOT 2
ABS_MT_BLOB_ID 11
ABS_MT_TRACKING_ID 47
ABS_MT_POSITION_X x[2]
ABS_MT_POSITION_Y y[2]
SYN_MT_SLOT 3
ABS_MT_BLOB_ID 89
ABS_MT_TRACKING_ID 30
ABS_MT_POSITION_X x[3]
ABS_MT_POSITION_Y y[3]
SYN_REPORT

Here, we are looking at one blob (11) consisting of three contacts (45, 46, 47),
and another blob (89) consisting of one contact (30).

[...]
> So, an EVIO for X driver to retrieve the number of SLOTs would be very
> helpful.  Something like the following would do the work:
> 
> input_set_abs_params(input_dev, ABS_MT_SLOT, 0, 12, 0, 0);
> 
> which tells the user land clients that they can expect up to 13 touch areas.

The SYN_MT_SLOT is a synchronization control event (EV_SYN), so it would require
a different way to report value ranges, but the idea is sound. I will think
about how to achieve this.

>> +The main difference between the raw type A protocol and the higher level
>> +type B slot protocol lies in the usage of identifiable contacts. The slot
>> +protocol requires the use of the ABS_MT_TRACKING_ID,
> 
> With what I said above, I think ABS_MT_TRACKING_ID is not the unique
> identifier for type B protocol. It is the fact that we can identify
> individual touch areas and use ABS_MT_SLOT to report them that makes
> it a type B event.

This is correct, but the TRACKING_ID is strong evidence that the device is
capable of identifying contacts.

>> ABS_MT_TRACKING_ID, either provided by the
>> +hardware of computed from the raw data [5].
>                    ^^ or  (is it?)
> 
> I agree with this ABS_MT_TRACKING_ID definition.  I would think something like:
> 
> input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0, 47, 0, 0);
> 
> which tells the clients that total of 48 points are tracked, would be helpful.

Agreed.

> Another topic that may be irrelevant to this patch is the filter. With
> the use of ABS_MT_TRACKING_ID, a filter can be applied to discard the
> useless repeated points or less than a certain number of points
> movement.

As pointed out by Rafi in a later post, this is indeed one of the major points
of the slot protocol. The filtering details can be found in the patch
accompanying this documentation.

Cheers,
Henrik
