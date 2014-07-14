From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v4 0/4] Add support for Lenovo Compact Keyboard
Date: Mon, 14 Jul 2014 23:02:56 +0200
Message-ID: <20140714230256.9bd2c374a5b7ce085d5064be@ao2.it>
References: <1405236262-8070-1-git-send-email-jm@lentin.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:32422 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756878AbaGNVDR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2014 17:03:17 -0400
In-Reply-To: <1405236262-8070-1-git-send-email-jm@lentin.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 13 Jul 2014 08:24:18 +0100
Jamie Lentin <jm@lentin.co.uk> wrote:

> This patchset follows on from my previous attempts to add support for
> these keyboards from Lenovo.
[...] 

Hi Jamie,

in the next (and last) iteration add some context to the short commit
message, e.g. by adding a prefix:

HID: lenovo: ...

following the scheme of previous commits in the history.

> Cheers,
> 
> Jamie Lentin (4):
>   Rename hid-lenovo-tpkbd to hid-lenovo
>   Make all base functions switch depending on product ID
>   Style fixes
>   Add support for Compact (Bluetooth|USB) keyboard with Trackpoint

Maybe rename Bluetooth to BT if this becomes too long with the prefix.

Thanks,
   Antonio 

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
