From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: alps: Reset mouse before identifying it
Date: Wed, 15 Oct 2014 10:43:15 -0700
Message-ID: <20141015174315.GA1968@dtor-ws>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <542E70CF.40205@redhat.com>
 <20141014060834.GA8084@dtor-glaptop>
 <201410151453.12115@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34994 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbaJORnT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 13:43:19 -0400
Content-Disposition: inline
In-Reply-To: <201410151453.12115@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 15, 2014 at 02:53:11PM +0200, Pali Roh=E1r wrote:
> On Tuesday 14 October 2014 08:08:34 Dmitry Torokhov wrote:
> > On Fri, Oct 03, 2014 at 11:47:59AM +0200, Hans de Goede wrote:
> > > Hi,
> > >=20
> > > Thanks for working on this!
> > >=20
> > > On 10/03/2014 11:43 AM, Pali Roh=E1r wrote:
> > > > On some systems after starting computer function
> > > > alps_identify() does not detect dual ALPS
> > > > touchpad+trackstick device correctly and detect only
> > > > touchpad.
> > > >=20
> > > > Resetting ALPS device before identifiying it fixing this
> > > > problem and both parts touchpad and trackstick are
> > > > detected.
> > > >=20
> > > > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > > > Tested-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > >=20
> > > Looks good and seems sensible:
> > >=20
> > > Acked-by: Hans de Goede <hdegoede@redhat.com>
> >=20
> > *sigh* I am not really happy about this, as we making boot
> > longer and longer for people without ALPS touchpads. It would
> > be better if we only reset the mouse when we knew we are
> > dealing with ALPS, and even better if we only reset it when
> > we suspected that we missed trackstick. Any chance of doing
> > this?
> >=20
> > Thanks.
>=20
> Dmitry, problem is that function check which detecting trackstick=20
> does not working when I start my laptop from power-off state and=20
> do not reset PS/2 device. But detecting ALPS touchpad looks like=20
> working. So if do not like this idea, what about doing something=20
> like this in alps_dectect function?
>=20
> int alps_detect(...)
> {
> ...
> /* detect if device is ALPS */
> if (alps_identify(...) < 0)
> return -1;
> /* now we know that device is ALPS */
> if (!(flags & ALPS_DUALPOINT)) {
> /* reset it and identify again, maybe there is trackstick */
> psmouse_reset(...);
> alps_identify(...);
> }
> ...
> }
>=20
> It will does not affect non ALPS devices (because first identify=20
> call will fail), but will affect ALPS devices without trackstick=20
> (because identify will be called twice and reset too).

I think this is a step in right direction. Do you know what exactly
fails in alps_identify() on your box if you do not call psmouse_reset?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
