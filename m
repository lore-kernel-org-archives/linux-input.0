From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH RFC V2 0/3] Input: goodix - add axis swapping and axis
 inversion support
Date: Tue, 13 Oct 2015 06:59:42 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0FE4B0@irsmsx105.ger.corp.intel.com>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444413352-24529-1-git-send-email-merker@debian.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Karsten Merker [mailto:merker@debian.org]
> Sent: 09 October, 2015 20:56
> To: Bastien Nocera; Dmitry Torokhov; Tirdea, Irina; Aleksei Mamlin; linux-input@vger.kernel.org; Ian Campbell
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Chen-Yu Tsai; Karsten Merker
> Subject: [PATCH RFC V2 0/3] Input: goodix - add axis swapping and axis inversion support
> 
> Hello,
> 
> this is v2 of my "Input: goodix - add axis swapping and axis inversion
> support" patchset.
> The goodix touchscreen driver has gained device-tree support in kernel
> 4.1, but doesn't currently support the touchscreen-swapped-x-y,
> touchscreen-inverted-x and touchscreen-inverted-y properties.
> 
> On systems which combine a portrait-mode display with a landscape-mode
> touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
> features is necessary to have the touchscreen and the display use the
> same coordinate system.
> 
> With support for axis inversion, the "rotated_screen" flag in the
> driver can also be removed, as "rotated_screen" is just a special case
> of x/y axis inversion.
> 
> This patchset sits on top of the "[PATCH v8 0/9] Goodix touchscreen
> enhancements" series by Irina Tirdea:
> https://www.spinics.net/lists/linux-input/msg41437.html
> 
> I have successfully tested the axis swapping on an (arm-based) MSI
> Primo 81 tablet, but I lack appropriate hardware to do a real-world
> test of the "rotated_screen" code path, so I would appreciate very
> much if somebody with appropriate hardware (WinBook TW100 or TW700)
> could give it a try.
> 
> Regards,
> Karsten
> 

Hi Karsten,

I took a look at your patches and also did a quick test on my setup.
Code looks good, I have just one comment I've mentioned on the
first patch in the series.

Thanks,
Irina

> Changelog:
> 
> v1: * Initial version (based von v6 of Irina Tirdea's "Goodix
>       touchscreen enhancements" series).
>       Reviewed-by: Bastien Nocera <hadess@hadess.net>
> 
> v2: * Rebase against v8 of Irina Tirdea's "Goodix touchscreen
>       enhancements" series.
>     * Fix a typo in the commit message.
>     * Add an update for the goodix dt bindings documentation
>       (patch No. 3).
> 
> 
> Karsten Merker (3):
>   Input: goodix - add dt axis swapping and axis inversion support
>   Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
>   Input: goodix - update dt bindings documentation (axis
>     swapping/inversion)
> 
>  .../bindings/input/touchscreen/goodix.txt          |  6 ++++
>  drivers/input/touchscreen/goodix.c                 | 33 ++++++++++++++++++----
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 
> --
> 2.1.4
