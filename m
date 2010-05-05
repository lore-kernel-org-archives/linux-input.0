From: =?ISO-8859-15?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 05 May 2010 20:13:05 +0200
Message-ID: <4BE1B531.6030805@tudelft.nl>
References: <4BE16121.8040000@tudelft.nl> <20100505171350.GE7337@core.coreip.homeip.net> <20100505180048.GH6075@perldition.org> <201005051109.11531.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:53373 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab0EESNI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 14:13:08 -0400
In-Reply-To: <201005051109.11531.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 05-05-10 20:09, Dmitry Torokhov schreef:
> On Wednesday 05 May 2010 11:00:48 am Florian Ragwitz wrote:
:
>> Some firmwares always set the upper bits to 0. Others don't.
>>
>> As far as I can see, we only know about firmware version 2.1 and 4.1
>> using those high bits for width reports.
>>
>> However, there's firmware versions inbetween, like 2.48, which don't
>> report width information. And there's even other firmware versions
>> inbetween, like 2.36, which actually implment what the driver calls
>> hardware version 1. Those have a quite different packet format, and also
>> no width information.
> 
> What we need to figure out if 2.48 and 2.36 are in fact something like
> 2.0.48 and 2.0.36.. And 2.1 is actually 2.x.1. Then it would all make
> better sense.
Could it be that the ability of detecting width is indicated in the
capability bytes? Here I have 0x08 0x13 0x0d .

Eric
