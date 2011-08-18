From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 5/6] Input: elantech - clean up elantech_init
Date: Thu, 18 Aug 2011 11:04:35 +0800
Message-ID: <CAGS+omDVn1uoU85pPN+jeHMTMp83EA13b3E8Sca0QOqDBZHQFg@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-6-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:41671 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab1HRDE7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:04:59 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p7I34vCS030850
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 20:04:58 -0700
Received: from qwi2 (qwi2.prod.google.com [10.241.195.2])
	by hpaq1.eem.corp.google.com with ESMTP id p7I321de004275
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 20:04:56 -0700
Received: by qwi2 with SMTP id 2so1225327qwi.36
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 20:04:56 -0700 (PDT)
In-Reply-To: <1313632629-23603-6-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 9:57 AM, JJ Ding <jj_ding@emc.com.tw> wrote:
> Group property setting code into elantech_set_properties.
>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |   69 ++++++++++++++++++++++-----------------
>  1 files changed, 39 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 7b9b6e5..ddd40eb 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -791,6 +791,42 @@ static int elantech_reconnect(struct psmouse *psmouse)
>  }
>
>  /*
> + * determine hardware version and set some properties according to it.
> + */
> +static void elantech_set_properties(struct elantech_data *etd)
> +{
> +       /*
> +        * Assume every version greater than 0x020030 is new EeePC style
> +        * hardware with 6 byte packets, except 0x020600
> +        */
> +       if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
> +               etd->hw_version = 1;
> +       else
> +               etd->hw_version = 2;
> +
> +       /*
> +        * Turn on packet checking by default.
> +        */
> +       etd->paritycheck = 1;

Assuming paritycheck goes away:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
