From: Chr <chunkeey@web.de>
Subject: Re: [PATCH] usbhid: add ASUS LCM to the blacklist
Date: Mon, 30 Jul 2007 16:11:07 +0200
Message-ID: <200707301611.08758.chunkeey@web.de>
References: <200707240228.39421.chunkeey@web.de>
	<200707270110.01135.chunkeey@web.de>
	<Pine.LNX.4.64.0707301440020.5747@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0707301440020.5747@twin.jikos.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Adilson Oliveira <adilson@linuxembarcado.com.br>, linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@linux-foundation.org>, Bernd Dau <bernd@daucity.de>
List-Id: linux-input@vger.kernel.org

On Monday, 30. July 2007, Jiri Kosina wrote:
> On Fri, 27 Jul 2007, Christian Lamparter wrote:
> 
> > Some of ASUS' notebooks (e.g G Series) include a tiny oled display, which is 
> > attached to an internal USB bus. Unfortunatly the device reports a wrong
> > DeviceDescriptor and is therefore identified as a HID device...
> 
> Hi Christian,
> 
> I have slightly modified your patch (let's keep the hid_blacklist[] 
> properly sorted) and applied it into my tree.

Ok, found it " hid_blacklist is alphabetically sorted blacklist by quirk type. "
But is there a Order for the bitfields? e.g

shouldn't: hid-quriks.c (line 439, 440)

{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, 
HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE } 

be:
{..., ..., HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_HAS_FN }


Anyway, thanks for merging! 
	Chr.
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
