From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v8] input: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Wed, 9 May 2012 22:09:55 +0100 (BST)
Message-ID: <1336597795.45073.YahooMailClassic@web29017.mail.ird.yahoo.com>
References: <20120509080006.GJ10514@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm23-vm2.bullet.mail.ird.yahoo.com ([212.82.109.231]:38313 "HELO
	nm23-vm2.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761026Ab2EIVQN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 May 2012 17:16:13 -0400
In-Reply-To: <20120509080006.GJ10514@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: philipp.zabel@gmail.com, linux-input@vger.kernel.org

Hello Dmitry,

--- On Wed, 9/5/12, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> The driver looks excellent now, I have just a few nits:
>=20
> - you do not need separate mutex and counter; it is
> perfectly fine to
> =A0 use input device's ones;
>=20
> - we don't really need min/max for coordinates: the defaults
> are good
> =A0 for your device and if more devices come with
> different limits one
> =A0 could adjust limits via EVIOCSABS ioctls.
>=20
> I also took libertu if rearranging the code a bit so it
> flows more like
> the rest of the input drivers. Could you please tell me if
> the patch
> below breaks your device or if it still works?

It still works! Thanks.

Will you apply a combined patch (my patch v8 + your patch),
or should I submit them as patch v9?

Regards,
Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
