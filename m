From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS	PS2/USB
 adapter
Date: Wed, 13 May 2009 10:10:17 +0200
Message-ID: <4A0A8069.6060909@suse.cz>
References: <20090508074636.16912.55839.stgit@fate.lan> <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de> <4A0848E7.9080301@suse.cz> <20090511214620.GA22717@kroah.com> <4A08A073.60005@suse.cz> <20090511220200.GA17259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:15285 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbZEMIKn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 04:10:43 -0400
In-Reply-To: <20090511220200.GA17259@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 05/12/2009 12:02 AM, Greg KH wrote:
> On Tue, May 12, 2009 at 12:02:27AM +0200, Jiri Slaby wrote:
>> On 05/11/2009 11:46 PM, Greg KH wrote:
>>> On Mon, May 11, 2009 at 05:48:55PM +0200, Jiri Slaby wrote:
>>>> Here comes some of my comments to the rest:
>>>>
>>>> +#define debug(format, arg...) pr_debug("hid-sjoyff: " format "\n" , ## arg)
>>>>
>>>> Define pr_fmt instead of this.
>>>
>>> No, please use dev_dbg() instead of creating a new macro.
>>
>> No, unfortunately there is no struct device available in the two
>> functions he uses this macro in.
>>
>> It should look like
>>
>> #define pr_fmt(fmt) "hid-sjoyff: " fmt "\n"
>>
>> and then use pr_debug as usual.
>>
>> In other places he correctly uses dev_* stuff.
> 
> Oh, ok, yes, that's correct, sorry for not looking closer.

Oh my, that's me, who was wrong, sorry. The play has struct device
available, indeed. -ETOOFEWCOFFEIN

Jussi: please fix that up by using dev_dbg without any prefixes or so.
