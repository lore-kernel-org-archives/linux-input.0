From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: Add keycodes for some missing Fn key
 combinations
Date: Sat, 17 May 2014 14:32:48 -0700
Message-ID: <20140517213248.GB19657@core.coreip.homeip.net>
References: <201405171639.45722@pali>
 <1400337817-14473-2-git-send-email-pali.rohar@gmail.com>
 <20140517203054.GA19657@core.coreip.homeip.net>
 <201405172238.30089@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64630 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEQVcv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 May 2014 17:32:51 -0400
Content-Disposition: inline
In-Reply-To: <201405172238.30089@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-hotplug@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org

On Sat, May 17, 2014 at 10:38:30PM +0200, Pali Roh=E1r wrote:
> On Saturday 17 May 2014 22:30:54 Dmitry Torokhov wrote:
> > Hi Pali,
> >=20
> > On Sat, May 17, 2014 at 04:43:36PM +0200, Pali Roh=E1r wrote:
> > > There are already defined some Fn key combinations, but not
> > > all. This patch adds missing combinations for support in
> > > dell-wmi driver.
> > >=20
> > > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> > > ---
> > >=20
> > >  include/uapi/linux/input.h |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/include/uapi/linux/input.h
> > > b/include/uapi/linux/input.h index f484952..3a32799 100644
> > > --- a/include/uapi/linux/input.h
> > > +++ b/include/uapi/linux/input.h
> > > @@ -672,6 +672,12 @@ struct input_keymap_entry {
> > >=20
> > >  #define KEY_FN_F		0x1e2
> > >  #define KEY_FN_S		0x1e3
> > >  #define KEY_FN_B		0x1e4
> > >=20
> > > +#define KEY_FN_Q		0x1e5
> > > +#define KEY_FN_W		0x1e6
> > > +#define KEY_FN_R		0x1e7
> > > +#define KEY_FN_T		0x1e8
> > > +#define KEY_FN_A		0x1e9
> > > +#define KEY_FN_G		0x1ea
> >=20
> > What do they actually do?
> >=20
> > Thanks.
>=20
> All 10 combinations Fn+Q ... Fn+T, Fn+A ... Fn+G are reported by=20
> WMI and I need to assign some keycodes for them in dell-wmi=20
> driver.=20

If they do not have a well-defined meaning then KEY_UNKNOWN is
appropriate and user later can redefine via EVIOCSKEYCODE to the code
they wish.

> And because More FN_* constants are already defined in=20
> input.h I added those which are missing.

I am not sure if adding existing generic KEY_FN_* was a good idea.

>=20
> With this patch series I'm able to use above Fn combinations for=20
> my own keyboard shortcuts. Before this patch all Fn combinations=20
> were one same keycode - which was useless.

Are there not enough key definitions already to accommodate actions you
want? dell-wmi supports changing keymap from usersopace so you should b=
e
able to remap entries you want to the actions you need.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
