From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Tosa keyboard support
Date: Fri, 11 Jan 2008 16:38:02 +0000 (UTC)
Message-ID: <fm8619$ili$2@ger.gmane.org>
References: <20071223232914.GA28932@doriath.ww600.siemens.net>
	<d120d5000801030851j6629e4f0m102939aff412df5b@mail.gmail.com>
	<fljpft$nc9$1@ger.gmane.org>
	<d120d5000801110656n1e65f4amf743a8f90183cc09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47474 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577AbYAKQiO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 11:38:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDMtU-0000uU-MR
	for linux-input@vger.kernel.org; Fri, 11 Jan 2008 16:38:08 +0000
Received: from iap-pxy-mow1.siemens.ru ([212.248.25.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 16:38:08 +0000
Received: from dbaryshkov by iap-pxy-mow1.siemens.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 16:38:08 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Hi,

Dmitry Torokhov wrote:

> Hi,
> 
> On Jan 3, 2008 6:01 PM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>>
>>
>> > Also, I'd put these defines rigth in tosakbd.c.
>>
>> The TOSA_KEY_RECORD and SYNC are used inside arch/arm/mach-pxa/tosa.c
>> (for gpio-keys declaration). So I would prefer to place all such
>> defines here. When the Kdrive would be fixed, I would drop KEY_RECORD
>> and happily move that defines to tosakbd.c
>>
>>
> Ok, fair enough. Because driver touches arch-specific arm parts it does
> not apply cleanly to my tree. I think the best way would be to merge it
> through arm side, this will minimize merge efforts Feel free to add:

Strange. The patch is against 2.6.24-rc7 and applies cleanly to both
for-linus and master branches of .../dtor/input.git

> Acked-by: Dmitry Torokhov <dtor@mail.ru>

Russell, do I need to resent patch?

-- 
With best wishes
Dmitry


