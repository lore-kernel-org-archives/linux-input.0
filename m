From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: touchscreen stops working in 2.6.39
Date: Tue, 3 May 2011 11:59:44 -0500
Message-ID: <BANLkTiksg5na6QHeUU4c2rskiG2KeQpmFA@mail.gmail.com>
References: <BANLkTim2aw1eC8UAJ4W7c1dQ7bPM0_j03w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55611 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab1ECQ7p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 12:59:45 -0400
Received: by bwz15 with SMTP id 15so287694bwz.19
        for <linux-input@vger.kernel.org>; Tue, 03 May 2011 09:59:44 -0700 (PDT)
In-Reply-To: <BANLkTim2aw1eC8UAJ4W7c1dQ7bPM0_j03w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Mattias_S=E4teri?= <mattias.sateri@gmail.com>
Cc: pingc@wacom.com, linux-input@vger.kernel.org

I believe all you need to do is upgrade your xf86-input-wacom to
latest version... or edit a config file to remap your touchscreen
device ("Finger") to xf86-input-evdev instead of xf86-input-wacom.

Your touchscreen reports multi-touch events now and that confuses
older xf86-input-wacom's.

Chris

2011/5/3 Mattias S=E4teri <mattias.sateri@gmail.com>:
> Hi,
>
> on an HP Touchsmart tm2 laptop with a wacom touchscreen, the
> touchscreen stopped working with the 2.6.39 kernel. The pen still
> works, but not touching the screen with a finger. However, doing '#
> cat /dev/input/mouse0' and touching the screen with my finger outputs
> characters to the console.
>
> I have attached dmesg output, perhaps it can help. Please let me know
> if there is anything I can do to help with this.
>
>
> Regards,
> Mattias S=E4teri
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
