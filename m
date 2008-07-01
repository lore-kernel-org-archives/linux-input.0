From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid: gyration remote support
Date: Tue, 1 Jul 2008 09:55:40 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807010954540.6375@jikos.suse.cz>
References: <1214854982-20611-1-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:58782 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752632AbYGAHzl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Jul 2008 03:55:41 -0400
In-Reply-To: <1214854982-20611-1-git-send-email-dwalker@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

On Mon, 30 Jun 2008, Daniel Walker wrote:

> This adds in a quirk for the additional un-mapped buttons on the
> gyration MCE remote.
>
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
> ---
> drivers/hid/hid-input-quirks.c |   28 ++++++++++++++++++++++++++++
> 1 files changed, 28 insertions(+), 0 deletions(-)
[ ... ]
> @@ -324,6 +347,9 @@ static int quirk_sunplus_wdesktop(struct hid_usage *usage, struct input_dev *inp
> #define VENDOR_ID_SUNPLUS			0x04fc
> #define DEVICE_ID_SUNPLUS_WDESKTOP		0x05d8
>
> +#define VENDOR_ID_GYRATION			0x0c16
> +#define DEVICE_ID_GYRATION_REMOTE		0x0002

Hi daniel,

thanks a lot for the patch. Could you please leave the order of these 
defines alphabetically sorted?

> static const struct hid_input_blacklist {
> 	__u16 idVendor;
> 	__u16 idProduct;
> @@ -353,6 +379,8 @@ static const struct hid_input_blacklist {
>
> 	{ VENDOR_ID_SUNPLUS, DEVICE_ID_SUNPLUS_WDESKTOP, quirk_sunplus_wdesktop },
>
> +	{ VENDOR_ID_GYRATION, DEVICE_ID_GYRATION_REMOTE, quirk_gyration_remote },
> +

And here too, please.

Thanks,

-- 
Jiri Kosina
SUSE Labs
