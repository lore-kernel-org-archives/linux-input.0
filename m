From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Sun, 2 Jan 2011 20:59:39 -0800
Message-ID: <AANLkTimC_yHgEWdjmBNWb76Djyb_4+zOx5BJ4cgW4qbb@mail.gmail.com>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
	<20101229074058.GA13061@core.coreip.homeip.net>
	<AANLkTinmm1=Xp587ii4fHWUv25Skx_V=3eumjpuC48O6@mail.gmail.com>
	<AANLkTikpxkYUjEJQKqtW0KZJDnOZcWpjVho6JLtOt3dm@mail.gmail.com>
	<20110102090113.GH5429@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58384 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab1ACE7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Jan 2011 23:59:41 -0500
Received: by wyb28 with SMTP id 28so13057960wyb.19
        for <linux-input@vger.kernel.org>; Sun, 02 Jan 2011 20:59:40 -0800 (PST)
In-Reply-To: <20110102090113.GH5429@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, Jan 2, 2011 at 1:01 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Dec 30, 2010 at 10:25:20AM -0800, Ping Cheng wrote:
>> On Wed, Dec 29, 2010 at 2:30 PM, Ping Cheng <pinglinux@gmail.com> wr=
ote:
>> > Dmitry,
>> >
>> > Thank you for your effort in updating the patch. Most changes work=
 for
>> > me. I do have comments related to raw touch data scaling for MT an=
d
>> > single touch legacy client support. Details are inline.
>>
>> After revisited the change you made, I think I can accept both
>> suggestions. The legacy client support may introduce issue. But it
>> won't hurt too much, I hope ;). =A0The MT scaling offers a consisten=
t
>> support between one and two finger touch, which is good.
>>
>> So, the only change left is to scale the raw x,y of 2FGT to max_pen.=
 I
>> can make a version 3 of this patch for you or you can change those t=
wo
>> lines if you don't mind. Just let me know.
>
> If there are such devices that have pen + 2FGT then please adjust the
> patch as you should be able to test it ;)

Yes, there are pen + 2FGT devices in the market now. Will update the pa=
tch soon.

> Also, if you [re]send me inputattach part for 8001 I shoudl try addin=
g
> it to inputattach (it's not there yet, is it?).

No, inputattach is not part of this patchset. I am not sure which
inputattach.c source my patch should be based on. The one under your
repo looks a bit old....

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
