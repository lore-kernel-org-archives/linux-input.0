From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCHv3 0/5] ARM:sunxi:ps2 Added support for A10/A20 ps2 controller.
Date: Mon, 15 Dec 2014 16:13:35 +0100
Message-ID: <548EFA9F.4080208@redhat.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>	<548C1E7D.1000005@redhat.com>	<CAEzqOZtyeAnG660AKf_0_gCa-+BT_pAzHk0HYYSCdm4y89GFJA@mail.gmail.com>	<548D5207.8030004@redhat.com> <CAEzqOZsWSpd_r3Oc=PBVw3NQH-_1V9JXtC2H4tZ3U6nCN_Z7aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEzqOZsWSpd_r3Oc=PBVw3NQH-_1V9JXtC2H4tZ3U6nCN_Z7aA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vishnu Patekar <vishnupatekar0510@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "msalter@redhat.com" <msalter@redhat.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jdelvare@suse.de" <jdelvare@suse>
List-Id: linux-input@vger.kernel.org

Hi,

On 15-12-14 15:13, Vishnu Patekar wrote:
> Hi,
>
> On Sun, Dec 14, 2014 at 2:31 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 13-12-14 21:01, Vishnu Patekar wrote:
>>>
>>> Hello Hans,
>>> Please find my comments inlined.
>>>
>>> On 12/13/14, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi VishnuPatekar,
>>>>
>>>> The patch mangling for this set seems to have gone a bit wrong I'm afraid
>>>
>>>
>>> No, this time I've corrected it. Infact, last version of patch did not
>>> used the status bit error macros.
>>>
>>>> a lot of the patches have my fixup commit messages (which should have
>>>> disappeared when squashing in the patches), please replace those by
>>>> proper
>>>> commit messages describing what the patch actually does.
>>>
>>> Yes, [PATCHv3 3/5] uses fixup. I'll correct it.
>>>>
>>>>
>>>> Also the adding of the commented nodes for the lime2 seems to be gone
>>>> entirely
>>>> from the set, instead now only a comment about the conflict with the hdmi
>>>> pins is added, but it is above the i2c node instead of above a ps2 node.
>>>>
>>> Maxime's suggested that we should not add commented nodes specially
>>> when its trivial to apply. And just note saying ps20 pins conflict
>>> with HDMI.
>>
>>
>> Ah, I see.
>>
>>> Should I remove the this comment as well?
>>> Or
>>> Put this note in start of DTS file?
>>
>>
>> The comment should be added to where the pinctrl bits are, not to the lime2
>> file, ps0 will conflict with hdmi on all boards.
>
> Well, In that case,PS2_0 pins conflicts with HDMI, PS2_1 pins
> conflicts with LCD. Every pin has multiplexing.

Almost every A10 board has a hdmi connector, and only the hdmi ddc pins
are multiplexed, so this is sort of special, but yes if we do not have
the commented nodes in the dts file, then this comment can be dropped too
I guess.

Regards,

Hans
