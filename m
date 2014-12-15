From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 0/5] ARM:sunxi:ps2 Added support for A10/A20 ps2 controller.
Date: Mon, 15 Dec 2014 19:43:22 +0530
Message-ID: <CAEzqOZsWSpd_r3Oc=PBVw3NQH-_1V9JXtC2H4tZ3U6nCN_Z7aA@mail.gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
	<548C1E7D.1000005@redhat.com>
	<CAEzqOZtyeAnG660AKf_0_gCa-+BT_pAzHk0HYYSCdm4y89GFJA@mail.gmail.com>
	<548D5207.8030004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <548D5207.8030004-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare@suse>
List-Id: linux-input@vger.kernel.org

Hi,

On Sun, Dec 14, 2014 at 2:31 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> On 13-12-14 21:01, Vishnu Patekar wrote:
>>
>> Hello Hans,
>> Please find my comments inlined.
>>
>> On 12/13/14, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>
>>> Hi VishnuPatekar,
>>>
>>> The patch mangling for this set seems to have gone a bit wrong I'm afraid
>>
>>
>> No, this time I've corrected it. Infact, last version of patch did not
>> used the status bit error macros.
>>
>>> a lot of the patches have my fixup commit messages (which should have
>>> disappeared when squashing in the patches), please replace those by
>>> proper
>>> commit messages describing what the patch actually does.
>>
>> Yes, [PATCHv3 3/5] uses fixup. I'll correct it.
>>>
>>>
>>> Also the adding of the commented nodes for the lime2 seems to be gone
>>> entirely
>>> from the set, instead now only a comment about the conflict with the hdmi
>>> pins is added, but it is above the i2c node instead of above a ps2 node.
>>>
>> Maxime's suggested that we should not add commented nodes specially
>> when its trivial to apply. And just note saying ps20 pins conflict
>> with HDMI.
>
>
> Ah, I see.
>
>> Should I remove the this comment as well?
>> Or
>> Put this note in start of DTS file?
>
>
> The comment should be added to where the pinctrl bits are, not to the lime2
> file, ps0 will conflict with hdmi on all boards.

Well, In that case,PS2_0 pins conflicts with HDMI, PS2_1 pins
conflicts with LCD. Every pin has multiplexing.

Do we really need to add this comment?
Can't we just  keep PS2 pins disabled, without any comment in dtsi or dts file?

Whoever wants, can enable PS2 pins in respective board dts file by
taking care that it does not conflict with any other peripheral.

>
> Regards,
>
> Hans
>
>
>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>> On 12-12-14 19:25, VishnuPatekar wrote:
>>>>
>>>> v2 --> v3
>>>> 1. changed config to SERIO_SUN4I_PS2 from SERIO_SUNXI_PS2
>>>> 2. changed driver name to sun4i-ps2 from sunxi-ps2.
>>>> 3. changed the function names to sun4i_ps2_*.
>>>> 4. added locking in sun4i_ps2_open.
>>>> 5. kept compatible "sun4i-a10-ps2" for A10 and A20, as A10 is earlier
>>>> SOC.
>>>> 6. corrected the style errors.
>>>> 7. separated the dts patches.
>>>> 8. removed commented ps2 notes from lime2 dts.
>>>> 9. added note that ps2 pins confilt with hdmi.
>>>> 10. corrected the interrupt property for A10.
>>>> 11. moved dt-bindings to Documentation/devicetree/bindings/serio
>>>>
>>>> v1 --> v2:
>>>> 1. added default n depends on ARCH_SUNXI || COMPILE_TEST in Kconfig.
>>>> 2. handled errors and free resources on errors.
>>>> 3. used BIT(x), DIV_ROUND_UP macros.
>>>> 4. corrected style errors.
>>>> 5. added support for A10 also, A10 and A2 have same properties of PS2
>>>> controller.
>>>> 6. by default commented ps20 and ps21 nodes,as ps20 pins conflict with
>>>> HDMI.
>>>> 7. added compatible as allwinner,sun4i-a10-ps2.
>>>> 8. corrected the possible race condition.
>>>>
>>>>
>>>> VishnuPatekar (5):
>>>>     sunxi:dts-bindings:input:ps2 bindings for A10/A20 ps2.
>>>>     ARM:sunxi:drivers:input Add support for A10/A20 PS2
>>>>     ARM: sunxi: dts: Add PS2 nodes to dtsi for A10 and A20
>>>>     ARM: sunxi: dts: Add A10/A20 PS2 pin muxing options
>>>>     ARM: sunxi: dts: Add note ps2 pins conflict with hdmi
>>>>
>>>>    .../bindings/serio/allwinner,sun4i-ps2.txt         |   23 ++
>>>>    arch/arm/boot/dts/sun4i-a10.dtsi                   |   31 ++
>>>>    arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |    6 +-
>>>>    arch/arm/boot/dts/sun7i-a20.dtsi                   |   32 ++
>>>>    drivers/input/serio/Kconfig                        |   11 +
>>>>    drivers/input/serio/Makefile                       |    1 +
>>>>    drivers/input/serio/sun4i-ps2.c                    |  362
>>>> ++++++++++++++++++++
>>>>    7 files changed, 465 insertions(+), 1 deletion(-)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
>>>>    create mode 100644 drivers/input/serio/sun4i-ps2.c
>>>>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
