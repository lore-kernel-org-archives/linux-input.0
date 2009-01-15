From: David Hagood <david.hagood@aeroflex.com>
Subject: Re: [Bugme-new] [Bug 12447] New: usbtouchscreen submits URB too
	quickly if built in to kernel
Date: Thu, 15 Jan 2009 10:31:31 -0600
Message-ID: <1232037091.9098.46.camel@sage.wic.aeroflex.com>
References: <Pine.LNX.4.44L0.0901151008560.2490-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:26881 "EHLO
	WA4EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbZAOQbf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2009 11:31:35 -0500
In-Reply-To: <Pine.LNX.4.44L0.0901151008560.2490-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On Thu, 2009-01-15 at 10:09 -0500, Alan Stern wrote:
> On Wed, 14 Jan 2009, Dmitry Torokhov wrote:
> 
> > > I suppose this is device-specific an
> A usbmon trace might come in useful here.  See the instructions in 
> Documentation/usb/usbmon.txt.
> 
> Alan Stern
> 

Now that i've mounted the USB monitor system, it works. Heisenberg
lives!


Notice: This e-mail is intended solely for use of the individual or entity to which it is addressed and may contain information that is proprietary, privileged, company confidential and/or exempt from disclosure under applicable law. If the reader is not the intended recipient or agent responsible for delivering the message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited.  If this communication has been transmitted from a U.S. location it may also contain data subject to the International Traffic in Arms Regulations or U.S. Export Administration Regulations and cannot be disseminated, distributed or copied to foreign nationals, residing in the U.S. or abroad, without the prior approval of the U.
 S. Department of State or appropriate export licensing authority. If you have received this communication in error, please notify the sender by reply e-mail or collect telephone call and del
 ete or destroy all copies of this e-mail message, any physical copies made of this e-mail message and/or any file attachment(s).


