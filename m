From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/3] Input: Add new ABS_WHEEL2 axis
Date: Wed, 2 Nov 2011 17:08:52 -0700
Message-ID: <CAF8JNhLH1JhZb93KQ3mmOVW_HJEXzVN_VoKjfTWHBu2LH+aVJg@mail.gmail.com>
References: <1319247352-2006-1-git-send-email-killertofu@gmail.com>
	<CANRwn3TO6X9ABZJj+O+LW6W8RxB3mf5gpj7UUtCu46AkVtkU+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34497 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1KCAIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 20:08:53 -0400
Received: by ywf7 with SMTP id 7so705635ywf.19
        for <linux-input@vger.kernel.org>; Wed, 02 Nov 2011 17:08:52 -0700 (PDT)
In-Reply-To: <CANRwn3TO6X9ABZJj+O+LW6W8RxB3mf5gpj7UUtCu46AkVtkU+g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>

On Wed, Nov 2, 2011 at 12:46 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> On Fri, Oct 21, 2011 at 6:35 PM, Jason Gerecke <killertofu@gmail.com>=
 wrote:
>> Provides a new ABS_WHEEL2 axis in input.h for use by drivers who
>> need to represent hardware with dual wheels.
>>
>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>> ---
>> =A0include/linux/input.h | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/input.h b/include/linux/input.h
>> index 6d5eddb..117c68d 100644
>> --- a/include/linux/input.h
>> +++ b/include/linux/input.h
>> @@ -768,6 +768,7 @@ struct input_keymap_entry {
>> =A0#define ABS_TILT_X =A0 =A0 =A0 =A0 =A0 =A0 0x1a
>> =A0#define ABS_TILT_Y =A0 =A0 =A0 =A0 =A0 =A0 0x1b
>> =A0#define ABS_TOOL_WIDTH =A0 =A0 =A0 =A0 0x1c
>> +#define ABS_WHEEL2 =A0 =A0 =A0 =A0 =A0 =A0 0x1d
>>
>> =A0#define ABS_VOLUME =A0 =A0 =A0 =A0 =A0 =A0 0x20
>>
>> --
>> 1.7.6
>>
>>
>
> We're coming up on two weeks without activity on this patchset. Any
> comments or ACKs?

Here is my acked-by in case you are waiting for it:

Acked-by: Ping Cheng <pingc@wacom.com>

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
