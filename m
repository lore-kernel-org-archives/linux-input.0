From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/7] HID: Extend the interface with wait io request
Date: Fri, 15 Feb 2013 21:47:42 +0100
Message-ID: <20130215204742.GA25671@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
 <1360334256-22127-3-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:34380 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab3BOUrA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 15:47:00 -0500
Content-Disposition: inline
In-Reply-To: <1360334256-22127-3-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 08, 2013 at 03:37:31PM +0100, Benjamin Tissoires wrote:
> Some drivers need to wait for an io from the underlying device, creating
> an unwanted dependency on the underlying transport layer. This patch adds
> wait() to the interface, thereby removing usbhid from the lion share of
> the drivers.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c |  1 +
>  include/linux/hid.h           | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)

    Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Thank you, Benjamin,
Henrik
