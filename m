From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/3] Input: Add new ABS_WHEEL2 axis
Date: Mon, 14 Nov 2011 10:19:20 -0800
Message-ID: <CANRwn3Qa4K45OcVMyx_S9JHyOsR1FXxvMhfnTj6jzQ4soFrvfw@mail.gmail.com>
References: <1319247352-2006-1-git-send-email-killertofu@gmail.com>
	<CANRwn3TO6X9ABZJj+O+LW6W8RxB3mf5gpj7UUtCu46AkVtkU+g@mail.gmail.com>
	<CAF8JNhLH1JhZb93KQ3mmOVW_HJEXzVN_VoKjfTWHBu2LH+aVJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49679 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1KNSTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 13:19:21 -0500
Received: by vws1 with SMTP id 1so5327632vws.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 10:19:21 -0800 (PST)
In-Reply-To: <CAF8JNhLH1JhZb93KQ3mmOVW_HJEXzVN_VoKjfTWHBu2LH+aVJg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Wed, Nov 2, 2011 at 5:08 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Wed, Nov 2, 2011 at 12:46 PM, Jason Gerecke <killertofu@gmail.com>=
 wrote:
>> On Fri, Oct 21, 2011 at 6:35 PM, Jason Gerecke <killertofu@gmail.com=
> wrote:
>>> Provides a new ABS_WHEEL2 axis in input.h for use by drivers who
>>> need to represent hardware with dual wheels.
>>>
>>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>>> ---
>>> =C2=A0include/linux/input.h | =C2=A0 =C2=A01 +
>>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/linux/input.h b/include/linux/input.h
>>> index 6d5eddb..117c68d 100644
>>> --- a/include/linux/input.h
>>> +++ b/include/linux/input.h
>>> @@ -768,6 +768,7 @@ struct input_keymap_entry {
>>> =C2=A0#define ABS_TILT_X =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x1a
>>> =C2=A0#define ABS_TILT_Y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x1b
>>> =C2=A0#define ABS_TOOL_WIDTH =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1c
>>> +#define ABS_WHEEL2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1d
>>>
>>> =C2=A0#define ABS_VOLUME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x20
>>>
>>> --
>>> 1.7.6
>>>
>>>
>>
>> We're coming up on two weeks without activity on this patchset. Any
>> comments or ACKs?
>
> Here is my acked-by in case you are waiting for it:
>
> Acked-by: Ping Cheng <pingc@wacom.com>
>
> Ping
>

Poking this thread again to see if anyone would like to add their two c=
ents.

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
