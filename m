From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/6] mc13783 cleanup
Date: Sun, 18 Sep 2011 18:33:51 +0200
Message-ID: <20110918163351.GL32263@sortiz-mobl>
References: <20110824132740.GA28197@pengutronix.de>
 <201108250905.13168.philippe.retornaz@epfl.ch>
 <20110915151213.GE32263@sortiz-mobl>
 <20110915160321.GA29357@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36403 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233Ab1IRQbX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Sep 2011 12:31:23 -0400
Content-Disposition: inline
In-Reply-To: <20110915160321.GA29357@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org, Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, kernel@pengutronix.de, linux-input@vger.kernel.org

Hi Uwe,

On Thu, Sep 15, 2011 at 06:03:21PM +0200, Uwe Kleine-K=F6nig wrote:
> Hi Samuel,
>=20
> On Thu, Sep 15, 2011 at 05:12:13PM +0200, Samuel Ortiz wrote:
> > On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R=E9tornaz wrote=
:
> > > Le mercredi 24 ao=FBt 2011 15:27:40, Uwe Kleine-K=F6nig a =E9crit=
 :
> > > > Hello,
> > > >=20
> > > > this series removes the long obsolte mc13783 API after fixing a=
ll
> > > > remaining users.
> > >=20
> > > I posted a patch last month which was touching this MFD too.
> > > We will need to synchronize both patch.=20
> > I applied Uwe's patchset now.
> Thanks.
>=20
> >                               Could you please sync your code and s=
end me a
> > patchset that applies on top of:
> >=20
> > git://git.infradead.org/users/sameo/mfd-2.6.git for-next
> You can fetch the updated series from
>=20
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git mc13783
I merged this one on top of my for-next branch. My MFD tree temporary l=
ives on
infradead:

git://git.infradead.org/users/sameo/mfd-2.6.git

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
