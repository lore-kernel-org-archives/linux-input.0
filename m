From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] RFC: input: Extend matrix-keypad device tree binding
Date: Thu, 20 Dec 2012 13:13:23 -0800
Message-ID: <20121220211323.GA24981@core.coreip.homeip.net>
References: <1356035039-21653-1-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1356035039-21653-1-git-send-email-sjg@chromium.org>
Sender: linux-doc-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, Roland Stigge <stigge@antcom.de>, linux-doc@vger.kernel.org, Vincent Palatin <vpalatin@chromium.org>, Wolfram Sang <w.sang@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Luigi Semenzato <semenzato@chromium.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-input@vger.kernel.org

Hi Simon,

On Thu, Dec 20, 2012 at 12:23:58PM -0800, Simon Glass wrote:
> 
> For the key repeat feature, we need to set this after the input device
> is registered. So we would need to add a matrix_keypad_setup_input() or
> similar to be called by the driver after input_register_device(). I am
> less keen on that idea, and less again on the alternative of perhaps
> matrix_keypad_register_device() which does input_register_device() and
> then sets up the key repeat. Thoughts?

No, we already have default rate and delay. Unless you can prove that
random firmware writer's idea of appropriate delay and rate is better
then current default - for everyone - and then can successfully argue
that that obviously best delay/rate combo should not replace the current
one but stay only in DT bindings, let's keep relying on users adjusting
their own preferences from respective desktop environments/console/etc.

Thanks.

-- 
Dmitry
