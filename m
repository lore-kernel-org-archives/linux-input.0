From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/9] HID: make a bus from hid code
Date: Thu, 15 May 2008 11:11:02 +0200
Message-ID: <1210842662.7025.21.camel@violet.holtmann.net>
References: <1210536043-19812-1-git-send-email-jirislaby@gmail.com>
	 <1210536043-19812-2-git-send-email-jirislaby@gmail.com>
	 <1210547158.16390.28.camel@violet.holtmann.net>  <482AB12F.20106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53508 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYEOJLC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 May 2008 05:11:02 -0400
In-Reply-To: <482AB12F.20106@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, akpm@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>

Hi Jiri,

> >> +static struct hid_driver hid_generic_bt = {
> >> +	.name = "hid-generic-bt",
> >> +	.id_table = hid_generic_bt_ids,
> >> +};
> > 
> > And this one to hidp_driver instead of hid_generic_bt.
> > 
> > Also the name "hid-generic-bt" is not okay. Call it "hidp" since that is
> > the driver name. An alternative would be "hid-bluetooth". I don't like
> > the "generic" part and we never used the shortcut "bt" in any sysfs
> > visible file.
> 
> Thanks for comments, I fixed all those except this one. The generic- word is 
> tested in the core to recognize generic drivers which bind non-blacklisted 
> devices and are handled separately. Anyway I've renamed them to 
> generic-bluetooth and generic-usb instead of hid-generic-{bt,usb}.
> 
> I think the generic word in the driver name is OK, so that one ordinary user 
> can see, my device is handled by the generic driver without special 
> processing. Would you rather see some flag or something?

actually generic-usb and generic-bluetooth sound perfectly fine to me.

Regards

Marcel


