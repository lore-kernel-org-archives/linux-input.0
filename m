From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 5/5] hid-multitouch: migrate 3M PCT touch screens to
 hid-multitouch
Date: Mon, 21 Mar 2011 11:34:47 +0100
Message-ID: <20110321103447.GA1734@polaris.bitmath.org>
References: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
 <1300454876-5017-6-git-send-email-benjamin.tissoires@enac.fr>
 <20110321090533.GE3784@polaris.bitmath.org>
 <AANLkTinAPFnHA=MWbb=Yu7U0AXrxHv2-95M=OequsAL7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:54778 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752521Ab1CUKbp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 06:31:45 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinAPFnHA=MWbb=Yu7U0AXrxHv2-95M=OequsAL7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 21, 2011 at 11:13:46AM +0100, Benjamin Tissoires wrote:
> On Mon, Mar 21, 2011 at 10:05, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> > Hi Benjamin,
> >
> > On Fri, Mar 18, 2011 at 02:27:56PM +0100, Benjamin Tissoires wrote:
> >> This patch merges the hid-3m-pct driver into hid-multitouch.
> >> To keep devices working the same way they used to with hid-3m-pct,
> >> we need to add two signal/noise ratios for width and height.
> >> We also need to work on width/height to send proper
> >> ABS_MT_ORIENTATION flag.
> >>
> >> Importing 3M into hid-multitouch also solved the bug in which
> >> devices handling width and height in their report descriptors
> >> did not show ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR.
> >>
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> >> Reviewed-by: St=E9phane Chatty <chatty@enac.fr>
> >> ---
> >
> > The patch _looks_ good, but I have problems getting this to work on=
 a
> > 3M2256. What devices were this one tested on so far?
>=20
> Hi Henrik,
>=20
> I tested it against 3M1968. I'll try to have it again to make more te=
sting.
> What symptoms do you have?

I think it is the input mode setting, but I am not sure yet.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
