From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
Date: Thu, 23 May 2013 09:29:16 -0700
Message-ID: <20130523162916.GB15494@core.coreip.homeip.net>
References: <1369239198-11059-1-git-send-email-Baohua.Song@csr.com>
 <AAD401B65941D44692B7183E6577180803A11B7C@banasiexm01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:34684 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3EWQ3T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 12:29:19 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3115477pbc.4
        for <linux-input@vger.kernel.org>; Thu, 23 May 2013 09:29:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AAD401B65941D44692B7183E6577180803A11B7C@banasiexm01.ASIA.ROOT.PRI>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Madhvapathi Sriram <Madhvapathi.Sriram@csr.com>
Cc: Barry Song <21cnbao@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <Workgroup.Linux@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Barry.Song@csr.com>

Hi Madhvapathi,

On Thu, May 23, 2013 at 01:49:10PM +0000, Madhvapathi Sriram wrote:
> Possible mem leak here not freeing any allocated devices/memory/irq.
> I suggest all the error handling be collated at the end of this
> function for various stages and error handling be done there.
> Please have a look at
> https://www.kernel.org/doc/Documentation/input/input-programming.txt

Please note that the driver uses managed resources which get cleaned
automatically.

Also, could you please use a sane mailer that wraps long lines properly.

Thanks.

-- 
Dmitry
