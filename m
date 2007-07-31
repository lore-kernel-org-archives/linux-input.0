From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] usbhid: add ASUS LCM to the blacklist
Date: Tue, 31 Jul 2007 10:39:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707311038400.5747@twin.jikos.cz>
References: <200707240228.39421.chunkeey@web.de> <200707270110.01135.chunkeey@web.de>
 <Pine.LNX.4.64.0707301440020.5747@twin.jikos.cz> <200707301611.08758.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707301611.08758.chunkeey@web.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Chr <chunkeey@web.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Bernd Dau <bernd@daucity.de>, Adilson Oliveira <adilson@linuxembarcado.com.br>
List-Id: linux-input@vger.kernel.org

On Mon, 30 Jul 2007, Chr wrote:

> Ok, found it " hid_blacklist is alphabetically sorted blacklist by quirk 
> type. " But is there a Order for the bitfields? e.g
> shouldn't: hid-quriks.c (line 439, 440)
> { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, 
> HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE } 
> be:
> {..., ..., HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_HAS_FN }

This could be a possible cleanup for hid_blacklist[], if you are going to 
make a patch I will happily accept it.

Thanks,

-- 
Jiri Kosina
