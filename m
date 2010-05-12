From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 GPIO
Date: Wed, 12 May 2010 13:52:29 +0100
Message-ID: <20100512125229.GB8082@rakim.wolfsonmicro.main>
References: <AANLkTikXR3vlUg-XX33LCrAiVxk0nJWNe__7SU7g1DuF@mail.gmail.com>
 <20100512123026.GA8082@rakim.wolfsonmicro.main>
 <AANLkTimGhfLPxAIhtTYoUO-te1mUs86LEVEcYN7DgOtY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40941 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751565Ab0ELMwb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 08:52:31 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimGhfLPxAIhtTYoUO-te1mUs86LEVEcYN7DgOtY@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-input@vger.kernel.org

On Wed, May 12, 2010 at 02:50:44PM +0200, Manuel Lauss wrote:
> On Wed, May 12, 2010 at 2:30 PM, Mark Brown

> > The WM9712 does not support this feature. =A0It only supports setti=
ng the
> > GPIO status by use of AC'97 slot 12 for which there's currently no
> > standard glue on Linux. =A0Setting slot 12 needs to be done in the =
AC'97
> > controller.

> Wonderful.  Thanks for the info.

Glad to be of service :) .  FWIW slot 12 is the method specified by the
AC'97 standard for setting GPIO on AC'97 CODECs so we really should hav=
e
something for it, but sadly quality of implementation and coverage in
controllers is a little variable.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
