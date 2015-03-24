From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Tue, 24 Mar 2015 08:27:29 +0100
Message-ID: <551111E1.6090303@redhat.com>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com> <550FFB84.6000609@redhat.com> <201503231802.28977@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbbCXHaC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 03:30:02 -0400
In-Reply-To: <201503231802.28977@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Santiago Gala <sgala@apache.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 23-03-15 18:02, Pali Roh=C3=A1r wrote:
> On Monday 23 March 2015 12:39:48 Hans de Goede wrote:
>> Hi,
>>
>> On 22-03-15 14:46, Pali Roh=C3=A1r wrote:
>>> This patch adds detection of trackstick for v7 protocol
>>> devices. Code in this patch is used in official Dell
>>> touchpad linux drivers for Dell models: Dell Latitude
>>> E5250/5250, E5450/5450, E5550/5550
>>>
>>> Detection code and base reg for alps v3 rushmore and v7
>>> devices is exacly same.
>>>
>>> Also user in bug
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D94801 reported
>>> that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad
>>> device without trackstick and kernel reports to userspace
>>> also redundant trackstick device.
>>>
>>> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>>
>> Looks good, but has this been tested on a laptop which
>> actually has a v7 pad + trackstick? I would like to see this
>> actually tested on at least one such laptop before it gets
>> merged.
>>
>> Regards,
>>
>> Hans
>>
>
> I did not tested my patch on any v7 touchpad-only laptop.

Ah, but I'm not worried about testing on a touchpad-only laptop,
we are already reporting a trackpoint there even though there
is none. I'm worried about breaking existing v7 using laptops
which actually have a trackstick.

So if this is tested on a v7 laptop with trackstick, and it
does not break the trackstick then that is good enough for me.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
