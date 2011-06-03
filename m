From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Reporting screen/laptop orientation data to userspace
Date: Fri, 03 Jun 2011 16:55:28 +0100
Message-ID: <1307116529.2669.130.camel@novo.hadess.net>
References: <4DE1FA7F.3050308@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52587 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab1FCPzc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2011 11:55:32 -0400
In-Reply-To: <4DE1FA7F.3050308@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Mardegan <mardy@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

On Sun, 2011-05-29 at 10:49 +0300, Alberto Mardegan wrote:
> Hi all,
>   the WMI interfaces in some Lenovo Ideapad laptops provide notification
> callbacks when the laptop orientation changes, reporting 4 different
> values defining the new orientation.
> 
> I'd like to extend the ideapad-laptop driver with this information; but
> how should it be reported to userspace? I initially thought of the input
> subsystem, but I cannot find any suitable event codes; then I would
> probably export it as a device under /sys, or are there better options?
> 
> Are there other devices which provide coarse orientation data to
> userspace, which I might want to use as a reference?
> I guess that at least some display screens have this feature.

Do you also have a discrete accelerometer with that? Or you only ever
get notification through there?

If there is a discrete accelerometer, I'd drop the extra metadata, and
send an event through udev, and expect user-space to read from the
accelerometer instead.

If there isn't a discrete accelerometer, create a fake one, with some
hardcoded data based on the actual orientation of the device.

The accelerometer (whether real or fake) should show 3 axis (X/Y/Z).

As soon as it's seen some testing, I'll be showing the work I did for
GNOME support for automatic rotation based on orientation.

Cheers

