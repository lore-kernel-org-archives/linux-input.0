From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 19/20] Input: atmel_mxt_ts - remove mxt_make_highchg and
 parse T6 report
Date: Fri, 30 Mar 2012 00:00:40 -0700
Message-ID: <4F755A18.6040101@itdev.co.uk>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org> <1331640263-18935-20-git-send-email-djkurtz@chromium.org> <4F68A46D.9020601@itdev.co.uk> <CAGS+omBkqBqMC7f73RzXqdwkpqTOxUvWWYLMGefF+zdBKjKLTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.21.227.130] ([89.21.227.130]:51922 "EHLO
	mail.epsilon.itdev.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750943Ab2C3HAq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 03:00:46 -0400
In-Reply-To: <CAGS+omBkqBqMC7f73RzXqdwkpqTOxUvWWYLMGefF+zdBKjKLTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, "Tiwari, Atul" <Atul.Tiwari@atmel.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Daniel Kurtz wrote:
> On Tue, Mar 20, 2012 at 11:38 PM, Nick Dyer <nick.dyer@itdev.co.uk> wrote:
>> mxt_make_highchg exists due to the interrupts being edge triggered. It
>> forces the CHG line to go high.
>>
>> With this implementation, I suspect that if a new message arrives after you
>> have read T44 and before you finish processing messages, then the interrupt
>> handler will not ever be run. What testing have you done on this?
> 
> Actually, for the MXT224E on which I've been testing, the CHG line
> goes high after reading the first byte of the T5 message (in other
> words, the first byte of the first message, no matter how many
> messages T44 reports).

The CHG line behaviour is configurable - you should find this documented in
the data sheet.

> Expect an updated version of this patchset soon.
> 
> Thanks for all of your reviews!

no problem.

-- 
Nick Dyer
Software Engineer, ITDev Ltd
Hardware and Software Development Consultancy
Website: http://www.itdev.co.uk
