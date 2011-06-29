From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 05/12] HID: wiimote: Synchronize wiimote input and hid
 event handling
Date: Wed, 29 Jun 2011 14:39:06 +0200
Message-ID: <BANLkTimbhk9y8V6ff0FiTsjNQWw6wBXjNA@mail.gmail.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
	<1309185013-484-5-git-send-email-dh.herrmann@googlemail.com>
	<ca4e286b-420b-4d36-bb97-243dcdc9a527@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35031 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab1F2MjI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 08:39:08 -0400
Received: by vws1 with SMTP id 1so836247vws.19
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 05:39:07 -0700 (PDT)
In-Reply-To: <ca4e286b-420b-4d36-bb97-243dcdc9a527@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

On Tue, Jun 28, 2011 at 7:49 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>
> David Herrmann <dh.herrmann@googlemail.com> wrote:
>
>>The wiimote first starts HID hardware and then registers the input
>>device. We need to synchronize the startup so no event handler will
>>start parsing events when the wiimote device is not ready, yet.
>>
>
> I believe this is generic HID layer problem. Would it be possible to fix this issue there?

The point is, I do not use HIDINPUT/HIDDEV (see commit message 2/12).
The wiimote has no valid report-descriptor table so hidinput/hiddev do
not make sense. I could set up a valid report-descriptor-table, use
input_mapping, input_mapped, report_fixup callbacks and then use
HIDINPUT. However, that would be far more complex than my current
solution, which is creating my own input instance and also my own
synchronization.
Furthermore, the wiimote provides input/output features that cannot be
handled by the generic HID handler, so I would need to extend the
input_mapping, anyway.

But, thanks to your hint, I looked at hid_hw_start() again and as far
as I can see the synchronization issue exists there, too.
The ll_driver->start() function is called first and after that, the
input instance is registered.
If the ll_driver reports an event before the input instance is
registered, the hidinput/other-driver will call input_event() on an
invalid input instance (probably even a NULL dereference).
This may not be a problem for usbhid, because usbhid_open() has to be
called first, however, hidp (bluetooth hid) ignores the *_open()
callback and therefore may fail.

I will look at this again and send a separate mail to this list,
however, I don't think this is related to my driver? Or do you think I
should replace my input-handling with HIDINPUT to be more homogeneous
with the other hid drivers?

> Thanks.
>
> --
> Dmitry

Regards
David
