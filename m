From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Fri, 10 Dec 2010 09:37:49 -0800
Message-ID: <AANLkTinBpM-Q8dsvqOwzm=T37b3PtW_gze4Rha0MVfMd@mail.gmail.com>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
	<AANLkTikatcsta_EQ26CzouHj+WMfQptJF_ZkMfCwUmnN@mail.gmail.com>
	<AANLkTi=w3uOQKFN3WBgzib9M0Cb143vChPPaYm6fWypi@mail.gmail.com>
	<20101209195035.GD23781@core.coreip.homeip.net>
	<AANLkTinXGX5d6-LGZjjZ9yDn_c+s7qQ7motxKjpuhaV2@mail.gmail.com>
	<20101210073813.GB21009@core.coreip.homeip.net>
	<AANLkTimM9stMm8zKbjyRV5BpsV9m1s6EBATMZXbf-+5W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61056 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0LJRhu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 12:37:50 -0500
Received: by wyb28 with SMTP id 28so3696682wyb.19
        for <linux-input@vger.kernel.org>; Fri, 10 Dec 2010 09:37:49 -0800 (PST)
In-Reply-To: <AANLkTimM9stMm8zKbjyRV5BpsV9m1s6EBATMZXbf-+5W@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Dec 10, 2010 at 5:47 AM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> On Fri, Dec 10, 2010 at 1:38 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Dec 09, 2010 at 03:21:34PM -0600, Chris Bagwell wrote:
>>>
>>> For first point, your right that (123,78) is just a good "known
>>> starting value" if a driver is going to use that concept because it
>>> could be filtered just as easy as (0,0).
>>
>> I am afraid I did not explain myself well enough. (0,0) is valid
>> coordinate, same as (123, 78). Thus, even if we try to make driver s=
end
>> (0,0, !touch), input core may suppress it and never deliver to
>> userspace if last touching point happened to be also (0,0). Thus
>> userspace should not rely on having coordinates reset I think.
>>
>
> I had understood ya. =A0What I meant is if a driver sends (0,0,!touch=
)
> and a sync when switching tools then you do not need to buffer
> previous values but instead can imply what previous values are.
> Userland would still need to account for case of filtered events. =A0=
Its
> a memset() vs. a memcpy() when switching tools.

Oh, I see your point. I think we need to add a sync statement to mark
the end of the touch events. This is consistent with the existing
behavior.

Thank you for reviewing the patchset.

Ping

> Anyways, =A0I'm not recommending any behavior; just letting you know
> some existing assumptions on driver behavior.
>
> Thanks,
> Chris
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
