From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 17:34:19 +0200
Message-ID: <CAN+gG=EYXHegM+BTEuDvAT_cmvZCT5u38hY+Woe_No3V0rDfWA@mail.gmail.com>
References: <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz>
	<4f95669e.a0e7d80a.2ef7.6710SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40151 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab2DWPeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:34:20 -0400
Received: by iadi9 with SMTP id i9so2161021iad.19
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 08:34:19 -0700 (PDT)
In-Reply-To: <4f95669e.a0e7d80a.2ef7.6710SMTPIN_ADDED@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi guys,

On Mon, Apr 23, 2012 at 16:19, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi Jiri,
>
> On Mon, Apr 23, 2012 at 9:43 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>
>> those two links don't provide any detailed report whatsoever. Lookin=
g at
>>
>> =A0 =A0 =A0 =A0https://bugs.launchpad.net/ubuntu/+source/linux/+bug/=
913164
>>
>> there seems to be quite some discussion, but covering multiple model=
s from
>> multiple vendors (and likely multiple different patches needed).
>
> On comment #14, #15 and #32 of the above link, only the =A0Quanta tou=
chscreen
> (vendor ID: 0408, device ID:3008) is related.
>
>>
>> So if there are patches that need to be applied (likely device ID
>> additions as far as I understand this monster launchpad bug entry), =
please
>> point me directly to the respective patches or send me a little bit =
more
>> details (VID/PID/protocol needed), and I'll queue the patches.
>
> Sorry, I have not any patches which can make the Quanta touchscreen(0=
408:3008)
> working well, also no any device ID addition patch is need for the de=
vice.
>
> You can understand my email as a regression report for the Quanta tou=
chscreen
> device, since it works well on 3.0 kernel, but double click stops wor=
king
> on 3.4-rc2.

Well, depending on the point of view, it's a regression or a feature ;-=
)

in kernels pre-3.2 IIRC, this device used the embedded mouse interface
(so the double click "worked"). Now, it's using the generic
hid-multitouch driver, which means that it forwards raw multitouch
events to the upper layers.

The problem relies in the upper layers and not in the kernel: nobody
took the time to code a X.org driver that handles true multitouch
direct devices. You can eventually use the synaptics one, but you will
have to deal with absolute/relative coordinates, and the last time I
played with it, it was not convenient as I was not able to make GDM
use the absolute coordinate system (I kow I should have patched the
synaptics X.org driver).

Cheers,
Benjamin

>
>
> Thanks,
> --
> Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
