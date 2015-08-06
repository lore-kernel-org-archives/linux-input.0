From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100
 touch object
Date: Thu, 6 Aug 2015 13:19:12 +0200
Message-ID: <55C342B0.1060301@osg.samsung.com>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
 <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
 <55C33C30.9080807@de.bosch.com> <1438859498.3362.12.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438859498.3362.12.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hello,

On 08/06/2015 01:11 PM, Sjoerd Simons wrote:
> + Corrected Javiers e-mail address. 
> On Thu, 2015-08-06 at 12:51 +0200, Dirk Behme wrote:
>> On 17.03.2015 15:00, Javier Martinez Canillas wrote:
>>>
>> Having this patch in mainline as commit 
>> b23157dc74272ac8ebffd1a566e3e822dbc3e65f [1] breaks our Atmel touch.
>>
>> It seems that above
>>
>> +	set_bit(EV_ABS, input_dev->evbit);
>>
>> is missing in the version which went into mainline? Re-adding it 
>> makes 
>> it work for us, again.
>>
>> Opinions?
> 
> In mainline the EV_ABS bit automatically gets set as soon as
> input_set_abs_params get called. 
> 
> If you're using this patch on an older kernel you should backport
> 2c9a9cfec04f2c6ed7b4e607cd53ca903b2c4642 as well.
> 

That's correct. The reason why the original patch had that it's
because it was forward ported from an older kernel and I missed
that detail when doing the rebase.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
