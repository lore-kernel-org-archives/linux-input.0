From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: rmi: Make hid-rmi a transport driver for
 synaptics-rmi4
Date: Wed, 15 Jun 2016 11:41:37 +0200
Message-ID: <20160615094137.GY24234@mail.corp.redhat.com>
References: <1464979306-2771-1-git-send-email-aduggan@synaptics.com>
 <alpine.LNX.2.00.1606150923310.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbcFOJlm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2016 05:41:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1606150923310.6874@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>

On Jun 15 2016 or thereabouts, Jiri Kosina wrote:
> On Fri, 3 Jun 2016, Andrew Duggan wrote:
> 
> > The Synaptics RMI4 driver provides support for RMI4 devices. Instead of
> > duplicating the RMI4 processing code, make hid-rmi a transport driver
> > and register it with the Synaptics RMI4 core.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> 
> Is there any update on the Input series please?

FWIW, I just reviewed it. Now the ball is in Dmitry's hand (I don't
think it needs a resubmission).

Cheers,
Benjamin

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
