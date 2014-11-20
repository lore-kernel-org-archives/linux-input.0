From: Anders Kaseorg <andersk@mit.edu>
Subject: Re: Bisected two-finger scrolling regression on Lenovo Y50 (Re:
 [PATCH 1/5] Input: elantech - use elantech_report_trackpoint for hardware
 v4 too)
Date: Thu, 20 Nov 2014 03:21:19 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1411200320260.37899@buzzword-bingo.mit.edu>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org> <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org> <546D9120.1040703@mit.edu> <20141120074207.GA30434@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:55109 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbaKTIVi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 03:21:38 -0500
In-Reply-To: <20141120074207.GA30434@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulrik De Bie <ulrik.debie-os@e2big.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Marcus Overhagen <marcus.overhagen@gmail.com>

On Thu, 20 Nov 2014, Dmitry Torokhov wrote:
> Thank you for your report. Please try the patch below.
>=20
> [=E2=80=A6]
>=20
> Input: elantech - trust firmware about trackpoint presence
>=20
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Only try to parse data as coming from trackpoint if firmware told us =
that
> trackpoint is present.
>=20
> Fixes commit caeb0d37fa3e387eb0dd22e5d497523c002033d1
>=20
> Reported-and-tested-by: Marcus Overhagen <marcus.overhagen@gmail.com>
> Reported-by: Anders Kaseorg <andersk@mit.edu>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

That fixes it for me too, thanks.

Anders
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
