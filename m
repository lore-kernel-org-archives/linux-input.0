From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big enough
Date: Tue, 7 Jan 2014 17:34:50 +0100
Message-ID: <CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com>
	<3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org>
	<CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com>
	<alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51715 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaAGQev (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 11:34:51 -0500
In-Reply-To: <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

Hi Jiri

On Tue, Jan 7, 2014 at 1:11 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 27 Dec 2013, David Herrmann wrote:
>
>> >> I also haven't figured out a nice way to make HID-core honor the
>> >> "size" parameter. hid-input depends on getting the whole
>> >> input-report.
>> >
>> > I think this needs clearly fixing.
>>
>> And we have a volunteer, yippie! ;)
>>
>> I think hid_input_report() in hid-core.c is the only place that relies
>> on this. Maybe it really is easier to fix it. But I am not even
>> slightly familiar with that code. So if no-one of the HID core
>> developers steps up to fix it, we should take the transport-driver
>> fixes instead. As nearly all transport-drivers are affected by this,
>> maybe we should even move this buffer into hid_device and provide
>> hid_input_truncated_report() which does this.
>>
>> Anyhow, waiting for Jiri's comments on this.
>
> Hmm, this is really unfortunate situation.
>
> I am now looking into making hid_input_report() honor 'size' properly, but
> no matter how it'll be done in the end, it'll absolutely not be a simple
> 'fix'. So definitely can be done for 3.15 or so, but not as a fix for
> current kernels.
>
> So doing kzalloc(rsize, GFP_ATOMIC) in the HID-core for now, and copying
> the buffer around, seems like only viable solution for now, with the
> outlook of removing this ugliness once hid-core honors 'size' properly.

Should I resend the patches and move it to hid_input_report() for now?
Or are you getting something in yourself?
Given the amount of reports on the list and bugzilla, I think we
should get this fix in asap. We can always fix it properly in -next.

Thanks
David

> I will keep looking into this and maybe some easy way how to hack this
> together will materialize, but I don't currently see it.
>
> Hmm ...
>
> --
> Jiri Kosina
> SUSE Labs
