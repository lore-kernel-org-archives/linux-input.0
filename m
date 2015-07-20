From: Robert Dolca <robert.dolca@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Tue, 21 Jul 2015 00:13:27 +0300
Message-ID: <CAFPB+Ycury020k0W6LVK9mnbS6hFXNdqr6qPP21PMXbNy8TYmQ@mail.gmail.com>
References: <55A18959.7050502@gmail.com> <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
 <55A3CA05.5030302@gmail.com> <CAFPB+YcZnzHVdztqYuD63fNGhedDZR4xEW8Nkd+zJ_H_gm+L-w@mail.gmail.com>
 <55A3D6DA.9090206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38211 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbGTVNr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 17:13:47 -0400
Received: by wibxm9 with SMTP id xm9so37977483wib.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 14:13:46 -0700 (PDT)
In-Reply-To: <55A3D6DA.9090206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor,

On Mon, Jul 13, 2015 at 6:18 PM, Gregor Riepl <onitake@gmail.com> wrote:
>> In the datasheet there is no register map. Silead gave us a partial
>> register map in order to implement the driver. In the map they
>> provided there is no register for resolution or anything that would
>> help with this issue. The information in [1] is incomplete and can not
>> be considered reliable since the vendor does not say anything about
>> it.
>
> That is indeed true.
> Relying on parameters read from the ACPI DSDT or the DeviceTree would
> certainly be the "clean" way to go on new hardware, but it will not work on
> existing hardware where the device parameters are fixed.
>
> Do you think it would make sense to also allow passing the parameters as
> module options, or via sysfs for cases where they can't be autodetected?

For the existing devices you can override the ACPI tables using initrd.
https://www.kernel.org/doc/Documentation/acpi/initrd_table_override.txt

There is some work being done that will allow to amend (no need to
completely override) the ACPI tables with custom data.
https://lkml.org/lkml/2015/6/18/947

Device tree already has support for overlays.

Giving this I think that we should keep the driver as simple as possible.

> Also, while going over your code, I found something that might be incorrect.
> When you evaluate the point data from the device, you are interpreting it with
> this code:
>
> #define SILEAD_POINT_DATA_LEN   0x04
> #define SILEAD_POINT_X_OFF      0x02
> #define SILEAD_POINT_ID_OFF     0x03
> #define SILEAD_X_HSB_MASK       0xF0
> #define SILEAD_TOUCH_ID_MASK    0x0F
> for (i = 1; i <= touch_nr; i++) {
>         offset = i * SILEAD_POINT_DATA_LEN;
>
>         /* The last 4 bits are the touch id */
>         id = buf[offset + SILEAD_POINT_ID_OFF] & SILEAD_TOUCH_ID_MASK;
>
>         /* The 1st 4 bits are part of X */
>         buf[offset + SILEAD_POINT_ID_OFF] =
>                 (buf[offset + SILEAD_POINT_ID_OFF] & SILEAD_X_HSB_MASK)
>                 >> 4;
>
>         y = le16_to_cpup((__le16 *)(buf + offset));
>         x = le16_to_cpup((__le16 *)(buf + offset + SILEAD_POINT_X_OFF));
> }
>
> The Basewin driver and all the ones derived from it interpreted it like this:
>
> ts->dd = {
>         .x_index = 6,
>         .y_index = 4,
>         .z_index = 5,
>         .id_index = 7,
> }
> for(i= 0;i < (touches > MAX_FINGERS ? MAX_FINGERS : touches);i ++) {
>         x = join_bytes( ( ts->touch_data[ts->dd->x_index + 4 * i + 1] & 0xf),
>         ts->touch_data[ts->dd->x_index + 4 * i]);
>         y = join_bytes(ts->touch_data[ts->dd->y_index + 4 * i + 1],
>         ts->touch_data[ts->dd->y_index + 4 * i ]);
>         id = ts->touch_data[ts->dd->id_index + 4 * i] >> 4;
> }
>
>
> Or, in other words, your code uses the second-to-last nibble of each record as
> the touch id, while the Basewin code uses the last nibble (in little-endian
> order).
> Please correct me if I am wrong.


I will come back with the info on the touch id after I check the docs.
