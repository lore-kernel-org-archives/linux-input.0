From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/34] move grover_remove to .devexit.text
Date: Mon, 5 Oct 2009 22:05:51 -0700
Message-ID: <20091006050551.GA27881@core.coreip.homeip.net>
References: <20091001082607.GA2181@pengutronix.de> <1254385718-14254-5-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756165AbZJFFGi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1254385718-14254-5-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 01, 2009 at 10:28:09AM +0200, Uwe Kleine-K=F6nig wrote:
> The function grover_remove is used only wrapped by __devexit_p so def=
ine
> it using __devexit.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

=46olded together with your other patch to sparkspkr and applied.

Thanks Uwe.

--=20
Dmitry
