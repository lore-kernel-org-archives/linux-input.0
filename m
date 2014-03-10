From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
Date: Mon, 10 Mar 2014 16:35:57 +0000
Message-ID: <20140310163557.GJ13661@lee--X1>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1>
 <20140310152859.GA29054@core.coreip.homeip.net>
 <20140310153815.GE13661@lee--X1>
 <20140310155824.GB29054@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:53060 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbaCJQgE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 12:36:04 -0400
Received: by mail-bk0-f53.google.com with SMTP id r7so1220475bkg.12
        for <linux-input@vger.kernel.org>; Mon, 10 Mar 2014 09:36:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140310155824.GB29054@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Giuseppe Condorelli <giuseppe.condorelli@st.com>

> > > > > This patch adds ST Keyscan driver to use the keypad hw a subs=
et
> > > > > of ST boards provide. Specific board setup will be put in the
> > > > > given dt.
> > > > >=20
> > > > > Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.co=
m>
> > > > > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > > >=20
> > > > Are you sure these are in the correct order?
> > > >=20
> > > > What is the history of this commit?
> > > >=20
> > > > > ---
> > > > >  .../devicetree/bindings/input/st-keypad.txt        |  50 +++=
+
> > > >=20
> > > > This should be submitted as a seperate patch.
> > >=20
> > > Why do we have such requirement? To me it would make more sense t=
o add
> > > binding documentation in the same commit as the code that uses th=
ese
> > > bindings.
> >=20
> > I'm inclined to agree with you and that's actually how we used to d=
o
> > it, but a decision was made by the DT guys at one of the Kernel
> > Summits to submit Documentation as a separate patch.
>=20
> Do you have background for this decision? To me it is akin splitting
> header file into a separate patch.

The discussion/decision was verbal unfortunately.

I don't really mind either way. I'm just attempting to enforce the
decisions that were made by the forces-that-be. Perhaps ping
devicetree@vger.kernel.org with me in CC for more clarification if
required.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
