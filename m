From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 01/05] input synaptics-rmi4: Split F01 definitions out
 into header file for use by reflash.
Date: Mon, 10 Mar 2014 19:36:50 -0700
Message-ID: <531E76C2.20405@synaptics.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com> <20140310144658.GB18578@sonymobile.com> <531E3DA2.5090705@synaptics.com> <20140310224550.GF18578@sonymobile.com> <20140310225750.GG18578@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:3229 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbaCKCgw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 22:36:52 -0400
In-Reply-To: <20140310225750.GG18578@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/10/2014 03:57 PM, Courtney Cavin wrote:
> On Mon, Mar 10, 2014 at 11:45:50PM +0100, Courtney Cavin wrote:
>> On Mon, Mar 10, 2014 at 11:33:06PM +0100, Christopher Heiny wrote:
>>> On 03/10/2014 07:46 AM, Courtney Cavin wrote:
>>>> On Sat, Mar 08, 2014 at 03:29:51AM +0100, Christopher Heiny wrote:
>>>>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>>>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>> Cc: Linux Walleij <linus.walleij@linaro.org>
>>>>> Cc: David Herrmann <dh.herrmann@gmail.com>
>>>>> Cc: Jiri Kosina <jkosina@suse.cz>
>>>>>
>>>>> ---
>>>>>
>>>>>    drivers/input/rmi4/rmi_f01.c |  96 ++-----------------------------------
>>>>>    drivers/input/rmi4/rmi_f01.h | 110 +++++++++++++++++++++++++++++++++++++++++++
>>>>>    2 files changed, 114 insertions(+), 92 deletions(-)
>> [...]
>>>>
>>>> I might be missing something, but these seem like the only defines used
>>>> in the flash code.  Why not keep these in the f01 driver, and export
>>>> a couple more functions, like rmi_f01_reset() and rmi_f01_set_sleep_mode() ?
>>>
>>> It seems better to me to have the information defined in a single place,
>>> rather than scattered hither and yon through the source files.
>>
>> Uh.  Exactly?  This is why I'm suggesting that you keep this information
>> isolated in the driver to which is directly related.
>>
>> Perhaps what you mean is that the regs/bits for the entire chip
>> functionality should be exposed in header files, so one can read/write
>> it from anywhere?  That seems backwards to the idea of separating these
>> 'functions' out into drivers.
>
> Ah.  Wait.  I think there was some mis-communication on my part.  What I
> should have said:  Why not keep all of the defines in the driver, and
> export a couple more functions?
>
> My point is exactly yours.  Keep the defines with the code.  Expose
> what's needed.

I don't see any win to that approach. For example, you can hide the 
sleep mode mask and the nosleep bit #defines in rmi_f01.c, but you've 
got to add a new function with either a tri-state field for the nosleep 
bit (set it, clear it, don't change it) which will require an additional 
3 #defines and the new sleep mode which still needs the sleep mode 
#defines (plus an additional one to indicate that you want to leave the 
sleep mode as it was), or 3 new functions, once of which changes the 
sleep mode, one of which sets/clears the nosleep bit, and one of which 
does both. In either case, you still need the sleep mode #defines, so 
some of the related stuff is in the header and some of it is in the .c 
file.  Now you wind up with more stuff in the .h file (at least twice as 
much as you've removed) and you no longer have one stop shopping for the 
F01_Ctrl0 #defines.

BTW - thanks very much for all of today's input.  Even though we don't 
necessarily agree with all of it, it's been helpful to go back and ask 
"did we make the right decision?".

					Chris
