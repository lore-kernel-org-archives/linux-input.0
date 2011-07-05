From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 02/12] Input: synaptics - do not invert y if 0
Date: Tue, 5 Jul 2011 20:07:13 +0200
Message-ID: <20110705180712.GA29224@polaris.bitmath.org>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-3-git-send-email-djkurtz@chromium.org>
 <20110704210838.GA23915@polaris.bitmath.org>
 <CAGS+omDXhiZz2i5eniu_eOCES1Eq_fKs4JVWU-+wz6ot7kyhSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:54890 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab1GESFV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 14:05:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omDXhiZz2i5eniu_eOCES1Eq_fKs4JVWU-+wz6ot7kyhSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

> > > In some cases, however, y = 0 is sent by the touchpad.
> > > In these cases, the kernel driver should not invert, and just report 0.
> > >
> > > This patch also refactors the inversion into a macro, and moves it
> > > into packet processing instead of during position reporting.
> >
> > The patch seems to invert the current output?
> 
> By 'current' do you mean referenced from the previous implementation?
> Or referenced from the raw input.
> It does indeed invert the raw input.
> This is the same as the previous implementation did.
> The difference is that it does not also invert the special 'y=0' into
> an arbitrarily large value.
> Is this your concern?

It would be clearer to just change the argument of the
input_report_abs() instances, would it not? An explanation why zero,
outside the value range, should be output also needs a rationale. It
would seem such packets should be masked somehow.

Thanks,
Henrik
