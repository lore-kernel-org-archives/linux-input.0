From: Chr <chunkeey@web.de>
Subject: Cleaning up the USBHID's blacklist.
Date: Tue, 31 Jul 2007 23:24:05 +0200
Message-ID: <200707312324.06116.chunkeey@web.de>
References: <200707240228.39421.chunkeey@web.de> <200707301611.08758.chunkeey@web.de> <Pine.LNX.4.64.0707311038400.5747@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0707311038400.5747@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Tuesday, 31. July 2007, Jiri Kosina wrote:
> On Mon, 30 Jul 2007, Chr wrote:
> 
> > Ok, found it " hid_blacklist is alphabetically sorted blacklist by quirk 
> > type. " But is there a Order for the bitfields? e.g
> > shouldn't: hid-quriks.c (line 439, 440)
> > { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, 
> > HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE } 
> > be:
> > {..., ..., HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_HAS_FN }
> 
> This could be a possible cleanup for hid_blacklist[], if you are going to 
> make a patch I will happily accept it.
> 
> Thanks,
> 
Ok! I'll make a patch..

But I have one (final?) question. Since I am sometimes stuck to 80x25 console...
 can we alphabetically sort the blacklist by the Vendor (the first field), instead of the quirk field(last field)?
Or is there a technical/theoretical reason behind it?   

Thanks,
	Chr.
