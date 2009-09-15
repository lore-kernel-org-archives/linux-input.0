From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: MX5000 support in hid-logitech
Date: Tue, 15 Sep 2009 14:44:28 +0200
Message-ID: <200909151444.29108.corentin.chary@gmail.com>
References: <200909151240.14486.corentin.chary@gmail.com> <1253012633.23937.8321.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:49308 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZIOMoS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 08:44:18 -0400
Received: by fxm17 with SMTP id 17so1525665fxm.37
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2009 05:44:21 -0700 (PDT)
In-Reply-To: <1253012633.23937.8321.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tuesday 15 September 2009 13:03:53 Bastien Nocera wrote:
> On Tue, 2009-09-15 at 12:40 +0200, Corentin Chary wrote:
> > Hi,
> > I'm trying to add support for MX5000 keyboard in hid-lg.c, and it's the
> > first time I'm playing with hid drivers.
> >
> > I added the keys in lg_wireless_mapping()
> >
> >         case 0x01b8: lg_map_key_clear(KEY_VIDEO);               break;
> >         case 0x01b7: lg_map_key_clear(KEY_AUDIO);               break;
> >         case 0x01bc: lg_map_key_clear(KEY_MESSENGER);           break;
> >         case 0x0183: lg_map_key_clear(KEY_MEDIA);               break;
> >         case 0x0230: lg_map_key_clear(KEY_ZOOMRESET);           break;
> >         case 0x022e: lg_map_key_clear(KEY_ZOOMOUT);             break;
> >         case 0x022d: lg_map_key_clear(KEY_ZOOMIN);              break;
> >         case 0x0184: lg_map_key_clear(KEY_WORDPROCESSOR);       break;
> >         case 0x0186: lg_map_key_clear(KEY_SPREADSHEET);         break;
> >         case 0x0188: lg_map_key_clear(KEY_PRESENTATION);        break;
> >
> > And that line in static const struct hid_device_id lg_devices[]
> >
> >         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc70a),
> >                 .driver_data = LG_RDESC | LG_WIRELESS },
> >
> > I also added a printk lg_event() to find usage->hid and check
> > if the device was correctly probed.
> >
> > I use xev to detect keystrocks.
> >
> > But Adding the code in lg_wireless_mapping() didn't change anything, keys
> > are not reported in xev.
> >
> > I added a printk between case 0x01b8: and lg_map_key_clear(KEY_VIDEO); to
> > check if the branch was taken, and it is.
> >
> > Did I do something wrong ?
> > Any suggestion ?
> 
> This won't be enough, check the archives for more details (around 10th
> February this year)
> 
> You'll need to poke at the receiver using the same kind of code that
> mx5000lib does. Your best bet is probably to start with Jiri's
> recommendations and get debugging info from the kernel before going any
> further.

It seems to work without poking the receiver.
As I said, these keys can be seen in lg_event().

So, I tried that code in lg_event() (with the previous code in 
lg_wireless_mapping()):

 unsigned int key = 0;
 struct input_dev *input = field->hidinput->input;

 switch (usage->hid & HID_USAGE) {
  case 0x01b8: key = KEY_VIDEO;           break;
  case 0x01b7: key = KEY_AUDIO;           break;
  case 0x01bc: key = KEY_MESSENGER;       break;
  case 0x0183: key = KEY_MEDIA;           break;
  case 0x0230: key = KEY_ZOOMRESET;       break;
  case 0x022e: key = KEY_ZOOMOUT;         break;
  case 0x022d: key = KEY_ZOOMIN;          break;
  case 0x0184: key = KEY_WORDPROCESSOR;   break;
  case 0x0186: key = KEY_SPREADSHEET;     break;
  case 0x0188: key = KEY_PRESENTATION;    break;
  default: return 0;
 }
 printk(KERN_WARNING "%x %x %x\n", usage->hid, usage->type, value);
 if (key) {
  input_event(input, usage->type, key, value);
  return 1;
 }

And it worked (with showkey in a terminal, not with xev, maybe I need to 
restart X for that ?).

But adding that code in lg_event() doesn't look right :/
-- 
Corentin Chary
http://xf.iksaif.net
