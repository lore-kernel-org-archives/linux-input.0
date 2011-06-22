From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local GPIO chips.
Date: Wed, 22 Jun 2011 08:58:45 -0600
Message-ID: <BANLkTinB+utdPeL+mGJQApXAydDyLEK7Kg@mail.gmail.com>
References: <20110618145154.GA18190@core.coreip.homeip.net>
 <20110618151645.GG8195@ponder.secretlab.ca> <20110620094815.341d1cff@archvile>
 <20110620084511.GB23113@core.coreip.homeip.net> <20110621114631.GC25032@sirena.org.uk>
 <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com> <20110621172744.GB26592@opensource.wolfsonmicro.com>
 <20110621204804.GC3731@core.coreip.homeip.net> <20110621230242.GA8791@opensource.wolfsonmicro.com>
 <20110622070052.GA16561@core.coreip.homeip.net> <20110622113835.GC18726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33697 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab1FVO7G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2011 10:59:06 -0400
Received: by yia27 with SMTP id 27so351682yia.19
        for <linux-input@vger.kernel.org>; Wed, 22 Jun 2011 07:59:05 -0700 (PDT)
In-Reply-To: <20110622113835.GC18726@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>, David Jander <david.jander@protonic.nl>

On Wed, Jun 22, 2011 at 5:38 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 22, 2011 at 12:00:52AM -0700, Dmitry Torokhov wrote:
>> On Wed, Jun 22, 2011 at 12:02:42AM +0100, Mark Brown wrote:
>> > On Tue, Jun 21, 2011 at 01:48:05PM -0700, Dmitry Torokhov wrote:
>
>> > > Can the initcall stuff be kept out of mainline? I'd expect
>
>> > The init order stuff is in mainline already, you're far too late t=
o the
>> > party here.
>
>> For some drivers it might be already in mainline, it does not matter
>> that we should continue adding more.
>
> It's not just a few drivers, there's entire subsystems that are doing
> this.
>
>> > Keeping things in board trees is exactly the sort of thing we want=
 to
>> > avoid people doing. =A0That just means people do all sorts of stuf=
f that
>> > wouldn't be acceptable upstream, either out of ignorance or throug=
h
>> > knowing that only their systems have to work with what they're doi=
ng,
>> > and just don't bother working upstream at all half the time making=
 life
>> > miserable for pretty much everyone.
>
>> So you are saying that we should accept such crap directly into
>> mainline?
>
> Pretty much, yes. =A0In code terms it's not really invasive and it do=
esn't
> have any real impact on other systems so it's the sort of thing we ca=
n
> carry without too much pain. =A0Pragmatically it's not unreasonable.

+1

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
