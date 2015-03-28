From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] Support-Alps-Touchpad-SS4-device
Date: Sat, 28 Mar 2015 09:23:37 +0100
Message-ID: <55166509.2040508@redhat.com>
References: <1427488186-10046-1-git-send-email-masaki.ota@jp.alps.com> <551513E5.10101@redhat.com> <20150328043639.GB9145@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbbC1IXj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 04:23:39 -0400
In-Reply-To: <20150328043639.GB9145@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Masaki Ota <012nexus@gmail.com>, linux-input@vger.kernel.org, masaki.ota@jp.alps.com

Hi,

On 03/28/2015 05:36 AM, Dmitry Torokhov wrote:
> On Fri, Mar 27, 2015 at 09:25:09AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 27-03-15 21:29, Masaki Ota wrote:
>>> From: Masaki Ota <masaki.ota@jp.alps.com>
>>> -Support SS4 device
>>> -SS4 device supports 4Finger and real multi-touch.
>>>
>>> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
>>
>> Thanks looks good now:
>>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>
>> One remark though, you enable: BTN_TOOL_QUINTTAP for v7 touchpads
>> in the alps_set_abs_params_v7_v8 changes. This is the right thing
>> to do as v7 can indeed report 5 fingers being down, something which I
>> missed when I added support for it. But it would be good to have
>> a small note about this in the commit message.
>>
>> Dmitry, can you amend the commit message for this when merging this?
>
> How about we simply split it out, like below?
>

Yes that would be even better :)

Regards,

Hans
