From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: HID: hid-multitouch: Switch to device groups
Date: Wed, 8 Aug 2012 19:28:29 +0200
Message-ID: <20120808172829.GA1001@polaris.bitmath.org>
References: <20120808134408.GA25857@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:43174 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928Ab2HHRZT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 13:25:19 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 03CBFEAC14
	for <linux-input@vger.kernel.org>; Wed,  8 Aug 2012 19:25:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120808134408.GA25857@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

Hi Dan,

> This is a semi-automatic email about new static checker warnings.
> 
> The patch 4fa3a5837b84: "HID: hid-multitouch: Switch to device 
> groups" from May 1, 2012, leads to the following Smatch complaint:
> 
> drivers/hid/hid-multitouch.c:735 mt_probe()
> 	 error: we previously assumed 'id' could be null (see line 694)

Yes, and the same patch also removes the reason 'id' could be null.

Thanks,
Henrik
