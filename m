From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 2/3] HID: sony: Set INPUT_PROP_COMPOSITE flag on sub devices.
Date: Wed, 23 Aug 2017 16:46:54 -0700
Message-ID: <CANndSKmDdt9t0KoGy46cGUEUuade-=Baquna-UUKiTfpTdJb-A@mail.gmail.com>
References: <20170818020156.23390-1-roderick@gaikai.com> <20170818020156.23390-3-roderick@gaikai.com>
 <1503478205.24498.13.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36228 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdHWXqz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 19:46:55 -0400
Received: by mail-oi0-f53.google.com with SMTP id g131so15781731oic.3
        for <linux-input@vger.kernel.org>; Wed, 23 Aug 2017 16:46:55 -0700 (PDT)
In-Reply-To: <1503478205.24498.13.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, Aug 23, 2017 at 1:50 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-08-17 at 19:01 -0700, Roderick Colenbrander wrote:
>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>
>> Configure the touchpad and motion sensor sub devices with the
>> INPUT_PROP_COMPOSITE flag. This flag will be consumed by joydev
>> to filter out the motion sensor device.
>
> Could you please add the same to the hid-udraw-ps3.c driver?

Sure, if the flag gets accepted we could add it there.
