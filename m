From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 20/26] Input: synaptics-rmi4: Create common functions for
 2D sensors
Date: Mon, 9 Nov 2015 15:35:25 -0800
Message-ID: <20151109233525.GH9155@dtor-ws>
References: <1446766925-31123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34901 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbKIXf2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 18:35:28 -0500
Content-Disposition: inline
In-Reply-To: <1446766925-31123-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Thu, Nov 05, 2015 at 03:42:05PM -0800, Andrew Duggan wrote:
> +config RMI4_2D_SENSOR
> +	bool "RMI4 2D Sensors"

Should this be a hidden option that is selected by RMI4_F11 and RMI4_F12
instead?

Thanks.

> +	depends on RMI4_CORE
> +	default y if RMI4_CORE
> +	help
> +	  Say Y here if you want to add support for 2D Sensors.
> +
> +	  Provides core functionality for 2D multifinger pointing for
> +	  touchscreens and touchpads using RMI4 functions 11 and 12. This
> +	  feature is needed is the device contains either F11 or F12.
> +
>  config RMI4_F11
>  	bool "RMI4 Function 11 (2D pointing)"


-- 
Dmitry
