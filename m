From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] Input: gpio_keys - Allow suppression of input
 events for wakeup button presses
Date: Wed, 1 Nov 2017 16:27:16 +0100
Message-ID: <7ca65f7f-60c4-04b7-2990-3037216f2be0@redhat.com>
References: <20171030174050.30375-1-hdegoede@redhat.com>
 <20171030174050.30375-3-hdegoede@redhat.com>
 <20171030181706.huwka5foqxparsiq@dtor-ws>
 <b6016f99-a313-164b-9e45-8611982d03a1@redhat.com>
 <20171030204809.mciyapkfqlihg3jd@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdKAP1U (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Nov 2017 11:27:20 -0400
In-Reply-To: <20171030204809.mciyapkfqlihg3jd@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi,

On 30-10-17 21:48, Dmitry Torokhov wrote:

<snip>

>> So both for consistency and because a timeout is racy I believe
>> that having the power button not send KEY_POWER after resume is
>> the proper solution here.
>>
>> Note that I've made this configurable and that soc_button_array
>> is the only driver getting this enabled, making the power-button
>> behavior on PC like devices consistent, without impacting any
>> other devices.
> 
> I'd rather we did not make assumption in the kernel about behavior of
> userspace we happen to run on. The "PC like" devices change all the
> time, and one could even say that failure to deliver events by ACPI
> drivers on resume is a bug.
> 
> Please teach userspace how to handle events coming during resume phase
> and what to do about them, and be done with it. One option is to say (in
> whatever implements your power policy) "we want to ignore next KEY_POWER
> event for the next NNN msec". You will need it ianyway if you decide to
> put your userspace onto, let's say, ASUS Flip (an ARM device using
> gpio-keys for power button and volume up/down buttons on the side of the
> case).

Ok, I've written and submitted patches for this for gnome:
https://bugzilla.gnome.org/show_bug.cgi?id=789771

That still leaves the same issue for KDE, XFCE, mate, etc. though,
note I've no intention of fixing those.

Regards,

Hans
