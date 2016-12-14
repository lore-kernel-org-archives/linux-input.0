From: Chris Chiu <chiu@endlessm.com>
Subject: Re: [PATCH] HID: add Asus macrokey support for Asus "Republic of
 Gamers" laptop
Date: Thu, 15 Dec 2016 00:50:22 +0800
Message-ID: <CAB4CAwdH4rMP5=QC_k9vu6bfZV_LXYtmqTiCrB9ahRCXy_NkPg@mail.gmail.com>
References: <1481546578-40703-1-git-send-email-chiu@endlessm.com> <alpine.LNX.2.00.1612141119430.16984@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33039 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755463AbcLNQuY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Dec 2016 11:50:24 -0500
Received: by mail-oi0-f48.google.com with SMTP id w63so26466028oiw.0
        for <linux-input@vger.kernel.org>; Wed, 14 Dec 2016 08:50:23 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1612141119430.16984@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux@endlessm.com

On Wed, Dec 14, 2016 at 6:20 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 12 Dec 2016, Chris Chiu wrote:
>
> [ ... snip ... ]
>> +static const struct hid_device_id asus_rog_devices[] = {
>> +     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY1) },
>> +     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_MACROKEY2) },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(hid, asus_rog_devices);
>
> [ ... snip ... ]
>
> In addition to what Benjamin said already, you also seem to be missing
> hid_have_special_driver[] entry for these VID/PIDs
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

You're right. I forgot to add VID/PID in hid_have_special_driver in
this patch. I'll modify per Benjamin's suggestion and re-commit.
Thanks.
