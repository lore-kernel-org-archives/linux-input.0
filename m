From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?=
	<fernando_b1@lab.ntt.co.jp>
Subject: Re: [PATCH] hid: fix bug destroying hidraw device files after parent
Date: Tue, 18 Mar 2014 10:24:06 +0900
Message-ID: <5327A036.6070101@lab.ntt.co.jp>
References: <1393401084.4876.2.camel@nexus> <alpine.LNX.2.00.1402261101540.5466@pobox.suse.cz> <53266890.1040504@lab.ntt.co.jp> <alpine.LNX.2.00.1403180041100.3690@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:35150 "EHLO
	tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaCRBY3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2014 21:24:29 -0400
In-Reply-To: <alpine.LNX.2.00.1403180041100.3690@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>

(2014=E5=B9=B403=E6=9C=8818=E6=97=A5 08:42), Jiri Kosina wrote:
> On Mon, 17 Mar 2014, Fernando Luis V=C3=A1zquez Cao wrote:
>
>>> I have slightly modified the patch title to make sure that it's obv=
ious
>>> that what it fixes is actually a WARN_ON() splat.
>> Thank you.
>>
>> Any chance we can get this to Linus before 3.14 comes out?
>> According to Linus, rc7 may be the last rc.
> It will be in Linus' 3.14 final -- it went in post-rc7.
>
> Thanks for taking care,

Thanks!

- Fernando
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
