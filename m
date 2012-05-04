From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 00/14 v3] cleanup atmel_mxt_ts
Date: Sat, 5 May 2012 01:39:05 +0800
Message-ID: <CAGS+omDm36Sxpv_e1=W6BNx9EoeWd1H2EaPqHAaGYYWnaZjZAw@mail.gmail.com>
References: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 18, 2012 at 9:21 PM, Daniel Kurtz <djkurtz@chromium.org> wr=
ote:
>
> This patchset cleans up the atmel_mxt_ts touchscreen driver.
> In particular, v3 implements the following:
>
> 1) sysfs
> =A0 a) fw_update only by root
> =A0 b) use sncprintf()
> 2) faster initialization
> =A0 a) read/write sets of registers using i2c block transactions
> =A0 b) fetch object descriptor table as a single i2c transaction
> =A0 c) fetch objects =A0as a set of i2c reads, one per object
> =A0 d) write config data as a set of i2c writes, one per object
> 3) faster interrupt processing & initialization times
> =A0 a) cache important values at init instead of computing in isr
> =A0 b) don't read message checksum byte (which isn't even enabled in =
fw)
> 4) more correct MT-B support
> =A0 a) send all (changed) contacts in a single EV_SYN/SYN_REPORT
>
> v3:
> =A0* Address Henrik's feedback:
> =A0 =A01) removed some more stack allocations
> =A0 =A02) use sncprintf() in sysfs handler
>
>
> The patches were tested using an MXT224E.
> They should apply cleanly to input/next.
>
> Daniel Kurtz (14):
> =A0Input: atmel_mxt_ts - use CONFIG_PM_SLEEP
> =A0Input: atmel_mxt_ts - only allow root to update firmware
> =A0Input: atmel_mxt_ts - refactor mxt_read/write_reg to take a length
> =A0Input: atmel_mxt_ts - verify object size in mxt_write_object
> =A0Input: atmel_mxt_ts - do not read extra (checksum) byte
> =A0Input: atmel_mxt_ts - dump each message on just 1 line
> =A0Input: atmel_mxt_ts - refactor mxt_object_show
> =A0Input: atmel_mxt_ts - optimize writing of object table entries
> =A0Input: atmel_mxt_ts - refactor get info
> =A0Input: atmel_mxt_ts - simplify event reporting
> =A0Input: atmel_mxt_ts - cache T9 reportid range when reading object
> =A0 =A0table
> =A0Input: atmel_mxt_ts - parse vector field of data packets
> =A0Input: atmel_mxt_ts - send all MT-B slots in one input report
> =A0Input: atmel_mxt_ts - parse T6 reports


Thank you to Henrik for reviewing again, and ACK'ing patch 3.

Could I get a review for the rest of the set?
There will actually be quite a few more patches that follow these.

-Daniel
