From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v2] input: bcm5974 - Add driver for Apple Magic Trackpad 2
Date: Wed, 01 Nov 2017 12:30:31 +0100
Message-ID: <14659004.E67qeesfdl@tauon.chronox.de>
References: <40764439.8xGR6LbaWR@positron.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.eperm.de ([89.247.134.16]:42080 "EHLO mail.eperm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754495AbdKALad (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Nov 2017 07:30:33 -0400
In-Reply-To: <40764439.8xGR6LbaWR@positron.chronox.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, marek.wyborski@emwesoft.com

Am Dienstag, 17. Oktober 2017, 05:05:13 CET schrieb Stephan Müller:

Hi Dimitry, Henrik, Jiri,

> Hi,
> 
> Changes v2:
> * port to 4.14-rc5
> * test hardware with 4.14-rc5
> 
> This patch was originally posted by Marek Wyborski. The patch has been
> tested by several people with a dkms:
> https://github.com/robbi5/magictrackpad2-dkms
> https://github.com/torvalds/linux/pull/332
> 
> The driver currently only supports USB. One option would be to integrate
> bluetooth support into the bcm driver or to move the driver to the
> hid-magicmouse which supports bluetooth. I integrated the driver into the
> bcm and not the magicmouse driver, because this way i was able to compare
> the outcome with the macbook touchpad as i dont own a magicmouse or a
> magictrackpad.
> 
> ---8<---
> 
> Add support for Apple Magic Trackpad 2 in bcm5974 (MacBook Tochpad) driver.
> The Magic Trackpad 2 needs to be switched into the finger-reporting-mode,
> just like the other macbook touchpads as well. But the format is different
> to the ones before. The Header is 12 Bytes long and each reported finger is
> additional 9 Bytes. The data order reported by the hardware is different as
> well.

May I inquire about this patch? Is there inappropriate code in the patch that 
needs cleanup before it can be merged?

Thanks a lot.

Ciao
Stephan

