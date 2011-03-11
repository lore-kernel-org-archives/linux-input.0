From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Fri, 11 Mar 2011 12:31:57 +0100
Message-ID: <20110311113157.GA3342@polaris.bitmath.org>
References: <1299627518.2306.47.camel@itzy>
 <20110309082455.GA3166@polaris.bitmath.org>
 <AANLkTikDBTFNWhYoR5B-kfZ8Ud_aiW36qrTNJsJgHdTJ@mail.gmail.com>
 <20110309092337.GC3824@polaris.bitmath.org>
 <AANLkTi=TJ3RPOSP3XyqOfX8Aeep3-uFcHmcia6+a2Wxy@mail.gmail.com>
 <20110309114038.GA9143@polaris.bitmath.org>
 <1299823326.1910.11.camel@itzy>
 <AANLkTims5Qg3m7pe-PBFNjmTmeOCPi6i8wqqrK1OJS84@mail.gmail.com>
 <AANLkTi=Awco-yuQUr2ZFYHPGjfAFa2cLxN6aMby=M0VX@mail.gmail.com>
 <AANLkTimQWT9BtLHVL8HgaiS8tabrtUYGK-Z3qjH73QvH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:42573 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184Ab1CKL3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 06:29:47 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimQWT9BtLHVL8HgaiS8tabrtUYGK-Z3qjH73QvH@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

On Fri, Mar 11, 2011 at 10:52:55AM +0100, Benjamin Tissoires wrote:
> Hi Richard,
>=20
> On Fri, Mar 11, 2011 at 10:23, Richard Nauber
> <richard.nauber@googlemail.com> wrote:
> >>On Fri, Mar 11, 2011 at 7:53 AM, Benjamin Tissoires
> >><benjamin.tissoires@gmail.com> wrote:
> >> Hi Richard,
> >>
> >> I'm really sorry, but it's a NACK for me:
> >> what ever Henrik said, I do not want to have numerical constants
> >> throughout the code. It would be the open door to many others. The
> >> reason we have "mt_class" is to regroup each per-device parameters=
 in
> >> it. So there is no need to introduce those constants everywhere.
> >
> > Hm, so should I make a patch that applies on top of Henriks "Send
> > events per slot if CONTACTCOUNT is missing" =A0and uses the generic=
 XY
> > fixup of my v3 patch?
> >
>=20
> I would say so. Please just change the name of the field .axis by a b=
etter name.

I disagree with this approach. The code in question is per device bug,
not per device. The next firmware bug might be that the axis are
shifted, or that the value is given with wrong byte order, we just
don't know. Until we know what the next bug has in common with the old
ones, let's be simple.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
