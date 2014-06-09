From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCHv2 2/3] IIO: Add iio_chan modifier for True/Magnetic North
 HID usages
Date: Mon, 09 Jun 2014 18:51:32 +0100
Message-ID: <5395F424.4070407@kernel.org>
References: <1401750890-31854-1-git-send-email-reyad.attiyat@gmail.com> <1401750890-31854-3-git-send-email-reyad.attiyat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59658 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbaFIRtm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jun 2014 13:49:42 -0400
In-Reply-To: <1401750890-31854-3-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org, jkosina@suse.cz

On 03/06/14 00:14, Reyad Attiyat wrote:
> Updated iio modifier enum for compass north usages,
> including magnetic/true north with tilt compensation.
>
> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
This looks fine.
> ---
>   drivers/iio/industrialio-core.c | 4 ++++
>   include/linux/iio/types.h       | 4 ++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ede16aec..2f523b5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -84,6 +84,10 @@ static const char * const iio_modifier_names[] = {
>   	[IIO_MOD_LIGHT_RED] = "red",
>   	[IIO_MOD_LIGHT_GREEN] = "green",
>   	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_NORTH_MAGN] = "north_magnetic",
> +	[IIO_MOD_NORTH_TRUE] = "north_true",
> +	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "north_magnetic_tilt_comp",
> +	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "north_true_tilt_comp",
>   };
>
>   /* relies on pairs of these shared then separate */
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 084d882..5bf8847 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -53,6 +53,10 @@ enum iio_modifier {
>   	IIO_MOD_LIGHT_RED,
>   	IIO_MOD_LIGHT_GREEN,
>   	IIO_MOD_LIGHT_BLUE,
> +	IIO_MOD_NORTH_MAGN,
> +	IIO_MOD_NORTH_TRUE,
> +	IIO_MOD_NORTH_MAGN_TILT_COMP,
> +	IIO_MOD_NORTH_TRUE_TILT_COMP
>   };
>
>   enum iio_event_type {
>

