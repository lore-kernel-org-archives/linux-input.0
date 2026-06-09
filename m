Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302B4219FC;
	Tue,  9 Jun 2026 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010480; cv=none; b=QC6mEgBQPcv09+rzRPUqJ/+lnVgep2HHm5RGrp71SqV9EH9V6f+jfdM3gd2TgExgpbV0IDJs7HEPhV9tM6zkvU2v+azzKDu9zQj80As3yenwY826WDthbFnrXYNlux90+9C+VzwydxSFBeRhnRonBXHxtuCWRRs57z2QuN0XDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010480; c=relaxed/simple;
	bh=cZ3YoPU1KdjQfuVoB0XaHeA+gakgEYUtMHMlWhmhUtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6KACmlbgt5AAO+dCazDaaq0lFyPEjdRgOjySPt3z18/ud9kO009lu/EfKWyAdoLaHGwX1iTxuUmtXviI3YRlCnHEvu2b7/FNR4z+8+8+ipRoyycT+0FoegA7ceUct16sc4oiUEgDdBHHqVUjiuWtMeNM+J1CDdfIeM7EkJT1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVrQyOc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVrQyOc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0391F00893;
	Tue,  9 Jun 2026 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781010477;
	bh=ez3WxGAHVVf0FbYYiKidwStYFHct7M0L+zp+aZhxhXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HVrQyOc4QGkbaB0ZenJBTxM/SfqiWkToPk0CoqsNwU3ENrnDSG/O2rzysT9+e7gPq
	 JG12LCCHOexMfLOR811nv2KiLwB9ZI9fhqHafFxurH3sZUBMR9NLr6DVbG5DxMayuR
	 LZB9hmet/KTNyKj7lpWuRBsVy/wNEc5A9SR2fG2bEXJJ/rnEDQGrU1qFgtTVUJ+3uk
	 jUeBE1k4IHiLMqIzWEaEN+aASZNEy6tgsXzROO72H/xFR7cRjfYGGc18cEMP48/s71
	 ZG5lT8bx2KENOpyu05LGrRhDCtEMYi82A0z4636G1Tvb1fh1+n8DkZUavZyq1TkZ8E
	 C7XUmy1OE6prg==
Message-ID: <0ff827b8-4690-4ec7-9025-6816befd1d7b@kernel.org>
Date: Tue, 9 Jun 2026 15:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] HID: i2c-hid: Refactor _DSM helper and add
 i2c-hid-acpi-prp0001 driver
To: =?UTF-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>,
 linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, bentiss@kernel.org
Cc: dianders@chromium.org, jikos@kernel.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, superm1@kernel.org
References: <4243c594-6535-4111-86cb-69784b0a34b7@kernel.org>
 <tencent_C2BEF7C0584BFE713DC7B41FFD7007B6D30A@qq.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <tencent_C2BEF7C0584BFE713DC7B41FFD7007B6D30A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9-Jun-26 12:10, 谢致邦 (XIE Zhibang) wrote:
> Hi Hans,
> 
> Thanks for the review.
> 
> The current header-based approach lets i2c-hid-acpi-prp0001.c work
> independently by just including a header for the _DSM helper. Switching
> to EXPORT_SYMBOL_GPL would force prp0001 to depend on i2c-hid-acpi —
> a Kconfig "depends on I2C_HID_ACPI", plus module-level dependency at
> load time — all for sharing a single function. I find that hard to
> accept.
> 
> I understand that adding a new header for one prototype is unusual,
> though it contains only a single static inline function and introduces
> no runtime dependency between the two drivers.
> 
> Looking back at the full discussion: Benjamin made it clear from the
> start that he doesn't want i2c-hid-of.c handling ACPI _DSM fallback.
> His line is that ACPI devices and OF devices should each go through
> their own drivers without cross-contamination. If you still prefer
> exporting the function from i2c-hid-acpi.c, then prp0001 would have to
> drag i2c-hid-acpi along with it — an independent leaf driver turned
> into something that can't stand alone.

Well it is a special case/version of the ACPI driver so depending
on it seems fine to me.

Anyways if you prefer the inline function in header solution that is
fine with me.

Lets see what bentiss has to say about this.

Regards,

Hans

