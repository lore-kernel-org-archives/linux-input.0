From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] input: Add support for Wacom protocol 4 serial tablets
Date: Tue, 22 Jul 2014 10:02:51 +1000
Message-ID: <20140722000251.GA11004@jelly.redhat.com>
References: <1405867583-3321-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:55366 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaGVADB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 20:03:01 -0400
Content-Disposition: inline
In-Reply-To: <1405867583-3321-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Julian Squires <julian@cipht.net>, linux-input@vger.kernel.org

On Sun, Jul 20, 2014 at 04:46:23PM +0200, Hans de Goede wrote:
> Recent version of xf86-input-wacom no longer support directly accessing
> serial tablets. Instead xf86-input-wacom now expects all wacom tablets to
> be driven by the kernel and to show up as evdev devices.

just for the archives: xf86-input-wacom still has ISDV4 serial handling code
in it, we just use inputattach in most setups now. Most contemporary serial
devices such that exist still work directly if needed. But yes, the protocol
4 support was dropped in 2009, so we're talking about devices >5 years old.

Cheers,
   Peter

> 
> This has caused old serial Wacom tablets to stop working for people who still
> have such tablets. Julian Squires has written a serio input driver to fix this:
> https://github.com/tokenrove/wacom-serial-iv
> 
> This is a cleaned up version of this driver with improved Graphire support
> (I own an old Graphire myself).
> 
> Signed-off-by: Julian Squires <julian@cipht.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
