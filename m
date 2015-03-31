From: Luca Coelho <luca@coelho.fi>
Subject: Re: [PATCH] Input: ALPS - fix max coordinates for v5 and v7
 protocols
Date: Tue, 31 Mar 2015 06:47:31 +0300
Message-ID: <1427773651.2999.2.camel@coelho.fi>
References: <20150322033656.GA35352@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dedo.coelho.fi ([88.198.205.34]:45096 "EHLO dedo.coelho.fi"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751261AbbCaEY6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 00:24:58 -0400
In-Reply-To: <20150322033656.GA35352@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Santiago Gala <sgala@apache.org>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-kernel@vger.kernel.org

On Sat, 2015-03-21 at 20:36 -0700, Dmitry Torokhov wrote:
> Commit 3296f71cd2fde7a2ad52e66a27eae419f6328066 ("Input: ALPS - conso=
lidate
> setting protocol parameters") inadvertently moved call to
> alps_dolphin_get_device_area() from v5 to v7 protocol, causing both
> protocols report incorrect maximum values for X and Y axes which resu=
lted
> in crash in Synaptics X driver.
>=20
> Reported-by: Santiago Gala <sgala@apache.org>
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Tested-by: Luciano Coelho <luca@coelho.fi>

Tested on a Dell E5250.

Are you planning to send this to 4.0-rc*? That would be nice, since thi=
s
is a regression from 3.19.

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
