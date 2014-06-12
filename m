From: Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: Re: [PATCH] Input: st-keyscan - Protect PM-only functions by #ifdef
 CONFIG_PM_SLEEP
Date: Thu, 12 Jun 2014 10:36:12 +0200
Message-ID: <5399667C.20203@st.com>
References: <1402513493-17613-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57873 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932399AbaFLIgt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2014 04:36:49 -0400
In-Reply-To: <1402513493-17613-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks Geert

Acked-by : Gabriel Fernandez <gabriel.fernandez@linaro.org>

Best Regards


On 06/11/2014 09:04 PM, Geert Uytterhoeven wrote:
> If CONFIG_PM_SLEEP=3Dn:
>
> drivers/input/keyboard/st-keyscan.c:219: warning: =E2=80=98keyscan_su=
spend=E2=80=99 defined but not used
> drivers/input/keyboard/st-keyscan.c:236: warning: =E2=80=98keyscan_re=
sume=E2=80=99 defined but not used
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drivers/input/keyboard/st-keyscan.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyb=
oard/st-keyscan.c
> index 758b48731415..668e3cf4b491 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -215,6 +215,7 @@ static int keyscan_probe(struct platform_device *=
pdev)
>   	return 0;
>   }
>  =20
> +#ifdef CONFIG_PM_SLEEP
>   static int keyscan_suspend(struct device *dev)
>   {
>   	struct platform_device *pdev =3D to_platform_device(dev);
> @@ -249,6 +250,7 @@ static int keyscan_resume(struct device *dev)
>   	mutex_unlock(&input->mutex);
>   	return retval;
>   }
> +#endif /* CONFIG_PM_SLEEP */
>  =20
>   static SIMPLE_DEV_PM_OPS(keyscan_dev_pm_ops, keyscan_suspend, keysc=
an_resume);
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
