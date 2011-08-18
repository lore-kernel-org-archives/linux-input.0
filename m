From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 13:31:21 +0800
Message-ID: <4E4CA3A9.2010900@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <4E4C80A0.8090708@cn.fujitsu.com> <87d3g347ey.fsf@emc.com.tw>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:60038 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab1HRFcm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 01:32:42 -0400
In-Reply-To: <87d3g347ey.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On 08/18/2011 01:26 PM, JJ Ding wrote:
> Hi Wanlong Gao,
>
> On Thu, 18 Aug 2011 11:01:52 +0800, Wanlong Gao<gaowanlong@cn.fujitsu.com>  wrote:
>> On 08/18/2011 09:57 AM, JJ Ding wrote:
>>> v3 hardware's packet format is almost identical to v2 (one/three finger touch),
>>> except when sensing two finger touch, the hardware sends 12 bytes of data.
>>>
>>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>>> ---
>>>    Documentation/input/elantech.txt |  104 ++++++++++++++++--
>>>    drivers/input/mouse/elantech.c   |  218 ++++++++++++++++++++++++++++++++++---
>>>    drivers/input/mouse/elantech.h   |   11 ++
>>>    3 files changed, 303 insertions(+), 30 deletions(-)
>>>
>>> +static int determine_packet_v3(struct psmouse *psmouse)
>> elantech_check_parity_v1
>> packet_simple_check_v2
>> determine_packet_v3
>>
>> Why not consistent them?
> OK, how do these names sound to you?
>
> elantech_check_parity_v1
> elantech_packet_check_v2
> elantech_packet_check_v3
>
> Thanks,
> jj

Yeah, sounds perfectly.

Thanks
-Wanlong Gao

