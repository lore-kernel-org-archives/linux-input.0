From: Donavan Lance <shvr@fedoraproject.org>
Subject: Re: [PATCH] HID: Add new Microsoft Type Cover 3 product id
Date: Mon, 14 Sep 2015 17:56:51 -0400
Message-ID: <BLU436-SMTP2302B872228D27FA089106ADF5D0@phx.gbl>
References: <BLU437-SMTP371DD8B4E702478936473BDF5D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from blu004-omc4s6.hotmail.com ([65.55.111.145]:62179 "EHLO
	BLU004-OMC4S6.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbINV4y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 17:56:54 -0400
In-Reply-To: <BLU437-SMTP371DD8B4E702478936473BDF5D0@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2015-09-14 at 17:01 -0400, Donavan Lance wrote:
> Adds support for Microsoft Type Cover 3 with 0x07e2 product ID.
> 
> Signed-off-by: Donavan Lance <shvr@fedoraproject.org>
> ---
>  drivers/hid/hid-core.c          | 2 ++
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/hid-microsoft.c     | 2 ++
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  4 files changed, 6 insertions(+)
> --------snip--------

Looks like the patch got mangled when I sent it. I'll resend, sorry for
the noise.
