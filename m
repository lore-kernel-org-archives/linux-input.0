Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D983C109E;
	Wed,  9 Sep 2026 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987258; cv=none; b=DXRUeqe8zdG/yqdjbZBKdNWXstgq6jm3q/xmqQny9kkI1lNsFJW9yh4rrkQbvJPjHskLyLWOsPHdG3nsImze9qHcDaWoLKkegWpRGDa+cRYyOdxmRAyhmXjBLkKnZ7Js9UKqJxkwGvZDdBMKyfyvyrhRr0LBC39aWLnIk9oWEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987258; c=relaxed/simple;
	bh=yzL3v1513rz6WHiWVe+wJzFLNLB1yY30ElfWbd1HSfs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KcxWXLryozw0lPM9KvsqpeyV4bePIyajCMeJZr6RIXzWR0glI8oqZhUF7QMY8P6FCKUfVH1YuqQh/gse7/PqhtxzRcSE4xaI0vaJl1iPXwRCnb5rf2ZEfN7AYSvX1DqdrtloIdq1yHkgsiTuAKWKA85kl+D93hpL1R2/UpnxczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMExEk3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMExEk3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3651F000FF;
	Wed,  9 Sep 2026 20:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987244;
	bh=tfXQTmImp135HQJ1XNVWEd7kOlyLsNALM8g5dX8a/g0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=iMExEk3Ei7gwV3uRKH32jcRKpw/LnTBq8PIzWYgVht9v63lEh2z+O+7oWfvZi/gjt
	 OLWEsClEcLFJ3aqclhqlIyRWvMPPNmBXcXRUB/pZks03uSF8WyF0hgK3fghJo5dTn8
	 1VlzICoGiLoUFu60UAdDwF7zaoQ6/CahoJNBJnnt+RHmV7puTgQoD5V/DJJPw3569P
	 oyNZi2AxNdAD2PwS3qNQu/7t8WByKs9YCvOfMZNWwZqJ870WT8rieB9oG4kZxDjGDD
	 wP0EZkzYA+Q/kaWmMeCSsh4xMF8y2Lfv0w1hiT2SJh98Q0pE/ZgYGJHRZXn/5S/36x
	 R/gkmxWAw6qHA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id C3C57198003A;
	Wed,  9 Sep 2026 16:54:01 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:54:01 -0400
X-ME-Sender: <xms:Z8ehalx-9CwrvJLxOGnwC3Jz8MobiJ-AanvBR8tMKTcULe9GK0Y41A>
    <xme:Z8ehagFJ_-3HFIoW6kRx8oluTOpYEakz6C_ri6RhW3EsvCo5NqtZyvCQmxt8fTaer
    daRvxYe0uIhRZe87LjxxdkU37xXQzhKDdM_7IvmfFrehsBqgIJN-QSn>
X-ME-Proxy-Cause: dmFkZTGd0gYElPLkZTGmydE4FJ0If9jioCyIM+W8sjFCuuKJ7B87MfdRRXaGX1CUdrmjmk
    uNeecr4CTC00G2zkUjjvOr13Od+s/xO80x78gjiY+3LwzTo0x5+RpRR3CQpY3azaV3JPzi
    Aulh4ILQkWxyCno+9QxFk1l8Sa0Uhxm1FMe87851yQP4/IgFosqjygQs/sO+fceZIZhRG4
    ZZDOvJOERjnqcjsQhgeR8WjceRchUiy2W1cgk1fBahgEaz87BvdSW7/mR2IUldwmBQiriD
    vg8YX7EjzwzkCJ69GC/uhWPrul+29zbp2vkTZ21y12C1TMexYpFXrEmx1Ch9Hx6jXmdMTu
    PCFfT7anXonwKOSlM9tyKGMvYx393qCqkYvXAjgENLr4nYevlJROHeeU6TjXwvXrAFvVNv
    UygasiMaBqp4OmwU+2UnP4jLzXsXBLXD04um6YphAoG2yxmYMg8smeVLteJFOKCBAizNTs
    gjmfBYj3Y+e9pzIOgfZpRatzcH010WD1Zd48nxtHuLPvwLqy9wfx5syxFOjRSl+4pO/L0L
    a5vHEh9FdtP1yDhGyQYkZg2uZRnOvqiEkUQRD7ObTzOnX85+7C7Ds7Afw8AenHR0YyJf0x
    u0DErY1UIzTTPBbnB/tZbhAThI+oclt+d4nCxgXHYWi7kQeFQtMLLkMVU+Pw
X-ME-Proxy: <xmx:acehamwmy0i8cFCjL9LnMMZb7GKpwvAwatiILAPw1vy8fqsRJjP3ow>
    <xmx:acehauktFkQXN4yiY5ANIb_Fr2IYCHPSUd3PoJLYmBjnDJdHxnf2lw>
    <xmx:acehap-EcgV8WhhvfbVqGB0xco2cVD4P5kEO2rvYKO0UI-dzjM8Q1Q>
    <xmx:acehapoQwqJ5MRfkBygnhtTZsvZieIX7cvO36Tp5lVY6orRSPs92HA>
    <xmx:acehatIJZUTtWArdFQxtDdLEHwjOMn6ozASv2NU2GMonszqpqigCT54J>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6981132A007B; Wed,  9 Sep 2026 16:53:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGc9YchnkBDN
Date: Wed, 09 Sep 2026 22:53:38 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-hwmon@vger.kernel.org, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-watchdog@vger.kernel.org,
 "Conor Dooley" <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
 media-ci@linuxtv.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org
Message-Id: <8618e335-4e89-4175-a9a5-17aa72f9e682@app.fastmail.com>
In-Reply-To: <20260909134823.AA3201F00A3D@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-13-arnd@kernel.org>
 <20260909134823.AA3201F00A3D@smtp.kernel.org>
Subject: Re: [PATCH 12/14] mfd: remove unused mcp-sa11x0/ucb1x00 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:48, sashiko-bot@kernel.org wrote:
>>
>> The sa1100 platform has been removed, so these drivers are no longer
>> used anywhere.
>
> [Severity: High]
> Is the sa1100 platform fully removed in this series? Looking at the tree,
> arch/arm/mach-sa1100/assabet.c and arch/arm/mach-sa1100/collie.c still
> exist and unconditionally include the headers deleted by this patch.

As explained in the cover letter, the platform is only removed in another
series I posted.

> [Severity: Medium]
> Does removing the MCP_UCB1200 config symbol leave the collie_battery
> driver as orphaned dead code?
>
> Looking at drivers/power/supply/Kconfig, BATTERY_COLLIE depends on
> SA1100_COLLIE && MCP_UCB1200. Furthermore,
> drivers/power/supply/collie_battery.c still includes the now-deleted
> include/linux/mfd/ucb1x00.h header.
>
> If this Kconfig symbol is removed without cleaning up the power supply
> subsystem, it causes an unmet dependency warning and leaves the battery
> driver unselectable.

I have separate patches for this.

       Arnd
