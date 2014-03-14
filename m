From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-lg4ff: Support new version of G27
Date: Fri, 14 Mar 2014 15:44:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403141544350.3690@pobox.suse.cz>
References: <1394736123-2102-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33463 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbaCNOoo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2014 10:44:44 -0400
In-Reply-To: <1394736123-2102-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Baldo <ibaldo@adinet.com.uy>, evilcow <evilcow93@yahoo.com>

On Thu, 13 Mar 2014, Simon Wood wrote:

> It has been reported that there is a new hardware version of the G27
> in the 'wild'. This patch add's this new revision so that it can be
> sent the command to switch to native mode.
> 
> Reported-by: "Ivan Baldo" <ibaldo@adinet.com.uy>
> Tested-by: "evilcow" <evilcow93@yahoo.com>
> Signed-off-by: Simon Wood <simon@mungewell.org>
> ---
>  drivers/hid/hid-lg4ff.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index befe0e3..24883b4 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -43,6 +43,7 @@
>  #define G25_REV_MIN 0x22
>  #define G27_REV_MAJ 0x12
>  #define G27_REV_MIN 0x38
> +#define G27_2_REV_MIN 0x39
>  
>  #define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
>  
> @@ -130,6 +131,7 @@ static const struct lg4ff_usb_revision lg4ff_revs[] = {
>  	{DFP_REV_MAJ,  DFP_REV_MIN,  &native_dfp},	/* Driving Force Pro */
>  	{G25_REV_MAJ,  G25_REV_MIN,  &native_g25},	/* G25 */
>  	{G27_REV_MAJ,  G27_REV_MIN,  &native_g27},	/* G27 */
> +	{G27_REV_MAJ,  G27_2_REV_MIN,  &native_g27},	/* G27 v2 */
>  };

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
