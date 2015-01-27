From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: Input: atmel_mxt_ts - status of the for-dtor branch and sscanf
 issue
Date: Tue, 27 Jan 2015 17:31:25 +0000
Message-ID: <54C7CB6D.9050603@itdev.co.uk>
References: <54BD01D9.90608@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:40055 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753886AbbA0Rb3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 12:31:29 -0500
In-Reply-To: <54BD01D9.90608@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org

On 19/01/15 13:08, Dirk Behme wrote:
> we have two questions regarding the atmel_mxt_ts driver:
> 
> First, what's the status of your github 'for-dtor' branch [1]? Is this
> subject to change? Or how stable is it? Will it go into mainline, soon?
> 
> We've tested the patches in that branch on top of the mainline ~v3.18
> atmel_mxt_ts patches and they improve the driver a lot. So we'd like to
> pick that patches into our internal development tree.

for-dtor is a set of patches that I have waiting to go upstream. I'm trying
to feed them into mainline, but it's a slow process unfortunately. Any
feedback/review of these patches is greatly appreciated.

It does get rebased frequently, for instance to re-order the patches or to
take account of upstream review, so I would suggest not pulling it into
your tree. I do however keep some backported branches (maxtouch-v3.x) at
https://github.com/atmel-maxtouch/linux/ against various kernel versions
which aren't ever rebased, which you should be able to pull from.

> Second, with that branch, doing a config file download, we sometimes
> randomly get
> 
> atmel_mxt_ts 2-004a: Bad format: failed to parse object
> atmel_mxt_ts 2-004a: Error -22 updating config
> 
> at the end of the parsing, depending on the byte following the
> firmware/config file in memory. Our config file does have CR/LF endings.
> The sscanf() returns "1" in that case.
> 
> A quick hack solution to that is skipping the last two bytes [2]. What do
> you think?

I'm not convinced it's the right solution. I suspect the root cause is that
the FW loader doesn't null-terminate the buffer we are handed from
user-space, so sscanf runs on past the end sometimes. So I think we need to
do something like this (from the chromiumos fork of this driver):

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/drivers/input/touchscreen/atmel_mxt_ts.c#2251
