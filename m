From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] Input: gpio-keys: do not reference platform_data
 after .probe exits
Date: Mon, 18 Jul 2011 11:15:27 -0600
Message-ID: <CACxGe6tFt4h-iVjM26BdD9oLj2Zd+z8i1naR0YU3AbLtGzmXgA@mail.gmail.com>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
 <1311007508-8096-2-git-send-email-shawn.guo@linaro.org> <201107181002.45170.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33876 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab1GRRPs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 13:15:48 -0400
Received: by gwaa18 with SMTP id a18so1390622gwa.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 10:15:47 -0700 (PDT)
In-Reply-To: <201107181002.45170.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Phil Blundell <pb@handhelds.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Jul 18, 2011 at 11:02 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
>> The patch makes a copy of platform data into driver data, so that any
>> reference to platform_data after .probe exits can be avoided.
>
> And why is this beneficial? I am of the opinion that platform data should
> stay on (and be accessed through a const pointer to ensure that the driver
> will not alter it).

Because when using the device tree, there is no platform_data.

g.
