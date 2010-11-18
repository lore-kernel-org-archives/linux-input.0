From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 5/5] qt602240_ts: add mXT224 identifier to id_table,
	to match Intel mid firmware identifier
Date: Thu, 18 Nov 2010 20:34:28 +0900
Message-ID: <4CE50F44.8080506@samsung.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204211.28796.93820.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48566 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0KRLe3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 06:34:29 -0500
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC200II3W5G9Q70@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:34:28 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC2009OUW5GWB@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:34:28 +0900 (KST)
In-reply-to: <20101116204211.28796.93820.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: linux-input@vger.kernel.org

On 2010-11-17 =EC=98=A4=EC=A0=84 5:42, Chris Leech wrote:
> "mXT224" is used in the SFI tables to identify the presence of this I=
2C device.
>
> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.

> ---
>   drivers/input/touchscreen/qt602240_ts.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/=
touchscreen/qt602240_ts.c
> index efe975e..cdd5a8b 100644
> --- a/drivers/input/touchscreen/qt602240_ts.c
> +++ b/drivers/input/touchscreen/qt602240_ts.c
> @@ -1432,6 +1432,7 @@ static int qt602240_resume(struct i2c_client *c=
lient)
>
>   static const struct i2c_device_id qt602240_id[] =3D {
>   	{ "qt602240_ts", 0 },
> +	{ "mXT224", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, qt602240_id);
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
