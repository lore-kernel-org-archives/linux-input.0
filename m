From: Alberto Mardegan <mardy@users.sourceforge.net>
Subject: Re: Reporting screen/laptop orientation data to userspace
Date: Mon, 06 Jun 2011 09:53:34 +0300
Message-ID: <4DEC796E.1050307@users.sourceforge.net>
References: <4DE1FA7F.3050308@users.sourceforge.net> <1307116529.2669.130.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49086 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab1FFGyf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 02:54:35 -0400
In-Reply-To: <1307116529.2669.130.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-kernel@vger.kernel.org, "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

On 06/03/2011 06:55 PM, Bastien Nocera wrote:
> Do you also have a discrete accelerometer with that? Or you only ever
> get notification through there?

There's a discrete accelerometer, but I suspect that it might be hard for its 
driver to get accepted into the mainline kernel, since it's directly playing 
with the EC I/O ports. It's this one:

https://gitorious.org/iaps/iaps/blobs/master/iaps.c

The coarse data OTOH comes via a clean WMI interface.

> If there is a discrete accelerometer, I'd drop the extra metadata, and
> send an event through udev, and expect user-space to read from the
> accelerometer instead.

You mean, send an event through udev when the WMI interface reports that the 
orientation has changed, and then expect the userspace to read the values from 
the accelerometer?
IMHO, reporting an event with no context data, it's inefficient and ugly 
(because it forces the userspace to perform additional acctions in order to get 
the data).

> If there isn't a discrete accelerometer, create a fake one, with some
> hardcoded data based on the actual orientation of the device.

This could be a solution in both cases (i.e., even if a discrete accelerometer 
is available). But it would be nice to have some flags on the input device which 
tell that this accelerometer is not as precise as one could desire. Is there 
such a thing?

> The accelerometer (whether real or fake) should show 3 axis (X/Y/Z).
>
> As soon as it's seen some testing, I'll be showing the work I did for
> GNOME support for automatic rotation based on orientation.

Do you support choosing the accelerometer device to be used?

The device that I wanted to create is actually something much simpler than an 
accelerometer; it would just report screen orientation. I believe that some 
computer screens might have something similar, detecting the screen orientation 
based on the angle formed between the screen base (or wall mount) and the screen 
panel... I would assume that if such information exists, this Lenovo Ideapad 
screen orientation should be reported in a similar way.

Ciao,
   Alberto

-- 
http://blog.mardy.it <-- geek in un lingua international!
