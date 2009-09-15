From: Corentin Chary <corentin.chary@gmail.com>
Subject: MX5000 support in hid-logitech
Date: Tue, 15 Sep 2009 12:40:14 +0200
Message-ID: <200909151240.14486.corentin.chary@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:33626 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZIOKkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 06:40:03 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1223953fge.1
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2009 03:40:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi,
I'm trying to add support for MX5000 keyboard in hid-lg.c, and it's the first 
time I'm playing with hid drivers.

I added the keys in lg_wireless_mapping()

        case 0x01b8: lg_map_key_clear(KEY_VIDEO);               break;
        case 0x01b7: lg_map_key_clear(KEY_AUDIO);               break;
        case 0x01bc: lg_map_key_clear(KEY_MESSENGER);           break;
        case 0x0183: lg_map_key_clear(KEY_MEDIA);               break;
        case 0x0230: lg_map_key_clear(KEY_ZOOMRESET);           break;
        case 0x022e: lg_map_key_clear(KEY_ZOOMOUT);             break;
        case 0x022d: lg_map_key_clear(KEY_ZOOMIN);              break;
        case 0x0184: lg_map_key_clear(KEY_WORDPROCESSOR);       break;
        case 0x0186: lg_map_key_clear(KEY_SPREADSHEET);         break;
        case 0x0188: lg_map_key_clear(KEY_PRESENTATION);        break;

And that line in static const struct hid_device_id lg_devices[]

        { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc70a),
                .driver_data = LG_RDESC | LG_WIRELESS },

I also added a printk lg_event() to find usage->hid and check
if the device was correctly probed.

I use xev to detect keystrocks.

But Adding the code in lg_wireless_mapping() didn't change anything, keys are 
not reported in xev.

I added a printk between case 0x01b8: and lg_map_key_clear(KEY_VIDEO); to 
check if the branch was taken, and it is.

Did I do something wrong ?
Any suggestion ?

(Please CC me, I didn't subscribed to linux-input)

Thanks,
-- 
Corentin Chary
http://xf.iksaif.net
