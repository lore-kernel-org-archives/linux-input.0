From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Sun, 5 Apr 2015 16:53:43 -0700
Message-ID: <20150405235343.GA5313@dtor-ws>
References: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com>
 <20150405214833.GD31564@dtor-ws>
 <201504060000.32145@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32805 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbDEXxs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Apr 2015 19:53:48 -0400
Content-Disposition: inline
In-Reply-To: <201504060000.32145@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 06, 2015 at 12:00:32AM +0200, Pali Roh=E1r wrote:
> On Sunday 05 April 2015 23:48:33 Dmitry Torokhov wrote:
> > Hi Pali,
> >=20
> > On Sun, Mar 29, 2015 at 04:36:19PM +0200, Pali Roh=E1r wrote:
> > > This patch fixes commit 61579ba83934 ("Input: atkbd - expand
> > > Latitude's force release quirk to other Dells"). Before
> > > that commit release quirks were called for all Dell
> > > Latitude models. After that commit only for Portable Dell
> > > devices. But lot of Latitude models are Laptop or Notebook
> > > DMI devices so quirks are not called.
> > >=20
> > > Release quirks are still needed also for new Dell Latitude
> > > models, so this patch enables quirks for all Portable,
> > > Laptop, Notebook and Sub-Notebook Dell devices.
> >=20
> > Does Dell use all these types for their laptops? What models
> > do you know that need this quirk?
> >=20
> > Thanks.
> >=20
>=20
> I do not if Dell use all types, but months ago Matthew wrote to=20
> include also other numbers not only 9 (Laptop) and you agreed.

Hmm, I tried looking back but I could not quite find the discussion.

>=20
> I do not know exact list of models which needs these quirks, but=20
> before that commit (61579ba83934) it was used for all Latitude=20
> models. At least I see that switches do not generate release=20
> events and on older Latitude machines some Fn keys do not=20
> generate them too.

So the question is still: what models do need this quirk and what
chassis type they are used.

Regardless, I have not accepted quirks for force_release and atkbd
keymaps for many years now as the task to adjust both keymap and
force_release list has been offloaded to udev.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
