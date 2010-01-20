From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
Date: Wed, 20 Jan 2010 03:52:13 -0800
Message-ID: <1263988333.5591.205.camel@localhost.localdomain>
References: <1263988051.1735.2474.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263988051.1735.2474.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Bastien,

> Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
> kernel. In the past, it was done in a patch in bluetootd.
> 
> - 0001-hidp-Use-the-control-socket-for-raw-messages.patch
> 
> As discussed, now uses the ctrl channel for sending raw reports to the device.
> 
> - 0002-hid-wacom-Implement-Wacom-quirk-in-the-kernel.patch
> 
> Uses the above to poke at the device and turn it into mode2
> 
> - 0001-hid-sony-Fix-typo-in-error-message.patch
> 
> Small typo, for the input tree
> 
> - 0001-hid-Enable-Sixaxis-controller-over-Bluetooth-as-well.patch
> 
> Use the hidp patch above to enable the sixaxis controller

please send them one patch per email and send them inline. In case of
troubles just use git send-email.

Regards

Marcel
