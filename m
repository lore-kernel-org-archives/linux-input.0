From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Thu, 09 Dec 2010 02:18:34 +0100
Message-ID: <4D002E6A.7070709@euromail.se>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se>	<4CFFC3C2.1080905@canonical.com>	<AANLkTikmomm2hd7AAJMTnY+=J2wPyVvodv2Ft0jFe7w2@mail.gmail.com>	<20101208235805.GE15294@core.coreip.homeip.net> <AANLkTink9aX=dV-+n5=2BpPF34kSZGSQQ6x2tUNJ8eSM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57892 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754919Ab0LIBS5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 20:18:57 -0500
In-Reply-To: <AANLkTink9aX=dV-+n5=2BpPF34kSZGSQQ6x2tUNJ8eSM@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>>> Those are good questions. Specifying how many touches are in the

>>> envelop makes sense. It also covers rectangle as a special case of
>>> envelop.
>>
>> I have a feeling that trying to accomodate non-rectangular,
> 
> No, we are not talking about non-rectangular shape here. Envelop is
> always a rectangle. By rectangle above, I meant 2 touches.
> 
> An envelop that includes number of touches offers us more information
> than a rectangle does.


All you need to do to know how many points there are is to count them. :-)

Henrik
