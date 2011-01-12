From: "Henrik Rydberg" <rydberg@bitmath.org>
Subject: Re: [PATCH v2] hid-multitouch: changes from the review process
Date: Wed, 12 Jan 2011 13:27:41 +0100
Message-ID: <20110112122741.GA29373@polaris.bitmath.org>
References: <1294760754-7885-1-git-send-email-benjamin.tissoires@enac.fr>
 <20110111173511.GA3461@polaris.bitmath.org>
 <AANLkTin86WMvEpNAm2T8wR=GgUBtYqoqGJxZm7hKnEoE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp1.one.com ([195.47.247.21]:45066 "EHLO csmtp1.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947Ab1ALM1s (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 07:27:48 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin86WMvEpNAm2T8wR=GgUBtYqoqGJxZm7hKnEoE@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 06:38:24PM +0100, Benjamin Tissoires wrote:
> On Tue, Jan 11, 2011 at 6:35 PM, Henrik Rydberg <rydberg@bitmath.org>=
 wrote:
> > On Tue, Jan 11, 2011 at 04:45:54PM +0100, Benjamin Tissoires wrote:
> >> * amended Kconfig (PixCir and Hanvon are the same panel but with
> >> =A0 different name)
> >> * insert field name in mt_class and retrieving it in mt_probe
> >> * add 2 quirks: MT_QUIRK_VALID_IS_INRANGE, MT_QUIRK_VALID_IS_CONFI=
DENCE,
> >> =A0 in order to find the field "valid"
> >> * inlined slot_is_contactid and slot_is_contact_number
> >> * cosmetics changes (tabs and comments)
> >> * do not send unnecessary properties once the touch is up
> >>
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> >
> > There are some syntactic suboptimalities in the resulting file that
> > perhaps could be fixed, but content-wise, I have nothing further. S=
o,
> > given that it actually works,
> >
> > Acked-by: Henrik Rydberg <rydberg@euromail.se>
> >
> > Thank you very much for your work, Benjamin.
>=20
> Thanks for the review Henrik,

Regarding the quanta patches you have pending, IFAICT the 0408:3001
device is not properly supported currently, so perhaps that one could
be added to the list, too.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
