From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Add driver for acer keybard with broken rdesc
Date: Tue, 17 Feb 2015 13:30:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171329340.2279@pobox.suse.cz>
References: <54C85FB5.9050404@simon-woerner.de> <1422492195-11492-1-git-send-email-linux@simon-woerner.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35453 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbbBQMaK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 07:30:10 -0500
In-Reply-To: <1422492195-11492-1-git-send-email-linux@simon-woerner.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux@simon-woerner.de
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, =?ISO-8859-15?Q?Simon_W=F6rner?= <mail@simon-woerner.de>

On Thu, 29 Jan 2015, linux@simon-woerner.de wrote:

> From: Simon W=C3=B6rner <mail@simon-woerner.de>
>=20
> HID: Add driver for acer keybard with broken rdesc

Hi Simon,

to make sure proper device <-> driver binding is performed, you also ha=
ve=20
to add device ID to the hid_have_special_driver[] array.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
