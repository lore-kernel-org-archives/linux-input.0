From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Thu, 19 Nov 2015 11:35:46 -0700
Message-ID: <029e8be19f95a6a1a89d7609de42fb64.squirrel@mungewell.org>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
    <1447345535-2912-2-git-send-email-simon@mungewell.org>
    <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
    <20151119183106.GC24773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:35763 "EHLO
	host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbbKSSfr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 13:35:47 -0500
In-Reply-To: <20151119183106.GC24773@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <edwin@velds.nl>, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, November 19, 2015 11:31 am, Dmitry Torokhov wrote:
> On Thu, Nov 19, 2015 at 02:50:51PM +0100, Jiri Kosina wrote:
>
>> On Thu, 12 Nov 2015, Simon Wood wrote:
>>
>>
>>> When plugged in the Logitech G920 wheel starts with USBID 046d:c261
>>> and behaviors as a vendor specific class. If a 'magic' byte sequence is
>>> sent the wheel will detach and reconnect as a HID device with the
>>> USBID 046d:c262.
>>>
>>>
>>> Signed-off-by: Simon Wood <simon@mungewell.org>
>>>
>>
>> Adding Dmitry to CC.
>>
>>
>> Dmitry, I am planning to take this through my tree together with the
>> rest of the actual HID support for that device if you Ack this.
>
> Hmm, I have an incoming series for xbox that night clash with this... If
> you'll put it in a clean branch off 4.3 I'd pull it and then get more
> changes on top.
>
> Can we also change the subject as it is not about adding a minimal
> support. Something like "Input: xpad - switch Logitech G920 Wheel into HID
> mode"

Will spin a 'v3' with this and Benjamin's suggestion.

Cheers,
Simon.

