From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 11:22:50 +0800
Message-ID: <4E4C858A.8070205@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <CAGS+omDm8RXPLXOnajrJ1hJPS5=mpzaLBybNYY92DMk1j=wByQ@mail.gmail.com> <4E4C813A.5010900@cn.fujitsu.com> <CAGS+omDgpsdDcpM3rVNJDo9CRBpqoeZZqug8RRBjyBjTpnKb2A@mail.gmail.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:65395 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab1HRDXw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:23:52 -0400
In-Reply-To: <CAGS+omDgpsdDcpM3rVNJDo9CRBpqoeZZqug8RRBjyBjTpnKb2A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On 08/18/2011 11:09 AM, Daniel Kurtz wrote:
> On Thu, Aug 18, 2011 at 11:04 AM, Wanlong Gao<gaowanlong@cn.fujitsu.com>  wrote:
>> On 08/18/2011 10:57 AM, Daniel Kurtz wrote:
>>>
>>> On Thu, Aug 18, 2011 at 9:57 AM, JJ Ding<jj_ding@emc.com.tw>    wrote:
>>>>
>>>> v3 hardware's packet format is almost identical to v2 (one/three finger
>>>> touch),
>>>> except when sensing two finger touch, the hardware sends 12 bytes of
>>>> data.
>>>>
>>>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>>>> ---
>>>>   Documentation/input/elantech.txt |  104 ++++++++++++++++--
>>>>   drivers/input/mouse/elantech.c   |  218
>>>> ++++++++++++++++++++++++++++++++++---
>>>>   drivers/input/mouse/elantech.h   |   11 ++
>>>>   3 files changed, 303 insertions(+), 30 deletions(-)
>>>>

>>>>
>>>> diff --git a/drivers/input/mouse/elantech.h
>>>> b/drivers/input/mouse/elantech.h
>>>> index 4b7447e..4f01fc6 100644
>>>> --- a/drivers/input/mouse/elantech.h
>>>> +++ b/drivers/input/mouse/elantech.h
>>>> @@ -16,6 +16,7 @@
>>>>   /*
>>>>   * Command values for Synaptics style queries
>>>>   */
>>>> +#define ETP_FW_ID_QUERY                        0x00
>>>
>>> One tab too many?
>>
>> No.
>
> Yeah, weird patchwork diff'ing artifact....
Yeah, it's caused by the '+' ahead the line.
-- 
Thanks
Wanlong Gao
