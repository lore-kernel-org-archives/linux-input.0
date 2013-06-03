From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 01/26] HID: wiimote: extend driver description
Date: Mon, 3 Jun 2013 22:28:31 +0200
Message-ID: <CANq1E4QSa3SaQMNAkaC50cfA+77t+d9h1tDDyk5XqWmqfV2__A@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-2-git-send-email-dh.herrmann@gmail.com>
	<alpine.LNX.2.00.1306031117561.6750@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51056 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3FCU2c (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Jun 2013 16:28:32 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so11689855ief.40
        for <linux-input@vger.kernel.org>; Mon, 03 Jun 2013 13:28:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1306031117561.6750@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Jiri

On Mon, Jun 3, 2013 at 11:19 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 5 May 2013, David Herrmann wrote:
>
>> The hid-wiimote driver supports more than the Wii Remote. Nintendo
>> produced many devices based on the Wii Remote, which have extension
>> devices built-in. It is not clear to many users, that these devices have
>> anything in common with the Wii Remote, so fix the driver description.
>>
>> This also updates the copyright information for the coming hotplugging
>> rework.
>
> I have now applied the whole patchset, with these two exceptions:
>
> 1) [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
>
>    - It's not completely clear to me whether you have reached conclusion
>      with Todd on this one or not

No, I am still working on this. I will resend the patch plus some
Documentation when I'm done.

> 2) [RFC 26/26] HID/ALSA: wiimote: add speaker support
>
>    - It'd be nice to get Ack from sound people on this one.

Yeah, sure. That one is still under construction. I got ADPCM working
now and will try to get some review from alsa-devel.

> Thanks a lot, David. Good work.

Thanks for reviewing! I checked your tree and all patches (including
the fixups) are applied as required. Thanks!

Cheers
David
