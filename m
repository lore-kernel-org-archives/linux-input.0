From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v5 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
Date: Tue, 16 Apr 2019 07:56:31 +0200
Message-ID: <dd5189a2-8422-5e3c-1c79-d68680117deb@samsung.com>
References: <20190415081300.24831-1-ronald@innovation.ch>
        <CGME20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac@epcas2p4.samsung.com>
        <20190415081300.24831-2-ronald@innovation.ch>
        <76cf3079-f190-bed4-7a00-149d7fa0a650@samsung.com>
        <20190415232444.GB13033@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415232444.GB13033@innovation.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 16.04.2019 01:24, Life is hard, and then you die wrote:
>   Hi Andrzej,
>
> On Mon, Apr 15, 2019 at 10:58:09AM +0200, Andrzej Hajda wrote:
>> On 15.04.2019 10:12, Ronald Tschalär wrote:
>>> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
>>> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
>>> However, this causes problems with other drivers, in particular an input
>>> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
>>> commit):
>>>
>>>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>>>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>>>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>>>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>>>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>>>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>>>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>>>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>>>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>>>
>>> According to the docs and general consensus, select should only be used
>>> for non user-visible symbols, but both RC_CORE and INPUT are
>>> user-visible. Furthermore almost all other references to INPUT
>>> throughout the kernel config are depends, not selects. For this reason
>>> the first part of this change reverts commit d6abe6df706c.
>>>
>>> In order to address the original reason for commit d6abe6df706c, namely
>>> that not all boards use the remote controller functionality and hence
>>> should not need have to deal with RC_CORE, the second part of this
>>> change now makes the remote control support in the driver optional and
>>> contingent on RC_CORE being defined. And with this the hard dependency
>>> on INPUT also goes away as that is only needed if RC_CORE is defined
>>> (which in turn already depends on INPUT).
>>>
>>> CC: Inki Dae <inki.dae@samsung.com>
>>> CC: Andrzej Hajda <a.hajda@samsung.com>
>>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
>>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Thanks for your reviews!
>
>> If there are no objections I will take it to drm-misc tomorrow.
> This brings us back to the discussion started in response to the first
> version of my patch (see
> https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#m24f45fecd987a787a9554c8088f463fd10de2b00).
> To recap: the problem is that the applespi patch depends on this patch
> here, as make-config will break as described above otherwise. So if
> this patch is submitted through drm-misc, then it's unclear to me how
> to ensure that the two patches make it upstream in proper order,
> unless the applespi patch is also upstreamed through drm-misc, or the
> Kconfig for applespi is (temporarily) modified to not trigger the
> config error and another patch is later submitted to fix the Kconfig
> again (which seems somewhat ugly to me). Assuming that consensus is to
> merge both patches through one tree, then it would seem that because
> this patch here is relatively small that maybe it could be merged
> through the input tree along with the applespi patch?


Oh, I have forgot. Please take it then via input tree.


Regards

Andrzej



>
>
>   Cheers,
>
>   Ronald
>
>
>
