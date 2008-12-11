From: Jim Gettys <jg@laptop.org>
Subject: Re: How do I find updates to the USB HID usage tables?
Date: Thu, 11 Dec 2008 11:01:57 -0500
Message-ID: <1229011317.14656.355.camel@jg-vaio>
References: <1229008606.14656.347.camel@jg-vaio>
	 <20081211153529.GB13887@kroah.com>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:50524 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756231AbYLKQCN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2008 11:02:13 -0500
In-Reply-To: <20081211153529.GB13887@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 2008-12-11 at 07:35 -0800, Greg KH wrote:
> On Thu, Dec 11, 2008 at 10:16:46AM -0500, Jim Gettys wrote:
> > Specifically, I'm trying to find definitions for new digitizer page
> > report fields not found in the USB serial bus HID usage tables v. 1.12
> > (the latest on the USB web site).
> > 
> > The fields of interest have values of 0x47, 0x48, and 0x49, that are in
> > the reserved area of the digitizer's page in the 1.12 document.
> 
> If they are "reserved" they shouldn't be used.
> Are you sure they are being used in a proper way and the device isn't
> just using the HID name to make it easier to write a userspace windows
> driver?

They are adjacent to the values that are allocated in the 1.12 spec; the
USB web site describes a process for asking for new fields to be defined
in that space.

Whether they are being used properly, is what I'd like to ensure; I have
a comment or two in the report data structure source I have that would
give me insight as to whether they are using them correctly.  If not, I
want to complain at them...

> 
> I can go dig through any pre-released specs that are availble if you
> think it is something that is being used properly.
> 
That would be greatly appreciated.  The values are all in the digitizer
page.

>
> The fields of interest have values of 0x47, 0x48, and 0x49, that are
> in the reserved area of the digitizer's page in the 1.12 document.

Thanks,
                   - Jim



-- 
Jim Gettys <jg@laptop.org>
One Laptop Per Child

