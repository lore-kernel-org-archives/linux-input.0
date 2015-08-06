From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100
 touch object
Date: Thu, 06 Aug 2015 13:11:38 +0200
Message-ID: <1438859498.3362.12.camel@collabora.co.uk>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
	 <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
	 <55C33C30.9080807@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42681 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbbHFLLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 07:11:43 -0400
In-Reply-To: <55C33C30.9080807@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

+ Corrected Javiers e-mail address. 
On Thu, 2015-08-06 at 12:51 +0200, Dirk Behme wrote:
> On 17.03.2015 15:00, Javier Martinez Canillas wrote:
> > 
> Having this patch in mainline as commit 
> b23157dc74272ac8ebffd1a566e3e822dbc3e65f [1] breaks our Atmel touch.
> 
> It seems that above
> 
> +	set_bit(EV_ABS, input_dev->evbit);
> 
> is missing in the version which went into mainline? Re-adding it 
> makes 
> it work for us, again.
> 
> Opinions?

In mainline the EV_ABS bit automatically gets set as soon as
input_set_abs_params get called. 

If you're using this patch on an older kernel you should backport
2c9a9cfec04f2c6ed7b4e607cd53ca903b2c4642 as well.

-- 
Sjoerd Simons
Collabora Ltd.
