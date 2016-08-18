From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: byd - fix issue where generic PS/2 mice are
 detected as BYD touchpad
Date: Thu, 18 Aug 2016 12:04:11 +0200
Message-ID: <CAN+gG=F6cs978_jtC=SSk66RRFC6JCTK_aS1jUubk=_w5o4Jbw@mail.gmail.com>
References: <20160627213412.GC22620@dtor-ws> <1467172878-25483-1-git-send-email-pospeselr@gmail.com>
 <20160711202620.GA24346@smaug> <20160712025757.GA12185@dtor-ws>
 <20160714164601.GB17106@dtor-ws> <CAHc7Qt1AEdCxu+rnrYqMRNQFGac4VuNFG=tfTSeHam4SnB3F3w@mail.gmail.com>
 <20160802113217.GA25170@peridot.local.diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35793 "EHLO
	mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbcHRKEU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2016 06:04:20 -0400
Received: by mail-ua0-f180.google.com with SMTP id n59so20467577uan.2
        for <linux-input@vger.kernel.org>; Thu, 18 Aug 2016 03:04:12 -0700 (PDT)
In-Reply-To: <20160802113217.GA25170@peridot.local.diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Richard Pospesel <pospeselr@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, phonesyfreakies@gmail.com

Hi,

Raising this thread in everyone's memory. We have people
complaining[1,2] regarding these bad detections, and I think given
that this is a regression, we should address this ASAP.

Apologies for being pushy.

Cheers,
Benjamin

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1352159
[2] https://bugzilla.kernel.org/show_bug.cgi?id=120781

On Tue, Aug 2, 2016 at 1:32 PM, Chris Diamand <chris@diamand.org> wrote:
> Hi,
>
> Sorry for the delay.
>
>>> Chris, Richard, do you guys have the same hardware or different laptops?
>>> Could you share DMI data?
>
>> Not sure, I've a Purism Librem13.
>
> Mines's branded as a PC Specialist "Lafite" v1.
>
> I'm pretty sure they're from the same OEM though, being sold under different
> brands, given that they look pretty much identical.
>
> Full output of `dmidecode` attached, but I've included some highlights below:
>
> Handle 0x0003, DMI type 3, 25 bytes
> Chassis Information
>         Manufacturer: To Be Filled By O.E.M.
>         Type: Laptop
>         Lock: Not Present
>         Version: To Be Filled By O.E.M.
>         Serial Number: To Be Filled By O.E.M.
>         Asset Tag: To Be Filled By O.E.M.
>         Boot-up State: Safe
>         Power Supply State: Safe
>         Thermal State: Safe
>         Security Status: None
>         OEM Information: 0x00000000
>         Height: Unspecified
>         Number Of Power Cords: 1
>         Contained Elements: 1
>                 <OUT OF SPEC> (0)
>         SKU Number: To be filled by O.E.M.
>
> ...
>
> Handle 0x0004, DMI type 8, 9 bytes
> Port Connector Information
>         Internal Reference Designator: J1A1
>         Internal Connector Type: None
>         External Reference Designator: PS2Mouse
>         External Connector Type: PS/2
>         Port Type: Mouse Port
>
> Cheers!
> Chris
