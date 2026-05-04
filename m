Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D835CB89
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936558; cv=none; b=KNXaGQ84YalL/oW5I1wXuTRo1rI25W9D8nWonoiccBlrolnxUt3HK6CPi1wpfWE0IyVAYQVjjxURedtSQEgyZgXrTNnTCQUQdt+emHutJ3KA4O8xj8u1IfDH9Pd/EV9np2gyUjq/SICLuPjuj1Ly1EFFIXxo8Kl8xEdabSaIIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936558; c=relaxed/simple;
	bh=6kA5f8/Eq1uu4hnjHTbRSXA1fMelDXAzD0GtxiZTMBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+aYNkQzDTYTFBJhfPW+x1Ey1FBeFd62bNxcRQ7YMoB4dDSa1zhsTfNsWo9tYgudn3L7C+MGydpgdFhhvCuHsDWCfptvsRWa5BjV3SNLtFkk0B/7S84yiJm3SWP+qS6Y1MQGWJb2ES3ee0IsXzGTUgKIYT+EaSr+44jsXEXNYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHUVOf2U; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHUVOf2U"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c45281a06so7198544c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777936556; x=1778541356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJUaPNEnLT6eI3Sz+OplXWx4CX0ycNqOaqliP4b8tDU=;
        b=OHUVOf2UM8g4vLb7uYSU6h5tYF5iG+pxFI2BhfjLj060+C7P68bEIfcaaEvlK4ZBSQ
         LL1JLXxMo6dQcxGpR4kfrMjmIzZeBOn3MXoq/Fp5YtHTMf6g3tzhSAOrOiYLccFDRE7X
         mwfOJKzvHMJOZXDFHM9nawoPZrwr24xEoxusT3zqkmJVTRqJjkLCT0srQB4zDVAf6uHU
         fB9TR/qUpJwAVKnZr+6vsaMMBXVqIZb1pNhURGF+nm86hFAd6xEhHPmD+rcbOAc0V492
         IU6esuFqC3h0BauoAMFynEWDIXlJ7kU4GeFaNGRkjJDY50+2ccRUgZGXRrOvuygPlKbd
         1plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777936556; x=1778541356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJUaPNEnLT6eI3Sz+OplXWx4CX0ycNqOaqliP4b8tDU=;
        b=Cj64iuxJblDwYiO3c3QoaMMQK+7fRHq9PVmGnUVPkmxKxcq4k6lJ69T1vIIrrNEdN7
         RD8J1t9NG/buobLcQtBBqx67Sn6RNvXpyIbOXYNOHBpxm3quKRPl+TqGAfiQKF/MdBRl
         CAwBQTbuobbity2p+eorLyBwb8Hh2cK1m5k/D+xroQGS9xIF0e/XWdCBN9omd0/Y2M7h
         AKOA9ZBUp4XxYVw/N6taLMU+rs8F0oD27EtJuy5Yl1VtAIdiV6NRyeXFR8alENfvVk/Q
         LuESjLxBQlyM7hOgJNmeMJm4ipSOvMQBM12jNlJ5OZTqNIX3kWYj8LXU3lzzlSjWGaSM
         OBQw==
X-Forwarded-Encrypted: i=1; AFNElJ9C8viROp+veTGOy3K/tUsys44PPjeCD2dIbUpBQCmYKrFw+CV0r8eYjNmyGdEro0ZoJV/931/qmnsDFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKra1/O0DG28p3IJJ3iOSG6Zc/CYOgnlYnyfVvzMM96KopsU+
	MM+7GY6e4w7KoI1OApVxWChehjrjmIcJTf+xGNqdP89DauflISZcWGzH
X-Gm-Gg: AeBDiev+kDwa4PeyA3/zH2wv4Fr1Bjf3nflhKoHk5hPySVcb0Il/igob8maT9ro6N8Q
	U/sfKmfb72n1pIjCORRAX6fVPA8KTgzO/NT3usIbgwqIkuPEuwjNwnklQq6GE9Jn1I4yVs2qSwJ
	xb+bAL6pMDopMRIjPbAARrvEOTSJTYru2yiLOAUVuWsVulfLa2Sdyf6SotS1W6tGBhTkV7YXYMN
	eNICW/cZQ7QcwXijH45Xn4a0YVQ/z9Ye7hudYb7EAQ8tm4mmlMVL0ofkrLDXyGJ6KTHGEoQGwXs
	62IDZd6xfOxeaRAHt8MsNYJx3zXsHEPUDehoNWax11jJBxoYYFxc5bofxF7rkSQG0bz4Ebfn/DC
	z+3EECTy+KKJiHv9fJAimGQ4E0cgsNQZ5GMCQtDo1AjyLwcfFnm5zHpUNP/zxptTm97jzE/yO0L
	a7GZQ57cTfewJ8MYiHi+Dy1MNV1NGwX3WXCQYhOcvR5dZE/MCJAt6ie3NaHkd1tJse0eMrga6Ct
	1vnwAozgZ5YDg==
X-Received: by 2002:a05:7022:605:b0:12c:8b9:7208 with SMTP id a92af1059eb24-130b1b67874mr477748c88.26.1777936556135;
        Mon, 04 May 2026 16:15:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84252c0sm20605766c88.10.2026.05.04.16.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:15:55 -0700 (PDT)
Date: Mon, 4 May 2026 16:15:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 4/4] HID: wacom: use __free(kfree) to clean up
 temporary buffers
Message-ID: <afknxbpP7oj4bNab@google.com>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
 <20260504-wip-fix-core-v3-4-ce1f11f4968f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-fix-core-v3-4-ce1f11f4968f@kernel.org>

Hi Benjamin,

On Mon, May 04, 2026 at 10:47:25AM +0200, Benjamin Tissoires wrote:
> @@ -386,10 +381,11 @@ static void wacom_feature_mapping(struct hid_device *hdev,
>  	case WACOM_HID_WD_OFFSETRIGHT:
>  	case WACOM_HID_WD_OFFSETBOTTOM:
>  		/* read manually */
> -		n = hid_report_len(field->report);
> -		data = hid_alloc_report_buf(field->report, GFP_KERNEL);
> +		u8 *data __free(kfree) = hid_alloc_report_buf(field->report, GFP_KERNEL);
> +
>  		if (!data)
>  			break;
> +		n = hid_report_len(field->report);
>  		data[0] = field->report->id;
>  		ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
>  					data, n, WAC_CMD_RETRIES);
> @@ -400,7 +396,6 @@ static void wacom_feature_mapping(struct hid_device *hdev,
>  			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
>  				 __func__);
>  		}
> -		kfree(data);
>  		break;
>  	}

I'd recommend establishing a new scope for the "data", otherwise it is
fragile. If there was another label below then this cleanup would
explode since current scope of "data" is from the declaration point
until the end of the switch statement.

Having a dedicated scope makes lifertime explicit.

Thanks.

-- 
Dmitry
