From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Tue, 18 Feb 2014 14:11:58 +0800
Message-ID: <CAGsJ_4yqAz6eVM0stvzstiC+rxuCK5G-0QM=F2NJWEviYJDD9Q@mail.gmail.com>
References: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
 <20140214075717.GA14682@core.coreip.homeip.net> <CAGsJ_4xqnZAO6vpkgTEHmfp9+nbWa1qwQ4pda6B2sSrEtbV3ZA@mail.gmail.com>
 <847BC5012124A94BB5CA1B26E022CCA3012BAFDC27@SHAASIEXM01.ASIA.ROOT.PRI>
 <CAGsJ_4zjtWV3Z1AJ2bqekXn54rm=k8d4iOi_zzainCEnNGefCw@mail.gmail.com> <20140217191658.GA19223@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44291 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbaBRGMT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 01:12:19 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so16287556pad.39
        for <linux-input@vger.kernel.org>; Mon, 17 Feb 2014 22:12:18 -0800 (PST)
In-Reply-To: <20140217191658.GA19223@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Xianglong Du <Xianglong.Du@csr.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Barry.Song@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-18 3:16 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Fri, Feb 14, 2014 at 09:41:06PM +0800, Barry Song wrote:
>> >> Input: sirfsoc-onkey - implement open and close methods
>> >>
>> >> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> >>
>> >> We can control whetehr device generates interrupts or not so let's
>> >> implement open and close methods of input device so that we do not do any
>> >> processing until there are users.
>> >>
>> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Tested-by: Xianglong Du <Xianglong.Du@csr.com>
>>
>> Dmitry, will you push this one to your tree so that i can rebase others?
>
> I rebased and pushed everything out, please take a look to make sure it
> all looks good.

thanks, we have done a update to CSR local tree.

>
> Thanks.
>
> --
> Dmitry

-barry
