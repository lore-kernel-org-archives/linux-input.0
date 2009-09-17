From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 1/2] Input: Add DaVinci DM365 Keypad support
Date: Thu, 17 Sep 2009 22:01:01 +0400
Message-ID: <4AB2795D.2060900@ru.mvista.com>
References: <1252951959-31015-1-git-send-email-miguel.aguilar@ridgerun.com>	<200909141145.48252.david-b@pacbell.net> <4AB276BF.9000807@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:13256 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758877AbZIQR6h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2009 13:58:37 -0400
In-Reply-To: <4AB276BF.9000807@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: David Brownell <david-b@pacbell.net>, davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com

Hello.

Miguel Aguilar wrote:

> David,

    Though I'm not David, I'll reply... :-)

> What are the proper error codes when platform_get_resource,

    -ENODEV.

> request_mem_region

    -EBUSY.

> and ioremap functions fail?.

    -ENOMEM.

WBR, Sergei
