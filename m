From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 1/7] input: cyapa: change strings of gen5 to pip in the
 name when they are shared
Date: Fri, 12 Jun 2015 23:34:35 -0700
Message-ID: <20150613063435.GA5808@hudson.localdomain>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
 <1434092198-13018-2-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34060 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbFMGeh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jun 2015 02:34:37 -0400
Content-Disposition: inline
In-Reply-To: <1434092198-13018-2-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se, bleung@google.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

Just noticed a few spelling errors...

On Fri, Jun 12, 2015 at 02:56:32PM +0800, Dudley Du wrote:
> Change strings 'gen5' to 'pip' for all macros, varibales and functions when
                                             sp: ^^^^^^^^^

> they are shared to be used in for gen5 and gen6 modules. The change of these
> strings is aimed to keep name definition much more clear and readable.
> TEST=test on Chromebook.
> 
> Signed-off-by: Dudley Du <dudl@cypress.com>
> ---
>  drivers/input/mouse/cyapa.c      |   22 +-
>  drivers/input/mouse/cyapa.h      |  133 ++++-
>  drivers/input/mouse/cyapa_gen3.c |    2 +-
>  drivers/input/mouse/cyapa_gen5.c | 1092 ++++++++++++++++++--------------------
>  4 files changed, 661 insertions(+), 588 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index efe1484..e7d4226 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -6,7 +6,7 @@
>   *   Daniel Kurtz <djkurtz@chromium.org>
>   *   Benson Leung <bleung@chromium.org>
>   *
[...]
>  	/* Size of packet not including output report register address */
>  	__le16 length;
> @@ -352,7 +298,7 @@ struct gen5_app_cmd_head {
>  	u8 parameter_data[0];  /* Parameter data variable based on cmd_code */
>  } __packed;
>  
> -/* Application get/set parameter command data structure */
> +/* Applicaton get/set parameter command data structure */
sp:   ^^^^^^^^^^

>  struct gen5_app_set_parameter_data {
>  	u8 parameter_id;
>  	u8 parameter_size;
> @@ -369,30 +315,26 @@ struct gen5_retrieve_panel_scan_data {
>  	u8 data_id;
>  } __packed;
[...]
> +				pip->irq_cmd_buf, length))) {
>  			/*
> -			 * Work around the Gen5 V1 firmware
> -			 * that does not assert interrupt signalling
> -			 * that command response is ready if user
> -			 * keeps touching the trackpad while command
> -			 * is sent to the device.
> +			 * Cover the Gen5 V1 firmware issue.
> +			 * The issue is there is no interrut will be
                                    sp: ^^^^^^^^

> +			 * asserted to notityf host to read a command
                       sp: ^^^^^^^

> +			 * data out when always has finger touch on
> +			 * trackpad during the command is issued to
> +			 * trackad device.
           sp: ^^^^^^^

> +			 * This issue has the scenario is that,
> +			 * user always has his fingers touched on
> +			 * trackpad device when booting/rebooting
> +			 * their chrome book.
>  			 */

The wording in the above section could be improved as well.


>  			length = 0;
> -			if (gen5_pip->resp_len)
> -				length = *gen5_pip->resp_len;
> +			if (pip->resp_len)
> +				length = *pip->resp_len;
>  			cyapa_empty_pip_output_data(cyapa,
> -					gen5_pip->resp_data,
[...]

-- 
- Jeremiah Mahler
