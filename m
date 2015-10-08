From: Cliff Jolly <expiredpopsicle@gmail.com>
Subject: Re: [PATCH] HID: wacom: Add support for Cintiq Companion 2
Date: Wed, 7 Oct 2015 19:31:13 -0700
Message-ID: <CADvPr_5M_o46S_Y1qnWSmJVgTVeNaBo77x5fPgYdQhyKYG_gNg@mail.gmail.com>
References: <1444262144-19327-1-git-send-email-killertofu@gmail.com>
	<1444265973.28661.3.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33723 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbJHCbP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 22:31:15 -0400
Received: by lbos8 with SMTP id s8so31253202lbo.0
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2015 19:31:13 -0700 (PDT)
In-Reply-To: <1444265973.28661.3.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

This applies to both. When running as a standalone tablet, all the
tablet input devices still go through the usb system. The different
modes show the same usb vendor and product IDs and seem to behave
identically in the testing I've done.

Sorry for the multiple-message spam.

On Wed, Oct 7, 2015 at 5:59 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2015-10-07 at 16:55 -0700, Jason Gerecke wrote:
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> Signed-off-by: Clifford Jolly <expiredpopsicle@gmail.com>
>
> Is that support for using the Cintiq Companion 2 as an accessory (eg.
> still running Windows on the machine, and plugging it in to a Linux
> machine), or for the Wacom device inside the tablet when it's running
> Linux (if that's possible)?
>
> Either way, which it is should be included in the commit message.
>
> For those who don't know about that device:
> http://www.wacom.com/en-us/products/pen-displays/cintiq-companion-2
>
> Cheers
