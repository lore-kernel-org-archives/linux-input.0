From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4] Input: Add driver for Microchip's CAP1106
Date: Tue, 15 Jul 2014 09:53:48 +0100
Message-ID: <20140715085347.GS26465@leverpostej>
References: <1405348082-24210-1-git-send-email-zonque@gmail.com>
 <20140714184642.GA38980@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49937 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932585AbaGOIx7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jul 2014 04:53:59 -0400
Content-Disposition: inline
In-Reply-To: <20140714184642.GA38980@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "dh.herrmann@gmail.com" <dh.herrmann@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jul 14, 2014 at 07:46:43PM +0100, Dmitry Torokhov wrote:
> On Mon, Jul 14, 2014 at 04:28:02PM +0200, Daniel Mack wrote:
> > +
> > +static int cap1106_i2c_remove(struct i2c_client *i2c_client)
> > +{
> > +	struct cap1106_priv *priv = i2c_get_clientdata(i2c_client);
> > +
> > +	input_unregister_device(priv->idev);
> > +
> 
> No need to call unregister on managed input devices.
> 
> Otherwise if DT guys are happy with bindings I am happy with the patch.

First I'd like to clarify the situation with properties for buttons
which I've just asked about on the last posting, but otherwise this
looks fine to me.

Thanks,
Mark.
