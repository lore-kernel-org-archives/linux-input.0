From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] Input: add dt support to zforce driver
Date: Mon, 27 Jan 2014 22:45:40 -0800
Message-ID: <20140128064540.GB16142@core.coreip.homeip.net>
References: <2587208.XYbbI8xJiH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:59787 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaA1Gpo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jan 2014 01:45:44 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so6710954pdj.15
        for <linux-input@vger.kernel.org>; Mon, 27 Jan 2014 22:45:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2587208.XYbbI8xJiH@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bqreaders.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi Heiko,

On Thu, Jan 09, 2014 at 10:19:15PM +0100, Heiko St=FCbner wrote:
> This adds the binding documentation and necessary parsing code to mak=
e
> zforce based touchscreen usable on devicetree platforms.
>=20
> Heiko Stuebner (3):
>   dt-bindings: bindings for zforce touchscreens
>   Input: zforce: Use internal pdata pointer instead of dev_get_platda=
ta
>   Input: zforce: add devicetree support
>=20
>  .../bindings/input/touchscreen/zforce_ts.txt       |   30 ++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/input/touchscreen/zforce_ts.c              |   63 ++++++++++=
++++++++--
>  3 files changed, 89 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/zforce_ts.txt
>=20

I applied the 2nd one and then folded parts of 1st into the 3rd, leavin=
g
changes to devicetree/bindings/vendor-prefixes.txt out. Please resubmit
them to DT maintainers.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
