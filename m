From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid_parse failure
Date: Thu, 10 May 2012 12:21:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205101220070.31253@pobox.suse.cz>
References: <1335888472-19053-1-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758781Ab2EJKVg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 06:21:36 -0400
In-Reply-To: <1335888472-19053-1-git-send-email-srinivas.pandruvada@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-input@vger.kernel.org

On Tue, 1 May 2012, srinivas pandruvada wrote:

> When logical maximum is 0xffffffff, the parser fails even if
> logical minimum is equal to or greater than  0.
> By HID specification, if both the Logical Minimum and Logical
> Maximum extents are defined as positive values (0 or greater)
> then the report field can be assumed to be an unsigned value.
> Otherwise, all integer values are signed values represented
> in 2=E2=80=99s complement format.

Signed-off-by: line is missing, could you please fix that?

> ---
>  drivers/hid/hid-core.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c757f10..b616f4b 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -225,8 +225,16 @@ static int hid_add_field(struct hid_parser *pars=
er, unsigned report_type, unsign
>  		return -1;
>  	}
> =20
> -	if (parser->global.logical_maximum < parser->global.logical_minimum=
) {
> -		dbg_hid("logical range invalid %d %d\n", parser->global.logical_mi=
nimum, parser->global.logical_maximum);
> +	if ((parser->global.logical_minimum < 0 &&
> +		parser->global.logical_maximum <
> +			parser->global.logical_minimum) ||
> +		(parser->global.logical_minimum >=3D 0 &&
> +			(__u32)parser->global.logical_maximum <
> +			(__u32)parser->global.logical_minimum)
> +		) {
> +		dbg_hid("logical range invalid 0x%x 0x%x\n",
> +			parser->global.logical_minimum,
> +				parser->global.logical_maximum);
>  		return -1;
>  	}

The change looks correct per se, but I will have to think a little bit=20
more whether other places of report parsing don't need similar adjustme=
nts=20
as well to work properly in such scenarios.

How did you find this out? By code/spec inspection, or do you actually=20
have the device that exposes this problem?

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
