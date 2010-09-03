From: Diego Calleja <diegocg@gmail.com>
Subject: Re: [PATCH 3/5] input: wacom: Add support for the Bamboo Touch trackpad (rev3)
Date: Fri, 3 Sep 2010 20:24:19 +0200
Message-ID: <201009032024.19745.diegocg@gmail.com>
References: <1283516247-11624-1-git-send-email-rydberg@euromail.se> <1283516247-11624-4-git-send-email-rydberg@euromail.se>
Reply-To: diegocg@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52448 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab0ICSYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 14:24:25 -0400
In-Reply-To: <1283516247-11624-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Viernes, 3 de Septiembre de 2010 14:17:25 Henrik Rydberg escribi=F3:
> @@ -1280,6 +1361,7 @@ const struct usb_device_id wacom_ids[] =3D {
>  	{ USB_DEVICE_WACOM(0xC6) },
>  	{ USB_DEVICE_WACOM(0xC7) },
>  	{ USB_DEVICE_WACOM(0xCE) },
> +	{ USB_DEVICE_WACOM(0xD0) },
>  	{ USB_DEVICE_WACOM(0xF0) },
>  	{ USB_DEVICE_WACOM(0xCC) },
>  	{ USB_DEVICE_WACOM(0x90) },

I have a wacom bamboo touch & pen (CTH-461) with a 0xD2 id. Can I do
something to help to get it supported in these patches?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
