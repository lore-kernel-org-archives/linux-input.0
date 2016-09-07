From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend fixes for 4.8 0/2] input: touchscreen: silead_gsl1680: fixes
Date: Wed,  7 Sep 2016 22:09:55 +0200
Message-ID: <20160907200957.3341-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbcIGUKD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Sep 2016 16:10:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi Dmitry,

Here are 2 fixes for the silead touchscreen driver which is new in 4.8,
since these change firmware loading behavior (*) we really ought to get
these into 4.8, so that don't end up shipping a stable kernel with the
old firmware loading behavior.

Note the small dt binding change this includes has been acked by
Robh, so these 2 are ready for merging now.

Thanks & Regards,

Hans
