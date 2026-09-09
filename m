Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265F58F06E
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986837; cv=none; b=chXOUpzOu2AWhW8eMVHjCNBgFhI3b/RXHpt8EnSBBvQXIFhvfOnEor2QGaHM6gIXKJO560CJ/EFGgI3QY3FQp/i2S8ab9Yx6yXneDnjueWXk+eDO4MJPcxETNf/dj+Ft4OgNLT5F9kRyH/hPRl7JPD9Ix6bhDRfRFtMKZ6wU+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986837; c=relaxed/simple;
	bh=fV6iXWX0mmB/G468K7hvnWQ54p4s/YlWu1AvqhaLGjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rMUtn6KQUFpqBXC/l0CdEx+mCAzsZ3Gi3IZP8yHAdoxukNLoUKHx88ruXfh4VfPGLgQzEK15dTJZaFLIjZegoIyzJInn95yOioRFLkh47OdsZdjCg86dlOPJPxJXDKuYtvjLcpG6UaXHHiMptd5X1cujVrIbg9qDtiVg4ok9aDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nspB5071; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nspB5071"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85791F000FF;
	Wed,  9 Sep 2026 20:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986826;
	bh=v2JjZ/AR3wGVNWpMfGkri5D4yVOiJejXVZCAAY3Mv1w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=nspB5071AtFnuE/G8Kg521ZFyysvUz+Qhjam+y514c4ehjiskQ6k0FzurMKeHcT+n
	 jqV2QP3l1kn5yFNc3XGH3WnQ1u8sp9MLVuzuGHa2eOVSEhnUHTV70FM+4Ou1ylk77q
	 ZeEHxG1ygcG9lZw5BQ37pnZcxD5p6OnqkGqXpJZxhV55HoO3sy0BZhMTSlxWU7Xi7E
	 TmVaz9tv1ADysDFiB7YqWs8swU9/PbZ9UCngDdF+JyqsoZH6unyXD/ABuq1PeRj23m
	 73P4+9j8oc+cCnc2k21fT79B0caMBUN3w9gp+FZbsjWuiOsT3yp7iNHEHSarSlmeNK
	 9P/v7JmoW5vJg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 39968198003A;
	Wed,  9 Sep 2026 16:47:04 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:47:04 -0400
X-ME-Sender: <xms:xcWhaq8_Q61kXo0IMDQ58fPAqQTZ8tf5kHPD1cbQysphdJirlfmWmw>
    <xme:xcWhalgrvIMf_6LUwFUkeHmkL_iOofTXxLXCkcPPpenSv6I1RHHFkRCKG2VtbIPmK
    EbGq-zKwVvlSDAnl4MuU9IeLvxKf63PszZ43lnehBRZDMepx531apmWGw>
X-ME-Proxy-Cause: dmFkZTFqb0S1UKeED46t7V7AaDZQOyNUriK9lNpweq+oFuFsncA5u/n+amUPWXVGSZwRp0
    aoA/8/u8xfnY7DjRsbI2Jns+nH3zbzBghMPk0AMvv+HCAV1xtzlgjq12QYSqN1X88VeN/A
    pym+2CmbNo0bNNwmFK6AeRvLW7Lf3NSnfmAyULhcp0dZ93rt6kdDUZJIXfZ8gmVGnEo6tx
    gKfs3a3Pus8LjknyRCpkJUQWOFxNv6HOJ0tLWp4tDej+BdccpbNL7qVfwWpDSbo3xgP0ZV
    +LhwuibAxpRy+AXBwU9SB7e4fILZ2mtX+VJdpi7tO54CsxcxGrO2+30XpZGxL4aqy3X/Nl
    1gPfo82LOa75pb29VtCYbi7hbSrE+I1bAkEgEiiv2NahNkgB1t4s7Ewp80829rozxNkfJK
    KPwFlhghrb1eG05pdm2MzE0XUZYdOwfxlVP9q5OXPtjel2gMm8pti3W78nBqyKf/o4lflK
    Qpu/bK2jlU6URCRZGWhIu30fo/vdFe2DLJPa4pZ9W5XyvsRkq1mBMPdz24wkDsMeQQjwYu
    LXKft9xGEeRQQBdbwdQBtdkNf5QlHj+uDZGeqt6FOmrz1v6RH+XgsibxEKPcfw1OJB9ctn
    msCK7eigEkKHrI2i4qJjI3ns5yxsfUgtgsVG9ygdlwAVs/BRSBsJvb7egJ8w
X-ME-Proxy: <xmx:yMWhageO8A4LP83Jmioohhfjwe6thY3V70kJBRBqQyIe5itMVwFwcw>
    <xmx:yMWhauiM_Cnexb6zkCeq4RHXfTjukjG049orpmNjHE6TSxnRQfpsEw>
    <xmx:yMWhajIR9pbTPc4bsQ2f6KyOLxYZShCrER8pNrzwIuSZqnWfJ1y0GQ>
    <xmx:yMWhajH9lNnB7WpxdL9cthPnoEJ8jc-F-aFDyzTqIhmNVfechJ_aaw>
    <xmx:yMWhah1w9ymXahoKekUZ7b_C32f4SemT7T4BKD4Q17lhnEtTf0Wjs4Z->
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BB78832A007B; Wed,  9 Sep 2026 16:47:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlHo1ocPbBlo
Date: Wed, 09 Sep 2026 22:46:41 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
 linux-rtc@vger.kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 media-ci@linuxtv.org, linux-leds@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, "Lee Jones" <lee@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Message-Id: <5c169e15-45a5-46dc-bfdc-84228eb773a5@app.fastmail.com>
In-Reply-To: <20260909134910.33A1C1F00A3D@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-14-arnd@kernel.org>
 <20260909134910.33A1C1F00A3D@smtp.kernel.org>
Subject: Re: [PATCH 13/14] mfd: remove unused menelaus driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:49, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Is the omap24xx platform completely removed?
>
> It looks like arch/arm/mach-omap2/board-n8x0.c and 
> arch/arm/mach-omap2/common-board-devices.h still exist and unconditionally
> include the deleted header, which breaks the build for OMAP2 configurations:
>
> arch/arm/mach-omap2/board-n8x0.c:
>     #include <linux/mfd/menelaus.h>
>
> arch/arm/mach-omap2/common-board-devices.h:
>     #include <linux/mfd/menelaus.h>
>     extern struct menelaus_platform_data n8x0_menelaus_platform_data;

As mentioned in the cover letter, this is one of the four drivers
that are only orphaned after the series I sent yesterday to remove
omap2 and other platforms.

>> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
>> deleted file mode 100644
>> index a125d40fa121b..0000000000000
>> --- a/drivers/mfd/menelaus.c
>> +++ /dev/null
>> @@ -1,1251 +0,0 @@
>
> [Severity: Low]
> Should the reference to this file in MAINTAINERS also be removed?
>
> MAINTAINERS:
>     F: drivers/mfd/menelaus.c

This was accidentally removed in the omap2 patch, moving it to this
patch now.

> [ ... ]
>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index ec73533703f72..9dfe1ea08c250 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -570,15 +570,6 @@ config RTC_DRV_BQ32K
>>  	  This driver can also be built as a module. If so, the module
>>  	  will be called rtc-bq32k.
>>  
>> -config RTC_DRV_TWL92330
>> -	bool "TI TWL92330/Menelaus"
>
> [Severity: Low]
> Does this leave an orphaned defconfig entry?
>
> arch/arm/configs/omap2plus_defconfig still references the removed config:
>
> arch/arm/configs/omap2plus_defconfig:
>     CONFIG_RTC_DRV_TWL92330=y

This is now removed in the omap2 removal patch as well.

      Arnd
