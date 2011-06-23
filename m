From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for
 device-tree platform data
Date: Thu, 23 Jun 2011 13:39:08 +0100
Message-ID: <20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
	<1308823455-14446-2-git-send-email-david@protonic.nl>
	<BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55839 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759227Ab1FWMgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 08:36:52 -0400
In-Reply-To: <BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Jander <david@protonic.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> > + =A0 =A0 =A0 - gpios: OF devcie-tree gpio specificatin.
> > + =A0 =A0 =A0 - label: Descriptive name of the key.
> > + =A0 =A0 =A0 - linux,code: Keycode to emit.
>=20
> The fact that this is the Linux internal keycode definitions still
> makes me nervous.  Is there no existing standard for keycodes emitted
> by keyboard devices?

There is but no standard lookup table. For Intel MID we do a translatio=
n
between Linux key names in the firmware and keycodes but there isn't a
generic helper for it.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
