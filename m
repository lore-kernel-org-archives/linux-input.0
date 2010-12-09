From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Wed, 8 Dec 2010 17:22:33 -0800
Message-ID: <AANLkTinp1ptZfiv3dqzcxvF8HAdj656NJvYaZxt-9bd6@mail.gmail.com>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se>
	<4CFFC3C2.1080905@canonical.com>
	<AANLkTikmomm2hd7AAJMTnY+=J2wPyVvodv2Ft0jFe7w2@mail.gmail.com>
	<20101208235805.GE15294@core.coreip.homeip.net>
	<AANLkTink9aX=dV-+n5=2BpPF34kSZGSQQ6x2tUNJ8eSM@mail.gmail.com>
	<4D002E6A.7070709@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54632 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab0LIBWe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 20:22:34 -0500
In-Reply-To: <4D002E6A.7070709@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 8, 2010 at 5:18 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>>>> Those are good questions. Specifying how many touches are in the
>
>>>> envelop makes sense. It also covers rectangle as a special case of
>>>> envelop.
>>>
>>> I have a feeling that trying to accomodate non-rectangular,
>>
>> No, we are not talking about non-rectangular shape here. Envelop is
>> always a rectangle. By rectangle above, I meant 2 touches.
>>
>> An envelop that includes number of touches offers us more information
>> than a rectangle does.
>
>
> All you need to do to know how many points there are is to count them. :-)

Yeah, you are right. What if the client does not have the information
to count them if we do not pass them over?

Ping
