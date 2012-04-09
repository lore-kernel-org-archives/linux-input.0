From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 00/16 v2] cleanup atmel_mxt_ts
Date: Mon, 9 Apr 2012 21:14:52 +0800
Message-ID: <CAGS+omB=dC8u+eJo5_mKJRH6=8=6BoQJ1uctKrhso6R4S5FTEg@mail.gmail.com>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36787 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab2DINPN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Apr 2012 09:15:13 -0400
Received: by yhmm54 with SMTP id m54so1756772yhm.19
        for <linux-input@vger.kernel.org>; Mon, 09 Apr 2012 06:15:12 -0700 (PDT)
In-Reply-To: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>

On Fri, Mar 30, 2012 at 12:49 AM, Daniel Kurtz <djkurtz@chromium.org> w=
rote:
> This patchset cleans up the atmel_mxt_ts touchscreen driver.
> In particular, v2 implements the following:
>
> 1) sysfs
> =A0 a) fw_update only by root
> 2) faster initialization
> =A0 a) read/write sets of registers using i2c block transactions
> =A0 b) fetch object table as a set of i2c reads, one per object
> =A0 c) write config data as a set of i2c writes, one per object
> 3) faster interrupt processing & initialization times
> =A0 a) cache important values at init instead of computing in isr
> =A0 b) don't read message checksum byte (which isn't even enabled in =
fw)
> 4) more correct MT-B support
> =A0 a) send all (changed) contacts in a single EV_SYN/SYN_REPORT
>
> v2:
> =A0* Writable config via sysfs has been removed to resolve possible
> =A0 =A0conflict with Nick Dyer's implementation.
> =A0* Using T44 has been removed from this patchset, hopefully it can
> =A0 =A0be reexamined after most of these patches are accepted.
>
> The patches were tested using an MXT224E.

Joonyoung, Nick, Henrik,

Can you please take a look at this second version of the atmel_mxt_ts p=
atches?
Thanks!

>
> Daniel Kurtz (16):
> =A0Input: atmel_mxt_ts - use CONFIG_PM_SLEEP
> =A0Input: atmel_mxt_ts - only allow root to update firmware
> =A0Input: atmel_mxt_ts - refactor mxt_read/write_reg to take a length
> =A0Input: atmel_mxt_ts - store actual size and instance
> =A0Input: atmel_mxt_ts - verify object size in mxt_write_object
> =A0Input: atmel_mxt_ts - do not read extra (checksum) byte
> =A0Input: atmel_mxt_ts - dump each message on just 1 line
> =A0Input: atmel_mxt_ts - refactor mxt_object_show
> =A0Input: atmel_mxt_ts - optimize writing of object table entries
> =A0Input: atmel_mxt_ts - refactor get info
> =A0Input: atmel_mxt_ts - refactor reading object table
> =A0Input: atmel_mxt_ts - simplify event reporting
> =A0Input: atmel_mxt_ts - cache T9 reportid range when reading object
> =A0 =A0table
> =A0Input: atmel_mxt_ts - parse vector field of data packets
> =A0Input: atmel_mxt_ts - send all MT-B slots in one input report
> =A0Input: atmel_mxt_ts - parse T6 reports
>
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0477 ++++++++++++----=
--------------
> =A01 files changed, 191 insertions(+), 286 deletions(-)
>
> --
> 1.7.7.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
