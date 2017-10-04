From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <l.majewski@majess.pl>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Wed, 4 Oct 2017 12:45:39 +0200
Message-ID: <e0352de3-f346-f6c0-5fab-7353d4c0d696@majess.pl>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
 <20171004103213.4ezs6ie6z6dq7pvh@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:60389 "EHLO
        15.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdJDKwa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Oct 2017 06:52:30 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7964213538E
        for <linux-input@vger.kernel.org>; Wed,  4 Oct 2017 12:45:49 +0200 (CEST)
In-Reply-To: <20171004103213.4ezs6ie6z6dq7pvh@sirena.co.uk>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>

Hi Mark,

Thank you for your reply.

> On Tue, Oct 03, 2017 at 06:58:00PM +0200, Łukasz Majewski wrote:
> 
>> Have I overlooked something? Maybe there is any other mainline code, which I
>> could reuse?
> 
> No, we don't support randomly toggling power for devices without their
> cooperation - it's not generally going to end well.  The reason it's
> difficult to do this is that it's a bad idea.

I do understand the rationale. No issues with this.

>  Perhaps this is something
> that could be implemented generically for USB as it's a hotpluggable bus

In this case we use VBUS as a power supply voltage. The problem with 
regulator API used in this case is that we enable it on boot-up, but 
then we cannot "symulate hotplug" anymore.

> but I'm not convinced.
> 

Maybe, I can look into USB driver and see if the VBUS is manageable from 
there (so I could add some sysfs entry to control it if needed).


-- 
Best regards.

Łukasz Majewski
