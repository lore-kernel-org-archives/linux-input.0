From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: Add keycodes for some missing Fn key
 combinations
Date: Sat, 17 May 2014 13:30:54 -0700
Message-ID: <20140517203054.GA19657@core.coreip.homeip.net>
References: <201405171639.45722@pali>
 <1400337817-14473-1-git-send-email-pali.rohar@gmail.com>
 <1400337817-14473-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64672 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaEQUa5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 May 2014 16:30:57 -0400
Content-Disposition: inline
In-Reply-To: <1400337817-14473-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-hotplug@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org

Hi Pali,

On Sat, May 17, 2014 at 04:43:36PM +0200, Pali Roh=E1r wrote:
> There are already defined some Fn key combinations, but not all.
> This patch adds missing combinations for support in dell-wmi driver.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  include/uapi/linux/input.h |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index f484952..3a32799 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -672,6 +672,12 @@ struct input_keymap_entry {
>  #define KEY_FN_F		0x1e2
>  #define KEY_FN_S		0x1e3
>  #define KEY_FN_B		0x1e4
> +#define KEY_FN_Q		0x1e5
> +#define KEY_FN_W		0x1e6
> +#define KEY_FN_R		0x1e7
> +#define KEY_FN_T		0x1e8
> +#define KEY_FN_A		0x1e9
> +#define KEY_FN_G		0x1ea

What do they actually do?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
