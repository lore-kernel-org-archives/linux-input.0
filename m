From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [ebeam PATCH v2 1/2] hid: Blacklist eBeam devices
Date: Thu, 11 Oct 2012 00:01:13 +0200
Message-ID: <5075F029.90807@laposte.net>
References: <1349529287-23193-1-git-send-email-yann.cantin@laposte.net> <1349529287-23193-2-git-send-email-yann.cantin@laposte.net> <20121010163747.GD19335@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:52803 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605Ab2JJV4u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 17:56:50 -0400
In-Reply-To: <20121010163747.GD19335@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org

Hi,

Le 10/10/2012 18:37, Dmitry Torokhov a =E9crit :
> Is the device usable at all with generic HID driver? If it isn't then
> maybe we should blacklist it unconditionally?

Without the libusb based proprietary stack, the device is unusable unde=
r linux.

If i correctly understand, libusb need a driver to be present in the fi=
rst place,
(even a useless generic-usb) to be able to grab the device. If we uncon=
ditionally
blacklist the device and the ebeam driver isn't loaded (not compiled fo=
r example), no way
for libusb (and the stack) to handle the device.

As stated before, i'm not comfortable with the risk of breaking other h=
ypothetical support,
even proprietary.

--=20
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
