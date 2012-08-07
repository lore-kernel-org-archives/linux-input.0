From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC ebeam PATCH v3 2/2] input: misc: New USB eBeam input driver.
Date: Mon, 6 Aug 2012 18:43:54 -0700
Message-ID: <20120807014354.GA21477@core.coreip.homeip.net>
References: <1344288104-20731-1-git-send-email-yann.cantin@laposte.net>
 <1344288104-20731-3-git-send-email-yann.cantin@laposte.net>
 <20120806214359.GB30355@kroah.com>
 <502067C8.2020204@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <502067C8.2020204@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 07, 2012 at 02:56:40AM +0200, Yann Cantin wrote:
> Hi,
>=20
> Le 06/08/2012 23:43, Greg KH a =E9crit :
> > On Mon, Aug 06, 2012 at 11:21:44PM +0200, Yann Cantin wrote:
> >>
> >> Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
> >> ---
> >>  drivers/input/misc/ebeam.c |  764 +++++++++++++++++++++++++++++++=
+++++++++++++
> >>  1 file changed, 764 insertions(+)
> >>  create mode 100644 drivers/input/misc/ebeam.c
> >=20
> > What adds this file to the build?
> =20
> Sorry, i don't get it : what do you mean ?

Greg meant that you forgot to include Makefile and Kconfig changes with
this patch.

--=20
Dmitry
