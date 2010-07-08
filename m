From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Input: twl4030-pwrbutton - replace __devinit with
 __init
Date: Thu, 8 Jul 2010 12:27:08 +0300
Message-ID: <20100708092708.GB29007@nokia.com>
References: <1278509063-30362-1-git-send-email-markus.lehtonen@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:16666 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab0GHJ1u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jul 2010 05:27:50 -0400
Content-Disposition: inline
In-Reply-To: <1278509063-30362-1-git-send-email-markus.lehtonen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Lehtonen Markus (Nokia-MS/Helsinki)" <markus.lehtonen@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dtor@mail.ru" <dtor@mail.ru>, "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>

On Wed, Jul 07, 2010 at 03:24:23PM +0200, Lehtonen Markus (Nokia-MS/Helsinki) wrote:
>Power button is not hot-pluggable so we can save some memory by
>using __init.
>
>Signed-off-by: Markus Lehtonen <markus.lehtonen@nokia.com>

then you need to change __devexit too ?!?

-- 
balbi

DefectiveByDesign.org
