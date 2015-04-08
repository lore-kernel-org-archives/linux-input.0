From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] alps: Non interleaved V2 dualpoint has separate stick
 button bits
Date: Wed, 08 Apr 2015 19:05:17 +0200
Message-ID: <55255FCD.30407@redhat.com>
References: <1428509092-25794-1-git-send-email-hdegoede@redhat.com> <20150408162430.GA10344@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbbDHRFW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 13:05:22 -0400
In-Reply-To: <20150408162430.GA10344@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org

Hi,

On 08-04-15 18:24, Dmitry Torokhov wrote:
> On Wed, Apr 08, 2015 at 06:04:52PM +0200, Hans de Goede wrote:
>> Non interleaved V2 dualpoint touchpad / stick combos have separate stick
>> button bits in the touchpad packets, if we do not check these then the
>> trackpoint buttons will not work when using the touchpad, and when pressed
>> when the user starts using the touchpad will report a release event even
>> though the button is still pressed.
>>
>> This commit fixes this by checking the separate bits, note that we simply
>> combine the buttons, since the hardware does the same when using the touchpad
>> buttons with the trackpoint, so we do not have enough information to properly
>> separate them.
>
> Hmm, if they are designated as trackstick buttons why don't we report
> them as such (i.e. send button events out of dev2 without movement)?

Because we may then end up with having a button pressed on both
the touchpad and trackstick evdev nodes, and if we then switch to
getting trackstick packets, which have one combined bit for both, and
the bit becomes 0 we end up releasing only one, which is what the commit
message tries to say with: "we do not have enough information to properly
separate them", I actually had an earlier version which did as you suggested,
but that become ugly pretty quickly.

> Also, should we make note of this in alps.txt?

Ack, I'll do a v2 when we've agreement on your first point (and I've
some time).

Regards,

Hans



>
> Thanks!
>
>>
>> Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/mouse/alps.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 6962c26..58987b5 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -243,6 +243,14 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
>>   		return;
>>   	}
>>
>> +	/* Non interleaved V2 dualpoint has separate stick button bits */
>> +	if (priv->proto_version == ALPS_PROTO_V2 &&
>> +	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
>> +		left |= packet[0] & 1;
>> +		right |= packet[0] & 2;
>> +		middle |= packet[0] & 4;
>> +	}
>> +
>>   	alps_report_buttons(dev, dev2, left, right, middle);
>>
>>   	/* Convert hardware tap to a reasonable Z value */
>> --
>> 2.3.4
>>
>
