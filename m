From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.25-rc5.git4 regression PS/2 mouse not detected/working
Date: Mon, 17 Mar 2008 14:55:28 -0400
Message-ID: <20080317145429.ZZRA012@mailhub.coreip.homeip.net>
References: <1205775229.25146.11.camel@indigo.declera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:48893 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbYCQSzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 14:55:54 -0400
Received: by py-out-1112.google.com with SMTP id u52so7904125pyb.10
        for <linux-input@vger.kernel.org>; Mon, 17 Mar 2008 11:55:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1205775229.25146.11.camel@indigo.declera.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yanko Kaneti <yaneti@declera.com>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Mar 17, 2008 at 07:33:49PM +0200, Yanko Kaneti wrote:
> Hi
> 
> My PS/2 mouse stops being detected between kernels 2.6.24.3-12.fc8 and
> 2.6.25-0.121.rc5.git4.fc9 (which I believe do not carry any patches in
> that area). Its an ASUS P5E-VM DO motherboard , bios revision 0506. The
> PS/2 keyboard still works.
> 
> Attached are both dmesg logs with i8042.debug=1, dmidecode, lspci -vvnn
> Tried i8042.noloop and both the mouse and keyboard stop working.
> 

Could you please send me dmesg from booting with i8042.noloop. I would
expect this option to help in your case so I am curious what went wrong.

Thanks.

-- 
Dmitry
