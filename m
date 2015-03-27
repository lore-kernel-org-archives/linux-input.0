From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: proposal for deletion of drivers/hid/hid-ids.h
Date: Fri, 27 Mar 2015 09:07:34 -0400
Message-ID: <CAN+gG=HRTOaf-4CkgA5c-N=205MkZ=nKzqTpJAOV=2ACnGQmEw@mail.gmail.com>
References: <1427370288.2075.19.camel@suse.de>
	<CAN+gG=EJUwfzvNeud76RNa-hMQrttbNm03uKYJhqfTeJxjjF5Q@mail.gmail.com>
	<1427446189.5783.29.camel@suse.de>
	<1427449150.5783.46.camel@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34442 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbbC0NHf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 09:07:35 -0400
Received: by qgep97 with SMTP id p97so132484101qge.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 06:07:34 -0700 (PDT)
In-Reply-To: <1427449150.5783.46.camel@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, pavel@ucw.cz

On Fri, Mar 27, 2015 at 5:39 AM, Oliver Neukum <oliver@neukum.org> wrote:
> On Fri, 2015-03-27 at 09:49 +0100, Oliver Neukum wrote:
>> On Thu, 2015-03-26 at 10:06 -0400, Benjamin Tissoires wrote:
>
>> Well, yes, so you needed to grep for MULTI_INPUT. The entries would
>> still have been present, just with nummerical IDs.
>
> Especially as I see stuff like this:
>
> 0c3910c255 (Stephane Chatty               2010-04-10 16:43:08 +0200  282) #define USB_VENDOR_ID_DWAV            0x0eef
> fe6065dc30 (Peter Hutterer                2010-02-02 13:40:40 +1000  283) #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER  0x0001
> 729b814ace (Forest Bond                   2012-11-06 13:41:22 -0500  284) #define USB_DEVICE_ID_DWAV_TOUCHCONTROLLER    0x0002
> e36f690b37 (Benjamin Tissoires            2011-11-23 10:54:31 +0100  285) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480D     0x480d
> e36f690b37 (Benjamin Tissoires            2011-11-23 10:54:31 +0100  286) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_480E     0x480e
> fd1d152583 (Benjamin Tissoires            2012-03-06 10:53:47 +0100  287) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207     0x7207
> e36f690b37 (Benjamin Tissoires            2011-11-23 10:54:31 +0100  288) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C     0x720c
> fd1d152583 (Benjamin Tissoires            2012-03-06 10:53:47 +0100  289) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224     0x7224
> 2ce09df47b (Benjamin Tissoires            2012-03-06 17:57:02 +0100  290) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A     0x722A
> fd1d152583 (Benjamin Tissoires            2012-03-06 10:53:47 +0100  291) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E     0x725e
> fd1d152583 (Benjamin Tissoires            2012-03-06 10:53:47 +0100  292) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262     0x7262
> e36f690b37 (Benjamin Tissoires            2011-11-23 10:54:31 +0100  293) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B     0x726b
> e36f690b37 (Benjamin Tissoires            2011-11-23 10:54:31 +0100  294) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72A1     0x72a1
> aa672da1b0 (Andy Shevchenko               2013-05-17 14:34:48 +0300  295) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72AA     0x72aa
> aa672da1b0 (Andy Shevchenko               2013-05-17 14:34:48 +0300  296) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72C4     0x72c4
> aa672da1b0 (Andy Shevchenko               2013-05-17 14:34:48 +0300  297) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72D0     0x72d0
> 66f06127f3 (Benjamin Tissoires            2011-11-23 10:54:33 +0100  298) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72FA     0x72fa
> bb9ff21072 (Marek Vasut                   2011-11-23 10:54:32 +0100  299) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7302     0x7302
> fd1d152583 (Benjamin Tissoires            2012-03-06 10:53:47 +0100  300) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7349     0x7349
> ae01c9e53f (Thierry Reding                2012-08-09 08:34:48 +0200  301) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_73F7     0x73f7
> e36f690b37 (Benjamin Tissoires            2011-11-23 10:54:31 +0100  302) #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001     0xa001
>
> I mean these entries are screaming: I make no sense.
> Including the number in the name is so close to the nadir
> to make no difference.

Well, first, these entries are now used only once in the hid tree, and
it's in hid-multitouch. So it's a rather bad example IMO and I agree,
we could simply clean them up.

Second, I take that personally (even if there were no intent behind,
but git blame kinds of forces me to take it personally). There is a
story behind those defines and I only tried to keep them manageable.
If you look at the parent commit, they were called
"USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_X", X being 1 to N. It make even
less sense to have those. But at the time, they were needed because
hid-core.c needed them in hid_have_special_driver so they were used in
2 different files.

My point is:
- if you want to clean up the entries that are not used in several
places, fine by me
- but please keep at least the defines for the vendor_ID and the
defines were we are re-using them in hid-core.c and someplace else.

Cheers,
Benjamin
