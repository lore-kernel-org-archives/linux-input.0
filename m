From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Mon, 24 May 2010 16:15:03 +1000
Message-ID: <20100524061503.GA20447@barra.redhat.com>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>
 <1274213429-22667-2-git-send-email-rydberg@euromail.se>
 <AANLkTikpmYwEYh5Dh-p3478cDMVo9hXOsDkt54ltHW6J@mail.gmail.com>
 <4BF4E00A.30206@euromail.se>
 <AANLkTinYX96zokFF6Rc-3_gxIrMZmvMS_pw3YdQD6CG4@mail.gmail.com>
 <1274455140.1871.8.camel@tron>
 <AANLkTimemw0iAslk6jeuwf0LGRgCo0-2Mvpgso42CP5Z@mail.gmail.com>
 <4BF6FA55.6040900@euromail.se>
 <20100524052530.GD16369@barra>
 <AANLkTimoAPwV8IUox5MpOrFsefdte15dSCmNnuZ7bCOn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:11982 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0EXGR6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 02:17:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimoAPwV8IUox5MpOrFsefdte15dSCmNnuZ7bCOn@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Rafi Rubin <rafi@seas.upenn.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Michael Poole <mdpoole@troilus.org>

On Sun, May 23, 2010 at 10:48:35PM -0700, Ping Cheng wrote:
> On Sun, May 23, 2010 at 10:25 PM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Fri, May 21, 2010 at 11:25:41PM +0200, Henrik Rydberg wrote:
> >> Ping Cheng wrote:
> >> > On Fri, May 21, 2010 at 8:19 AM, Rafi Rubin <rafi@seas.upenn.edu=
> wrote:
> >> [...]
> >> >> Ping: please confirm, are you actually talking about each finge=
r simultaneously sending multiple positions?
> >> >
> >> > You are definitely on the right track. =A0The fingers/touch obje=
cts can
> >> > be represented two-dimensionally (x,y) instead of one-dimensiona=
lly
> >> > (ABS_MT_TRACKING_ID). =A0I think we can survive with the current=
 MT_BLOB
> >> > definition although some optimization would be helpful, especial=
ly for
> >> > filtering. For the sake of Henrik great effort, I'd like to see =
his
> >> > current patchset gets in the tree before we start another round =
of
> >> > "suggestions".
> >> >
> >> > Thank you for asking.
> >>
> >> Regarding blobs, I confused myself yesterday. The original intenti=
on of the blob
> >> =A0id was in fact to be able to "paint" more generic contact forms=
=2E However, no
> >> driver has come close to doing this yet, so it has gotten close to=
 no attention.
> >> Now, to address the question of how to communicate more elaborate =
contact forms,
> >> it seems one can combine the two goals "one position per slot" and=
 "multiple
> >> positions per contact" by simply repeating the same tracking id fo=
r a set of
> >> slots, like this:
> >>
> >> ABS_SLOT 0
> >> ABS_MT_TRACKING_ID 14
> >> ABS_MT_POSITION_X x[0]
> >> ABS_MT_POSITION_Y y[0]
> >> ABS_SLOT 1
> >> ABS_MT_TRACKING_ID 14
> >> ABS_MT_POSITION_X x[1]
> >> ABS_MT_POSITION_Y y[1]
> >> ABS_SLOT 2
> >> ABS_MT_TRACKING_ID 14
> >> ABS_MT_POSITION_X x[2]
> >> ABS_MT_POSITION_Y y[2]
> >>
> >> Not all too different from what you suggested, and there is no blo=
b id involved
> >> at all. And yes, it would require additional parsing power at the =
user end.
> >> Something for later.
> >
> > This is confusing me now :)
> >
> > How would a device get multiple x/y coordinates for a single contac=
t? I
> > could understand a range of coordinates but that's what we have the
> > ABS_MT_WIDTH_MAJOR/MINOR for. If a touchpoint sends two different x=
/y
> > coordinates, wouldn't that be two touchpoints, tracked individually=
 and thus
> > with a different tracking ID?
> >
> > I read the example above as _the_ example for using blob IDs to com=
bine
> > multiple contacts into one semantic contact.
>=20
> As Henrik pointed out, the current BLOB format is for "more generic
> contact forms", such as rectangles or ellipses.  They are special
> blobs. A generic (true) blob doesn't have to have a regular shape.  I=
t
> is most likely in an irregular shape. They would be represented in an
> array of points/contacts/(x,y)s,  whichever term works for you :).

Hmm. I always assumed blob is for irregular shapes, and rectangles or o=
thers
are just subsets of irregular shapes (with slightly less 'ir', maybe).
So what would be the difference between these two event streams?

ABS_SLOT 0
ABS_MT_TRACKING_ID 14
ABS_MT_POSITION_X x[0]
ABS_MT_POSITION_Y y[0]
ABS_SLOT 1
ABS_MT_TRACKING_ID 14
ABS_MT_POSITION_X x[1]
ABS_MT_POSITION_Y y[1]


ABS_SLOT 0
ABS_MT_TRACKING_ID 14
ABS_MT_BLOB_ID 1
ABS_MT_POSITION_X x[0]
ABS_MT_POSITION_Y y[0]
ABS_SLOT 1
ABS_MT_BLOB_ID 1
ABS_MT_TRACKING_ID 15
ABS_MT_POSITION_X x[1]
ABS_MT_POSITION_Y y[1]

Cheers,
  Peter

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
