From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 22:19:37 +0800
Message-ID: <CACVXFVMK6W4opVx_ZF94oz2ZZaN5=a6U7HkEvMTT8BYs=ojEGA@mail.gmail.com>
References: <CACVXFVPTMPGRcvgdBd9Z=rsPCUGdmyoejU208Wy=c3c38U-ZkQ@mail.gmail.com>
	<alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:49966 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2DWOTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 10:19:37 -0400
Received: by dadz8 with SMTP id z8so15620485dad.10
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 07:19:37 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>

Hi Jiri,

On Mon, Apr 23, 2012 at 9:43 PM, Jiri Kosina <jkosina@suse.cz> wrote:

> those two links don't provide any detailed report whatsoever. Looking=
 at
>
> =A0 =A0 =A0 =A0https://bugs.launchpad.net/ubuntu/+source/linux/+bug/9=
13164
>
> there seems to be quite some discussion, but covering multiple models=
 from
> multiple vendors (and likely multiple different patches needed).

On comment #14, #15 and #32 of the above link, only the  Quanta touchsc=
reen
(vendor ID: 0408, device ID:3008) is related.

>
> So if there are patches that need to be applied (likely device ID
> additions as far as I understand this monster launchpad bug entry), p=
lease
> point me directly to the respective patches or send me a little bit m=
ore
> details (VID/PID/protocol needed), and I'll queue the patches.

Sorry, I have not any patches which can make the Quanta touchscreen(040=
8:3008)
working well, also no any device ID addition patch is need for the devi=
ce.

You can understand my email as a regression report for the Quanta touch=
screen
device, since it works well on 3.0 kernel, but double click stops worki=
ng
on 3.4-rc2.


Thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
