From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] Input: Fixed pressure and tool width calculation
 in BCM5974 multitouch driver
Date: Thu, 21 Nov 2013 10:17:54 +0100
Message-ID: <528DCFC2.5060005@euromail.se>
References: <1384988052-31898-1-git-send-email-linux@schoeller.se> <1384988052-31898-2-git-send-email-linux@schoeller.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:35415 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab3KUJOj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 04:14:39 -0500
In-Reply-To: <1384988052-31898-2-git-send-email-linux@schoeller.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Friedrich_Sch=F6ller?= <linux@schoeller.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Friedrich,

> Previously ABS_PRESSURE and ABS_TOOL_WIDTH were calculated by looking at the
> size of the first touch in the list reported by the trackpad. This is not
> necessarily the same touch as the one used to perform pointer emulation in the
> input multitouch library (input-mt). By using the sum of the sizes of all
> touches as a basis for this calculation we get more coherent values.
> ---
>  drivers/input/mouse/bcm5974.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

The input-mt core can be used to output the correct pointer-emulated pressure
based on the individual pressures. Devices capable of measuring pressure should
rather use that method. However, this particular device does not actually
support pressure, and is therefore not applicable.

The legacy pressure code was added a long time ago in order to work with the
only userland option at the time (synaptics X driver). Since then, userland has
matured considerably, with drivers such as input-multitouch, input-evdev,
input-mtrack at your disposal. The only reason the pointer pressure and width
are still in the driver is to remain compatible with old userland.

Thanks,
Henrik

