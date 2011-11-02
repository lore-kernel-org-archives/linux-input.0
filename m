From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v5 0/2] Add device tree support for Samsung's keypad
 controller driver
Date: Wed, 02 Nov 2011 20:27:52 +0900
Message-ID: <004b01cc9952$75c87060$61595120$%kim@samsung.com>
References: <1318264197-6698-1-git-send-email-thomas.abraham@linaro.org>
 <057501cc880e$af0a28a0$0d1e79e0$%kim@samsung.com> <4EA56178.60301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4EA56178.60301@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, grant.likely@secretlab.ca, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com, patches@linaro.org
List-Id: linux-input@vger.kernel.org

Kukjin Kim wrote:
> 
> On 10/11/11 14:09, Kukjin Kim wrote:
> > Thomas Abraham wrote:
> >>
> >> Changes since v4:
> >> - Tested with linux 3.1-rc9. No changes in code.
> >>
> >> Changes since v3:
> >> - Addressed comments from Grant Likely.
> >>    - Set num_rows and num_cols to zero in samsung_keypad_parse_dt
> function.
> >>    - Fixed the wierd looking if-else block in samsung_keypad_probe
> > function.
> >>
> >> Changes since v2:
> >> - Addressed comments from Grant Likely.
> >>    - Renamed 'keypad,key-code' property name to 'linux,code'.
> >>    - Fixed incorrect data types for all instances of
of_property+read_u32.
> >>    - linux,input-type binding was not added as suggested since the
driver
> >>      supports only EV_KEY event type.
> >>
> >> Changes since v1:
> >> - Addressed comments from Dmitry Torokhov.
> >>    - Type of controller is cached in driver's private data and the
function
> >>      that determines the type of the controller for each keypad scan is
> >>      removed.
> >>    - pdata allocated during probe is explicitly freed after probe
completes
> >>      without any error. In case of exit from probe due a error, no
explicit
> >>      deallocation of pdata memory is performed and it is left to devres
to
> >>      handle that.
> >>    - The generic code to translate KEY(x,y,code) is retained in the
driver
> >>      itself. I am unsure of a right common place for it.
> >>    - Driver continues with the probe even if one or more gpio
configuration
> >>      fails.
> >>    - Patch 1 that adds a new config option is still retained in this
> > patchset.
> >>
> >>
> >> This patchset adds device tree support for samsung's keypad controller
> > driver.
> >> First patch adds a new config option to be used by device tree enabled
> > platforms
> >> for selecting the samsung's keypad controller driver. The second patch
> > adds
> >> device
> >> tree support for the keypad driver.
> >>
> >>
> >> Thomas Abraham (2):
> >>    input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
> >>    input: samsung-keypad: Add device tree support
> >>
> >>   .../devicetree/bindings/input/samsung-keypad.txt   |   88 ++++++++++
> >>   drivers/input/keyboard/Kconfig                     |    9 +-
> >>   drivers/input/keyboard/samsung-keypad.c            |  174
> >> ++++++++++++++++++--
> >>   3 files changed, 258 insertions(+), 13 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/input/samsung-
> >> keypad.txt
> >
> > Looks ok to me,
> > Acked-by: Kukjin Kim<kgene.kim@samsung.com>
> >
> > Hi Dmitry,
> > If you're ok on this, please adding this in your tree for upcoming merge
> > window.
> >
> Dmitry,
> 
> Any problem on this?
> 
Hi Dmitry,

I applied this in Samsung tree, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
