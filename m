From: Phil Turmel <philip@turmel.org>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Tue, 21 Sep 2010 10:54:03 -0400
Message-ID: <4C98C70B.3080407@turmel.org>
References: <Pine.LNX.4.44L0.1009211013460.1644-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atl.turmel.org ([74.117.157.138]:57360 "EHLO atl.turmel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab0IUOyS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 10:54:18 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009211013460.1644-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Mat <jackdachef@gmail.com>, Guillaume Chazarain <guichaz@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>, Gabriel C <nix.or.die@googlemail.com>

On 09/21/2010 10:30 AM, Alan Stern wrote:
> On Tue, 21 Sep 2010, Jiri Kosina wrote:
> 
>> I have just found out that it's actually CONFIG_USB_DYNAMIC_MINORS which 
>> makes the difference. When unset, the problem doesn't trigger, and 
>> usb_find_interface() always returns the proper interface. When 
>> CONFIG_USB_DYNAMIC_MINORS is being used, the oops happen.
>>
>> I'll look into that.
> 
> Apparently the problem is that intf->minors doesn't get initialized 
> properly.  This patch should fix it.  Everybody, please try it out.

Yes, this works for me.  (as did Jiri's version.)

Thank you both for the support.

Feel free to add my:

Tested-by: Philip J. Turmel <philip@turmel.org>
