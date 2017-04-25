From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 7/7] HID: picoLCD: Replace two seq_printf() calls by
 seq_puts() in picolcd_debug_reset_show()
Date: Tue, 25 Apr 2017 08:40:51 +0200
Message-ID: <20170425084051.5b981b48@pluto.restena.lu>
References: <2d526d72-a740-367b-04a9-ed698435f8ed@users.sourceforge.net>
        <ceee0ae6-fd37-66b6-116a-319f5e393327@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:47043 "EHLO
        smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164724AbdDYGuB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 02:50:01 -0400
In-Reply-To: <ceee0ae6-fd37-66b6-116a-319f5e393327@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Acked-by: Bruno Prémont <bonbons@linux-vserver.org>

On Mon, 24 Apr 2017 22:23:02 +0200 SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 24 Apr 2017 21:27:42 +0200
> 
> Strings which did not contain data format specifications should be put
> into a sequence. Thus use the corresponding function "seq_puts".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/hid/hid-picolcd_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
> index 3e0feb4bb538..975f36601d59 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -33,9 +33,9 @@
>  static int picolcd_debug_reset_show(struct seq_file *f, void *p)
>  {
>  	if (picolcd_fbinfo((struct picolcd_data *)f->private))
> -		seq_printf(f, "all fb\n");
> +		seq_puts(f, "all fb\n");
>  	else
> -		seq_printf(f, "all\n");
> +		seq_puts(f, "all\n");
>  	return 0;
>  }
>  
