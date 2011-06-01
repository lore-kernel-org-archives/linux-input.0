From: simon@mungewell.org
Subject: Re: Byte swapping u16 data in HID report
Date: Wed, 1 Jun 2011 11:02:44 -0400
Message-ID: <dcea9655b8d109dafa45f240f7aebf9f.squirrel@host171.canaca.com>
References: <80b32cfd7dc9e8afee2c4d9e21d1a7e3.squirrel@host171.canaca.com>
    <20110601125832.78d862ee.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:60270 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab1FAPCr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jun 2011 11:02:47 -0400
In-Reply-To: <20110601125832.78d862ee.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Marcin Tolysz <tolysz@gmail.com>


> Marcin Tolysz (added to CC), worked on the sixaxis descriptor before,
> see http://permalink.gmane.org/gmane.linux.bluez.kernel/5184

Looks like this is over a year old, so I presume that it got dropped.

For reference I use a small(er) shim to the existing descriptor
--
static const u8 sixaxis_rdesc_fixup[] = {
    0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
    0x81, 0x01, 0x75, 0x10, 0x95, 0x04, 0x26, 0xFF,
    0x03, 0x46, 0xFF, 0x03, 0x09, 0x01, 0x81, 0x02
    };
--
    if ((sc->quirks & SIXAXIS_CONTROLLER_USB) &&
            *rsize == 148 && rdesc[83] == 0x75) {
        hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
        memcpy((void *)&rdesc[83], (void *) &sixaxis_rdesc_fixup,
sizeof(sixaxis_rdesc_fixup));
--

I'll look at the byte swap stuff from Marcin's patch and submit a patch
here it appears to work.

BTW. There are a great set of tools for encoding/decoding the HID
descriptors here:
http://digimend.sourceforge.net/

Cheers,
Simon

