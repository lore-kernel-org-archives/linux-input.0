Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716213AC0C0
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339604; cv=none; b=poCy5+kmLMngfr/nFFFisBxeS2ez0i54GHCzWbSefp00nDODiz5q6jH9PirgdwYX+elH/kHk+3dHmef3TgX1+8IhA1WklrraELIkqro3fJnj3VibjOfweI9lv7eOHO6Mr44GxB7EGSpFJ5wSPWRQjFBfbz9kkixmfthilBSPFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339604; c=relaxed/simple;
	bh=dcNnH3lRSCWAyb/2RllcUja1jqWu6vySIBB1hJ6Yt5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPdtX5xgoUaNxu5CIzt4icXYnB1YL1/+2tGF4WuH6QQ9hyXjUDZNo88dsQ7s4eBJHmvSEVaoDGt64mqaAQyhcrsqcwPe/aeYiew7jk8WT3n/I1OkpE6UqIv4CI70gZN34QDaKYfz+kFu00UPlGj3Wi/zIN2E4Cte2fkNSDhfJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IyG63zEl; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IyG63zEl"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dcNnH3lRSCWAyb/2RllcUja1jqWu6vySIBB1hJ6Yt5w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792339598; v=1; x=1792944398;
 b=IyG63zEl6iinucKyZB6w6S6srtdxW2lQU2+nyInHCpuivDmJgh4SoydzzvOevv7IAe76fVdP
 xDIZZk5+iMm32HAklwqP/+swJdq8kGCO17jTS09t1C9ud0uMU4d3YzR53rNIdrHYYja9i+xOD40
 zNsGyeaK6Sb41MOAo3ZueK2Q=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0e1932ff56a47880;
	Sun, 18 Oct 2026 16:06:37 +0000
X-Mizu-Trace-ID: 0e1932ff56a47880
X-Migadu-Flow: FLOW_OUT
Message-ID: <f93c315e-db6f-4322-9081-e192da12e58f@linux.dev>
Date: Sun, 18 Oct 2026 18:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] HID: asus: Force hid-input to bind to the Zenbook
 Duo hotkey interface
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-4-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-4-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:40, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
>
> The Zenbook Duo USB keyboard reports its hotkeys on a dedicated
> interface, separate from the keyboard and consumer control ones, that
> only contains ASUS vendor usage collections. hid-input does not
> consider those an input application and never binds to the interface,
> so the hotkeys are never mapped.
>
> Pass HID_CONNECT_HIDINPUT_FORCE for the interface of Zenbook Duo
> keyboards that carries the ASUS vendor collection, which skips that
> check, so the vendor usages go through asus_input_mapping() like on
> any other ASUS keyboard. The other interfaces either have a proper
> input application or nothing worth an input device.
>
> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: use HID_CONNECT_HIDINPUT_FORCE on the vendor interface instead
>  of injecting a fake keyboard collection into its report descriptor]
> Assisted-by: LLM

Same as the other one, Assisted-by isn't right like this... About the rest:

Reviewed-by: Denis Benato <denis.benato@linux.dev>

> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
> ---
>  drivers/hid/hid-asus.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 242e273e4cb3..d69431615c27 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1405,6 +1405,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	struct asus_drvdata *drvdata;
>  	struct hid_report *rep;
>  	bool is_vendor = false;
> +	unsigned int connect_mask;
>  	int ret;
>  
>  	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> @@ -1500,7 +1501,18 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  	}
>  
> -	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	/*
> +	 * The Zenbook Duo keyboard reports its hotkeys on a dedicated USB
> +	 * interface that only has vendor usage collections, which hid-input
> +	 * does not consider an input application. Make it bind to the
> +	 * interface carrying the ASUS vendor collection anyway so the
> +	 * hotkeys get mapped.
> +	 */

I would shorten this comment, but I'm not good in this and the code is okay so
I gave reviewed-by regardless: do what you wish with my suggestion.

> +	connect_mask = HID_CONNECT_DEFAULT;
> +	if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) && is_vendor)
> +		connect_mask |= HID_CONNECT_HIDINPUT_FORCE;
> +
> +	ret = hid_hw_start(hdev, connect_mask);
>  	if (ret) {
>  		asus_worker_stop(drvdata->worker);
>  		hid_err(hdev, "Asus hw start failed: %d\n", ret);
