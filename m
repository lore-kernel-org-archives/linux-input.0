From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 4/5] platform/x86: intel-vbtn: support
 KEY_ROTATE_LOCK_TOGGLE
Date: Fri, 10 Nov 2017 00:30:46 +0100
Message-ID: <1510270246.2624.43.camel@hadess.net>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
         <1a034599-ff6c-4a42-8252-4f6007894f4a@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33412 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754802AbdKIXat (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 18:30:49 -0500
In-Reply-To: <1a034599-ff6c-4a42-8252-4f6007894f4a@rwthex-w2-a.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>, platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org

On Thu, 2017-11-09 at 23:44 +0100, Stefan Brüns wrote:
> The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but
> not
> on BIOS A2).
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> ---
> 
> Changes in v2:
> - Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
> - Use separate up/down events
> 
>  drivers/platform/x86/intel-vbtn.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index e3f6375af85c..a484bcc6393b 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
>  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
>  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
>  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
> +	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
> +	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */

How are those events sent? When pressing and releasing the key, do you
receive 0xC8 followed by 0xC9? Or do you receive 0xC8 when pressing and
releasing the first time, and 0xC9 when pressing and releasing a second
time?

If the former, then it's not going to work. The release is supposed to
be ignored, as you send the event with sparse_keymap_report_event().

If the latter, and there's an actual state, does it disable a device
on-board, or activate an LED? If so, then it would need to be a switch,
not a key.

>  	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
>  	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
>  	{ KE_END },
