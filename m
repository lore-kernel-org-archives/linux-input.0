From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 1/4] Input: edt-ft5x06 - Use max support points to determine how much to read
Date: Thu, 15 Oct 2015 17:57:15 -0700
Message-ID: <2B78C5AE-31C7-4FFA-A9A7-8E1381CFEF08@gmail.com>
References: <1444220501-23623-1-git-send-email-fcooper@ti.com> <1444220501-23623-2-git-send-email-fcooper@ti.com> <20151014233904.GA3673@dtor-ws> <561F0848.7040408@ti.com> <20151016001632.GB1794@dtor-ws> <5620481B.5050709@ti.com> <CAKdAkRQahQWbGaVFfUn5O_R_SvxkkS0jWGYMHgu26t_RaneDaw@mail.gmail.com> <56204AB6.6080306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33318 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbbJPA5V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 20:57:21 -0400
In-Reply-To: <56204AB6.6080306@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <lw@karo-electronics.de>, Jingoo Han <jg1.han@samsung.com>, Asaf Vertz <asaf.vertz@tandemg.com>

On October 15, 2015 5:54:14 PM PDT, "Franklin S Cooper Jr." <fcooper@ti.com> wrote:
>
>
>
>On 10/15/2015 07:47 PM, Dmitry Torokhov wrote:
>> On Thu, Oct 15, 2015 at 5:43 PM, Franklin S Cooper Jr.
><fcooper@ti.com> wrote:
>>>
>>> On 10/15/2015 07:16 PM, Dmitry Torokhov wrote:
>>>> On Wed, Oct 14, 2015 at 08:58:32PM -0500, Franklin S Cooper Jr.
>wrote:
>>>>> On 10/14/2015 06:39 PM, Dmitry Torokhov wrote:
>>>>>> On Wed, Oct 07, 2015 at 07:21:38AM -0500, fcooper@ti.com wrote:
>>>>>>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>>>
>>>>>>> Calculate the amount of data that needs to be read for the
>specified max
>>>>>>> number of support points. If the maximum number of support
>points changes
>>>>>>> then the amount that is read from the touch screen controller
>should
>>>>>>> reflect this.
>>>>>>>
>>>>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>>> ---
>>>>>>>  drivers/input/touchscreen/edt-ft5x06.c | 6 ++++--
>>>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/input/touchscreen/edt-ft5x06.c
>b/drivers/input/touchscreen/edt-ft5x06.c
>>>>>>> index 7239c31..1e0ed6e 100644
>>>>>>> --- a/drivers/input/touchscreen/edt-ft5x06.c
>>>>>>> +++ b/drivers/input/touchscreen/edt-ft5x06.c
>>>>>>> @@ -178,14 +178,16 @@ static irqreturn_t edt_ft5x06_ts_isr(int
>irq, void *dev_id)
>>>>>>>            cmd = 0xf9; /* tell the controller to send touch data
>*/
>>>>>>>            offset = 5; /* where the actual touch data starts */
>>>>>>>            tplen = 4;  /* data comes in so called frames */
>>>>>>> -          datalen = 26; /* how much bytes to listen for */
>>>>>>> +
>>>>>>> +          /* how many bytes to listen for */
>>>>>>> +          datalen = tplen * MAX_SUPPORT_POINTS + offset + 1;
>>>>>>>            break;
>>>>>>>
>>>>>>>    case M09:
>>>>>>>            cmd = 0x02;
>>>>>>>            offset = 1;
>>>>>>>            tplen = 6;
>>>>>>> -          datalen = 29;
>>>>>>> +          datalen = tplen * MAX_SUPPORT_POINTS - cmd + 1;
>>>>>>>            break;
>>>>>> Hmm, why would formulae for datalen be different depending on the
>>>>>> firmware? And I think original 29 it too low: we need 30 bytes
>for 5
>>>>>> contacts + 1 to account for offset.
>>>>> So based on the current ISR we don't care about the touch weight
>and
>>>>> which are the last two registers for each touch point. So for the
>last
>>>>> touchpoint we really don't need to read the extra two registers
>(-2).
>>>> This is really not obvious. I do not think we'd see any performance
>>>> degradation if we actually read the whole last touchpoint.
>>> Yeah that shouldn't be a problem. I'll fix that.
>>>>> We need +1 simply for the fact that we read the register at
>location
>>>>> cmd.
>>>> I am not sure I follow this. We do not reference anything past
>>>> rdbuf[(MAX_SUPPORT_POINTS - 1) * tplen + offset] and
>>>> our offset takes care of the start position, so why exactly we need
>the
>>>> +1? Ah, CRC is in the extra byte.
>>> Sorry your right the +1 isn't needed.
>>>> Can we unify the calculation to be:
>>>>
>>>>       datalen = tplen * MAX_SUPPORT_POINTS + offset + crc_len;
>>> Why do we need the crc_len? M06 is the only one that uses the CRC
>>> and the offset insures we are reading the necessary crc registers.
>> CRC is at buf[datalen - 1] position, so it is the last byte after
>last
>> contact. That is why we have +1 for M06. For M09 crc_len will be 0.
>Ok I get it now.
>
>I can submit a v2 patchset with these changes. Are you ok with this
>patchset
>as a whole other than these changes or should I give you more time to
>review
>the rest before sending out a v2 and remove the RFC.

No, I think I'm good with the direction you are going. Please resubmit and I should be able to apply it.


Thanks.

-- 
Dmitry
