From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [Q] max11801 licensing terms
Date: Thu, 18 Aug 2011 18:27:10 +0800
Message-ID: <CACrgxGD3M-yCSBdu3p9em698jQ4X2cZd17gHDYdvJWgFNG=PBg@mail.gmail.com>
References: <201108171431.26470.brian.foster@maxim-ic.com> <CACrgxGB0RaxhbPfU34L3b-1vPEDYf5M7Z8q2HKoKEQ8YcuFCsw@mail.gmail.com>
 <20110817174510.GF4877@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39984 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab1HRK1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 06:27:30 -0400
Received: by vxi9 with SMTP id 9so1598513vxi.19
        for <linux-input@vger.kernel.org>; Thu, 18 Aug 2011 03:27:30 -0700 (PDT)
In-Reply-To: <20110817174510.GF4877@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Brian Foster <brian.foster@maxim-ic.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Jean-Marc Simohand <JeanMarc.Simohand@maxim-ic.com>

Hi Dmitry,

I've send a patch to mail list.

Thanks.

Best regards,
Zhang Jiejing



2011/8/18 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Wed, Aug 17, 2011 at 09:24:32PM +0800, Jiejing.Zhang =A0wrote:
>> Hi Brian Foster,
>>
>> > =A0 =A0 * Based on mcs5000_ts.c
>> I have referenced mcs5000_ts.c source code when writing this driver,
>> but I don't think it's a big deal, I really reference lots of files.
>>
>> > =A0What does =93either version 2 of the License.=94 mean?
>> > =A0Either GPLv2 or what?
>>
>> Yes, I think it means GPLv2, I'm not really not very care about thes=
e
>> license, just copy other files under driver/input/ directory.
>
> mcs5000_ts.c (and m97xx-core.c it was derived from) are GPLv2 or late=
r
> so max11801_ts.c shoudl folow the same licensing terms, but it seems =
the
> statement was truncated.
>
> Jiejing, could you please send me a patch restoring the proper wordin=
g
> so there won't be any confusion in the future?
>
> Thanks!
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
