From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Regression: commit e696c68363740d3a8fe495e353de3ff26b86257a
 prevents Linux 3.13 from booting on Lenovo X1 Carbon.
Date: Mon, 20 Jan 2014 15:53:58 -0800
Message-ID: <20140120235358.GC5012@kroah.com>
References: <20140120232652.GA5815@weetamoe.luzern.taprogge.wh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36543 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaATXxM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 18:53:12 -0500
Content-Disposition: inline
In-Reply-To: <20140120232652.GA5815@weetamoe.luzern.taprogge.wh>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Tue, Jan 21, 2014 at 12:26:52AM +0100, Jens Taprogge wrote:
> Hello,
> 
> I have bisected the boot failure of a Lenovo Thinkpad X1 Carbon to the
> merge ea4ebd1cb093c8ec5d7f4bf9070dc444184c3971.  What I call "boot
> failure" refers to the fact that no console is shown, the machine only
> reads from the disc for a very short time, and the machine does not
> respond to Ctrl-Alt-Del, etc.
> 
> As it turns out reverting e696c68363740d3a8fe495e353de3ff26b86257a
> (Input: serio - fix sysfs layout) on top of v3.13 makes the machine boot
> again.  So far I have now clue how this commit can affect early boot
> / showing of the console.
> 
> Does it ring any bells for you?

No, not at all, I don't see how that patch could prevent booting,
especially as it is fixing a regression (i.e. putting things back the
way they originally were.)

very odd.

greg k-h
