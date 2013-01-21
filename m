From: simon@mungewell.org
Subject: Re: [PATCH v2] HID: add ThingM blink(1) USB RGB LED support
Date: Mon, 21 Jan 2013 13:40:01 -0500
Message-ID: <d76e4c014234c2f0e8ef1328f0e7572a.squirrel@mungewell.org>
References: <1358792314-24596-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46311 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3AUSkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 13:40:03 -0500
In-Reply-To: <1358792314-24596-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org


> +++ b/Documentation/ABI/testing/sysfs-driver-hid-blink1
> @@ -0,0 +1,23 @@
> +What:		/sys/class/leds/blink(1)::<serial>/rgb
> +Date:		January 2013
> +Contact:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> +Description:	The ThingM blink(1) is an USB RGB LED. The color notation is
> +		3-byte hexadecimal. Read this attribute to get the last set
> +		color. Write the 24-bit hexadecimal color to change the current
> +		LED color. The default color is full white (0xFFFFFF).
> +		For instance, set the color to green with: echo 00FF00 > rgb
> +

Shouldn't the name presented in the sys/class/leds directories change
appropriately too?

Simon

