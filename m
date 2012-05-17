From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 2/2] Input: spear-keyboard: add device tree bindings
Date: Thu, 17 May 2012 14:31:46 -0700
Message-ID: <20120517213145.GB29141@core.coreip.homeip.net>
References: <cover.1333009670.git.viresh.kumar@st.com>
 <eebfde0a1511204cab203fa18efe6264abe00486.1333009670.git.viresh.kumar@st.com>
 <20120509052828.GD10514@core.coreip.homeip.net>
 <CAOh2x=k2bZy-FV9XUWUxDaB7hCi1mfYv9tFVTnGObiAVjfOpvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55213 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab2EQVby (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 May 2012 17:31:54 -0400
Received: by dady13 with SMTP id y13so2949516dad.19
        for <linux-input@vger.kernel.org>; Thu, 17 May 2012 14:31:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOh2x=k2bZy-FV9XUWUxDaB7hCi1mfYv9tFVTnGObiAVjfOpvQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, swarren@nvidia.com, spear-devel@list.st.com, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, linux-input@vger.kernel.org, sr@denx.de

On Tue, May 15, 2012 at 12:24:11PM +0530, viresh kumar wrote:
> Hi Dmitry,
>=20
> On Wed, May 9, 2012 at 10:58 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Now that I got matrix_keypad_build_keymap() also handle DT case, ho=
w
> > about the patch below?
> >
> > Input: spear-keyboard - add device tree bindings
> >
> > From: Viresh Kumar <viresh.kumar@st.com>
> >
> > This adds simple DT bindings for spear-keyboard controller.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >
> > =A0drivers/input/keyboard/spear-keyboard.c | =A0 71 +++++++++++++++=
+++++++++-------
> > =A01 files changed, 56 insertions(+), 15 deletions(-)
>=20
> You missed following file in this patch, which was there in original =
patch.
>=20
> Documentation/devicetree/bindings/input/spear-keyboard.txt

Oh, yes, sorry about that - that is danges of stgit - if patch does not
import cleanly for some reason (local changes in the tree for example)
and I have to massage and apply the patch then new files are not added
to git automatically and I sometimes forget about them. I'll ressurect
the doc change.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
