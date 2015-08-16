From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Adding an interface to evdev for tablet orientation
Date: Sun, 16 Aug 2015 22:17:08 +0200
Message-ID: <1439756228.5372.15.camel@hadess.net>
References: <55C35EDD.8010806@redhat.com>
	 <1439755101.5372.10.camel@hadess.net> <55D0EEA6.1070700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43985 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbHPURN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Aug 2015 16:17:13 -0400
In-Reply-To: <55D0EEA6.1070700@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, linux-usb <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sun, 2015-08-16 at 22:12 +0200, Hans de Goede wrote:
> 
<snip>
> Interesting, so you're suggesting to not add any new evdev event
> types for this at all, and to instead use a sysfs attribute +
> change kevents on orientation changes so that userspace will know
> when to re-read the sysfs attribute ?

Yes, the changes to the iio-sensor-proxy code would be minimal (read
from the sysfs property if it exists instead of the raw data).

> Dmitry what is your take on this ?
> 
> Regards,
> 
> Hans
> --
> To unsubscribe from this list: send the line "unsubscribe linux
> -input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
