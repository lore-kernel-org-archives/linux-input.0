From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5 1/2] HID: logitech: Add MX Master over Bluetooth
Date: Mon, 14 Oct 2019 09:07:50 +0200
Message-ID: <CAO-hwJLea5rAZ20Mdn8tSD1a8FfbS9RDcu2nWwLgxTtxKKsWyg@mail.gmail.com>
References: <Mbf4goGxXZTfWwWtQQUke_rNf8kezpNOS9DVEVHf6RnnmjS1oRtMOJf4r14WfCC6GRYVs7gi0uZcIJ18Va2OJowzSbyMUGwLrl6I5fjW48o=@protonmail.com>
 <201910140950.uA9aSUlt%lkp@intel.com> <TKRbvHYo9MdseQJhtKe0NPnI1BAPwcVBM_mJjDhYyPD46CuOy06PNzSQ6ifxPMMzKXTsRoD2aC_AaY5L9OAovXbof8ItLNZHcXULttZnps8=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TKRbvHYo9MdseQJhtKe0NPnI1BAPwcVBM_mJjDhYyPD46CuOy06PNzSQ6ifxPMMzKXTsRoD2aC_AaY5L9OAovXbof8ItLNZHcXULttZnps8=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>
Cc: kbuild test robot <lkp@intel.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
List-Id: linux-input@vger.kernel.org

Hey,

On Mon, Oct 14, 2019 at 6:35 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Sunday, October 13, 2019 9:28 PM, kbuild test robot <lkp@intel.com> wr=
ote:
>
> > Hi Mazin,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [cannot apply to v5.4-rc2 next-20191010]
> > [if your patch is applied to the wrong git tree, please drop us a note =
to help
> > improve the system. BTW, we also suggest to use '--base' option to spec=
ify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/3=
7406982]
> >
> > url: https://github.com/0day-ci/linux/commits/Mazin-Rezk/HID-logitech-A=
dd-MX-Master-over-Bluetooth/20191014-071534
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 7.4.0
> > reproduce:
> > wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make=
.cross -O ~/bin/make.cross
> > chmod +x ~/bin/make.cross
> > # save the attached .config to linux build tree
> > GCC_VERSION=3D7.4.0 make.cross ARCH=3Dmips
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot lkp@intel.com
> >
> > All warnings (new ones prefixed by >>):
> >
> > In file included from include/linux/ioport.h:15:0,
> > from include/linux/device.h:15,
> > from drivers/hid/hid-logitech-hidpp.c:13:
> > drivers/hid/hid-logitech-hidpp.c: In function 'hidpp_send_rap_command_s=
ync':
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > > > drivers/hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro=
 'BIT'
> >
> >     #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> >                                               ^~~
> >
> >
> > > > drivers/hid/hid-logitech-hidpp.c:347:26: note: in expansion of macr=
o 'HIDPP_QUIRK_MISSING_SHORT_REPORTS'
> >
> >      if (hidpp_dev->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS &&
> >
> >                              ^
> >
> >
> > drivers/hid/hid-logitech-hidpp.c: In function 'hidpp_validate_device':
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > > > drivers/hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro=
 'BIT'
> >
> >     #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> >                                               ^~~
> >
> >
> > drivers/hid/hid-logitech-hidpp.c:3496:22: note: in expansion of macro '=
HIDPP_QUIRK_MISSING_SHORT_REPORTS'
> > if (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)
> >
> >                          ^
> >
> >
> > drivers/hid/hid-logitech-hidpp.c: At top level:
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > > > drivers/hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro=
 'BIT'
> >
> >     #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> >                                               ^~~
> >
> >
> > drivers/hid/hid-logitech-hidpp.c:85:40: note: in expansion of macro 'HI=
DPP_QUIRK_MISSING_SHORT_REPORTS'
> > #define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPORT=
S
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > > > drivers/hid/hid-logitech-hidpp.c:3794:5: note: in expansion of macr=
o 'HIDPP_QUIRK_CLASS_BLUETOOTH_LE'
> >
> >         HIDPP_QUIRK_CLASS_BLUETOOTH_LE },
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > > > drivers/hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro=
 'BIT'
> >
> >     #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> >                                               ^~~
> >
> >
> > drivers/hid/hid-logitech-hidpp.c:85:40: note: in expansion of macro 'HI=
DPP_QUIRK_MISSING_SHORT_REPORTS'
> > #define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPORT=
S
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/hid/hid-logitech-hidpp.c:3797:5: note: in expansion of macro 'H=
IDPP_QUIRK_CLASS_BLUETOOTH_LE'
> > HIDPP_QUIRK_CLASS_BLUETOOTH_LE },
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------
> >
> > In file included from include/linux/ioport.h:15:0,
> > from include/linux/device.h:15,
> > from drivers//hid/hid-logitech-hidpp.c:13:
> > drivers//hid/hid-logitech-hidpp.c: In function 'hidpp_send_rap_command_=
sync':
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > drivers//hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro 'B=
IT'
> > #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> > ^~~
> > drivers//hid/hid-logitech-hidpp.c:347:26: note: in expansion of macro '=
HIDPP_QUIRK_MISSING_SHORT_REPORTS'
> > if (hidpp_dev->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS &&
> >
> >                              ^
> >
> >
> > drivers//hid/hid-logitech-hidpp.c: In function 'hidpp_validate_device':
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > drivers//hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro 'B=
IT'
> > #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> > ^~~
> > drivers//hid/hid-logitech-hidpp.c:3496:22: note: in expansion of macro =
'HIDPP_QUIRK_MISSING_SHORT_REPORTS'
> > if (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)
> >
> >                          ^
> >
> >
> > drivers//hid/hid-logitech-hidpp.c: At top level:
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > drivers//hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro 'B=
IT'
> > #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> > ^~~
> > drivers//hid/hid-logitech-hidpp.c:85:40: note: in expansion of macro 'H=
IDPP_QUIRK_MISSING_SHORT_REPORTS'
> > #define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPORT=
S
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers//hid/hid-logitech-hidpp.c:3794:5: note: in expansion of macro '=
HIDPP_QUIRK_CLASS_BLUETOOTH_LE'
> > HIDPP_QUIRK_CLASS_BLUETOOTH_LE },
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > > > include/linux/bits.h:8:26: warning: left shift count >=3D width of =
type [-Wshift-count-overflow]
> >
> >     #define BIT(nr)   (UL(1) << (nr))
> >                              ^
> >
> >
> > drivers//hid/hid-logitech-hidpp.c:74:43: note: in expansion of macro 'B=
IT'
> > #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> > ^~~
> > drivers//hid/hid-logitech-hidpp.c:85:40: note: in expansion of macro 'H=
IDPP_QUIRK_MISSING_SHORT_REPORTS'
> > #define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPORT=
S
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers//hid/hid-logitech-hidpp.c:3797:5: note: in expansion of macro '=
HIDPP_QUIRK_CLASS_BLUETOOTH_LE'
> > HIDPP_QUIRK_CLASS_BLUETOOTH_LE },
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > vim +/BIT +74 drivers/hid/hid-logitech-hidpp.c
> >
> > 12
> >
> > > 13 #include <linux/device.h>
> >
> >     14        #include <linux/input.h>
> >
> >     15        #include <linux/usb.h>
> >
> >     16        #include <linux/hid.h>
> >
> >     17        #include <linux/module.h>
> >
> >     18        #include <linux/slab.h>
> >
> >     19        #include <linux/sched.h>
> >
> >     20        #include <linux/sched/clock.h>
> >
> >     21        #include <linux/kfifo.h>
> >
> >     22        #include <linux/input/mt.h>
> >
> >     23        #include <linux/workqueue.h>
> >
> >     24        #include <linux/atomic.h>
> >
> >     25        #include <linux/fixp-arith.h>
> >
> >     26        #include <asm/unaligned.h>
> >
> >     27        #include "usbhid/usbhid.h"
> >     28        #include "hid-ids.h"
> >     29
> >     30        MODULE_LICENSE("GPL");
> >     31        MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gma=
il.com>");
> >
> >     32        MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.=
com>");
> >
> >     33
> >     34        static bool disable_raw_mode;
> >     35        module_param(disable_raw_mode, bool, 0644);
> >     36        MODULE_PARM_DESC(disable_raw_mode,
> >     37                "Disable Raw mode reporting for touchpads and kee=
p firmware gestures.");
> >     38
> >     39        static bool disable_tap_to_click;
> >     40        module_param(disable_tap_to_click, bool, 0644);
> >     41        MODULE_PARM_DESC(disable_tap_to_click,
> >     42                "Disable Tap-To-Click mode reporting for touchpad=
s (only on the K400 currently).");
> >     43
> >     44        #define REPORT_ID_HIDPP_SHORT                   0x10
> >     45        #define REPORT_ID_HIDPP_LONG                    0x11
> >     46        #define REPORT_ID_HIDPP_VERY_LONG               0x12
> >     47
> >     48        #define HIDPP_REPORT_SHORT_LENGTH               7
> >     49        #define HIDPP_REPORT_LONG_LENGTH                20
> >     50        #define HIDPP_REPORT_VERY_LONG_MAX_LENGTH       64
> >     51
> >     52        #define HIDPP_SUB_ID_CONSUMER_VENDOR_KEYS       0x03
> >     53        #define HIDPP_SUB_ID_ROLLER                     0x05
> >     54        #define HIDPP_SUB_ID_MOUSE_EXTRA_BTNS           0x06
> >     55
> >     56        #define HIDPP_QUIRK_CLASS_WTP                   BIT(0)
> >     57        #define HIDPP_QUIRK_CLASS_M560                  BIT(1)
> >     58        #define HIDPP_QUIRK_CLASS_K400                  BIT(2)
> >     59        #define HIDPP_QUIRK_CLASS_G920                  BIT(3)
> >     60        #define HIDPP_QUIRK_CLASS_K750                  BIT(4)
> >     61
> >     62        /* bits 2..20 are reserved for classes */
> >     63        /* #define HIDPP_QUIRK_CONNECT_EVENTS           BIT(21) d=
isabled */
> >     64        #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS        BIT(22)
> >     65        #define HIDPP_QUIRK_NO_HIDINPUT                 BIT(23)
> >     66        #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS        BIT(24)
> >     67        #define HIDPP_QUIRK_UNIFYING                    BIT(25)
> >     68        #define HIDPP_QUIRK_HI_RES_SCROLL_1P0           BIT(26)
> >     69        #define HIDPP_QUIRK_HI_RES_SCROLL_X2120         BIT(27)
> >     70        #define HIDPP_QUIRK_HI_RES_SCROLL_X2121         BIT(28)
> >     71        #define HIDPP_QUIRK_HIDPP_WHEELS                BIT(29)
> >     72        #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS      BIT(30)
> >     73        #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS  BIT(31)
> >
> >
> > > 74 #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(32)
> >
> >     75
> >
> >
> > --
> >
> > 0-DAY kernel test infrastructure Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all Intel Corporation
>
>
> It seems that I overlooked that quirks is an unsigned long and is 32-bit
> on some architectures. I feel like it's possible to change driver_data
> and quirks to unsigned long long but it seems like such an unnecessarily
> large change.

Yep, which is why I told you to use 0x20 and 0x1f :)

>
> Since we've already reached the 32-bit limit for quirks, is it possible
> that we could change how many bits are reserved for classes?

yes, we can simply change the reserved range, this is just a comment after =
all.

>
> Also, could bit 21 be reused for HIDPP_QUIRK_MISSING_SHORT_REPORTS?

unfortunately no. This is theoretically kernel API, as you can have a
script that binds a driver and sets a custom quirk for it (by writing
to the sysfs new_id). So if one is marked as "reserved", resuing it
might break someone's device though really unlikely.

I'd rather shrink the number of classes than reusing one quirk already used=
.

Cheers,
Benjamin
