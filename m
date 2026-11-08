Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794119605;
	b=j22kJK5qqpQX03k17VnVMxRQpTSjM9ABcxMbnyxLMbPzKgrUg9GGccfzjrAa+Wgi7o0Z
	 +tS3Q+eiMaNiWsLy4SiCxqMpMHdfsiRgCWsd9XtHN/KeEpAY5dlESHNUbwqqBVy0/PNFz
	 F3nhd7IbNXYL764MwnwAKxdKJJJBVnEB5fKwfWP9T4ChL6NMKyW+8LLo4ZxkKI8gNp8qq
	 FBYMlESRm62ZbzvZ6IcIlXWrJO/jE0+1tCiu8tAljTVa7jXeQmhw5rOEfHgkuhNmIfOH1
	 43o1Y4GxNFtooq7kmmt3jbr5AEE8yw35/ZIF7kLbFHfCQO1qZeR4VFFHsa4RxXKkkSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794119605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7tw1+OakpoH9nv5oeIcEeSnu2yq2xP4kxsGUVLSS30s=;
	b=kxr4v5bLPXOa5VX72+VyM9YOQZ18RBqGEfBelF/X2m8RI3gXUVEALNBYtgr/OIJ8Kq3H
	 Fno1Wa5avLFLyGuqs+SJ6mxTJPY7jJNWEbQjBzgwqUcrGToNxWpX0K4KFXerHuv1CegOj
	 EwzIcmrHa8qteaNzl9CnwrX0ezQnFf8B+BU8uuVrGaRGB+18+AYfpiPkpEwSsIKTciTi+
	 GPhCA260Tzgy0ZzVddu/JwCX5zh/SDgKlnI7i1UlbivHy5oyOXKV5qb2MFvL95QBUi7KL
	 EV4nBxwNfcCH3O0BlNSoNs86DNmiSyLgqznUMSvAdxWEWv1SRDLiXpcPW4FBXTfE4NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfwogyhf;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771B606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 06:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D771B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nfwogyhf
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a315ed211so262286eec.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 22:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794119604; x=1794724404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7tw1+OakpoH9nv5oeIcEeSnu2yq2xP4kxsGUVLSS30s=;
        b=nfwogyhfxYMzhIdJgftuvaUAywO8YTaWI09/Ngr2qPexgB7X+oQSG3Ywnz0S5EWJi5
         1Bf9GzLJCv6IT1CGsgD8I/g4xIL1lugugzD7saWOuoClP8ph2YFbkj01RYPLRp8N+jqB
         2zT6xBsRTaozjYHnHiBTT7fm3LkWhmPfod8+qbKopXgQ2AzO/yTLEkXLURSY+NhWlPvt
         WLFwPe53VMq3M6IC9Jva9v9MEWcWtJ5NXtGDEinm9AIHGc9V+rGV834iG++48miOZTdz
         AhEO149FxBxBEA/HX+jbUNxKvbrol6YeefpkKXYqxSQ6Cj/02ez4IG/8O/THIEix6n45
         XW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794119604; x=1794724404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7tw1+OakpoH9nv5oeIcEeSnu2yq2xP4kxsGUVLSS30s=;
        b=wjJ2k95auY/UwM0ET4i2eJ0THKL6v7Jt+d7ceVfpFhZvSp7T4iIj8ZpQOX4woUS5ih
         kwJoOBzoLF3/g1rlOJs1wtsBnp7BwSYIWwkz78Lk6l9qMHUG21bAEsO51ou2Evjrs1UX
         7W2SzmwbNKAalmRAjFjeSLe3t2P2Wd1cTOQUZQKmnxeezQBt3gwNDFbJIcN+9vZ6NGwq
         9HKeYMqLiPnOwZbrxxqRtgjDr9rYswGrrZOK1n8ZwXDiapU0KUXvGm8TzfaPjJE1z4LI
         MwZF2nOjFKbyka2Edo2Wif1xCycplbGI8cg8imgQdSywNVweRmo/hGjmOTkNqmK85cPB
         ooIQ==
X-Gm-Message-State: APuU4Z9I8d72hcF3+dPFo8Pvv4jU8gNEUDW8CPfPbq7RPIhyHijjg/Jv
	2LG2kdgMbURfZWAWFWdkjb6BdwyA1FB6w13X5hLEy5kTlK/aLk31X+Ih
X-Gm-Gg: AYBFou1bUXRJUE1ksKIDbtqtUsvZvPCgaa16cD663JvSMMtqq4j4oeTEnwt413hu/xR
	FySYBZ5tOjZAtd8z5Onnq/0aoyUg/hD93t8skeQqBuMTZiYNhEDandg1XlJ3lQzME+L/YYCSH/c
	wkBPa0cfInnUy/BGV2q4v7blOP2Mvv1s/1vbKj0ewijwyPAVWejqZfIVbMVQFtmIsCAa3p3sedf
	b4dwLZ/9c16CGPZt6DFfqTOIvlbY5BCNwnIoRI6izbt+Ave4+yHicQb6Re52D4p1ifBwbcA8u1z
	Y6nIkSHDEy4ZSkzQ8hu8Djhw4RsviHtggAnJ1/XF9/KtmXzL7sEZqlLiFqMd74+BUe27f695Tq2
	wxuKgffbURG/kB6rcKONX2xDez1zRz8ZHgxfPqwzMdGwDYPVmkizPWhBF8bO+4gaO9JCcl0xEx7
	yH8CeZKe3VZyhEeYUTKRs8Qe/D2ZqZarMcXy3DzX0xgwNF3pxQCcldBTdA81ZOqRubofgRwSu2r
	ACZKpL6wSRY6iFfOOSgAKmVoaROSGe48kRgjyUchqqzsMIBhyv72o19FgbXaweuP8IbUclLdTM0
	ilJcCvz6AZlWqqSamPoFlTiKv2wl3ewZqBf5JoZhkj9xryu9NMNThbVMhHmr96g3Aa/L
X-Received: by 2002:a05:7301:4712:b0:36a:15ba:43ea with SMTP id 5a478bee46e88-37255c4ce59mr1728747eec.5.1794119603737;
        Sat, 07 Nov 2026 22:33:23 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:5a4:1cb9:242d:4f00])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265d05514sm3001194eec.15.2026.11.07.22.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:33:22 -0800 (PST)
Date: Sat, 7 Nov 2026 22:33:20 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: sidewinder - size the name buffers to their
 formats
Message-ID: <avARPWwbjYnmuTeb@google.com>
References: <20261106033300.3439313-1-xujiahao@cmss.chinamobile.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106033300.3439313-1-xujiahao@cmss.chinamobile.com>

On Fri, Nov 06, 2026 at 11:33:00AM +0800, xujiahao wrote:
> sw_connect() composes the physical path of each port as "%s/input%d"
> from gameport->phys into a 32-byte array.  gameport->phys is a 32-byte
> string and the port number is an int, so the worst case is 31 + 6 + 10
> characters plus the terminator and does not fit.
> 
> sw_3dp_id() builds " [PnP %d.%02d id %s rev %s]" into the 40-byte
> comment buffer of sw_connect().  The PnP ID is 7 characters, the
> revision string 8, and the %d arguments are a full-range int as far as
> the compiler can tell, so 44 characters plus the terminator do not fit
> either.
> 
> Size both buffers to their formats.  Truncation is theoretical with the
> values seen today, but a buffer should not be smaller than what it is
> asked to hold.  Building with W=1:
> 
>   drivers/input/joystick/sidewinder.c:538:58: warning: '%s' directive output may be truncated writing up to 8 bytes into a region of size between 5 and 21 [-Wformat-truncation=]
>   drivers/input/joystick/sidewinder.c:727:29: warning: '/input' directive output may be truncated writing 6 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> 
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
> ---
>  drivers/input/joystick/sidewinder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
> index 7f37d18c8..2bd5cfe5c 100644
> --- a/drivers/input/joystick/sidewinder.c
> +++ b/drivers/input/joystick/sidewinder.c
> @@ -97,7 +97,7 @@ struct sw {
>  	struct gameport *gameport;
>  	struct input_dev *dev[4];
>  	char name[64];
> -	char phys[4][32];
> +	char phys[4][64];
>  	int length;
>  	int type;
>  	int bits;
> @@ -574,7 +574,7 @@ static int sw_connect(struct gameport *gameport, struct gameport_driver *drv)
>  	unsigned char *buf = NULL;	/* [SW_LENGTH] */
>  	unsigned char *idbuf = NULL;	/* [SW_LENGTH] */
>  	unsigned char m = 1;
> -	char comment[40];
> +	char comment[48];

This just wastes memory for something that never happens. We are OK even
if data is truncated.

To shut off the warnings I think we can switch to scnprintf().

Thanks.

-- 
Dmitry
