From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: Correct property to use for wake up support on rotary encoders
Date: Mon, 12 Oct 2015 18:42:49 +0200
Message-ID: <20151012164248.GA11780@gradator.net>
References: <20151012160943.GA10239@gradator.net>
 <CAKdAkRSAYRr8PqcmzVCmGy89dedo_aybJq-2FhPzF1CFYy0GYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:46393 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbJLQmu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 12:42:50 -0400
Content-Disposition: inline
In-Reply-To: <CAKdAkRSAYRr8PqcmzVCmGy89dedo_aybJq-2FhPzF1CFYy0GYg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>

Hi Dmitry,

On Mon, Oct 12, 2015 at 09:29:16AM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 12, 2015 at 9:09 AM, Sylvain Rochet
> <sylvain.rochet@finsecur.com> wrote:
> >
> > Several month ago I proposed a patch[1][2] to add wake up support to
> > rotary encoders[3].
> >
> > Among all the properties currently used in Linux kernels device trees,
> > we have three recognisable patterns for wake up support:
> >  - driver-name,wakeup
> >  - linux,wakeup
> >  - wakeup-source
> >
> > We don't know which one to use, could you tell which one we should use
> > for GPIO rotary encoders ?
> 
> Please use "wakeup-source", we've been trying to standardize on it.

Thank you Dmitry for this fast answer. I will respin shortly then.

Sylvain
