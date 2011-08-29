From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 14/14] HID: wiimote: Read wiimote battery charge level
Date: Mon, 29 Aug 2011 16:41:03 +0200
Message-ID: <CANq1E4SDh-3ipJqZDZ3dJniPrBQkXecTZdMY5EWVOZsbJGL7cQ@mail.gmail.com>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com>
	<1314625091-1405-15-git-send-email-dh.herrmann@googlemail.com>
	<201108291628.59839.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62793 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1H2OlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 10:41:04 -0400
Received: by gxk21 with SMTP id 21so4835985gxk.19
        for <linux-input@vger.kernel.org>; Mon, 29 Aug 2011 07:41:03 -0700 (PDT)
In-Reply-To: <201108291628.59839.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

On Mon, Aug 29, 2011 at 4:28 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Montag, 29. August 2011, 15:38:11 schrieb David Herrmann:
>> This adds a new sysfs file for wiimotes which returns the current ba=
ttery charge
>> level of the device. Since this information is not sent by the wiimo=
te
>> continously, we need to explicitely request it.
>
> Again I need to ask whether you really want a specific interface for
> a functionality which is common to many devices.

Thanks for the hint. I will convert it to use "struct power_supply". I
wasn't aware it existed.
So patch 13 and 14 can be dropped from this set.

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
>

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
