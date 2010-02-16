From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Key for tablet rotation?
Date: Tue, 16 Feb 2010 14:54:49 -0800
Message-ID: <20100216225449.GA4466@core.coreip.homeip.net>
References: <20100216211714.GA5071@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41105 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933395Ab0BPWyz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 17:54:55 -0500
Received: by vws8 with SMTP id 8so466566vws.19
        for <linux-input@vger.kernel.org>; Tue, 16 Feb 2010 14:54:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100216211714.GA5071@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org

On Tue, Feb 16, 2010 at 09:17:14PM +0000, Matthew Garrett wrote:
> Many tablet PCs have a button to indicate that the screen should be 
> rotated from landscape to portrait mode. There's currently no 
> standardisation here - a couple of drivers seem to be using 
> KEY_DIRECTION, and others are just being mapped to arbitrary F keys. So:
> 
> 1) What is KEY_DIRECTION supposed to be for?

Hmm, that is the good question. It looks like it's been introduced with
the first patch for input events that Vojtech brought in 2.3 kernels and
I do not see any users for it in mainline.

Vojtech, do you remember by any chance what you intended it to be used
for?

> 2) If it's not suitable, do we still have space for a KEY_ROTATE?
> 

We still have a few slots available but I'd lean towards KEY_DIRECTION
(with better name maybe).

-- 
Dmitry
