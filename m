From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 0/2] input: Driver for Goodix GT801 2+1 touchscreen
Date: Tue, 08 Dec 2015 13:14:51 +0100
Message-ID: <1449576891.28364.15.camel@hadess.net>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54974 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbbLHMPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2015 07:15:00 -0500
In-Reply-To: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Priit Laes <plaes@plaes.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tirdea Irina <irina.tirdea@intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>, linux-sunxi@googlegroups.com

On Mon, 2015-12-07 at 09:25 +0200, Priit Laes wrote:
> This series adds support for Goodix GT801 2+1 touchscreen controller
> and hooks it up on Gemei G9 tablet.
>=20
> Now about GT801 2+1 - I initially tried to implement this inside the
> existing Goodix driver, but unfortunately there are too many small
> bits and pieces that would make the otherwise simple driver a
> complicated mess:
> =C2=A0 - endianness differences of coordinate readouts
> =C2=A0 - totally different touch protocol
> =C2=A0 - configuration layout and version information
> =C2=A0 - I2C register differences (2 bytes vs single byte)

The goodix driver will get more complicated after we merge Irina's
patchset. Instead of looking at the differences between the protocols,
which don't look insurmountable (a switch statement in a few places,
right?), you should look at the code you could share:
- power management
- ESD support
- ACPI support
- the support for variants in goodix.c (911-variants, and 967-variants)
- ability to read and write config data to the device

Taking this into account (and the fact that I can't read Chinese that
well, so my reading of the specs is cursory), would it make sense to
merge the 2 drivers?

CC'ing Irina about this.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
