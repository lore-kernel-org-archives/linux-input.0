From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100
 touch object
Date: Thu, 06 Aug 2015 14:02:50 +0100
Message-ID: <55C35AFA.9070505@itdev.co.uk>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk> <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk> <55C33C30.9080807@de.bosch.com> <1438859498.3362.12.camel@collabora.co.uk> <55C342B0.1060301@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:61549 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755565AbbHFNCx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 09:02:53 -0400
In-Reply-To: <55C342B0.1060301@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 06/08/15 12:19, Javier Martinez Canillas wrote:
>> In mainline the EV_ABS bit automatically gets set as soon as
>> input_set_abs_params get called. 
>>
>> If you're using this patch on an older kernel you should backport
>> 2c9a9cfec04f2c6ed7b4e607cd53ca903b2c4642 as well.
>>
> That's correct. The reason why the original patch had that it's
> because it was forward ported from an older kernel and I missed
> that detail when doing the rebase.
>
Yes, I've spotted the same issue myself.

I do keep a list of API breaks that affect this driver here:
https://github.com/atmel-maxtouch/linux/wiki/Driver-Integration#branches

(there's the MT protocol A to B change as well, at about 2.6.39)
