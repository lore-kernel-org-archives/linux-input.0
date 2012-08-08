From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Wed, 8 Aug 2012 10:49:52 +0100
Message-ID: <20120808094952.GH16861@opensource.wolfsonmicro.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
 <20120808080411.GB4728@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39657 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752634Ab2HHJtz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Aug 2012 05:49:55 -0400
Content-Disposition: inline
In-Reply-To: <20120808080411.GB4728@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org

On Wed, Aug 08, 2012 at 09:04:12AM +0100, Lee Jones wrote:

> During non-DT boot:
>  - Platform data is passed, which contains an IRQ base
>  - If an IRQ base is requested we use it to register a Legacy IRQ Domain
>  - MFD adds the IRQ base to the hwirq and registers it as a virq

Just don't do this step - the only reason to do it is for mapping back
into a linear domain but if you're going to do this...

>  - AB8500 child devices use *_get_virq() to convert virq to virq - *ERROR*

...then it's redundant.  The mapping functions in the domain code
replace this functionality.
