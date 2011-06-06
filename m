From: Marco Chiappero <marco@absence.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Mon, 06 Jun 2011 14:45:40 +0200
Message-ID: <4DECCBF4.7080800@absence.it>
References: <4DE8FC4A.9010401@absence.it> <4DE8FFE0.5070506@absence.it> <20110604084338.GD7194@kamineko.org> <4DEA1664.4090409@absence.it> <20110605223815.GC26835@kamineko.org> <4DECC6C6.2050409@absence.it> <20110606124231.GA30602@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aa013-1msr.fastwebnet.it ([62.101.93.133]:34279 "EHLO
	aa013-1msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab1FFMpn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 08:45:43 -0400
In-Reply-To: <20110606124231.GA30602@kamineko.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Il 06/06/2011 14:42, Mattia Dongili ha scritto:
> On Mon, Jun 06, 2011 at 02:23:34PM +0200, Marco Chiappero wrote:
>> Il 06/06/2011 00:38, Mattia Dongili ha scritto:
>>> it's a bit out of context but I guess it should work. It would be good
>>> to have sony_nc_hotkeys_decode also report the "not decoded" case
>>> consistently back to callers though.
>>
>> Do you mean a negative value instead of 0? If so, let's return -EIO
>> (or -2) on error and -1 for the unknown mapping case, else the
>> translated key value (>  0).
>
> I was more thinking of -EINVAL for all cases.

Ok, added to my changelist. As soon as there are no more comments I'll 
repost the modified patches.

