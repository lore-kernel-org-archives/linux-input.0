From: <samu.p.onkalo@nokia.com>
Subject: RE: [PATCH 1/1] Polled input device: add device open and close
	methods
Date: Thu, 15 Oct 2009 07:49:33 +0200
Message-ID: <62697B07E9803846BC582181BD6FB6B812F69AEB75@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255415088-31845-1-git-send-email-samu.p.onkalo@nokia.com>
 <1255415088-31845-2-git-send-email-samu.p.onkalo@nokia.com>
 <20091014080057.GE5318@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17964 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbZJOFvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2009 01:51:51 -0400
In-Reply-To: <20091014080057.GE5318@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org


 >input_dev *input)
>>  	if (error)
>>  		return error;
>>  
>> +	if (dev->open)
>> +		dev->open(dev);
>> +
>>  	if (dev->flush)
>>  		dev->flush(dev);
>
>Hmm... I think having both open and flush is overkill. My 
>fault for not looking closer, I will kill the flush and 
>convert existing users to open.
>

Good. So I can continue work with my drivers with an assumption that
there are open and close methods available at some point.

Samu

