From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: alps: Reset mouse before identifying it
Date: Mon, 13 Oct 2014 23:08:34 -0700
Message-ID: <20141014060834.GA8084@dtor-glaptop>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <1412329392-5580-2-git-send-email-pali.rohar@gmail.com>
 <542E70CF.40205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49159 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaJNGIi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2014 02:08:38 -0400
Content-Disposition: inline
In-Reply-To: <542E70CF.40205@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 03, 2014 at 11:47:59AM +0200, Hans de Goede wrote:
> Hi,
>=20
> Thanks for working on this!
>=20
> On 10/03/2014 11:43 AM, Pali Roh=E1r wrote:
> > On some systems after starting computer function alps_identify() do=
es not detect
> > dual ALPS touchpad+trackstick device correctly and detect only touc=
hpad.
> >=20
> > Resetting ALPS device before identifiying it fixing this problem an=
d both parts
> > touchpad and trackstick are detected.
> >=20
> > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > Tested-by: Pali Roh=E1r <pali.rohar@gmail.com>
>=20
> Looks good and seems sensible:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>

*sigh* I am not really happy about this, as we making boot longer and l=
onger
for people without ALPS touchpads. It would be better if we only reset =
the
mouse when we knew we are dealing with ALPS, and even better if we only=
 reset
it when we suspected that we missed trackstick. Any chance of doing thi=
s?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
