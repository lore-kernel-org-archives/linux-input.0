From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Linux-v4.6-rc2] atkbd serio0: Unknown key pressed (translated
 set 2, code 0xa8 on isa0060/serio0).
Date: Wed, 6 Apr 2016 10:08:58 -0700
Message-ID: <CAKdAkRRT=Vq_X9Un3Zk-an42WR+ECKt-h6JxALK=4MkJkdgnow@mail.gmail.com>
References: <CA+icZUV0MGYme3EvLwYaW7HaAdKq7KQm6jgbcy58z4Vk3+n7qg@mail.gmail.com>
	<CA+icZUVZ05ri=Vs6UGWN0ks74_R2Q48u0=xoh2LSFwSLhpfabg@mail.gmail.com>
	<CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35794 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbcDFRI7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2016 13:08:59 -0400
In-Reply-To: <CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, USB list <linux-usb@vger.kernel.org>

On Wed, Apr 6, 2016 at 3:27 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Wed, Apr 6, 2016 at 11:35 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On Wed, Apr 6, 2016 at 11:27 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> Hi,
>>>
>>> I cannot use cursor up and down on my notebook and see this in my dmesg.
>>>
>>> [  685.425634] atkbd serio0: Unknown key pressed (translated set 2,
>>> code 0xa8 on isa0060/serio0).
>>> [  685.425648] atkbd serio0: Use 'setkeycodes e028 <keycode>' to make it known.
>>>
>>> Known issue?
>>>
>>> Do you need more input?
>>>
>>> Linux-config and dmesg-output attached.
>>>
>>> Regards,
>>> - Sedat Dilek -
>>
>> Attached is output of...
>>
>>    $ xmodmap -pke > /tmp/xmodmap-pke.txt
>>
>
> [ CC (USB)HID folks ]
>
> I forgot to tell that I have some patches on top of vanilla Linux v4.6-rc2.
>
> Dropping the patches from <jikos/hid.git#for-4.6/upstream-fixes> makes
> the issue go away.
> Unsure what is the cause.

Hmm, this is quite curious, none of the recent patches in
for-4.6/upstream-fixes touches atkbd. I'd be very interested in which
one exactly causes this.

Thanks.

-- 
Dmitry
