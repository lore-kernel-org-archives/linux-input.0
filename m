Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7093AB291
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911229; cv=none; b=Jz+4MYbvQz75hcqRAny5J8VzbkJqDBCImSXy/xYw/ePqRZ5AGBhlrjMP7qHcozEGRleCYgYcEBsN33ifXQlYZIX+qpUaQHxDtB4qYj199gmDNLrDauOJ51LEBcrWZXNd1a2og9k8IErR5a87fKkI/HjF/tmpgm8E/3Q/tzXxmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911229; c=relaxed/simple;
	bh=PYpLRUGkx31RSnORmVUud1jDNUKNdi451B07enxpxEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEn4EZg6NvBlg0ngSn+YnVDX5Jf2UutotRgvG5/c0rd7NaCvPOI6bRS4TTy3A0Q4EAoNvSDy7564z8yCGDX6LI84qzWyr54llReClHVFCmys27lYXvfB2SyFdTTPJXrBnlIfgv/rhzCN3V9yTfsvh9GukJVs8afmPZNCpfwyiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFrdyPkb; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFrdyPkb"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso5940512eec.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911227; x=1780516027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyFFFX6XR0cRJQPeXMVh4IghXeM3GX8dFIEjzWZo0sI=;
        b=oFrdyPkbYtnn0tV79P/aPBBVj11Ep8YLVILDYf/Q45/3LwIvVTIpNaHl/LT/xqA41z
         L0HdW12xjK3ltioru23AGPvjeUoJoRi+ndbM6bC6/uj3mcx/5MJ2pR0MBcAQbJvR/j0C
         BfeGbTiN0AW2tAsQ4Hbx5vGtmUl5EFmh72626vMYCFLLip742OztGI1mhM9xuYzl50PC
         XzTyiKrudnvx2VB8RQZnN0Rk6pLlNBqSpyg8iwyUOtHzU2mtnJ2py+5ylMl2Y9IL9LVv
         4iwrJcrvSV/38hHRnpyE0I5hc8HsIBHCi87UeOuz/QvllFZy6lyF8EUcVSIlQvhMLboo
         1SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911227; x=1780516027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyFFFX6XR0cRJQPeXMVh4IghXeM3GX8dFIEjzWZo0sI=;
        b=DaoElJqTIjvwZI0Cr35V9nuc8O/OzSjiCAGs88BA+0mUfly2vRJFkTLHksigYkms86
         Qya6UyS9NggkzucA2vXznJocNNJ1ozw1ynUNwvbwf82rX5owwgduVxa4VDMVeLaA9EJ5
         gZbzNfUVOeNHq5ye38iA97aokqHaHA3Hh6kEn+/Z5nbqcUS4ROPM7N4PN+1rixAp1z2/
         LR4mfGNBsT5FCJjBGnyTSoJtrP1tHMYUEuZwJAtdi6aYD+aX/9zeOEt7l5xAYs3IfgBa
         RRYZEj/qGLeJwP7NHN/qpCAmCeVYr8oPc8fjqMC13V+itCjft2e+YyWvDxi3X3URh5Qy
         8b4w==
X-Forwarded-Encrypted: i=1; AFNElJ8PsI3gOU/MUSeBo4wrUaXb5aRy88EgzPv2DewL/0TpnYhDTsairpppe41Vo5F8PK0OlGgI/bR5s/A8vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBU4NuNLmwPy8l59THm8emDBnBkBKh3zMgFdQ/lZTdwA+OtTVR
	iMMpmHzLB2+LvYxbxvbaIz3SgRIuhNwtj7atZq2ORUooAl/kHl3gdY+S
X-Gm-Gg: Acq92OFx9PO6upvNYHXyijZ2uv/ysCPiqjFYVTIH5pNRRVF/+jQbSrPxoOMBoyNFQon
	TqEiQqjkae/EEk0HZ1hGRxhlRMU+FdjNlef+WY0kKXOmXZ21YhtYlk6WbVywlMs+QllbANhtwug
	upw1nR7sZWo+wkat/86shaKlfu0E1+Ww7DRc2OiLR/m493gbvXIExykjKtnxtwbNzly44la+mAM
	7GvHJRkeaACaZSv+GhBr911izpZcF+JVSK3+q5Y1APzj7Q6pi01RUiv0pRwQXlLvIDvK+kxT4/D
	/3jYqXm2ESHb5J5VkdtdilFOCVI2tnPMnYZq+CanYa5ncBFxRMz0YJZlXbBaqlPyz+FMfPCJqZ/
	Em39m2qdkyc+/tnakVaN/zNt3H5MxeXJFZ4Pr1abT6iF/QV4iE8MHepptkbxOdII/xePnDqzgez
	1ijodV5uCLOLuvDFJm8CjjWDA3td+e6tGB1ob8g7P6kW+EDCtr2bArZJ0SyyHwbp+lCBryCT9nT
	Xo=
X-Received: by 2002:a05:7300:1481:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-30449037dc6mr12024869eec.3.1779911227370;
        Wed, 27 May 2026 12:47:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30458ab1a46sm13602131eec.24.2026.05.27.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:47:06 -0700 (PDT)
Date: Wed, 27 May 2026 12:47:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, 
	Ping Cheng <ping.cheng@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: validate report size before kfifo insert
Message-ID: <ahdJzWhVFm7mWu-v@google.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
 <20260524135203.1996265-2-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524135203.1996265-2-jinmo44.yang@gmail.com>

On Sun, May 24, 2026 at 10:52:03PM +0900, Jinmo Yang wrote:
> wacom_wac_queue_insert() passes the report size directly to kfifo_in()
> without checking whether the report fits in the kfifo buffer.
> 
> Since commit 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX
> limit"), the kfifo is sized dynamically as min(PAGE_SIZE, 10 * pktlen),
> which can be as small as 256 bytes. However, reports received via
> UHID_INPUT2 can be up to UHID_DATA_MAX (4096) bytes. When such an
> oversized report reaches wacom_wac_queue_insert(), the existing
> kfifo_avail() loop cannot make room for a record larger than the total
> buffer, causing kfifo_copy_in() to memcpy up to 3840 bytes past the
> slab allocation.

Does it? Or maybe spins there indefinitely? Also, doesn't
kfifo_copy_in() return 0 if a record it too big and not copy anything?

> 
> Add a size check at the top of wacom_wac_queue_insert() to reject
> reports that exceed the kfifo capacity.
> 
> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b..cc82c6f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -54,6 +54,12 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
>  {
>  	bool warned = false;
>  
> +	if (size > kfifo_size(fifo)) {
> +		hid_warn(hdev, "%s: report too large (%d > %u) for kfifo\n",
> +			 __func__, size, kfifo_size(fifo));
> +		return;
> +	}
> +
>  	while (kfifo_avail(fifo) < size) {
>  		if (!warned)
>  			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);

Thanks.

-- 
Dmitry
