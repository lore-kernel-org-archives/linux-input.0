From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: ADXL34X orientation definition
Date: Mon, 9 Dec 2013 09:11:38 +0100
Message-ID: <52A57B3A.7030607@analog.com>
References: <20131207095335.GA10573@core.coreip.homeip.net>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:37144
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759364Ab3LIITC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Dec 2013 03:19:02 -0500
In-Reply-To: <20131207095335.GA10573@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 12/07/2013 10:53 AM, Dmitry Torokhov wrote:
> Hi Michael,
>
> I was going though Coverity reports and it looks like definition of
>
> #define ADXL346_2D_ORIENT(x)            (((x) & 0x3) >> 4)
>
> is not correct as it will always evaluate to 0. Should the mask be 0x30
> instead?
>
> Thanks.
>
Hi Dmitry,

Good catch!

Yes, of course  - the mask should be 0x30.
Shall I send a patch?

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


