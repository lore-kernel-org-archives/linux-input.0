From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 5/5] platform/x86: intel-vbtn: support panel front
 button
Date: Fri, 10 Nov 2017 00:40:33 +0100
Message-ID: <1510270833.2624.52.camel@hadess.net>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
         <7c072721-1bd8-4921-b759-70bafb2ec894@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36453 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754942AbdKIXkk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 18:40:40 -0500
In-Reply-To: <7c072721-1bd8-4921-b759-70bafb2ec894@rwthex-w2-a.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>, platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org

On Thu, 2017-11-09 at 23:44 +0100, Stefan Brüns wrote:
> The Lenovo Helix 2 and Dell XPS 12 (9Q33) have an extra button on the
> front showing a 'Windows' logo, both reporting event codes 0xC2/0xC3
> on press/release. On the Dell, both press/release are distinct events
> while on the Helix 2 both events are generated on release.
> 
> Tested on XPS 12, for info on the Helix 2 see:
> https://www.spinics.net/lists/ibm-acpi-devel/msg03982.html
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

Same problem as mentioned in patch 3. Pretty sure you need to set the
Windows key release to KEY_IGNORE.

Or better, teach the intel-vbtn driver which buttons should be
autoreleased, and which ones should send key presses and key releases
separately. This would allow handling long presses in the upper layers.

> ---
> 
> Changes in v2:
> - Emit KEY_LEFTMETA instead of KEY_MENU
> 
>  drivers/platform/x86/intel-vbtn.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c
> b/drivers/platform/x86/intel-vbtn.c
> index a484bcc6393b..0861efe490d0 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -38,6 +38,8 @@ static const struct acpi_device_id intel_vbtn_ids[]
> = {
>  static const struct key_entry intel_vbtn_keymap[] = {
>  	{ KE_KEY, 0xC0, { KEY_POWER } },	/* power key press
> */
>  	{ KE_IGNORE, 0xC1, { KEY_POWER } },	/* power key
> release */
> +	{ KE_KEY, 0xC2, { KEY_LEFTMETA } },		/*
> 'Windows' key press */
> +	{ KE_KEY, 0xC3, { KEY_LEFTMETA } },		/*
> 'Windows' key release */
>  	{ KE_KEY, 0xC4, { KEY_VOLUMEUP } },		/*
> volume-up key press */
>  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/*
> volume-up key release */
>  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/*
> volume-down key press */
