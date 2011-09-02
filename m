From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] input: keyboard: adp5589-keys: Add support for the
 ADP5585 derivatives
Date: Fri, 2 Sep 2011 09:08:30 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E703E0AF@LIMKCMBX1.ad.analog.com>
References: <1311944415-20197-1-git-send-email-michael.hennerich@analog.com>
 <4E390710.5060503@analog.com>
 <20110804031906.GA30482@core.coreip.homeip.net>
 <4E3A4EFD.5030507@analog.com> <20110804075542.GC31276@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:32875
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758014Ab1IBIIt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Sep 2011 04:08:49 -0400
In-Reply-To: <20110804075542.GC31276@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>

Dmitry Torokhov wrote on 2011-08-04:
> On Thu, Aug 04, 2011 at 09:49:17AM +0200, Michael Hennerich wrote:
>> On 08/04/2011 05:19 AM, Dmitry Torokhov wrote:
>>> On Wed, Aug 03, 2011 at 10:30:08AM +0200, Michael Hennerich wrote:
>>>> On 07/29/2011 03:00 PM, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>>
>>>>> The ADP5585 family keypad decoder and IO expander is similar to the
>>>>> ADP5589, however it features less IO pins, and lacks hardware
>>>>> assisted key- lock functionality. Unfortunately the register
>>>>> addresses are different, as well as the event codes and bit
>>>>> organization within the port related registers.
>>>>>
>>>>> Move ADP5589 Register defines from the header file into the main
>>>>> source file. Add new defines while making sure we don't break
>>>>> existing platform_data. Add register address translation, and turn
>>>>> device specific defines into variables. Introduce some helper
>>>>> functions and disable functions that doesn't exist on the added
>>>>> devices.
>>>>>
>>>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>>>>> ---
>>>>>  drivers/input/keyboard/Kconfig        |    4 +-
>>>>>  drivers/input/keyboard/adp5589-keys.c |  607
>>>>>  ++++++++++++++++++++++++++------- include/linux/input/adp5589.h
>>>>>      |  157 ++++----- 3 files changed, 549 insertions(+), 219
>>>>>  deletions(-)
>>>> Hi Dmitry,
>>>>
>>>> If you prefer support for the ADP5585 as separate driver, please let
>>>> me know.
>>> Hi Michael,
>>>
>>> No, I actually like this approach very much, but do you think we could
>>> have adp5589-keys.c, adp5585-keys.c and adp558x-keys-core.c? The
>>> register definitions put all in one file are a bit overwhelming...
>>
>> Hi Dmitry,
>>
>> The register look-up table used for the ADP5585 also requires the
>> ADP5589 defines.
>> Also the core file would need the ADP5589 defines. So I don't think
>> splitting stuff into
>> 3 source files will greatly improve things.
>
> Hmm... let me mull this over...

Hi Dmitry,

Any chance to get the adp5585 patch into input next?

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



