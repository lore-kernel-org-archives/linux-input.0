From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: mms114 - drop platform data and use generic APIs
Date: Tue, 26 Dec 2017 17:57:25 -0600
Message-ID: <20171226235725.frypld2nseydnhtq@rob-hp-laptop>
References: <20171226032511.17726-1-simon@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35316 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdLZX52 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Dec 2017 18:57:28 -0500
Content-Disposition: inline
In-Reply-To: <20171226032511.17726-1-simon@lineageos.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Dec 26, 2017 at 02:25:11PM +1100, Simon Shields wrote:
> The MMS114 platform data has no in-tree users, so drop it,
> and make the driver depend on CONFIG_OF.
> 
> Switch to using the standard touchscreen properties via
> touchscreen_parse_properties(), and move the old DT parsing code
> to use device_property_*() APIs.
> 
> Finally, use touchscreen_report_pos to report x/y coordinates
> and drop the custom x/y inversion code.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  .../bindings/input/touchscreen/mms114.txt          |  29 ++--

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |   1 +
>  drivers/input/touchscreen/mms114.c                 | 146 +++++++++------------
>  include/linux/platform_data/mms114.h               |  24 ----
>  4 files changed, 77 insertions(+), 123 deletions(-)
>  delete mode 100644 include/linux/platform_data/mms114.h
