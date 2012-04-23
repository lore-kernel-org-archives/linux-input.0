From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 17:48:09 +0200
Message-ID: <CAN+gG=HJVynUaLciTkKqMSvciU1RN9NssQOBGeH2Wkg=9b6kOQ@mail.gmail.com>
References: <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz>
	<4f95669e.a0e7d80a.2ef7.6710SMTPIN_ADDED@mx.google.com>
	<CAN+gG=EYXHegM+BTEuDvAT_cmvZCT5u38hY+Woe_No3V0rDfWA@mail.gmail.com>
	<4F957856.1070107@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38010 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab2DWPsL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:48:11 -0400
Received: by iadi9 with SMTP id i9so2175761iad.19
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 08:48:10 -0700 (PDT)
In-Reply-To: <4F957856.1070107@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, Apr 23, 2012 at 17:42, Chase Douglas
<chase.douglas@canonical.com> wrote:
> On 04/23/2012 08:34 AM, Benjamin Tissoires wrote:
>> The problem relies in the upper layers and not in the kernel: nobody
>> took the time to code a X.org driver that handles true multitouch
>> direct devices. You can eventually use the synaptics one, but you wi=
ll
>> have to deal with absolute/relative coordinates, and the last time I
>> played with it, it was not convenient as I was not able to make GDM
>> use the absolute coordinate system (I kow I should have patched the
>> synaptics X.org driver).
>
> X now supports direct multitouch devices using the X evdev driver. Th=
is
> may be a bug in the X server.

Yes it does, but does it also emulates right-clicks with double tap?
(It's not an attack ;-), it's just a question as I did not followed
the development of XInput 2.2 since a long time...)

thanks,
Benjamin

>
> -- Chase
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
