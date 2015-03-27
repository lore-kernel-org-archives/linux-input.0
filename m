From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Documentation: input - define INPUT_PROP_ACCELEROMETER
 behavior
Date: Fri, 27 Mar 2015 01:43:37 +0100
Message-ID: <1427417017.2492.32.camel@hadess.net>
References: <20150327001106.GA16588@jelly.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43840 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbC0AoB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 20:44:01 -0400
In-Reply-To: <20150327001106.GA16588@jelly.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, Hans de Goede <hdegoede@redhat.com>

On Fri, 2015-03-27 at 10:11 +1000, Peter Hutterer wrote:
> Spell out what this property means to userspace. If the property is 
> set, all
> directional axes must be accelerometer axes, any other axes are left 
> as-is.
> This allows an accelerometer device to e.g. have an ABS_WHEEL.
> 
> It is not permitted to mix normal directional axes and accelerometer 
> axes on
> the same device node.
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Looks good.

Reviewed-by: Bastien Nocera <hadess@hadess.net>
