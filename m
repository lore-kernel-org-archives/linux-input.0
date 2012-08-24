From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC ebeam PATCH v4 2/2] input: misc: New USB eBeam input driver.
Date: Fri, 24 Aug 2012 13:41:04 +0200
Message-ID: <1555763.Oi7gGGn7BU@linux-lqwf.site>
References: <1345673514-11575-1-git-send-email-yann.cantin@laposte.net> <1368810.q4rGz16CTW@linux-lqwf.site> <50374B69.3040002@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50374B69.3040002@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Friday 24 August 2012 11:37:45 Yann Cantin wrote:
> Hi,
>=20
> Le 23/08/2012 09:23, Oliver Neukum a =E9crit :
> > On Thursday 23 August 2012 00:11:54 Yann Cantin wrote:

> > These functions are identical. You should unify them.
>=20
> Removed reset_resume from the driver (optional, and not needed
> for this hardware).

Why did you do that? It is always better to have reset_resume().
And you cannot tell whether it will be needed.

	Regards
		Oliver
