From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] HID: Remove Jabra speakerphone devices from ignore list
Date: Thu, 14 Sep 2017 17:11:01 +0100
Message-ID: <CAD2FfiFg49trS6aQmbnvbEwoRgORyqFkzRwyM=5juTwOPM+ehg@mail.gmail.com>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com>
 <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com>
 <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTzwOgA6e2gO2fc8vzps4mUJkxC=LzoGEACHcLKkoygXpA@mail.gmail.com> <20170913170238.GB13863@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:51311 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdINQLC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Sep 2017 12:11:02 -0400
Received: by mail-yw0-f177.google.com with SMTP id p10so538932ywh.8
        for <linux-input@vger.kernel.org>; Thu, 14 Sep 2017 09:11:02 -0700 (PDT)
In-Reply-To: <20170913170238.GB13863@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc: Vincent Palatin <vpalatin@chromium.org>, Niels Skou Olsen <nolsen@jabra.com>, Richard Hughes <richard@hughsie.com>, Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On 13 September 2017 at 18:02, benjamin.tissoires@redhat.com
<benjamin.tissoires@redhat.com> wrote:
>> I don't think so, as mentioned above.
>> It would have been nice to ignore it in HID based on the firmware
>> version/bcdUSB but not my call.
>
> I do not see a reason not to. Maybe Jiri will, but the fact that one
> version works and one doesn't seem enough to allow such specific
> blacklisting.

If there's any interest in making the firmware easily upgradable I'd
be happy to help. The fwupd project is already able to upgrade lots of
different type of hardware securely and sanely and we're always
looking for more devices to add to the supported matrix. If this
sounds interesting, please grab me off-cc with details as I'm happy to
help. Thanks!

Richard
