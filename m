From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: WM9712 GPIO
Date: Wed, 12 May 2010 14:54:16 +0200
Message-ID: <AANLkTimZnfh4ld3dcEYbdDsOdNe3J7FNLWK4bpk9Ppbc@mail.gmail.com>
References: <AANLkTikXR3vlUg-XX33LCrAiVxk0nJWNe__7SU7g1DuF@mail.gmail.com>
	 <20100512123026.GA8082@rakim.wolfsonmicro.main>
	 <AANLkTimGhfLPxAIhtTYoUO-te1mUs86LEVEcYN7DgOtY@mail.gmail.com>
	 <20100512125229.GB8082@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35975 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab0ELMyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 08:54:18 -0400
Received: by fxm15 with SMTP id 15so12379fxm.19
        for <linux-input@vger.kernel.org>; Wed, 12 May 2010 05:54:17 -0700 (PDT)
In-Reply-To: <20100512125229.GB8082@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Wed, May 12, 2010 at 2:52 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 12, 2010 at 02:50:44PM +0200, Manuel Lauss wrote:
>> On Wed, May 12, 2010 at 2:30 PM, Mark Brown
>
>> > The WM9712 does not support this feature. =A0It only supports sett=
ing the
>> > GPIO status by use of AC'97 slot 12 for which there's currently no
>> > standard glue on Linux. =A0Setting slot 12 needs to be done in the=
 AC'97
>> > controller.
>
>> Wonderful. =A0Thanks for the info.
>
> Glad to be of service :) . =A0FWIW slot 12 is the method specified by=
 the
> AC'97 standard for setting GPIO on AC'97 CODECs so we really should h=
ave
> something for it, but sadly quality of implementation and coverage in
> controllers is a little variable.

=46ortunately my target CPU does have special AC97 GPIO registers.  So =
all
is well on my end :)

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
