From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Thu, 16 Jul 2015 15:59:58 +0200
Message-ID: <55A7B8DE.6050704@gmail.com>
References: <55A18959.7050502@gmail.com> <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com> <55A3CA05.5030302@gmail.com> <CAFPB+YcZnzHVdztqYuD63fNGhedDZR4xEW8Nkd+zJ_H_gm+L-w@mail.gmail.com> <55A3D6DA.9090206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36254 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbbGPOA5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 10:00:57 -0400
Received: by wgxm20 with SMTP id m20so59288222wgx.3
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 07:00:56 -0700 (PDT)
In-Reply-To: <55A3D6DA.9090206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Dolca <robert.dolca@gmail.com>
Cc: linux-input@vger.kernel.org

Please excuse me if I'm being to brash. I'd love to see complete Silead
touchscreen controller support in the mainline kernel, but with the hardware
being what it is and the lack of complete public documentation, I understand
this is a bit difficult.

> /* The last 4 bits are the touch id */
> id = buf[offset + SILEAD_POINT_ID_OFF] & SILEAD_TOUCH_ID_MASK;
>
> /* The 1st 4 bits are part of X */
> buf[offset + SILEAD_POINT_ID_OFF] =
>	(buf[offset + SILEAD_POINT_ID_OFF] & SILEAD_X_HSB_MASK)
>	>> 4;
>
> y = le16_to_cpup((__le16 *)(buf + offset));
> x = le16_to_cpup((__le16 *)(buf + offset + SILEAD_POINT_X_OFF));

Can you confirm that your data sheet/hardware does in fact use the lower 4
bits of byte 3 of each point record as the touch id, and not the upper 4 bits?

I just checked, both the Basewin driver (and all drivers derived from it) and
my testing hardware attribute it to the high nibble. The lower nibble is part
of the x coordinate.

Aside from this, would you be interested in making your driver compatible with
legacy/"broken" hardware? I'd start working on a patch if this is ok to you.

This would encompass the following:
- Adding fallbacks for unavailable information (width, height, number of touch
points, finger tracking availability, axis swapping and mirroring, firmware
name), maybe keeping the device uninitialized until all parameters are set
- Adding a sysfs interface and/or module options to set these attributes, or
possibly adding platform quirks that autoconfigurate depending on DMI data
(better ideas are welcome)
- Adding code paths for the missing functionality (finger tracking,
swapping/mirroring, other quirks)

