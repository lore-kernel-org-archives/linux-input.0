Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584927;
	b=Ma6nfL1Ij8obu46SnqsHwaXRIJ6x4dElLGk3pKmnHg3CDLDRzHko2SDiPK3CAPxvyjUY
	 DWEQ5frgR1BJSDPSLcJPK4VkDrmYqu93F1qgnwNyDISy4RFMLXCh+nuP2glc8SFXLEdMX
	 kMJW5d/kPrQb8TKX5nUZ14fJ/YhPMm3QRHHvsLTVZ71ia4OcGhsduPw7vGh2oLKkXGp+X
	 C4egrGzDtwkGNYR0xPhzXnIKDH0FsemrlX3XFgSnX6r3Qd/hahTo1VYpZdB8TmP7qDFON
	 tJWhcQHPtqfRi4IF0EsRYCdqbIerJGvKCYmmqpRScBauECATUM1wXNM6MXA5IupdRCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L6ki+0PaY/WrQkPB6SC5FsCkgGtvChfCsF9j3DnLHtw=;
	b=PNMTr4kyyUOTG29gc0TPORFAF8NjrHSEfcJZ3eTQfE97KiR3O2Pg0gtOOB5B+AgNGbqR
	 IEdMBcr313ea353BB87OVp7SVX/uTXGjvkiv0mHfgiOULBwqb2fc64h/g68w9OKTV4qRP
	 5t0yqFza0hEkFL/4Kao+kyio4RC2tmpABD13PyRZXqturM3vZ4odS+kUwusEiIHF5/rHE
	 3yIb0fLu3IDRonOytxyc4mi5Fi+LldIMo6y9zxcdY1j+euxBxGj2kztxVvWvJovX0S/cy
	 jJNBJDKDsorcpOiw80d2pXWd6s9mVymxkWcqxDIvubv1Yjx5zPzJCghfJ/HJTGfzchw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNZqCOkt;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337F606A890
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 15:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5337F606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNZqCOkt
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b24f4b15c4so664150c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584925; x=1795189725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L6ki+0PaY/WrQkPB6SC5FsCkgGtvChfCsF9j3DnLHtw=;
        b=dNZqCOktSMke+581Te3s4mDy6oblJ53Glr5/osQh0522nsi5YCjsx7GlWu2mrdBq89
         TmWqE69XSIZJmh8EE7HE558eZxnIoWJI3JU5ttGpobnRI5r4ZI5LfzDWSqm0LsMSutuI
         DrY7QS1HrbT8bLhcltQk3PBPUz7WP9dBzo4TsgokV6eLPeDhG3OdPe/BmmYVH5JS9asD
         s15AN8E0jg4jrm3C2cTqYz5R6ZBGK+CjS+tJqRLwFmoLANF7na6WxjlgcTQdsQfmpSFq
         5L9GbYs12uT/btqH8AnrZtMUZkfiaAikq+wj9A8XXRhqnxXmEW3XOsuRF1ttkinKT5on
         bthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584925; x=1795189725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6ki+0PaY/WrQkPB6SC5FsCkgGtvChfCsF9j3DnLHtw=;
        b=jRCUYn5YSckfPDL27AeeNtzrfndzjk7R0aAOjYKW/+S5IMskg/nWHlTD1n7rIe1yxs
         x/T02+iay+937q087aG9qmpMnrDawOXbkbLnpW91kIr9yPKl8S+Ou0E5t87SUv+7CRzq
         RekIgeRlDEwFU7732/kkM3KeiX4lBQsZRGfuxRA2+AZHM+ZOW0WBPXZ+WknqtGNNsOdE
         MswoWuqKUtIR3jw7qD0ZnPjzKxke++bSA6ZoMcGEjHCGXdKsl7Wr0sKdADJGFvh9xzVq
         bZLcvEk1oHg7t9Wci1zL7xo22H4YYwIuoZhZPJDqG5wbikHJsF/wJHz3ywIYa8nu+Vhl
         Mfyw==
X-Forwarded-Encrypted: i=1; AL+hErHic8cvrrcr5cIY8V5k4kvd14GPPreQsZtEHYuWb9y5TKqmgmW7dorp0pKdWgJ5uyOt+hne3Eib3TRxQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+IF0SFf2YVtFJXY6kz7ReiSIPUWS83Uk4KyPwmTS27uX2DEcMc
	oi1c8X6WawVKm/Mou7KrFNe7Vl/J3mtJKxrd+PDdKuJZuRVEHoIjF8DD
X-Gm-Gg: AYBFou3loAE5WKXP4JQ7Zz23zWdXecsZKWpMPyT9v5YZ3mzOvJ66IhVeV3TMPkXAUkb
	STAhI0REWIJdHVCQCQ+OLqrIAU8tF41UahybYexJB829xiZQ9PUagJFuQXEJWAhh7JO+KmJL0zR
	4TvjqEANlVS+TzLVKWw6977wAT9LmVRMN7JhyvWoDcV+Kr4We3zQt6/vzadRlXOp5DZNPOThQXX
	qqU2VbwL03j32OmjmL4CjSqjd0/cE6c2Zv2vlumlwusP1GL2DsOyE3AyukTu1pzwv/4Wz7g3w9w
	cNHMBoG7FTc7eTskBPdvVsagOs2pl1OIQsp8p3JQF6m+8uUcU51v3RESVrdnRyPWNFGxlA0biE4
	VxsAN9jjXpt1htbgpOBnUAxnzjKXtxFREA5+UakzdHVd5Mx/bWhRAHlsvZGfXGyJeSMsx4Eb5Vp
	dbNxARcoeKbHzeLKsanzbKamy27d8eisSTugkf4vjyj9nzF52xJ0X92JWq7PEjWKf/z94n7iY52
	wkfh7LkXUJkBDWQBzjZ9nN1tW31DElkHt2JoTu98bVmaBljkAf1hoK/l8GheKU0BM5M1Mt7g27z
	2yOWxEjzfYntSXWBjMxiyY67b+Zb7lv82oIRVVGU6fiP90qDKFMa70dkvCw2OQWFtWXQFEM=
X-Received: by 2002:a05:7022:3b84:b0:1b3:a8ee:a0e5 with SMTP id a92af1059eb24-1b5030243ddmr2914814c88.2.1794584925353;
        Fri, 13 Nov 2026 07:48:45 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b2b5sm7053580c88.1.2026.11.13.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:48:43 -0800 (PST)
Date: Fri, 13 Nov 2026 07:48:41 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yuan Yao <yaoyuan0329os@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Vishnu Sankar <vishnuocv@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yaoyuan@linux.alibaba.com>, Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Subject: Re: [PATCH v2 1/1] Input: trackpoint - Add new TP JYT_NDT device
 variant id 7
Message-ID: <avcxUnUh17L91ny9@google.com>
References: <20261113112202.10304-1-yaoyuan@linux.alibaba.com>
 <20261113112202.10304-2-yaoyuan@linux.alibaba.com>
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
In-Reply-To: <20261113112202.10304-2-yaoyuan@linux.alibaba.com>

On Fri, Nov 13, 2026 at 07:22:02PM +0800, Yuan Yao wrote:
> The new trackpoint variant id 7 is found on Lenovo Thinkpad X14
> Gen1 laptop(Product Name: 21XMA006CD), it belongs to JYT_NDT with
> confirmation from Vishnu Sankar in Lenovo. now it's incorrectly
> probed as Generic or Logitech PS/2 mouse.
> 
> Add the variant id 7 to match the TP_READ_ID command return
> value, probe the device as trackpoint correctly.
> 
> BEFORE:
> input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63
> 
> AFTER:
> psmouse serio1: trackpoint: JYT_NDT TrackPoint firmware: 0xa1, buttons: 3/3
> input: TPPS/2 JYT_NDT TrackPoint as /devices/platform/i8042/serio1/input/input8
> 
> Signed-off-by: Yuan Yao <yaoyuan@linux.alibaba.com>

Applied, thank you.

-- 
Dmitry
