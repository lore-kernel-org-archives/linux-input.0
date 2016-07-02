From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/2] Input-at32psif: Fine-tuning for OOM handling in
 psif_probe()
Date: Sat, 02 Jul 2016 13:45:33 -0700
Message-ID: <1467492333.1968.5.camel@perches.com>
References: <566ABCD9.1060404@users.sourceforge.net>
	 <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Sat, 2016-07-02 at 21:00 +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 2 Jul 2016 20:50:09 +0200
>=20
> A few update suggestions were taken into account
> from static source code analysis.
>=20
> Markus Elfring (2):
> =A0 Return directly after a failed kzalloc()
> =A0 Remove two OOM messages
>=20
> =A0drivers/input/serio/at32psif.c | 10 +++-------
> =A01 file changed, 3 insertions(+), 7 deletions(-)

What possible rationale is there for including this "references" header=
?
566ABCD9.1060404@users.sourceforge.net

This message id is for your message:
	"Source code review around jump label usage"
sent December 11, 2015!

Please stop adding unnecessary and useless email headers.
--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
