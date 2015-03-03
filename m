From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v3 6/6] HID: uclogic: actually invert the in-range bit
 for huion tablets only
Date: Tue, 03 Mar 2015 20:43:46 +0200
Message-ID: <54F600E2.5040002@gmail.com>
References: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com> <1425404645-20134-7-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:44983 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbbCCSno (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2015 13:43:44 -0500
In-Reply-To: <1425404645-20134-7-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 03/03/2015 07:44 PM, Benjamin Tissoires wrote:
> This hack is only needed for Huion tablets. It does not seem to have
> any effect on the other tablets handled by this device right now, but
> it's better to check for the product id sooner than discovering that
> we have messed up one tablet later.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> changes in v3:
> - stores a flag to know when to invert the bit.
> - add #define UCLOGIC_PEN_REPORT_ID
>
> new in v2
>
>   drivers/hid/hid-uclogic.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index f44e72b..bdda9fd 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -564,6 +564,7 @@ enum uclogic_ph_id {
>
>   /* Report descriptor template placeholder */
>   #define UCLOGIC_PH(_ID) UCLOGIC_PH_HEAD, UCLOGIC_PH_ID_##_ID
> +#define UCLOGIC_PEN_REPORT_ID	0x07

It would be nice to also use this macro in the replaced report descriptor
itself, but this will do for now.

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Thanks a lot, Benjamin!

Nick

P.S. I like the way you describe the changes between patchset versions, will
      have to keep it in mind and use in my own.
