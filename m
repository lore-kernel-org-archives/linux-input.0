From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v5 0/4] HID: lenovo: Add support for Lenovo Compact
 Keyboard
Date: Fri, 25 Jul 2014 16:05:27 +0200
Message-ID: <20140725160527.13cbeae1108fce5e09b6daae@ao2.it>
References: <1406154648-14000-1-git-send-email-jm@lentin.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:62473 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbaGYOFv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2014 10:05:51 -0400
In-Reply-To: <1406154648-14000-1-git-send-email-jm@lentin.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 23 Jul 2014 23:30:44 +0100
Jamie Lentin <jm@lentin.co.uk> wrote:

> This patchset follows on from my previous attempts to add support for
> these keyboards from Lenovo.
> 
> Antonio, I've used cptkbd_data and left data_pointer for now. It'd be
> an easy patch to change data_pointer to tpkbd_data, but is drifting
> away from what this patchset is supposed to do. Could send that
> afterwards though.
>

Sure, no problem. I think we are good to go.

BTW I was considering picking up one of such compact keyboards myself,
but I read that the BT one uses the USB cable only for charging
and it does not show as a USB HID device when plugged in, can you
confirm that?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
