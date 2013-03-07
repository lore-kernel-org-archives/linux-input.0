From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 1/2] HID: Extend the interface with idle requests
Date: Thu, 7 Mar 2013 15:26:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303071526040.28677@pobox.suse.cz>
References: <1361979498-24446-1-git-send-email-benjamin.tissoires@redhat.com> <1361979498-24446-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38594 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab3CGO0t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Mar 2013 09:26:49 -0500
In-Reply-To: <1361979498-24446-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 27 Feb 2013, Benjamin Tissoires wrote:

> Some drivers send the idle command directly to underlying device,
> creating an unwanted dependency on the underlying transport layer.
> This patch adds hid_hw_idle() to the interface, thereby removing
> usbhid from the lion share of the drivers.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 15 +++++++++++++++
>  include/linux/hid.h           | 19 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 420466b..effcd3d 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1253,6 +1253,20 @@ static void usbhid_request(struct hid_device *hid, struct hid_report *rep, int r
>  	}
>  }
>  
> +static int usbhid_idle(struct hid_device *hid, int report, int idle,
> +		int reqtype)

Where does the need for passing the report argument come from please?

-- 
Jiri Kosina
SUSE Labs
