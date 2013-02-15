From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/7] HID: Extend the interface with report requests
Date: Fri, 15 Feb 2013 20:46:23 +0100
Message-ID: <20130215194623.GA8867@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
 <1360334256-22127-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:58416 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab3BOTph (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 14:45:37 -0500
Content-Disposition: inline
In-Reply-To: <1360334256-22127-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 08, 2013 at 03:37:30PM +0100, Benjamin Tissoires wrote:
> Some drivers send reports directly to underlying device, creating an
> unwanted dependency on the underlying transport layer. This patch adds
> hid_hw_request() to the interface, thereby removing usbhid from the
> lion share of the drivers.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 13 +++++++++++++
>  include/linux/hid.h           | 20 ++++++++++++++++++++
>  2 files changed, 33 insertions(+)

    Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Thanks, Benjamin.
Henrik
