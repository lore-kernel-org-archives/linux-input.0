From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: conflict of wiimote and hid-sony
Date: Sun, 17 Nov 2013 17:26:00 +0100
Message-ID: <CANq1E4TVhxDk7JvNOMQG2Qddktdp2zzRayeAhQ0Zc=vghyGw7g@mail.gmail.com>
References: <CADwLDZsUsHduucFXrb218wemsGaWM76BCqQUY_OobuSf0UEP1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:56980 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab3KQQ0E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 11:26:04 -0500
Received: by mail-la0-f50.google.com with SMTP id el20so4092609lab.23
        for <linux-input@vger.kernel.org>; Sun, 17 Nov 2013 08:26:01 -0800 (PST)
In-Reply-To: <CADwLDZsUsHduucFXrb218wemsGaWM76BCqQUY_OobuSf0UEP1Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michel Kraus <mksolpa@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Sun, Nov 17, 2013 at 2:13 AM, Michel Kraus <mksolpa@gmail.com> wrote:
> Hi,
>
> commit 86b84167 HID: wiimote: add LEGO-wiimote VID
>
> introduced a VID/PID conflict with its original owner: hid-wiimote got
> hid:b0005g*v0000054Cp00000306 added but hid-sony already has this id for
> the PS3 Remote.
>
> I think the original and legitimate owner should remain the default for this
> VID/PID combination.

Thanks for the report! It's indeed officially allocated as USB ID to Sony.

@Jiri, can you revert the following commit (note: it was already
backported to stable):

commit 86b84167d4e67372376a57ea9955c5d53dae232f
Author: David Herrmann <dh.herrmann@gmail.com>
Date:   Fri Oct 18 16:26:22 2013 +0200

    HID: wiimote: add LEGO-wiimote VID

I will write a bluez-patch to force the official wiimote-id on the
device, based on a name-comparison. This should allow us to support
both devices.

Thanks
David
