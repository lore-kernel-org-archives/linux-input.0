From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch: fix broken eGalax
Date: Sun, 12 Jun 2011 20:07:49 +0200
Message-ID: <BANLkTikRPnNNVp=78BxvYZzp5A2HbBYEUg@mail.gmail.com>
References: <1307859728-3446-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110612152915.GA18794@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63313 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1FLSHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 14:07:51 -0400
In-Reply-To: <20110612152915.GA18794@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Sun, Jun 12, 2011 at 17:29, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Benjamin,
>
>> With this patch, the detection is made only when the field ContactID
>> has been detected inside the collection.
>
> The patch introduces an order dependence by relying on ContactID
> occuring early on, which seems unnecessary. How about checking for the
> presence of ContactID instead, and simply modify the logic which uses
> last_field_index and last_slot_field?

That's exactly what it does. A touch report has to contain the
contactID field. And each touch is at least in one collection (some
devices send one touch per collection, others only one collection for
the whole report).
The idea is when hardware makers introduce several input mode for
their device, they has to put them in different collections.

The logic behind the last_field_index and last_slot_field are only for
multitouch. So it does not matter if the contactID comes first or last
in the collection, it will set the right index/field.

Cheers,
Benjamin

>
> Thanks,
> Henrik
>
