From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Thu, 8 Jun 2017 20:39:04 +0100
Message-ID: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
References: <20170607192158.1eb9db3a@lxorguk.ukuu.org.uk>
        <Pine.LNX.4.44L0.1706071642230.1751-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:58632 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbdFHTjU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 8 Jun 2017 15:39:20 -0400
In-Reply-To: <Pine.LNX.4.44L0.1706071642230.1751-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, torvalds@linux-foundation.org

> Normally in this situation I'd recommend bisection.  However, this case
> may be simple enough for a usbmon trace to provide the answer.

With a shared file system between the T100TA and a big machine it's not
too hard to do some builds:

commit 76dd1fbebbaebab294dc09230960238746b883b1

is the offending commit, but I'm not sure it's a "bug" as such. Without
this commit my keyboard works without CONFIG_HID_ASUS, with it you need
the config entry enabled.

If you grab a default Ubuntu kernel .config and make oldconfig it's off.

Alan
