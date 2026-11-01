Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547334;
	b=o3+SEmym1Uk5i7rCegajJBcCJ74cB1mXOE/JeMllarQFHmkJQPx/m1pMpJ9tzTIvxa2f
	 qNsxoSBSIc7UYTWEFmHxWH1X25gEoANIQb/p9JYdeqummLM73yz3yVPXXLkt96ZB11/22
	 wFh/sMWNoaJr5S7WCI0mg8y6HAg5WUNJWvGKXM4vLCM9oQmn8nPW0FD7E0wJh+IuPJcNY
	 8krQcUN8lx07opol0qttLOKS9jpi6nQ1OPCELA8Sx9rj/144lQJQp9UP6kScQy1vFwNcw
	 MdTlwXxbymnq0QE5lcQ5KNdu8m5mlivQleJmW7j+Cz3azL0yXrFzDfTzYR4/OXk7aOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=N3x9c3HA3qIYEXegbIsrXGUWQ0aHcxkZ8PlgCcnDmP8=;
	b=MjnA7uWNzUKrOAMkUTTdYtA1EaScaLbNZA0XbJt9OZsFqMUA7GV3XBekOsskoDzw3snh
	 8BLADY+oAi7C34FpVWpvGNrdNAkDKdbqkcsozJKiHevUOd8UcSm8lOqi5E/Cav32uDbst
	 yWojIkcRaXtuWh/wsKIIlROG3/qPrVIytq7tvV2G/SOIMkGlcksSBHmjpxZ3a6jFGjbcR
	 sE1P7soMxfCVpTbcY8LzQhBi9X1cy0/HJNZ0mfpID/sVOWRI7fcARh9XBcVsKsQvNNpNT
	 jRsapbrJAn8O5xy0NvN4F2C8oxIkVCxO1cdP2WdFIfz993Dci9/WRclJkIU+zfO8Xpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvKDwD8f;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E89606A325
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 15:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E89606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FvKDwD8f
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so3875304eec.0
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793547333; x=1794152133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3x9c3HA3qIYEXegbIsrXGUWQ0aHcxkZ8PlgCcnDmP8=;
        b=FvKDwD8ferYtHFrVGIYUIQ36KbtjRYneflp6b+f2fRSmr0SOfWsP2bzKUcpdooGmIH
         NQksF8Can849wsUPE8EKqCBcGtoSslnebeqOIv1M7ULDAluLqTH0VP6iwdyCaESefOAs
         paPnj2iSbwVH4DGnUZdn3vEeWsidACXVNEY2vf0Vqk14oXKw4Ltwb8kzs49YCeGsM23Y
         60d5da8iNDRipyrty8/vEdxLX0K57x20/EnTACG7wxpu3qzTYwCiOQ/fwsLGuFtNiLJb
         8j5uUA1p6w/l0Gln0GWgqcs00CW5Sshd1Kst3Q4gEkWJDnVOsQXZUNmYwWzBBVs5u5KF
         7rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547333; x=1794152133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N3x9c3HA3qIYEXegbIsrXGUWQ0aHcxkZ8PlgCcnDmP8=;
        b=NBKn5n8JX1LxDuzUKGROJIqkjYDYHYFeeDtD/ar6Fs6xzMRns59aVcyruR+PivdhRd
         NxdtkMn2oD6u5chy6aEiHpJ1vPXyV8OrdxANqrcmk2Y9/uj3+C/vj8XNvRvsXoOrK4le
         zpxWmFb+mTRmFE0QVwnAX2Bxu1Fd4/x1oP6Zc0C8kC3Y1lFB8vUacPn46PXEOHCfqBsk
         e09LfImHvBq3rVL2ygXjvvEfrOubf/eqaZ+KuE5yt4gDqsQ05dk8wfp2TIaAqwQa/aSp
         ItJnUnBRBrw4S2BT//pWi35gqljG+ddxrfXdFeDY2y0tgVdELzk9crjAozj4nKAuBwbn
         wbGQ==
X-Gm-Message-State: AFq9FYKzz+g23MwOjS7eywDxKwpI0TQVH5wotsIEtMJ7Wcd8GBe+HTOW
	9HPjstwRlaTcyE9BkJ/f7Qz5KCaW82buIgO+nWIXglzRSLcxKE+oHFyA
X-Gm-Gg: AYBFou1v2QDRuwnI+FQkxbDmREJVDLl5MtfNBKwRokhChSBjE76vo/6RadEp4iqLtyD
	FASEwwpIZQn3dPj6ll1H4WtMcrsvy9QlbLbid1QPYbnjwrV4/8Qb+aMuar3Zkabhow7tGxIT/SS
	JC+LisMfe/z/9rWIHmF/ZH+q66JKcxPhFEU4vSBMj97Q83w9OwC2rHHltvyT21JIgEkEEf/zrOY
	927C6xRQeAw3u1UY9iAO/JC4BvBCN1jCQbVhJ92QATYjXA2aQIW/5Di7qFaGZL4ZOz5LRWAhxvv
	fnoUFtVMdN6u0gV2FPH293X8Tmh2TJ1coEa2Gcb9ehYsMNNzyGQG3MgoRwmFatCuw/0CkVmTudn
	EDnROZMhuTSOLAgQs9Z/KKjhgRFxzm2t07jC+vgK7b4rCBcqBD71K6jKa8SfWm+CXCAKGYXSBJG
	VI0kV7hb9Tjkdbk68/pe0U5oLPEVH76VI9NE7RJkINwbunF62TS2BiK40tHfLB1dIiX+KquJyY8
	e9pZ+nvmaHjw6ols+fxZ1JX7PdoEW0wKcKB6ZK7pAWdVFH4MT+yjVkqvpMi9Pu5HgHsMy9PU4CT
	1cMPIp6sHauMTBNrLzsRCMbTmUSDfeEhozIxtXFKXofLxIkLeHQe8C8OIbOUCxaca5c=
X-Received: by 2002:a05:7022:294:20b0:1a9:4d51:8c33 with SMTP id a92af1059eb24-1ac5bda4837mr10521810c88.18.1793547333257;
        Sun, 01 Nov 2026 07:35:33 -0800 (PST)
Received: from eggarch ([2409:40c4:3155:12c1:3d44:70f1:8a00:15db])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1d4dsm23714560c88.3.2026.11.01.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:35:32 -0800 (PST)
Date: Sun, 1 Nov 2026 21:05:27 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Eduardo Henrique Teixeira <ehstbr@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [BUG] ThinkPad T490 Synaptics TM3471-020 input lag and missed
 taps with SMBus/RMI4
Message-ID: <audS8Nb1wnifhCpr@eggarch>
References: <CAASp5sxs8o0rAe38Q4YZqK+F6st6TvxKSOR2RoKY9b1-gQCuow@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASp5sxs8o0rAe38Q4YZqK+F6st6TvxKSOR2RoKY9b1-gQCuow@mail.gmail.com>

Hi thanks for the report,

On Fri, Oct 30, 2026 at 06:10:50PM -0700, Eduardo Henrique Teixeira wrote:
> Potentially related upstream change:
> 
> Commit a961417c5ae77bbb728a23d9577ecd8f4d8a4b5a
> 
> “Input: synaptics - add LEN205b entry to smbus_pnp_ids for ThinkPad T490”
> 
> https://lkml.iu.edu/2609.2/11883.html
This was only added because the original reporter confirmed Intertouch
worked well on their device.

You said it happens more frequently while charging, so I wonder if PM is
involved.

Could you try reproducing after warm and cold boots?
And also with disabling runtime PM for the device?

Regards,
Lovekesh
