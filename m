From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv v2] Input: zforce - make the interrupt GPIO optional
Date: Mon, 3 Aug 2015 13:05:34 -0700
Message-ID: <20150803200534.GC38878@dtor-ws>
References: <1438583646-14022-1-git-send-email-dirk.behme@de.bosch.com>
 <1763405.uXNYd4iq17@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35813 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbbHCUFj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 16:05:39 -0400
Received: by pdrg1 with SMTP id g1so78244953pdr.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2015 13:05:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1763405.uXNYd4iq17@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

On Mon, Aug 03, 2015 at 09:54:49AM +0200, Heiko St=FCbner wrote:
> Hi Dirk,
>=20
> Am Montag, 3. August 2015, 08:34:06 schrieb Dirk Behme:
> > Add support for hardware which uses an I2C Serializer / Deserialize=
r
> > (SerDes) to communicate with the zFroce touch driver. In this case =
the
> > SerDes will be configured as an interrupt controller and the zForce=
 driver
> > will have no access to poll the GPIO line.
> >=20
> > To support this, we add two dedicated new GPIOs in the device tree:
> > reset-gpio and irq-gpio. With the irq-gpio being optional, then.
> >=20
> > To not break the existing device trees, the index based 'gpios' ent=
ries
> > are still supported, but marked as deprecated.
> >=20
> > With this, if the interrupt GPIO is available, either via the old o=
r new
> > device tree style, the while loop will read and handle the packets =
as long
> > as the GPIO indicates that the interrupt is asserted (existing, unc=
hanged
> > driver behavior).
> >=20
> > If the interrupt GPIO isn't available, i.e. not configured via the =
new
> > device tree style, we are falling back to one read per ISR invocati=
on
> > (new behavior to support the SerDes).
> >=20
> > Note that the gpiod functions help to handle the optional GPIO:
> > devm_gpiod_get_index_optional() will return NULL in case the interr=
upt
> > GPIO isn't available. And gpiod_get_value_cansleep() does cover thi=
s, too,
> > by returning 0 in this case.
> >=20
> > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>=20
> looks nice now in v2, thanks :-)
>=20
> Reviewed-by: Heiko Stuebner <heiko.stuebner@bq.com>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
