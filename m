From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH RFC V2 2/3] Input: goodix - use "inverted_[xy]" flags
 instead of "rotated_screen"
Date: Mon, 12 Oct 2015 15:10:41 +0200
Message-ID: <1444655441.28661.86.camel@hadess.net>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
	 <1444413352-24529-3-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48577 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbbJLNKy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 09:10:54 -0400
In-Reply-To: <1444413352-24529-3-git-send-email-merker@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>

On Fri, 2015-10-09 at 19:55 +0200, Karsten Merker wrote:
> The goodix touchscreen driver uses a "rotated_screen" flag for
> systems on which the touchscreen is mounted rotated by 180
> degrees with respect to the display.=C2=A0=C2=A0With the addition of
> support for the dt properties "touchscreen-inverted-x" and
> "touchscreen-inverted-y", a separate "rotated_screen" flag
> is not necessary any more. This patch replaces it by setting
> the inverted_x and inverted_y flags instead.
>=20
> Signed-off-by: Karsten Merker <merker@debian.org>

Acked-by: Bastien Nocera <hadess@hadess.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
