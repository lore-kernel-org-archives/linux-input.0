From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: How to choeck for a gpio-keys based switch state?
Date: Sat, 16 May 2009 10:30:26 +0200
Message-ID: <200905161030.27005.jkrzyszt@tis.icnet.pl>
References: <4A0D8EAB.6070900@tis.icnet.pl> <20090515185806.GA22662@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:43625 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbZEPIbJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 May 2009 04:31:09 -0400
In-Reply-To: <20090515185806.GA22662@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dimitry,

Thanks for you answer.

Friday 15 May 2009 20:58:06 you wrote:
> Your application should use EVIOCGSW ioctl to query the initial state of
> the switches.

I see. Is this ioctl query the only way of getting a switch state from 
userspace? Do you know of a utility that could be used from a shell script to 
check for the state?
Or maybe you could suggest a different approach, better than using gpio-keys 
for the purpose of driving a phone hook switch? Maybe something like rfkill 
device, that exposes its state over sysfs in addition to providing input 
events, would be better for this purpose?

Thanks,
Janusz
