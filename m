From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: power_supply: Change ownership from driver to core
Date: Mon, 23 Mar 2015 16:21:48 +0100
Message-ID: <1427124108.30970.1.camel@AMDC1943>
References: <20150323145433.GA1609@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:23978 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbCWPVw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 11:21:52 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NLO0051E86Z7NA0@mailout4.w1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 23 Mar 2015 15:25:47 +0000 (GMT)
In-reply-to: <20150323145433.GA1609@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

On pon, 2015-03-23 at 17:54 +0300, Dan Carpenter wrote:
> Hello Krzysztof Kozlowski,
> 
> The patch 297d716f6260: "power_supply: Change ownership from driver
> to core" from Mar 12, 2015, leads to the following static checker
> warning:
> 
> 	drivers/hid/hid-input.c:457 hidinput_setup_battery()
> 	error: potential NULL dereference 'dev->battery'.
> 

Yes, indeed. I'll fix it.

I suppose Smatch detected this so I wonder why it does not print this
warning in my configuration (I tried v0.5.0-2916-gbdbeaee0221e and
v0.5.0-3008-g08de8666209d). Any ideas?

Best regards,
Krzysztof



