From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] input/alps: Allow touchsticks to report pressure
Date: Fri, 10 Jun 2016 12:57:12 +0200
Message-ID: <0d0c8090-8d08-4c81-7842-02093ef2c05e@redhat.com>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
 <1464436862-2649-4-git-send-email-ben@smart-cactus.org>
 <625ba798-bec9-7dfe-ba9d-55a8c3ba347e@redhat.com>
 <871t45xs1n.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbcFJK5U (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2016 06:57:20 -0400
In-Reply-To: <871t45xs1n.fsf@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Peter Hutterer <peter.hutterer@redhat.com>

Hi,

On 10-06-16 12:21, Ben Gamari wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>
>> Hi,
>>>
>>> @@ -2996,6 +2999,10 @@ int alps_init(struct psmouse *psmouse)
>>>
>>>  		input_set_capability(dev2, EV_REL, REL_X);
>>>  		input_set_capability(dev2, EV_REL, REL_Y);
>>> +		if (priv->flags & ALPS_DUALPOINT_WITH_PRESSURE) {
>>> +			input_set_capability(dev2, EV_ABS, ABS_PRESSURE);
>>> +			input_set_abs_params(dev2, ABS_PRESSURE, 0, 127, 0, 0);
>>> +		}
>>>  		input_set_capability(dev2, EV_KEY, BTN_LEFT);
>>>  		input_set_capability(dev2, EV_KEY, BTN_RIGHT);
>>>  		input_set_capability(dev2, EV_KEY, BTN_MIDDLE);
>>
>> This seems wrong, reporting ABS_PRESSURE on a relative device. And yes, this
>> really is a relative device (it sends repeated delta events when you
>> keep pushing at the same force, rather then sending a single coordinate
>> value).
>>
>> Maybe we need a REL_PRESSURE for cases like this ?
>>
> Fair enough. However, if such a thing were added how would one specify
> the range of the value (which seems necessary for the pressure to have
> any meaning whatsoever)?

Good question, adding Peter Hutterer to the Cc.

Peter, some of the newer alps pointing sticks can also report pressure,
which is somewhat of an ill fit for the relative events interface
otherwise used with pointing sticks, do you have any suggestions on
how to deal with this ?

Regards,

Hans
