Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D551C343
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546044; cv=none; b=g63E9fG+su/L8+kFz8sMxPlfOBDEGbd5V/anL7Ulju7D1b9+LBZRW/GfGHzmHVvIMLB2ZqlQ4nox/Z+cHNiJTPd/80AaODuPGT320SUzrH84ZXc53Hc/aAhsNRKDxYP6uWyMcNsMZOeMTYtQ+jFsqvbYtHh24lEnXOKGGZLA6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546044; c=relaxed/simple;
	bh=p8jiS7m5GtotamdI8Uxwu0tjkDxlvSUgF5Lag9CysY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehUMZkKHAl5K0/Glco0fgo/BL6IIb+FstNVOX0nzNrf7aRtfV2GCsImUKz/mTdnjsNTpNDJqKWylCGJYSh1hKEodA+vfHBPjVXmBqdOUAIzV3uRYgtr6b0qtOgUZMC9HTx62puK1wkCmKyrJnoAKScH1voCooyjJwHwigYltgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAMLYZcm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAMLYZcm"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48436216a98so909908f8f.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788546040; x=1789150840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LrkrVTzj17Ap5Z1nlVtOhkCYeFPmAnty2zAj8V0K3zQ=;
        b=fAMLYZcm1tx3VzK6wqiRRS3F/8y/eEYaR6wpM845o8z9fhtvwx8p/MeRj9pS+bJ+0v
         /rkHBj4OH31C12uaUcFeZr8wV4JUZOM7Fqpa7VhFCSQ570lYnkp6nScd69nN0xlLHPjT
         95nRX7tE5EVp1K/QNPErZXzWnkv//kC6ItlKHxIXBHqqYDb+ratRHb5d+Ar1afD+/q3V
         fnb4eaToGJYrw7qfbIAbGRoIlW4Ml3VbusCDZipXlNcnEb1CM61KQhi3fsclrlTcNbqC
         kj/LYUZI4w40R9NqU3TDrSrGMYvWFMAjCv1qgx9Hw1RPartVTquc1ccyjjdjJH5oJAjk
         8Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788546040; x=1789150840;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrkrVTzj17Ap5Z1nlVtOhkCYeFPmAnty2zAj8V0K3zQ=;
        b=Afmw75ajIpxJGxlYBqy7SOXCNSq3cvJyo6wzw6ibWjbuUQDtomg+xFonHyaqJeXz/S
         +kq/TiRpppyAxDDdUWrQPuRmDTvfTtp6tmZ0cJkpPR8TdBuTUeIr8ClOAotUpb9uJMDM
         +Wom5WUDb1JdlFI3/aV4vnYwGwYLpSDtqDHqlvjuJHmFGzs0BXKljE8Z7FXdVuEb+Rgj
         NTLw/bmwOSqZ+mWI/YN4fd03vE+csPHzAQi3I5ba8m9HJcc7uOj6T0y1XnGXSyvlSbjO
         X5nKdNnlOFVXzpZHvvZiLnTWnF0mmHYMFg24aLRy/lKZwfv5kVkurjQo5CtCXZM+OKy2
         GEyg==
X-Forwarded-Encrypted: i=1; AKwUvBxbf17Y2g8FMPs7QlYbf9MV1Ms0HesQFGPbx+wbi+mffnhG5biBzJtSWomC5UWX5mu4/vANy+5xeAK2YA==@vger.kernel.org
X-Gm-Message-State: AFuF++k6+7JjEjaYynC8tjkouNZbNqhEULzndqC/hXrvBCfw88Z2LXbL
	MaKcsTy1FaXkHL9uvsqZBPgfntUvYgSKKe5kaJ7+0byaQ5p2Efv1bABU73WsNWVu
X-Gm-Gg: AYBFou19DtVYIZ5El3s3elpleL0ZTpFFGweeBMnYNLgRSEPYIaMUv5RD4l0g3m+TXn+
	kQ/3E9fLmwIxIL9MwnbghFLtOGcw9GN7bYubbIZ9GXUyhSKKcr6cOzpn4HIOn+s9tMp0x4Bv0+G
	Jrexcg/B/HAyHsImsqaX0vPwIRiS8+9UKg1usGOml/2bLlScGf8ruyh059IODCeG/n8MzV0riaQ
	vuepYuEfOtcTO3JwY2Dlst2IR6gNtdlfwpQzXeDGSSzjBlVAZj6iDU/UGoT9J0GChpSltx06pqU
	9+YZnyHmc6xHrKTmm7H5LtA8GzKxJDS4xQOhHk1TeEEwtfWarfyQ9HSLfL1pcFFcQSY4xRtWHjf
	lIY0JyhLqWrI9elksKLDJW958p8cBaxpFdq4opCCoABoheV8tnqEVlzUEMNz0E2P7imxkiyKmMR
	3dU8+RY6RdwHF+yPLDjm/01sedLuodm45AELcEM+6f4iKvyi5x99qaRbEwRNb5bDEB+EZE
X-Received: by 2002:a05:6000:1843:b0:485:8c17:9767 with SMTP id ffacd0b85a97d-4858c179a7emr5595696f8f.41.1788546039592;
        Fri, 04 Sep 2026 11:20:39 -0700 (PDT)
Received: from ?IPV6:2a0c:9a40:8950:f000::3a4? ([2a0c:9a40:8950:f000::3a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9a56sm6734429f8f.15.2026.09.04.11.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:20:39 -0700 (PDT)
Message-ID: <8b4a0709-823d-44cb-a6b0-14a12392ef0c@gmail.com>
Date: Fri, 4 Sep 2026 23:20:36 +0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected
 MX Master
To: Benjamin Tissoires <bentiss@kernel.org>,
 =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Cc: Rafael Passos <rafael@rcpassos.me>, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
 <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com> <apr493wpBH50vXNi@beelink>
Content-Language: en-US
From: Alexey Zagorodnikov <xglooom@gmail.com>
In-Reply-To: <apr493wpBH50vXNi@beelink>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 >we just revert the inclusion of the receiver in the dj driver.

Please no, we finally able to achieve hi-res scrolling, like it was on 
unifying and bluetooth connections.

Maybe place it behind some quirk flags if causes more trouble on other 
setup.

On 9/4/26 22:03, Benjamin Tissoires wrote:
> On Sep 04 2026, Erik Håkansson wrote:
>> Hi!
>> Is this the same issue as in
>> https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/
>> The symptoms seem similar at least, and if so the approach to fixing
>> it in that case is to simply treat Bolt devices like previous DJ
>> devices, rather than having special treatment for Bolt.
>> Can you who have Bolt mice maybe test that patch too to see if it
>> solves the same issue?
> FWIW, my initial decision a few years back when Bolt was introduced was
> to not include it in the kernel, because there are too many things it's
> missing, the most problematic one being that we don't know which device
> sends which event.
>
> So basically, there is a chance that the driver sets high-resolution
> scrolling on a bolt device, when 2 mice are connected, and one is
> capable of it and the other is not. This is unlikely to happen, but is
> hard to solve in the kernel.
>
> So I'm happy to wait for testing and patches, but I would also like a
> conclusion where bolt doesn't belong to the kernel, and we just revert
> the inclusion of the receiver in the dj driver.
>
> Cheers,
> Benjamin
