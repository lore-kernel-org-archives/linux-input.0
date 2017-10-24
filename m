From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS
 version 3
Date: Tue, 24 Oct 2017 16:50:26 -0700
Message-ID: <4b3f9306-785d-155d-f23f-54acf7852da5@synaptics.com>
References: <20171006140630.6398-1-yiannis.marangos@gmail.com>
 <20171006140630.6398-2-yiannis.marangos@gmail.com>
 <20171010175707.xtdgimmnju7cjlom@dystopia.localdomain>
 <20171024181924.ib3oybrxdq42h5f3@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:44640
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751277AbdJXXuc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 19:50:32 -0400
In-Reply-To: <20171024181924.ib3oybrxdq42h5f3@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yiannis Marangos <yiannis.marangos@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com

Hi Dmitry,

On 10/24/2017 11:19 AM, Dmitry Torokhov wrote:
> On Tue, Oct 10, 2017 at 09:04:20PM +0300, Yiannis Marangos wrote:
>> Hi guys,
>>
>> As I understand the second part of the patchset will take a while until it get
>> merged. Is it possible to merge the first part only? Without this, LEN0073 users
>> can not use psmouse.synaptics_intertouch=1 as a workaround. LEN0073 is not
>> usable at all unless users patch the kernel manually.
> Benjamin, Andrew, any comments/objections on expanding the acceptable
> version range?

I didn't comment earlier since I didn't have any specific info about 
SMBus v3. But, looking at the spec for v3 it sounds like our v2 
touchpads should be compatible with a v3 bus.

"This version of the specification is a superset of previous versions, 
1.0, 1.1, and 2.0. The intent is that all devices compliant with these 
previous versions are compliant with this version."

 From http://smbus.org/specs/SMBus_3_0_20141220.pdf pg 8 section 1.3.

Based on that quote and the fact that it seems to work for Yiannis makes 
me think that this change is probably ok.

Andrew

> Thanks.
>

