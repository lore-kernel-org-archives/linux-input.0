From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 1/3] HID: Add HID_CLAIMED_OTHER for non-generic drivers
Date: Mon, 16 Jul 2012 23:06:26 +0200
Message-ID: <CANq1E4RJQrKTVBBpfiCDGtZL-T_mN7zcS3Mr-nFnHTTaOYnNPw@mail.gmail.com>
References: <20120716184530.GA407@polaris.bitmath.org>
	<CANq1E4Q2AoA7JP9rL39gEkyMCy+-a3vcysn_kWOdB8Z4okAf+A@mail.gmail.com>
	<20120716193502.GA617@polaris.bitmath.org>
	<CANq1E4QuFX1-KVTb1udzMP6QUuWe=zhmu4RS2cgQ2=CdfJf5gg@mail.gmail.com>
	<20120716205937.GA603@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50490 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2GPVG1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 17:06:27 -0400
Received: by wibhr14 with SMTP id hr14so3125504wib.1
        for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 14:06:26 -0700 (PDT)
In-Reply-To: <20120716205937.GA603@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Henrik

On Mon, Jul 16, 2012 at 10:59 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> I am sorry, I misunderstood you. Yes, in fact, this is what wiimote
>> currently does. Well, it uses HID_CONNECT_HIDRAW but this has no
>> effect if CONFIG_HIDRAW is not set so this is equivalent to 0. My
>> first attempt was to make this work, however, this means refactoring
>> hid_connect() a lot as we need to differentiate between
>> hidraw_connect() failing and HID_CONNECT_HIDRAW being not set. Same
>> for hidinput_connect() and hiddev_connect(). That is, if
>> hid_hw_start() is called with HID_CONNECT_HIDDEV set, but
>> hiddev_connect() fails? Should the core bail out or let the device
>> through? In most cases bailing out is the best option. However, what
>> to do for the wiimote case? It requests hidraw but if hidraw_connect()
>> fails, then the wiimote driver can still work without it so in this
>> case we must not bail out.
>>
>> Taking this into account I really have no idea how to implement this
>> in a cleaner and safer way than using HID_CONNECT_OTHER. Btw., what
>> should the wiimote driver pass to hid_hw_start() in your case? It
>> wants HID_CONNECT_HIDRAW but also wants to get through if
>> CONFIG_HIDRAW is not set. It cannot pass 0 as this would always
>> disable HIDRAW. But in the case that HIDRAW is not available, it
>> cannot tell the core that it wants to stay on the bus. Hence, I think
>> using HID_CONNECT_OTHER is the only way, isn't it?
>>
>> > To catch possible mistakes, one could check for the presence of
>> > raw_event() instead, for instance.
>> >
>> > What I am getting at is that we really do not need to create any more
>> > backdoors into the hid core - on the contrary, we can most likely
>> > easily remove some of them instead.
>>
>> I fully agree, but I have to admit that I didn't find an easier way
>> that actually works.
>>
>> Thanks a lot for having a look at this. If you have any other ideas I
>> will gladly implement and test them, but I am currently out of ideas.
>
> Would something like this work for you?

Yes, that works fine. I just want some nice comment there so people
know we are using some heuristics. If you don't mind, I will wrap this
up tomorrow and send a new version of the patch(set). Otherwise, feel
free to send it yourself.

Thanks for your reviews!
David

> Henrik
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 4c87276..a43e14c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1373,8 +1373,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>         if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
>                 hdev->claimed |= HID_CLAIMED_HIDRAW;
>
> -       if (!hdev->claimed) {
> -               hid_err(hdev, "claimed by neither input, hiddev nor hidraw\n");
> +       if (!hdev->claimed && !hdev->driver->raw_event) {
> +               hid_err(hdev, "device has no listeners, quitting\n");
>                 return -ENODEV;
>         }
>
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index 45c3433..74c388d 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -2613,11 +2613,7 @@ static int picolcd_probe(struct hid_device *hdev,
>                 goto err_cleanup_data;
>         }
>
> -       /* We don't use hidinput but hid_hw_start() fails if nothing is
> -        * claimed. So spoof claimed input. */
> -       hdev->claimed = HID_CLAIMED_INPUT;
>         error = hid_hw_start(hdev, 0);
> -       hdev->claimed = 0;
>         if (error) {
>                 hid_err(hdev, "hardware start failed\n");
>                 goto err_cleanup_data;
