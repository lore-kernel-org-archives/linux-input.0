From: Bastien Nocera <hadess@hadess.net>
Subject: Re: MX5000 support in hid-logitech
Date: Tue, 15 Sep 2009 12:03:53 +0100
Message-ID: <1253012633.23937.8321.camel@localhost.localdomain>
References: <200909151240.14486.corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28659 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbZIOLD4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 07:03:56 -0400
In-Reply-To: <200909151240.14486.corentin.chary@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tue, 2009-09-15 at 12:40 +0200, Corentin Chary wrote:
> Hi,
> I'm trying to add support for MX5000 keyboard in hid-lg.c, and it's the first 
> time I'm playing with hid drivers.
> 
> I added the keys in lg_wireless_mapping()
> 
>         case 0x01b8: lg_map_key_clear(KEY_VIDEO);               break;
>         case 0x01b7: lg_map_key_clear(KEY_AUDIO);               break;
>         case 0x01bc: lg_map_key_clear(KEY_MESSENGER);           break;
>         case 0x0183: lg_map_key_clear(KEY_MEDIA);               break;
>         case 0x0230: lg_map_key_clear(KEY_ZOOMRESET);           break;
>         case 0x022e: lg_map_key_clear(KEY_ZOOMOUT);             break;
>         case 0x022d: lg_map_key_clear(KEY_ZOOMIN);              break;
>         case 0x0184: lg_map_key_clear(KEY_WORDPROCESSOR);       break;
>         case 0x0186: lg_map_key_clear(KEY_SPREADSHEET);         break;
>         case 0x0188: lg_map_key_clear(KEY_PRESENTATION);        break;
> 
> And that line in static const struct hid_device_id lg_devices[]
> 
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc70a),
>                 .driver_data = LG_RDESC | LG_WIRELESS },
> 
> I also added a printk lg_event() to find usage->hid and check
> if the device was correctly probed.
> 
> I use xev to detect keystrocks.
> 
> But Adding the code in lg_wireless_mapping() didn't change anything, keys are 
> not reported in xev.
> 
> I added a printk between case 0x01b8: and lg_map_key_clear(KEY_VIDEO); to 
> check if the branch was taken, and it is.
> 
> Did I do something wrong ?
> Any suggestion ?

This won't be enough, check the archives for more details (around 10th
February this year)

You'll need to poke at the receiver using the same kind of code that
mx5000lib does. Your best bet is probably to start with Jiri's
recommendations and get debugging info from the kernel before going any
further.

Cheers

