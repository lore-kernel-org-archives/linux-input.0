From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: axp20x-pek: use driver_data of
 platform_device_id instead of extended attributes
Date: Wed, 16 Aug 2017 17:46:02 -0700
Message-ID: <20170817004602.GE25491@dtor-ws>
References: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
 <df8eb78e18692292f5206a57c88fcefe6a1754de.1502271751.git-series.quentin.schulz@free-electrons.com>
 <CAGb2v65xoUZA+AGb+1LEba-ccmDdLo6YyAB1nqo2uKUN7x=2kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33703 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdHQAqF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Aug 2017 20:46:05 -0400
Content-Disposition: inline
In-Reply-To: <CAGb2v65xoUZA+AGb+1LEba-ccmDdLo6YyAB1nqo2uKUN7x=2kA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Mon, Aug 14, 2017 at 06:03:44PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 9, 2017 at 5:45 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > To prepare an upcoming patch adding support for another PMIC that has
> > different startup and shutdown time, use driver_data of
> > platform_device_id instead of a fixed extended device attribute.
> >
> > By doing so, we also remove a lot of nested structures that aren't
> > useful.
> >
> > With this patch, a new PMIC can be easily supported by just filling
> > correctly its ax20x_info structure and adding a platform_device_id.
> >
> > Moreover, since we get rid of extended attributes, rename
> > axp20x_store_ext_attr to axp20x_store_attr and axp20x_show_ext_attr to
> > axp20x_show_attr.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thank you.

> 
> [...]
> 
> > +
> > +DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup, axp20x_store_attr_startup);
> > +DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
> > +           axp20x_store_attr_shutdown);
> >
> 
> You could use DEVICE_ATTR_RW(...) if you renamed the function names to
> fit the macro if you wanted.

-- 
Dmitry
