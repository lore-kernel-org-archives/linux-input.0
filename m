From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: ff-core effect id handling in case of a failed effect upload
Date: Wed, 19 Feb 2014 20:49:49 +0100
Message-ID: <CADbOyBSszQC4H6J2u2Pa-qWrpWH+d6euJ19GVsw7uxnjYqre+A@mail.gmail.com>
References: <CADbOyBRX8Zd=WyXpgWo8Kkg5HkAJHjSA0KCiJD_36PLiSKAQJQ@mail.gmail.com>
	<5304E0A0.5070007@iki.fi>
	<CADbOyBTY8KtRyM6q7UMDAVieeR-X93qCoWO=ttizguKvouUkVw@mail.gmail.com>
	<20140219193215.GM743@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:48239 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbaBSTtu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 14:49:50 -0500
Received: by mail-ve0-f180.google.com with SMTP id db12so897219veb.11
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 11:49:49 -0800 (PST)
In-Reply-To: <20140219193215.GM743@foghorn.codeweavers.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Eikum <aeikum@codeweavers.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, wine-devel@winehq.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Feb 19, 2014 at 8:32 PM, Andrew Eikum <aeikum@codeweavers.com> wrote:
> On Wed, Feb 19, 2014 at 06:32:54PM +0100, Elias Vanderstuyft wrote:
>> I'll include the code (with effectId_old variable) and this discussion
>> when I submit my whole patchset for Wine's DInput libs to Wine-devel
>> mailing list. Right now, I don't know who I should personally mail to.
>>
>
> Patches ready to be included in Wine should go to
> wine-patches@winehq.org.  I've done a bit of work in dinput myself, so
> you can feel free to send them to me and/or wine-devel first if you'd
> like a review.

<offtopic>
Alright, thanks Andrew!
I've also done some work on reverse engineering the FFE file format,
which is needed to complete some missing functionality
(http://wiki.winehq.org/ForceFeedbackSummerOfCode2005Summary) of the
following functions:
IDirectInputDevice8::WriteEffectToFile and
IDirectInputDevice8::EnumEffectsInFile.
Can I send it to you (in a new mail subject, of course) and cc wine-devel?
</offtopic>

>
> Andrew

Elias
