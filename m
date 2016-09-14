From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: support the regulator
Date: Wed, 14 Sep 2016 16:31:02 +0200
Message-ID: <20160914143102.GK25951@mail.corp.redhat.com>
References: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
 <1473027116-13892-2-git-send-email-wxt@rock-chips.com>
 <20160914073603.GH25951@mail.corp.redhat.com>
 <20160914075505.GA14271@localhost>
 <20160914080241.GA14576@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758575AbcINObL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 10:31:11 -0400
Content-Disposition: inline
In-Reply-To: <20160914080241.GA14576@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, Jiri Kosina <jikos@kernel.org>, linux-rockchip@lists.infradead.org, dbasehore@chromium.org, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Guohua Zhong <ghzhong@yifangdigital.com>, "Zhonghui\"" <zhonghui.fu@linux.intel.com>, linux-kernel@vger.kernel.org

On Sep 14 2016 or thereabouts, Brian Norris wrote:
> On Wed, Sep 14, 2016 at 03:55:05PM +0800, Brian Norris wrote:
> > The default behavior of regulator_get() is to provide a dummy regulator
> > if none is found. So the pointer is never NULL, and it won't break
> > devices without a regulator. If you don't want a dummy regulator you
> > would use regulator_get_optional() instead, and you would then need to
> > handle ERR_PTR(-ENODEV) specifically.
> 
> One caveat to the never-NULL comment above that I just noticed:
> 
> If CONFIG_REGULATOR=n, then regulator_get() actually returns NULL (see
> include/linux/regulator/consumer.h), but it also specifically has a
> comment right next to that NULL return, saying:
> 
>         /* Nothing except the stubbed out regulator API should be
>          * looking at the value except to check if it is an error
>          * value. Drivers are free to handle NULL specifically by
>          * skipping all regulator API calls, but they don't have to.
>          * Drivers which don't, should make sure they properly handle
>          * corner cases of the API, such as regulator_get_voltage()
>          * returning 0.
>          */
> 
> So, we still don't need to handle the NULL case specially.

Well, all the other regulator calls are either regulator_enable() or
regulator_disable(), which in this case (CONFIG_REGULATOR=n) are
returning 0.

So I think the whole patch is safe in its current form. Thanks for the
explanations.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
> Brian
