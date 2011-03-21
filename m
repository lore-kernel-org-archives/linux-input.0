From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v3 5/5] hid-multitouch: migrate 3M PCT touch screens to hid-multitouch
Date: Mon, 21 Mar 2011 11:13:46 +0100
Message-ID: <AANLkTinAPFnHA=MWbb=Yu7U0AXrxHv2-95M=OequsAL7@mail.gmail.com>
References: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
	<1300454876-5017-6-git-send-email-benjamin.tissoires@enac.fr>
	<20110321090533.GE3784@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1CUKNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 06:13:48 -0400
In-Reply-To: <20110321090533.GE3784@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 21, 2011 at 10:05, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
> On Fri, Mar 18, 2011 at 02:27:56PM +0100, Benjamin Tissoires wrote:
>> This patch merges the hid-3m-pct driver into hid-multitouch.
>> To keep devices working the same way they used to with hid-3m-pct,
>> we need to add two signal/noise ratios for width and height.
>> We also need to work on width/height to send proper
>> ABS_MT_ORIENTATION flag.
>>
>> Importing 3M into hid-multitouch also solved the bug in which
>> devices handling width and height in their report descriptors
>> did not show ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> Reviewed-by: St=E9phane Chatty <chatty@enac.fr>
>> ---
>
> The patch _looks_ good, but I have problems getting this to work on a
> 3M2256. What devices were this one tested on so far?

Hi Henrik,

I tested it against 3M1968. I'll try to have it again to make more test=
ing.
What symptoms do you have?

=46or the current time, I'll redo the commit message of the previous on=
e
and then eventually we can slip this one for the next round.

And many thanks for the review of the patch series.

Cheers,
Benjamin

>
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
