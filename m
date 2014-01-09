From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2] input: synaptics-rmi4 - use snprintf instead of sprintf
 in rmi_i2c.c
Date: Thu, 9 Jan 2014 13:02:07 -0800
Message-ID: <52CF0E4F.6010902@synaptics.com>
References: <1389230319-4737-1-git-send-email-cheiny@synaptics.com> <20140109080454.GA27160@core.coreip.homeip.net> <20140109082858.GE27160@core.coreip.homeip.net> <52CF06BA.5040000@synaptics.com> <cdba3581-ff07-4f3e-900e-2ee5c6e404c8@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:17799 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbaAIVCI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 16:02:08 -0500
In-Reply-To: <cdba3581-ff07-4f3e-900e-2ee5c6e404c8@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/09/2014 12:48 PM, Dmitry Torokhov wrote:
> Christopher Heiny<cheiny@synaptics.com>  wrote:
>> >On 01/09/2014 12:28 AM, Dmitry Torokhov wrote:
>>> >>On Thu, Jan 09, 2014 at 12:04:54AM -0800, Dmitry Torokhov wrote:
>>>> >>>On Wed, Jan 08, 2014 at 05:18:39PM -0800, Christopher Heiny wrote:
>>>>> >>>>This is a trivial change to replace the sprintf loop with snprintf
>> >using
>>>>> >>>>up-to-date format capability.
>>>> >>>
>>>> >>>Hmm, how about we do this instead:
>>> >>
>>> >>And another small one...
>>> >>
>>> >>Input: synaptics-rmi4 - transport name should be a const pointer
>>> >>
>>> >>From: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>>> >>
>>> >>Signed-off-by: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>> >
>> >Looks good to me.  I think the correct protocol is to Ack the patch,
>> >so...
>> >
>> >Acked-by: Christopher Heiny<cheiny@synaptics.com>
> Both or only the const name one?
>

The const name one only at this point.  I have a couple of comments on 
the debug output, one.
