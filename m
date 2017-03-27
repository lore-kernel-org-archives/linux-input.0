From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Mon, 27 Mar 2017 18:23:02 +0200
Message-ID: <1490631782.2404.18.camel@hadess.net>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52372 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdC0QX4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 12:23:56 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-03-27 at 16:59 +0200, Benjamin Tissoires wrote:
> Hi,
> 
> this is finally a rework of the series that provides kernel
> power_supply
> for hidpp devices.
> 
> This will allow upower to not handle those devices anymore and to
> have more
> immediate reportng of the device to the system.

You can add my Tested-by to all the commits in this patchset, using a
K750 solar keyboard and a T650 touchpad.

Note that user-space support work is still ongoing, on top of the
current upower master:
https://bugs.freedesktop.org/show_bug.cgi?id=100359

Cheers
