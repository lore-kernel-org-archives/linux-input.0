From: Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] HID: Remove Jabra speakerphone devices from ignore list
Date: Fri, 15 Sep 2017 10:08:42 +0200
Message-ID: <CAP_ceTwr2X_FkZPjgSJx6RA4YiXWNVj_Y574rtaZkRexmb=+pQ@mail.gmail.com>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com>
 <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com>
 <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTzwOgA6e2gO2fc8vzps4mUJkxC=LzoGEACHcLKkoygXpA@mail.gmail.com>
 <20170913170238.GB13863@mail.corp.redhat.com> <nycvar.YFH.7.76.1709131009350.4703@jbgna.fhfr.qr>
 <VI1PR0701MB2991B9069D430C5DA6A91618DA6C0@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:48501 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOIJE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Sep 2017 04:09:04 -0400
Received: by mail-it0-f49.google.com with SMTP id d123so2267959ith.3
        for <linux-input@vger.kernel.org>; Fri, 15 Sep 2017 01:09:03 -0700 (PDT)
In-Reply-To: <VI1PR0701MB2991B9069D430C5DA6A91618DA6C0@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: Jiri Kosina <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, Richard Hughes <richard@hughsie.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On Fri, Sep 15, 2017 at 9:52 AM, Niels Skou Olsen <nolsen@jabra.com> wrote:
> On Wed, 13 Sep 2017, jikos@kernel.org wrote:
>
>> On Wed, 13 Sep 2017, benjamin.tissoires@redhat.com wrote:
>>
>> > I do not see a reason not to. Maybe Jiri will, but the fact that one
>> > version works and one doesn't seem enough to allow such specific
>> > blacklisting.
>>
>> The blacklist matching currently doesn't support that, but it'd be trivial to match, and I
>> actually think it generally makes sense to me. So feel free (once you guys settle on
>> solution that both Chromium and Jabr folk find acceptable) to send this together with
>> a hid-core patch that'd add a possibility to perform per-fw-version matching.
>
> Great! Shall I give it a shot? Or is there someone with more intimate knowledge
> about hid-core that wants to do it?
>
> How should it work?
>
> A simple setup would be to attach an optional list of blacklisted firmware versions
> to each entry in hid_ignore_list[]? If this list is empty, all firmware versions are
> blacklisted. The attached list could just be a static array. Would this be acceptable?

Where the firmware version is stored (eg here in bcdUSB)  is neither
really defined nor available at the pure HID level (ie you likely need
the USB descriptors). So probably you want to remove the Jabra devices
from the hid_ignore_list[] and add the new versioned quirk returning
HID_QUIRK_IGNORE in usbhid_lookup_quirk() [in
drivers/hid/usbhid/hid-quirks.c]. It seems we can either create a new
list with USB VID/PID/min bcdUSB or actually just add some code for it
as this might not extend to tons of devices, but the maintainers can
give guidance on this point.

-- 
Vincent
