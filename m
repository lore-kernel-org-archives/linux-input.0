From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] HID: i2c-hid: support the regulator
Date: Wed, 14 Sep 2016 16:02:42 +0800
Message-ID: <20160914080241.GA14576@localhost>
References: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
 <1473027116-13892-2-git-send-email-wxt@rock-chips.com>
 <20160914073603.GH25951@mail.corp.redhat.com>
 <20160914075505.GA14271@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33641 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755286AbcINICt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 04:02:49 -0400
Received: by mail-pf0-f171.google.com with SMTP id g202so3290213pfb.0
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 01:02:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160914075505.GA14271@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Jiri Kosina <jikos@kernel.org>, linux-rockchip@lists.infradead.org, dbasehore@chromium.org, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Guohua Zhong <ghzhong@yifangdigital.com>, "Zhonghui\"" <zhonghui.fu@linux.intel.com>, linux-kernel@vger.kernel.org

On Wed, Sep 14, 2016 at 03:55:05PM +0800, Brian Norris wrote:
> The default behavior of regulator_get() is to provide a dummy regulator
> if none is found. So the pointer is never NULL, and it won't break
> devices without a regulator. If you don't want a dummy regulator you
> would use regulator_get_optional() instead, and you would then need to
> handle ERR_PTR(-ENODEV) specifically.

One caveat to the never-NULL comment above that I just noticed:

If CONFIG_REGULATOR=n, then regulator_get() actually returns NULL (see
include/linux/regulator/consumer.h), but it also specifically has a
comment right next to that NULL return, saying:

        /* Nothing except the stubbed out regulator API should be
         * looking at the value except to check if it is an error
         * value. Drivers are free to handle NULL specifically by
         * skipping all regulator API calls, but they don't have to.
         * Drivers which don't, should make sure they properly handle
         * corner cases of the API, such as regulator_get_voltage()
         * returning 0.
         */

So, we still don't need to handle the NULL case specially.

Brian
