From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Tue, 10 Nov 2015 22:42:44 +0100
Message-ID: <CADbOyBQYNsbuzdZQpLSqoakiG1ea-5o4HRcjEc0_X0R_YoKd1w@mail.gmail.com>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
	<CADbOyBTM0dKYik6uHAsA102hwAbhWeXM+QrFba11p+ABoMxi+w@mail.gmail.com>
	<46665760.4161715.1447055452531.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34226 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbKJVmq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2015 16:42:46 -0500
In-Reply-To: <46665760.4161715.1447055452531.JavaMail.zimbra@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <btissoir@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Nov 9, 2015 at 8:50 AM, Benjamin Tissoires <btissoir@redhat.com> wrote:
>
> ----- Original Message -----
>> From: "Elias Vanderstuyft" <elias.vds@gmail.com>
>> To: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
>> Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "David Herrmann" <dh.herrmann@gmail.com>, "Peter Hutterer"
>> <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
>> Sent: Sunday, November 8, 2015 11:55:04 AM
>> Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and UI_ABS_SETUP ioctl
>>
>> I.e., why not:
>>
>> struct uinput_setup {
>>         char name[UINPUT_MAX_NAME_SIZE];
>>         struct input_id id;
>>         __u32 ff_effects_max;
>> };
>>
>> In case you would change this, also make sure to change the order in
>> the documentation of UI_DEV_SETUP.
>>
>
> Works for me.
> Dmitry, how do you want to handle this change? Me re-sending the whole series or you applying the change directly on your tree?

If this is too much of a hassle, please leave it as it was, I was just
being pedantic ;-)

Cheers,
Elias
