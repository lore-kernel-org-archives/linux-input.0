From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 2/8] Documentation: devicetree: thermal: da9062/61
 TJUNC temperature binding
Date: Mon, 19 Dec 2016 16:28:46 -0600
Message-ID: <20161219222846.wkj2tshtxfnwqref@rob-hp-laptop>
References: <cover.1481828921.git.stwiss.opensource@diasemi.com>
 <ae903f7c3c6325420b90c7f691655d902d137d1f.1481828921.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34671 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbcLSW2t (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 17:28:49 -0500
Content-Disposition: inline
In-Reply-To: <ae903f7c3c6325420b90c7f691655d902d137d1f.1481828921.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>

On Thu, Dec 15, 2016 at 07:08:39PM +0000, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Device tree binding information for DA9062 and DA9061 thermal junction
> temperature monitor.
> 
> Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
> device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for
> a configurable polling period for over-temperature polling.
> 
> This patch also adds two examples, one for DA9062 and one for DA9061. The 
> DA9061 example uses a fall-back compatible string for the DA9062.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.9
> 
> v4 -> v5
>  - Rebased from v4.8 to v4.9
>  - Updates from comments by Eduardo Valentin
>  - Replace vendor defined dlg,tjunc-temp-polling-period-ms with standard
>    thermal core polling-delay-passive as part of the device tree
>    initialisation
>  - Remove Acked-by Rob Herring

Acked-by: Rob Herring <robh@kernel.org>
