From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH] PM / Runtime: runtime: Add sysfs option for forcing
 runtime suspend
Date: Wed, 09 Sep 2015 08:26:06 +0200
Message-ID: <1441779966.26994.52.camel@suse.com>
References: <Pine.LNX.4.44L0.1509081039470.1533-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57367 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbbIIG1i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Sep 2015 02:27:38 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509081039470.1533-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 2015-09-08 at 10:44 -0400, Alan Stern wrote:
> It would not put the device into runtime suspend immediately, like you
> are proposing.  Instead it would mean the same as the "auto" mode,
> except that remote wakeup should be disabled during runtime suspend.

Hi,

this proposal is incomplete. If you don't want remote wakeup you
imply that input is no longer needed or possible. If that is
already known, we can just as well inform the driver, so that
it can cease IO for input.

Yet that is not necessarily the only scenario. For example
if you run a screensaver, you might not care for where the
user touches the screen, but the event as such is valuable.

	Regards
		Oliver


