From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: GPen 340 Pen Tablet input
Date: Sun, 16 Mar 2008 22:45:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803162244180.30831@jikos.suse.cz>
References: <alpine.LNX.1.00.0803161918260.15404@localhost>
 <Pine.LNX.4.64.0803161957010.19269@twin.jikos.cz> <alpine.LNX.1.00.0803162005320.32475@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38741 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752209AbYCPVqA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Mar 2008 17:46:00 -0400
In-Reply-To: <alpine.LNX.1.00.0803162005320.32475@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrej Gelenberg <andrej.gelenberg@googlemail.com>
Cc: linux-input@vger.kernel.org

On Sun, 16 Mar 2008, Andrej Gelenberg wrote:

> > Which driver is this tablet handled by?
> its handled by usbhid.

[ linux-input returned to CC ]

Please recompile your kernel with CONFIG_HID_DEBUG, modprobe the 'hid' 
module with 'debug=1' parameter, and send the output that appears in dmsg 
output when you connect the device, and also when you perform the actions 
that don't work properly.

Also, please annotate this output, i.e. write "this happens when I move 
the mouse in Y direction, this happens when I press that non-functioning 
button", etc.

Thanks,

-- 
Jiri Kosina
SUSE Labs
