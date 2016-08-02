From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 0289/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:13:35 +0200
Message-ID: <aca45400-b476-a48c-913c-09c4360a577a@analog.com>
References: <20160802105705.635-1-baolex.ni@intel.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:2785
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965538AbcHBOsT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 10:48:19 -0400
In-Reply-To: <20160802105705.635-1-baolex.ni@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, chuansheng.liu@intel.com

On 02.08.2016 12:57, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index e4bf110..83be4c5 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -364,7 +364,7 @@ static ssize_t ad7879_disable_store(struct device *dev,
>  	return count;
>  }
>
> -static DEVICE_ATTR(disable, 0664, ad7879_disable_show, ad7879_disable_store);
> +static DEVICE_ATTR(disable, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7879_disable_show, ad7879_disable_store);
>
>  static struct attribute *ad7879_attributes[] = {
>  	&dev_attr_disable.attr,
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
