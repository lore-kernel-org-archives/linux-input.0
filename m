From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/5] qt602240_ts: fix wrong sizeof in object table
 allocation
Date: Thu, 18 Nov 2010 20:16:25 +0900
Message-ID: <4CE50B09.2020507@samsung.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204150.28796.21244.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:28587 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab0KRLQ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 06:16:27 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC2004C1VBDKK70@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:16:25 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC2009PQVBECO@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:16:26 +0900 (KST)
In-reply-to: <20101116204150.28796.21244.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: linux-input@vger.kernel.org

Hi, Chris.

On 2010-11-17 =EC=98=A4=EC=A0=84 5:41, Chris Leech wrote:
> The kcalloc call for the object table is using sizeof(struct qt602240=
_data)
> when it should be using sizeof(struct qt6602240_object), resulting in=
 a larger
> allocation than is required.
>
> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>

Acked-by: Joonyoung Shim <jy0922@samsung.com>

Thanks.

> ---
>   drivers/input/touchscreen/qt602240_ts.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/=
touchscreen/qt602240_ts.c
> index 66b26ad..0b92c9d 100644
> --- a/drivers/input/touchscreen/qt602240_ts.c
> +++ b/drivers/input/touchscreen/qt602240_ts.c
> @@ -969,7 +969,7 @@ static int qt602240_initialize(struct qt602240_da=
ta *data)
>   		return error;
>
>   	data->object_table =3D kcalloc(info->object_num,
> -				     sizeof(struct qt602240_data),
> +				     sizeof(struct qt602240_object),
>   				     GFP_KERNEL);
>   	if (!data->object_table) {
>   		dev_err(&client->dev, "Failed to allocate memory\n");
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
