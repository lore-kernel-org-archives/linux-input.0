From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] alps: Non interleaved V2 dualpoint has separate stick
 button bits
Date: Thu, 09 Apr 2015 14:49:10 +0200
Message-ID: <55267546.6050408@redhat.com>
References: <1428509092-25794-1-git-send-email-hdegoede@redhat.com> <20150408162430.GA10344@dtor-ws> <55255FCD.30407@redhat.com> <20150408173815.GB14186@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbbDIMtN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Apr 2015 08:49:13 -0400
In-Reply-To: <20150408173815.GB14186@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org

Hi,

On 08-04-15 19:38, Dmitry Torokhov wrote:
> On Wed, Apr 08, 2015 at 07:05:17PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 08-04-15 18:24, Dmitry Torokhov wrote:
>>> On Wed, Apr 08, 2015 at 06:04:52PM +0200, Hans de Goede wrote:
>>>> Non interleaved V2 dualpoint touchpad / stick combos have separate stick
>>>> button bits in the touchpad packets, if we do not check these then the
>>>> trackpoint buttons will not work when using the touchpad, and when pressed
>>>> when the user starts using the touchpad will report a release event even
>>>> though the button is still pressed.
>>>>
>>>> This commit fixes this by checking the separate bits, note that we simply
>>>> combine the buttons, since the hardware does the same when using the touchpad
>>>> buttons with the trackpoint, so we do not have enough information to properly
>>>> separate them.
>>>
>>> Hmm, if they are designated as trackstick buttons why don't we report
>>> them as such (i.e. send button events out of dev2 without movement)?
>>
>> Because we may then end up with having a button pressed on both
>> the touchpad and trackstick evdev nodes, and if we then switch to
>> getting trackstick packets, which have one combined bit for both, and
>> the bit becomes 0 we end up releasing only one, which is what the commit
>> message tries to say with: "we do not have enough information to properly
>> separate them", I actually had an earlier version which did as you suggested,
>> but that become ugly pretty quickly.
>
> Oh, right... Do we get touchpad packets if both trackpoint and touchpad
> buttons are pressed and trackpoint is moved (bit no contacts on the pad)?

No, if the user does:

1) Press touchpad button
2) Move trackpoint

We get:

1) Touchpad packet with touchpad button pressed bit set
2) Trackpoint packets with "a button pressed" bit set and
movement

> Anyway, I guess it is older hardware and just mixing buttons is fine, no
> need to be super-fancy.

Ack, I'll do a v2 adding the requested documentation update tomorrow.

Regards,

Hans
