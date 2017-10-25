From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers/hid: Convert timers to use timer_setup()
Date: Wed, 25 Oct 2017 23:38:03 +0800
Message-ID: <201710252309.Izc4ivDK%fengguang.wu@intel.com>
References: <1508866222-15063-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1508866222-15063-1-git-send-email-allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Allen,

[auto build test ERROR on v4.14-rc6]
[cannot apply to hid/for-next next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Allen-Pais/drivers-hid-Convert-timers-to-use-timer_setup/20171025-230118
config: x86_64-randconfig-x011-201743 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/ioport.h:12:0,
                    from include/linux/device.h:16,
                    from drivers/hid/hid-appleir.c:26:
   drivers/hid/hid-appleir.c: In function 'key_up_tick':
>> drivers/hid/hid-appleir.c:178:39: error: 'applier' undeclared (first use in this function)
     struct appleir *appleir = from_timer(applier, t, key_up_timer);
                                          ^
   include/linux/compiler.h:553:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:576:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:46:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:928:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:928:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/timer.h:183:2: note: in expansion of macro 'container_of'
     container_of(callback_timer, typeof(*var), timer_fieldname)
     ^~~~~~~~~~~~
>> drivers/hid/hid-appleir.c:178:28: note: in expansion of macro 'from_timer'
     struct appleir *appleir = from_timer(applier, t, key_up_timer);
                               ^~~~~~~~~~
   drivers/hid/hid-appleir.c:178:39: note: each undeclared identifier is reported only once for each function it appears in
     struct appleir *appleir = from_timer(applier, t, key_up_timer);
                                          ^
   include/linux/compiler.h:553:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:576:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:46:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:928:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:928:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/timer.h:183:2: note: in expansion of macro 'container_of'
     container_of(callback_timer, typeof(*var), timer_fieldname)
     ^~~~~~~~~~~~
>> drivers/hid/hid-appleir.c:178:28: note: in expansion of macro 'from_timer'
     struct appleir *appleir = from_timer(applier, t, key_up_timer);
                               ^~~~~~~~~~

vim +/applier +178 drivers/hid/hid-appleir.c

  > 26	#include <linux/device.h>
    27	#include <linux/hid.h>
    28	#include <linux/module.h>
    29	#include "hid-ids.h"
    30	
    31	MODULE_AUTHOR("James McKenzie");
    32	MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>");
    33	MODULE_DESCRIPTION("HID Apple IR remote controls");
    34	MODULE_LICENSE("GPL");
    35	
    36	#define KEY_MASK		0x0F
    37	#define TWO_PACKETS_MASK	0x40
    38	
    39	/*
    40	 * James McKenzie has two devices both of which report the following
    41	 * 25 87 ee 83 0a	+
    42	 * 25 87 ee 83 0c	-
    43	 * 25 87 ee 83 09	<<
    44	 * 25 87 ee 83 06	>>
    45	 * 25 87 ee 83 05	>"
    46	 * 25 87 ee 83 03	menu
    47	 * 26 00 00 00 00	for key repeat
    48	 */
    49	
    50	/*
    51	 * Thomas Glanzmann reports the following responses
    52	 * 25 87 ee ca 0b	+
    53	 * 25 87 ee ca 0d	-
    54	 * 25 87 ee ca 08	<<
    55	 * 25 87 ee ca 07	>>
    56	 * 25 87 ee ca 04	>"
    57	 * 25 87 ee ca 02	menu
    58	 * 26 00 00 00 00       for key repeat
    59	 *
    60	 * He also observes the following event sometimes
    61	 * sent after a key is release, which I interpret
    62	 * as a flat battery message
    63	 * 25 87 e0 ca 06	flat battery
    64	 */
    65	
    66	/*
    67	 * Alexandre Karpenko reports the following responses for Device ID 0x8242
    68	 * 25 87 ee 47 0b	+
    69	 * 25 87 ee 47 0d	-
    70	 * 25 87 ee 47 08	<<
    71	 * 25 87 ee 47 07	>>
    72	 * 25 87 ee 47 04	>"
    73	 * 25 87 ee 47 02	menu
    74	 * 26 87 ee 47 **	for key repeat (** is the code of the key being held)
    75	 */
    76	
    77	/*
    78	 * Bastien Nocera's remote
    79	 * 25 87 ee 91 5f	followed by
    80	 * 25 87 ee 91 05	gives you >"
    81	 *
    82	 * 25 87 ee 91 5c	followed by
    83	 * 25 87 ee 91 05	gives you the middle button
    84	 */
    85	
    86	/*
    87	 * Fabien Andre's remote
    88	 * 25 87 ee a3 5e	followed by
    89	 * 25 87 ee a3 04	gives you >"
    90	 *
    91	 * 25 87 ee a3 5d	followed by
    92	 * 25 87 ee a3 04	gives you the middle button
    93	 */
    94	
    95	static const unsigned short appleir_key_table[] = {
    96		KEY_RESERVED,
    97		KEY_MENU,
    98		KEY_PLAYPAUSE,
    99		KEY_FORWARD,
   100		KEY_BACK,
   101		KEY_VOLUMEUP,
   102		KEY_VOLUMEDOWN,
   103		KEY_RESERVED,
   104		KEY_RESERVED,
   105		KEY_RESERVED,
   106		KEY_RESERVED,
   107		KEY_RESERVED,
   108		KEY_RESERVED,
   109		KEY_RESERVED,
   110		KEY_ENTER,
   111		KEY_PLAYPAUSE,
   112		KEY_RESERVED,
   113	};
   114	
   115	struct appleir {
   116		struct input_dev *input_dev;
   117		struct hid_device *hid;
   118		unsigned short keymap[ARRAY_SIZE(appleir_key_table)];
   119		struct timer_list key_up_timer;	/* timer for key up */
   120		spinlock_t lock;		/* protects .current_key */
   121		int current_key;		/* the currently pressed key */
   122		int prev_key_idx;		/* key index in a 2 packets message */
   123	};
   124	
   125	static int get_key(int data)
   126	{
   127		/*
   128		 * The key is coded accross bits 2..9:
   129		 *
   130		 * 0x00 or 0x01 (        )	key:  0		-> KEY_RESERVED
   131		 * 0x02 or 0x03 (  menu  )	key:  1		-> KEY_MENU
   132		 * 0x04 or 0x05 (   >"   )	key:  2		-> KEY_PLAYPAUSE
   133		 * 0x06 or 0x07 (   >>   )	key:  3		-> KEY_FORWARD
   134		 * 0x08 or 0x09 (   <<   )	key:  4		-> KEY_BACK
   135		 * 0x0a or 0x0b (    +   )	key:  5		-> KEY_VOLUMEUP
   136		 * 0x0c or 0x0d (    -   )	key:  6		-> KEY_VOLUMEDOWN
   137		 * 0x0e or 0x0f (        )	key:  7		-> KEY_RESERVED
   138		 * 0x50 or 0x51 (        )	key:  8		-> KEY_RESERVED
   139		 * 0x52 or 0x53 (        )	key:  9		-> KEY_RESERVED
   140		 * 0x54 or 0x55 (        )	key: 10		-> KEY_RESERVED
   141		 * 0x56 or 0x57 (        )	key: 11		-> KEY_RESERVED
   142		 * 0x58 or 0x59 (        )	key: 12		-> KEY_RESERVED
   143		 * 0x5a or 0x5b (        )	key: 13		-> KEY_RESERVED
   144		 * 0x5c or 0x5d ( middle )	key: 14		-> KEY_ENTER
   145		 * 0x5e or 0x5f (   >"   )	key: 15		-> KEY_PLAYPAUSE
   146		 *
   147		 * Packets starting with 0x5 are part of a two-packets message,
   148		 * we notify the caller by sending a negative value.
   149		 */
   150		int key = (data >> 1) & KEY_MASK;
   151	
   152		if ((data & TWO_PACKETS_MASK))
   153			/* Part of a 2 packets-command */
   154			key = -key;
   155	
   156		return key;
   157	}
   158	
   159	static void key_up(struct hid_device *hid, struct appleir *appleir, int key)
   160	{
   161		input_report_key(appleir->input_dev, key, 0);
   162		input_sync(appleir->input_dev);
   163	}
   164	
   165	static void key_down(struct hid_device *hid, struct appleir *appleir, int key)
   166	{
   167		input_report_key(appleir->input_dev, key, 1);
   168		input_sync(appleir->input_dev);
   169	}
   170	
   171	static void battery_flat(struct appleir *appleir)
   172	{
   173		dev_err(&appleir->input_dev->dev, "possible flat battery?\n");
   174	}
   175	
   176	static void key_up_tick(struct timer_list *t)
   177	{
 > 178		struct appleir *appleir = from_timer(applier, t, key_up_timer);
   179		struct hid_device *hid = appleir->hid;
   180		unsigned long flags;
   181	
   182		spin_lock_irqsave(&appleir->lock, flags);
   183		if (appleir->current_key) {
   184			key_up(hid, appleir, appleir->current_key);
   185			appleir->current_key = 0;
   186		}
   187		spin_unlock_irqrestore(&appleir->lock, flags);
   188	}
   189	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICFqs8FkAAy5jb25maWcAlDxLc+M20vf8CtVkD7uHydgex5nUlg8gCUqISIJDkJLlC8tj
ayaueKT5LDmPf/91N0gRAJtONlW7idCNV6Pf3fT3330/Ey/H/de74+P93dPTX7Mv2932+e64
fZh9fnza/neW6Fmh65lMVP0DIGePu5c/3/354aq9upxd/nB++cPZ2+f7q9ly+7zbPs3i/e7z
45cXWOBxv/vu++9iXaRqDriRqq//6n/e0HTv9/BDFaaumrhWumgTGetEVgNQN3XZ1G2qq1zU
12+2T5+vLt/Cad5eXb7pcUQVL2Bman9ev7l7vv8VT/zung536E7fPmw/25HTzEzHy0SWrWnK
UlfOgU0t4mVdiViOYXneDD9o7zwXZVsVSQuXNm2uiuuLD68hiJvr9xc8QqzzUtTDQhPreGiw
3PlVj1dImbRJLlpEhWvUcjgswcycwJks5vVigM1lISsVt8oIhI8BUTNnB9tKZqJWK9mWWhW1
rMwYbbGWar6oQ7KJTbsQODFu0yQeoNXayLy9iRdzkSStyOa6UvUiH68bi0xFFdwRnj8Tm2D9
hTBtXDZ0wBsOJuKFbDNVwCOrW4dOdCgj66ZsS1nRGqKSIiBkD5J5BL9SVZm6jRdNsZzAK8Vc
8mj2RCqSVSFIDEptjIoyGaCYxpQSXn8CvBZF3S4a2KXM4Z0XcGYOg4gnMsKss2hAudVACXj7
9xfOtAb0AE0enYXEwrS6rFUO5EtAkIGWqphPYSYS2QXJIDKQvAFtKYwo8MCJXrc6TYH012d/
PnyGf+7PTv/4yqQ1eTm1UVNWOpIOH6bqppWiyjbwu82lw0nlvBZASRCHlczM9WU/flInwB8G
FM+7p8dP777uH16etod3/2oKkUvkKymMfPdDoFXgX1ajaVcWVPWxXevKefaoUVkCxJOtvLGn
MJ6iqRfAdEjWVMP/tbUwOBmU7PezOSntp9lhe3z5NqhdIH/dymIF9MCD56CDB0UTV8A2pDkU
sM6bN7DM6cA01tbS1LPHw2y3P+LKjpYU2QoEG1gT5zHDwCe1DgRoCewss3Z+q0oeEgHkggdl
t64KciE3t1MzJvbPbtHwnO7qnMq9agins72GgCd8DX5zy1DSO+t4xUtmCjCiaDKQa21q5Lrr
N//e7Xfb/5yewayFQ1+zMStVxqMB/HdcZ+62oEVALPKPjWwks7FlFxAWXW1aUYNBdFRAuhBF
QgrotFxjJChjliSkRJgt6JlIdAkDjwiaoedxEJjZ4eXT4a/Dcft14PGToQJ5IjlnbBiAzEKv
eYhMUxmTwRJpCkbILMd4qGZBkyE+v0iu5hXpah4cL1ymx5FE50IV/phROYcEpgAUNJBl49LX
gZMiZeiJKOApxaCLre7wlLEpRWVkd6XTsu6pad3UcMyAnpLRDawNRqSOF4kO1byLkojaEV8X
sgKLnaDBzgTawU2cMe9HOnE1sENo9XE90NdFzbgaDrCNKi2SGDZ6HQ38rFYkvzQsXq7RniTW
jyK+rB+/bp8PHGvWKl62YESB95ylCt0ublHH5sQtJ8rDILgGSicqZqXGzlMgZsyDWGDaZJ5I
D6PgNWVT0xw9CV4ZmDFDFCdjRTcEb+VdfXf4bXaEq87udg+zw/HueJjd3d/vX3bHx92X4c4r
VdXWQ4pj3RS1x3IMECkbsjW994DCUiMyCYp7LEEpAWrNIqGJRJ/XY2G6UhU3M8O8WCXBjseN
eyL4CQYZnoZTWcYiu9ODITxC6w3hgnAqeJQTEzgQ65TLeRyRpzFIjQZn+qZuMQpZelQNIVbm
g1V1HCHlA28DIobiwrEOatkFTaMRIvYwnGlcIQW1qtL6+vwndxwfGIIQF35yOsoKYoJla0Qq
wzXee2agAZ/J+kDglCdWPqf8u6KBACYSmSjisbtJPm6EOgqWaQoMg8DLbdOsMZM+LJzx/OKD
Q+F5pZvSuFwBhjCe4Mxs2U3gFCcB7KUc8ylU1bKQOAW1BbZ1rRKKzgaurN0J0zuVKvHO3Q1X
ie+u+NAU+PiWwu5hXgkG3RekcM1ErlQsX8OARSZltT+vrNLpg5FFco9lgC1OQLAy/NILGS8p
GkXlBm44f0h0p8AogkrhBJ34B91a2sw7w8akGM2UlYzBLiTs4hh0bph1kVuAcOSqV87D02+R
w8LWUjqOdpX0TvSwejL2UAeQ7z3DADnN7mTwQKemOmmaOD5Fd6hj6K0wEVPEnucXomEwzVG0
90B7ESwgblCFTtxIzSKB/o1lSaEwJWECz76MTbmE42SixvM4Oq5Mhx9Whzt5G3CjFTC1x+YG
YmB0AdvO22Df0j7432DgsV9Dse62NbRcaADzzCZ3SNGPtJ4TNIxGRmcNeFJwS0/RnzAiCE5P
2Rkn5CWVHP5ui1y5xsKTOpmlYHUmxCh4DV5H4lHQL2FunsIlnPQM/QQ15jxkqV0KGDUvRJY6
skNEpYHhxOjapbxoApe8/pgLUPbMQYVyQkyRrBTcqVvHU7nIYxS0pZyeLmPVfmxUtQzNSySq
Chx/ZgplmBLXTFgxgG3a0A8u4/Ozy96R65K05fb58/75693ufjuTv2934MoJcOpidObAlR3c
IX/F0+G6xA0C4W7tKqf8DUu7VW7nt+TM8axusiYaa/Y+pVkt+UfJRDSxlifPmebRRAQ0ruay
D6j9SQBFG4geWFuB+dXc+/toC1ElECQ4j0L3spm+qlbC88yBT2qZk8lqV+D1pyqm8JGXqEqn
Kgs84Z5MlTALEkZH4uWNjIMx4hBtV3KG+xEUdys3XibCJs6YbX9p8hJitki6ggieNoRIS7kB
5QgqAtNHnhyMVxuCHzweVQlAvYFAo62N0bmfShNA1K5ihZzVFP6MwKlDDkVfFyIJCBq85Agt
pIBM6BTC4eoAtAzzhna0kjULAKPHT7CjEAm2KWe+PE075EAIdaH1MgBith5dfjVvdMNEvAZe
BqPELuYPyIGJblDLtUo3vWcxRgBPr8v0MM40uDobcJUwLidDSanN4IyVnINFKhJbOOkephVl
eNE4424HeCd94MIWa1AHUlhXLoDl6gY4YAAbOkOAhJoYxuumKiAiAhoot7YUKlHmYVDIMRIh
V7SWmNKlGdwizP69yqw6uiRNHrIjkZmTLktXCOVsWIR6Z/RylplsdBXnJVZMwuU7UbGvRsn3
8EnsPJvOnYAluvHKDcPJjYxRcbegU2qXtlPjNHMOHmOZNXNVuOzsDQ75qdMwZovISmTyRtWc
b+3gGnBS9WpiIfBUUJHA/ypdblj95C5FpMuA0f4OEy2HxZ7SYoBLnIDKh7gp8KN9IKf+Qxzg
6yL0xgMMYMwmExV7+jE2XECzlqdeYJ4MHh28yZDRrbJQhGJZPa0wugr5aTKnQeDpdJGnwMcZ
owl1WmDKU3ZFMYb1J/HasgmdLStxWFwD94cVYqPTuk3gCptQVemkwyhljJbfiUl00mRgKtBo
oZON3jpzXWR4NCeUNEbyMjqcppPrMq5ljovQAQJtwNoPf9ZQ1+7es9z0Zao6Cxe1jNBlfFWQ
/BxoCv4My5pYiY4asiI865aY5nIcg5RNXQ87rbqSOJFvKE4gSFOwKbK+FlOtb/hKxgRy71Vy
UcPJyNZgrWtnkutJTYLC6ZZj2OkeyElEpCQmo/DLFhJBS779dHfYPsx+s8HCt+f958cnL8eL
SN3hmIMRtHcrhZ+QDmETGhSQbIcHJVyspWX1+4D4vr0cbdSBLtufpn3O3muyXtVCotxP+PpY
eHXSKEBgDE1dpUZhrcFw6Po8EOlQxm2SFqys8OLUDtgUCGBPDRhdkZX3pLsVTBWfarETdO4x
FZ/H7MBoYavAER8S7JXK4bCgrpJ2iUkGhnS9TqPkeAb+bOOoy8jP62I2zMRGAZd+bKSb/u7z
ZJGZs4OZisbj2H8yr5SrgXsQNjd4lKe0bZ5Q+wdVxngDiWjriE9h2rUxNmY1D10OCKVLcSpq
lnfPx0fslZrVf33bHmy5pYv6MGqknJdIVphj47IHuUm0GVCdJEmquGE8Q/4Rkw6jMbS2lNGw
1VY9M/e/brHBwc0IKG0ToYXWXgKyH09A9SMJuWpkhxKnH6+/9oN9ObtbLxjtply/2e3335wG
BTjtP9jQwVpuIj+y7QFR+pHT0aY4H07TFNTJApJSgjuDojldihC1xsioyp1iM6kJOxkeU68L
1wG2vU0TQNxpCnYKbqlgnxAaFVYHlGlIOLla81NH40NlwLLv8/5+ezjsn2dHYF8qDX7e3h1f
nn1W7juJOMXqRkDYypNKAfGZtNn4AIQ14h6O2QUvMkCMmwvwDmJmGwTmJcm1E2LoLEmVWwZC
NHBIZZFgo9aQT/Y2WcGZWflHYL/mJALqpKzNygmNiigiHzZ/raoCTJy2ecS7Q5a/gRtr63v3
7XicS7SBwHSlDHj7c1/rAsEE6gWXBP3YuO1gjHJiPf6usmBOs1zlp2MMmahVzqrW8ZavFI9D
1KCoCM5jpHVt+8EGXbP8wJvH0vApzxwTb3yvUI7qgXNk+u4CN2/fM0uFJZGuOdGWSq9clOx8
Glab2F+vC+CD3lvsalj5I7kqVN7k5FSnIlfZ5vrq0kWgx4AwODeOTuoK8hg1ykzG3gviSqAm
Lf9zkWwHB+bnpsXgl4mG5d5S1uPUZZLzYjEHmwiCk+cNH0SIDDA2Y4xeqtZKe02ShNguZFb6
++fiJlATPZdR96dxyGkl1eRuvzEN5bEnd6B687KmAJ/j6g680hlwvqg2zNxXppG8+DxAGSAM
twImUrof9LRWJSuN9Scs+UWVXsqCxAmD1GlVl/uqzRoVpzzxdb97PO6fvfDDTdGRqtRrn/ar
/MPV5I7nVxHbfGY1uy3ftDJvsqCdS31YgtsyvK+KgdlBMqevZjhuJXErG5WE5PuRWk6nAsZy
sYHLJknV1mEzvW13x7TpNBjjMtBrrSzialO6UKDfPwGARqUWuWjjFExCZwLwuVw6tmf4C/sj
XQOviEsVQKgYjI1q4P3UEJu1QXWYGj+k23/fzfBVYZdsQeNvrySYXuoTmL+fVWh9/yPENNIL
bG1uxAIp3c85wFkm5yBRnSHGTEgjsbF5e/dwdjZubOa37IGn8+aiaAQHcaiCPUVU7y6x1OMT
0eak+qNLI1094FDtBgK4XHKgFfwfPntI2AGDCoStPW3Z1nou8TlfWWt8vCBS9IbpSu14Wm9X
503YG54oEPQqcRf28wKdJ2C7rYtAznsdYIm20DUmfB2H3xvvLjcJ7oMdTUGGS5MMfLeypguS
ybj0rmCp3aOhHqx9EnX7REh8P9tGtdV4st54ambl7MW0IrLul8Yk3TC4NA4f9lclbrFtlkl1
fXn285WbUhjnX6e0oi1H1Ysy6HqOMwkBM3pF7q3TSgM6IPKWnw1PbkutM1fv30YNF4ffvk/B
8R/i2luT9x81DEa4+7YALl/ynmk/i0qpTpzSsTF9stAXLKciUKCxrCq/xEPdRN4z/B0KFRBp
fJybP1kUG9ZRfOJGiBhsrEbVDNuW0o7aMR0jUKLAoY6MN6NlA/hAaTKo2ODVRhAPYdW7asow
vYxIKNHo+ue9YAyodoGJU6FKrFaYulqj0zZISV3xKSKiz7hrwDsMPDTPhjJVnNtpy2eelrpt
z8/O+MTmbXvx4xnnKt+278/OxqvwuNfvHVtEDumiwpZmR7ix0SD42foNBnaMWhw2mGp0hJQ6
F/wSqMX+xRtDjaPQEwXWqfBDoPPOTLq9deCqknBNaCyaT7VPmH/hWdleDfvNsSdeccBnrgRh
KBrATufpWPjkTRbUccUcLUS0bqd8da3A+3f0l81dwtE5LxLcB3yBLKnbUSM9GbwMjlhimywj
6PjZHSqDMIPUmaApO8jjgPbSbv8Zeo6dciB/jmw5+cc2Gtj/sX2eQTRw92X7dbs7UpIJfcXZ
/hsmTp3k5Oi7uYUUSdDfZz+Z4/i9m4ehdpZFwkt7OYs6jJkDSyZOlnVo0URQJmXpI+OIn/CC
Uaxw9LiDsszBti3lKHVyAgfIU1+AAEiX/n5ey8X6o42enKrZ2P2N3bYN8tI7piSJM6OcvvWF
8QPPrtiGU0r3g04a6Vqg7P70ZapxPq4dtGncd4PM2eSVXSskoN0TIrTU2B2mZlZy1QI7VpVK
pPshpb8SKKXpj2EIQ4TXi0QNTv4mHG3q2jdNNLyC3bkOXAKmYjwh0ay9IhjlbCoJT+s1Q/UU
sQmaOPgWOACrJJsEjg6jypwzWgTz1ev4fex2Yj6vgKf4HgfCxXghd8McN1z0l40bU2uQCZO8
Wn+1y5JyakpweJPwwiGMYUne/tPdYuRKPZVpAEHsU1be0cFDFaqQYxr3dLR69O+orXSYobFi
EvGZGDt3onPdpWkOcZt+BQ2cygY/N8M+qTX48BjU8A019vnSV74DJKkq5ag3rh/v2rP8FRHA
7peUdTrWBI4OVdi1Dkw4FRT17wP/zWoBk6rr4XupWfq8/b+X7e7+r9nh/s4vn/fy6bhCvcTO
9Qq/rcT8aT0BHn84dgKjSE+2RhBGH4DhQk73/v8wCSloxOp/mIL9bvRZxT+foosEQpyCZzR2
BsDQS59ytNg55NM2tcomKD31eYOHw9GDQzxRYXIp7tI8AwxXHcIgD8W92YkjP4ccOXt4fvzd
VnfdE1k6TSkuW74qe+vhBTVlHPcLTNe2Ogv1KhL4aDIB78Cm/StV6EnU8tKWcXJfLdGdDr/e
PW8fHD9xYpPgO+UTxdTD09YXWxV85NyPEdUzcJNZR8PDymXhW0K0R5igMwNerJsyk+MLRS+H
/jazf4OFmW2P9z/8x8mMu2V9tECJqoIyDI7muf3BOYw4ib4qNuGsuIguzjJpP1bglSh4kOi+
RQ3rtMbK9m/5ySP/ZIbX3nSs6XJjjJbHZk66cAO96klcUzfcRwGL2v++G1GRtTJJfycBx8Lz
Kr2a3KWspu9SCqOmPgbp+36HGL0z6vjgIUck28Pjl90a+HyG4HgP/2Fevn3bP8OOXQAF47/u
D8fZ/X53fN4/PUE4NUj+CUXuHr7tH3dHj5uAnEnfbe1doB9/zSISXplSpR4U1Wmnwx+Px/tf
+eP477TGehuEpLXkS61dSyCXa7d/tsZvOafSQ+Q+MOaABx1axnmsRPiberTaWDm+NE6zWc7u
Um/v754fZp+eHx+++J0PGyxb8myQXP108TN/rQ8XZz/zFeQKLpQoLlQglbYxadSfSv65vX85
3n162tJfcppRTe14mL2bya8vT3dB7IzdbXmNXaPDNeGH/xFJh2TiSpUeS1jPTDcTfVF2Wq4M
15qBW3RZoIEC4v3FUISbVP4377kvHm15ekXvr0u3XEROFRGn2B7/2D//hlaQMQ9gp5eSs4BN
obxmSvwNSlbwegn2w69h+DcuJE8sGMc/C4Mpv1xMKFpcuKzBOmYCAtaU36FfqFxsKNYAk52H
eWcX2bbm875vPfEZH0TNc96vW2WiaD+cXZzzVj6R8RQBsizmeV+VE024tch4Ot1c/MhvIUr+
L5OUCz11LCWlxPv8eDn5JKNPsYfrxvx+SYHfqRiNfzeHpzCQXlAHIE9l/P556rNsOFKmiuU0
f+ZlNjmzLSZ6mBZsWbty5axK6W8yuOXKG//r+e6LbeLjSvGW2sGxfM4ZTIRW+KcGzKb1PwuN
PnpGFD/y/IWNNnGJNNPr7g8k+Qpidtweuj9w4Si7vBLJ1KkFr64mWkZNDY5LzjScdvC1wr8q
ZXzipXNkxHOetVU0AtrD97N22+3DYXbczz5tZ9sd2ocHtA2zXMSEMNiEfgQDS+rLpz/rQH8b
zcm+rxWM8sYqXaqJ3mMk+s8ThTihUn5OynsBpRH4EdDkPirlYdm6bopC8gdM8M/RYAWRhQJr
QmiSvSI+YIBQ+LhMvNhQzrvDCNIbsmPUng+T7e+P99tZ4jts9Pe+Hu+74Zkem7DGfnZrG5OY
U8DudV7+P2NP1uQ2jvNf8dNXM1WbjSVf8sM+yJJsK60romyr8+LydJyZrumr0p2d5N8vAVIS
D1D9PeQwAPEmCBAHt8qu7SDnXHcF4pNfxGFmhBVVtahgm9Y53vRgPhGiou0JBSj9Sqv/Ki1k
IAHxJXgchD2pcrveFyli6XrnqzH0eStv9TXdK4N9D7JCJ4Q4Diuw9sR1enQMJaKTY50QYdIg
/cpvz8L0QdaBZCG7LaKO2HIjGZjGLVN8NukFOngUSlMqJSWrVKAxGfmz6mSnGZrF73PqR4OM
LGFMlbMlLM/VAPnuY1XDAgkN8xLGkAhma3rw8clPikiYoG03MVCGv+Lu0BY+S4EZwAWroRkM
DKbku94RT5c3ejhGEwtHY5oU7jvRxw1sQGqIh4ISKjg6YqB7xgdPL14rAoOZ0ZjpECTsLyDY
ynnLCuRKUIOzH+WW6kJYr3qwEa3wcvn+qvCjA/8xyUU6RMwl0Hy/PL0KJWOSXX5pMQRQ9Ca7
4cuSmWONQ+Roo/D0qUvVG2PbOI4XA9EL3Ryufl9vY7OMbhkxLQUpy4FOH56yrKwOON1LctVS
CN5YITOkbZGXKsw/1mX+cftweeUq8l/3L4pyrE7qNh32IAA+JVykFvtXg/Mtfu7A+rLYpiBW
yug118KALbsJuRCJCYjOnj4CBtYfxc7NsTLwDjdrohG0cydBSaqHXedTozMI881GIpQW+Xu0
u+WIhhtTfpaNNCXMubgRUzPED1/KLalD4x2vNt98AZldqEmfc9zgG+nth2svv7y8KNfCKBTi
CrzcQZCHsQBF4HXnzGRtBPC6MHxcbCznO/ocDHBwGWFc+1fNkAbFLgEvdYNl5fFq2fIem4OZ
Rvu2djjkAD5hG38MH90E0/loCSza+FyRcIWvAgkXDN+uD050Np9Pd7QojV2PKCurwOgXVwMM
syrd5lqiCGQLFXhxg/edMW/ifv8IrraO8xFDU2CZGSOcgfMIlmlxNXZ9+PYB7vsu909c2+DU
8uSmbv6wijxaLGgFB9CQNmV8pHN/UQWUWxMio33lz278xVIfMsYaf5FZLD3jnXWuY7Hf1MKb
2ISBH1FTNuDCBLoT+jvq2KTGyFHAekNMdX/q+TlyB6EQ3L/+/aF8+hDBzrS0A3WQymg3U/Rh
yMkJmYjP+X+8uQ1tBvdSXKqQvSOJInM0Ojg/ER3hL5LIJWkUCWCNk1QAOzexU53qxiWVRsqs
zro7urJxH8Qdjd/C2bgz5heHOatgIf+f+Nef8N00ebw+Pn//RZ/HSKavps/oOkwcyQws32Vt
LpvA+/kT4RQxaoxzvBXU00gDXuxZIYIPcrCKcPAOg8bKnwYNOGxSC3A+ZRjmz/bg9GqsZyTY
JBt5n+JP9bEHLATyuRwgO5pddkg2LoaHVejezniU9KXw4+FQpI0jgzXHyhw26vfIu7QEQgNM
N61xuKbHgPhs4NE6ZNDImz4NBr5Hdqp6xXuqikBu1J8ccAE4scqVOyjXgtPQkYWu/5Ar2lvK
rqBQsAMmqKWqHY4gq+idI06uw4dtEKzWy5GqOUuc25UWJfZ3gBeV9kPq3zmfPem62IWsvj3f
PT+oac6KSndyk0Hi2v2hjBsvIJnuxnHf3BE5Es3xlqeOgKHuSzChMgbsIK1mfksLA18MhmWV
EofRekn7BnckByOnnUUQlSfpa0LMTEeUaWHbKhTd+0VQWWDiMaKolN+KQ63ecJHg/lXcRv5x
vbv8eL1OwD8M4j25HIrmEtGIh+vd2/WrKjH0c7NxJPiTeHbzDr4NRvqqneoKUPZyeHJDxVkH
voqMQ82YFMVcvDxXN00UHx0+Vk2IDOOcNHuipSKCH6pQ9+EAxdQKoyNQM8eS64f4mDsuWjni
vKXse4hpwnqXNGqzFDAumPEvedGdAJTfv94pFz/dUZYUjB+M8DzDLDtOfU2bCuOFv2jPcUX6
48WHPL8186Cnm/wcMnqLVPuwaByaANuBV0BEa4xNus2txJldhRFbz3w2n3pqy5MiykoG8e7g
82Ne4w0mieqcZrRBIqxitg6mfpjRdvLMX0+ns0HoEBB/OkC6oW04ZrEgEJu9t1oRcKx6PW0H
zD6PlrOFr/YwZt4yoA1+TQqcbLXwaPSBbaR/AGcS4Xoe0ByPSzUNHzgutFYz6a5Az5yLq2r+
Dg6JIvJNv2UB4YuLFxvWZ9/TIzKEiT6pQKN87R02ullHON/u/nwYuwG4sIBmUIwE52G7DFY2
+XoWtUttmXXwtp3TtyuSIo2bc7DeVwmj+US0WXlTa4mLPPnXn5fXSfr0+vb9xyMmHZX+WW9w
VwgDMHng6iEcA3f3L/Bflcc3cBdCibDKvpc30/hZ+PB2/X6ZbKtdOPl2//3xH3CR+fr8z9PD
8+XrRLzcokQOgOk7hNuWSrsfFMJx7vAp7bFnB1McCJrWYSYXZpBjTvj2pE9wWcCFVLzqFjqe
OiSydHx2yc5wz6J06/gQUOQ3R86G6U84hvxiaOMeXIz6Dw1kBO4xOhLb56R/fukzi7C3y9t1
kg8BIL9FJct/N01i0Ha73VxbPH2mhz6J9g4TbpthJicnMtweOiNNWTlsDJzMcCvsWCAmcVOd
zcUPIZw+XC9c8Hm9cp3++Q63Cd6hf7z/eoU//377+Yb3cn9dH14+3j99e548P01AqEStVE3U
EyfndstbCHHDWl3gDCJv7BQgFy10/bHPocSRzJVZHZA7StVXvo6YuqN6ETXJblKHqVz59p2y
eaMTR6MxRMjVZsxcyo9p2koAkSBC9OzmBUYYrkI5VcetP/7x489v9z914xOOh31BYQr5naL9
aGKiPF7Op1SPBIafQ3srFRTVe67SWHsV7gCUjrwq545VxNgtS0cDloOlT9/S9QLlFzO80CIJ
k2jp0nR6miz1Fu1snCaPV/P3ymnStKXvHbSBHi+lqdNtlozT7KtmtqSP0o7kE+aQGN8DFW/v
+Fw3gbei5SOFxPfGxw5J3pH8WbCae7Q/Vd/aOPKnfC7PZTa+QnvCIjmNq2THkyN5UE+Rpnno
cEIbaNhi8c4QsCxaT5N3pqypcy4cj5Ic0zDwo/adhdhEwTKaTsc3D9+sRtIseXJyLU7en1ui
I2bP4zxf5SF1mMYYVkI/bMGUmw/8PNaDqhAmnckcBUCuNStwEBEGI8W2y0aLnGG/cXnv739N
3i4v139NovgDlzJ/pzgSc0SD7GuBJqVyiSwZeiCbJdbUwcTq85FL+3S23a4yNYy5g0V7RQOC
rkdwrx4aufMRk5W7ncsTEwlYBE5/4A1Cz37TicyvxszDPS7OtFXnNrKXgE6R4t9j64QLAqwv
3oRzcYf/QyC0x796KDxgpwfDClRdyRoerUE7WSlyaAp5GenqRLy3Bifen2uuarq/OGOOCWOC
OTjJIxsYZgezxyWLMcNCCjGOVtcAeyC9p3p0jM9yoLqTDMlFB7SeLl0MuXZvVIjVGIc1VY98
h2BTQuLhulatE4CS16NDqwH4pSpjelMiusptESTqff5fJ//cv/3FsU8f2HY7eeJi7n+vk3t4
gOLb5U5T/bC0cE9bMDqcKlQN/QZElByppYC4z2WdfrY6xicq8rhM4u5biMljzDbpNCzNfOoF
R8Rttz1H5L2/M4fl7sfr2/PjBLk/NST8/DyHsePFSaz9M2scrmGica2raZtcsH/ROBD8yRYi
mdoknHKXtIJ1xidygwEqP1qTUNAez2Jp8UMidSho3diPIR1MEJFHWiBB5CEbme9jOjIdx7RJ
GCNynf3/B7jChedogUDmLrsDIOumpCVfgXZLxhJfBcsVPbtIMCI3C/ytO40wEnDxwRGbC9gR
ebrHjzUP8K3veF+lJ6BFRMSPSNEDfqQBY9I+EuRhzc8ul5kOdkTSROMEafEpnNHKgCAYkeGR
gMvtzj0sCLjO5+I7SCAk+7GZAN7l0g+QAJzr2e3ISqljl0URNnBEe4UIJGTyqSEsZqR4zjyW
jrvkaox/ILIp2T7djAzQmPJYjfERRJ7SYlMWdmRolZYfnp8efpm8xGIg8h6hcpxcYiWOrwGx
ikYGCBYJwenF7BN2YgCPvRYmJt26SdA84b9dHh7+uNz9Pfk4ebj+ebn7RQYVdrIMWQ0gx+49
8Gtx0070LreyiYNWkJMXWF1qMu23/QSWhEsLEBuJgO1v1egBlDY055Nt2wMzwuzErVeSJBNv
tp5Pftvef7+e+J/fqUujbVonEKhCly2RXABl5LiFERdsS0gFhVequidhGEEYIPivJZuGZp6c
LRIe7gP6aDv3pE8vP96cKnRaVAc1FRr85PMeMxMGz0UnOYbnPOoYCEUSDgQaWGQCvAGneuOD
POR8ob0R7va9S/UD5DrqBcBXo4lnHBbDT0HHQGzMoSVG3SBjUZ0kxbn9jzf15+M0t/9ZLQOd
5FN5S3Q2OQLw0QTCGn9Up8HlwyY+uEluN2WovozZQbgArHm7KPBqsQgoU75Bsh5aN2Camw1V
2efGm6KN067vc+N7S8rXsKeIZRxevQwWRJ3ZjajTLhrcNMcKRjdOWGwJ/X0Thcu5w19aJQrm
3uh4ieVJDEuWBzN/RvWJI2YUIg/b1WxBDX0eMQpa1Z7vkQNfJKfGIVH1NGWVFMD3aObQk7Ew
ZwfHjcww2jK3u0w+PDZgXPs6hafwlpwVXtPNhjoYlM/zKiGGu+QMYk4MUpP7XPI4RHsOIdAt
LmpqCLlIys4JpZcNJGHleW1Lfr6JKM9YhXFozLzEVG+MdMpHnHBUUxwgERpWVZZg7zSXY8Tx
BizWK4d/PlJEt2FFutCX4pGlsJBmY+O7DgN/RorvyVhOZyIQZEfWtm0Y2tU4drgcj9si5LJU
xOgmDugDo+OLe/7MIHHjCAnmunIEPgsCGH9xBLhnPFXzzQtYEFR5MG3PZSGWplFsGK+8ufuA
Cps8yWAFWtMv8Js89MhMl/K0mbXTLuWa9S0wotVyPTvvcRDdvYq82SqYnatT3RelE+Scfy6m
ROeq0BVeKgh2le+wq0o0+G0lSeUIDleomjRr5EHg7AgSxgkkLa+JxjZZyM5cyCLdhCRJiiGM
TeKb0wyPfvLeSrSFbZtPa3PYECjbbFqppRB1gpxvTWI39jYJHdYIgY9yb7q2xSLx8h28amfP
uUXaHIYpd1bUVGy58L3AvToOQpw0BcRoGyxWcwt8yuWE240H3DHd1BQzk22+CaYLaAm51XD6
6xKeBgC3spLOVSRo43A9Xc76TavhTvxk92BDW/MV2XJtGLfZbN6apBJssjUdySpKixQ0aQ4u
2QezuigPZ1M9w62GMJm5Xmac8B0LAR/8f5uQ2CNxffSXnJmJ1ePeKEi3XHR0ZisFeqWgB1Nd
ns5p96n95ftXdGJKP5YT0/Sju2UTLuQGBf48p8F07ptA/je6sj3q4KgJ/GjlTU0412gM4VXC
o5Q+6QU6SzccbdZdhyfNNoJA6Zs1VhrH5eYbzuLbOhr9MKywGVadQq4mPzyIoeyHYRfmiRyw
vpAOdi4YVzOIQnqCbE5+x3Veb3pDW4d7oi0/WIk8D39dvl/u3iCrkukj2zSaPHp0ZbhZc3bW
3Crqrsz36gJKD2h/sVRHN8xUm5Nmj8akJdAHsoPRbZSFsUNiz8s2FJ5vmSMDB1KwHGJtaQIw
q5qnh4V0pALo0OedI3tP+aV0vDyTOnyvi/M+zuijqDjvHC7IGBJ/xgdXKC4u0ExLL9FrL7AM
lAfYjtpTEfz3jQDIyL3v95cHO+ZJTjBmpI/Uo0AiAn8xJYG8gqpOMMC9Cz2m6UQ4h7YvO9QW
5p90RVCIOIiV2msUaiPUV0a0WtUwHhWRtGHtag95EqgEeVJwMXKj884OWdTnAwbZzylsDc9Y
5ckYSfdgGd3wPCwgNU5tuCEoFCFmQjwfoYp3OoLJGkxXeX124a1OoKC3j9oz5rCXqTPNHHY8
tUqHwU6tqvGDgNIyVKJMS5esDWFqHXA9ijMbd7kQBzaYpUVeoeenD/Alp8adhY4wtheP+J6r
KDNvOjXPpx7jMLYKEpjOLG2oWANJoSd3U4DK5jFL/cQojV8iWRQVbUU0l0XeMmWrdmQO5DH/
qQl30HKiEEkxvkzTbbtslzbvaVPOtlt+pp9l6UbZdWR9AsKDi4sAjm9csa88q6l15ZI5OJIv
ar7YsBn2+A7Iru6xOea/OGOCrO3pLo3KzGXyl4uGs6Ev3mzhbho+pnpQBFZ+VpzR80Q5SPC3
9kxlZY9TVWm3v/tjl9dmIJGBSdankE6cC65FnCVKMCxCuYoJ76ActTeKFAy8fKw+VYIoYR0Q
b+ltIQOvXiZLTQBLt5rsD8ATRLfHJX1DKFoA6mq53RKjuz/J90CUAelAIg94WsKhS2BR1KEQ
8E4eAT6qeQBUMD7uSlVfKfUWRyOwv56tl/TtGtzK8SVnG1ek89WdWw7thShVNQKPGkh1N59O
pxR0rqoeUe3PlbCi/BSquZC5GmEtNshchnDIOgOSat8ReD+QmrOw2Il3ZUSi9mFLRDt90BCQ
MsFOTahNBnHaFhBuEPGyi0alHFIk+i2Wii8Ox9J1FQ50hSMGF3BYrRPb1ewkiGr66hFwRz5O
4KzTUoa/fjya2exLpUY6mRjzmsDC0zcFfOMYL3zyydfjpvmpkN0KhteX3sH46W0bDv2IsBeq
+bBgNvBuXL4WPvAIPxLvblGLDZGQNF+zmHFgfmj7uMcfD2/3Lw/Xn3xLQTswAQTVGH44bYQG
y4vMsqTYJVahiNeYXA/PD7RY0VFkTTSfTal47Y6iisL1Yu7ZlQrETxtRJzsbmGdtVGWx2UqZ
z83M8KxQ4FV8b2TkQxU+/Pn8/f7tr8dXY6CyXQlZqB9NYBVtKWCoFtpfyEDE1KuZc3nCG8Hh
7sTLWp8wvmFGO+b0+CXtfdTjHd5LiM/j1YI2A0p04DkSSiL7CRye6oh0edwIZO6wKnAkuJnQ
hwvyNC42R46HdHGWwal/7R4zjl/OaC8ViV4v3Svd5YUjcZypWcwBHUscE8yinAjwA27y6/Xt
+jj5A5LZybxLvz3yRfPwa3J9/OP69ev16+SjpPrAdQcI3vldX8URMCtqP8cJS3cFBhiO+teY
tA7fICBL8uRIibaAk01QIDdJXqmv4gGsRGusDuM7i/TfRVwbjraovpmR9iOc4pxro3pVQg/o
9nHykwsoT1wN46iPYsdevl5e3tw7NU5LsPgdHEZBJMkK96qV2Svew58zuL519KsuN2WzPXz5
ci6FqKrgmhAMukdrGJu0uDXNhNqSrsD7W6RDxz6Xb3+Jg0aOi7JCzTGRjNp1rgkT81kkW9Vb
C5n4DUgWqhlSepAMQLaXOOT4cDo2DSTAwN8hoe23RFod12tbgBN5/frrM84R8ssrrKfB9d12
dcGoDdRuNbUXoK2I6eCHeEo++wxIfoRtQlXtYfKlKa7vZMpdH4CjME4K9WFF0aFu81tdPY2k
DuJIPccnAvnq16tEvqDRZPlqes6yyqwNlF9algNsKVax+RFnEK7wwQE90gu4jY72aaU3kUVe
wA+QqdGXFlKimJMkeIqj+C+3xee8Ou8+C7m/XxZdHhq5PozVwP8Yjl04bmVZQQ5bVxYCoGmy
ZOm3U6M3cldppYl9BdqNc/AEiXypjcObunRcyNFPgO1V5Zr/0ERjYdZiqeGvOoAf7iFNgJZ6
G8Kq9iF15V1VmhTPf9r7VMhmFeuKtsVn+IzrppDZ+MbQ+xRUBs8Hm7VJ3BiDV8hMv4++aX+C
Q+vl7fm7LVQ2FW/4893fJiLBLN6Tan8LIefgM+jM/f/2PIHgcs7b+UH3FXO58tMPS3399zAM
0Dpe1rCIIN2ito1FAkEta5L8CC5/5X7qOy4YrMPXBYuCpyuYUbx0xjWg6EA2HdQikZXt8fLy
wkUlrMKyVuB3EBxs8CvRCYvxCnAeV9QeE14Up7DaWJ+AjcD1xbaBf6aeZptWe0mKaBpdLWdA
/zx1SN+IzG6LFvOWuArNk+KL568UcyZCOUs8VAYQng3VHx5D8LENFtSNIiJ1aavia/aDnCiw
Yo9M1nblBUFrd7YJVu7euhSRDjnz9ACNXgjHhlx/vvCtY4g3Mk+m5VBqEhRU/iJluU7NEQao
31pLCDVkUqCVaHAbaY3CmiqN/ABt82JLbGO7S1p76/RLWYTW8G7i9WLl5aejc91rhzuCpIyv
76msClYzu3cAXixplU1MEvg9utHobTMNqLuHAb/2zCYKjxWrNRy8Xs9tJswlhfcWxIi+LAay
CRwiiZj97JyWI2sVkwdyTcOV6li48sTRzBVxJAazjMNjmmW2LwnIH6MLhPNKbzknGa9njWMe
zWYBmWxVdCZlJauttdbWoTefzqy2gY7yzvAPygpR58nrRAvvwz/38npmkLH6kk6elNXRubmk
x3Egipk/X1N91EkCZe2pGO+kpWUeUKQcIFvOHi7/vZqNllIbPIdKt0bKbMKIb38JrZxSDFun
CLR+qAjMOC9fUqAo/kfZtTW3jSvpv+KnrZnaORWS4PVhHyiSkhiTEkNSspwXlY/tOeNax0rZ
ztlkf/12A7zg0qBnH+LY/TUuxKXRABrdLrMlDS0pPGarafxxTZlr/UzGPkwc2xJHpEW/whE7
9PdEsUsDceEo5j4i9HF6JIOncQxjz6ux12ayTZ3SWfDXPlW8hUocVZ95SeDZyhjS0tqsxCeU
g7/JtnRV1hY8tgG3B513XiIZiQ3xow9NU92aXyHo9vjYeSoYJVE3qGNpnk0xnOfxLGwfcfTL
+tFAFjnJFxUY1MMedHbIHtToPk78gD5wHJnEiCO+QWFQpLOCUKd2I0NVbEB7PTIqsRYzeEBx
E7bB9l11VKLVFy+yukAZa5UmtO32yADrjRsp934a4lFFc8y2Lo7VLrsGM1jkgYzixKFEyMiB
6oysO490/Sx2znGXbixjYcqzz1iouj436+X6QRRRJQjzm/3AFAaUpiTlw+3fzfpD7/lucLIA
iUOVjJAXRAvlIUfEAjLXIE4cE+jqFfPJ7xzMrqnixnGwSQ+bQog3n5wVoz3cQpXbHqalVOPt
TS0bePM/MXa7nL0gDueSsA02FvedcHVBmNQNXjPziLnKOiEhvkv5bVAYpJV7pteuoz6iUiFa
JVd5qLGkciTWAhitK0s8CegHiwX00cmlfIwCwGyAbwdcCxB69EcAFH1UQZ+72jQTd1lk85M2
8lzHfWEzOR1ZXOdDnnVau8HWXHL0GuGLqq7O6NquXIvHtpkFDQaX8u9PDdHAeRd6DlUm+oD1
KJk3MRRVBeKgphKXwTVsyKiLjalVIhcUybVZIX7K4K03FBKwKOhMYHwNJB6f6qm6bCub5Uz0
HnT9A4bMJnLcVIEbd+SnAeQ5FgvgiQc0VdoEccI9olB+yJLuTGRbbkOXEfOmXNWpbKMk0Zvi
RPYMlMHF4eIHlEHgLM0svNzBgU+U3McRVe7nzKfN7wQMs6N1PcrDMcbJSmVriQngywg5uzlE
7gwlDlhOifmAgOcGFsAjuo0Dvi1FSH0SB0jRjzqC7RRD5gkdy5GNwuQmC03AOUJiZUIgiUg6
AzWOaAL0aRyyxAL4pPjmEKlrKhz2iiSk2KqzhjmLcqvPwsAnMi12a89d1ZmuUcyrSXY6EZ1Z
h4wcg/Xi2gSwLRltCzrB5PQCOn0WOjNY3KdIDJReLcHUEK9jon+qmu4boC/JAIAZmVngMaLD
OOBTU5gDRG2bLI4YNSER8D2yYXd9Jg52St15l86Y9TCbyD5FKIqW5yvwwFaStlGQeRJnSdnk
Z9GJIlkayxvoKclNTS863ban5CCQaa0VAPZzoSDAMzqhaTSkqxp14UaM7J8CFn/tyJLi8Vxy
1yhxhDeeQ1ev7jI/qpdEysiSELJRYCtGCTJQTYLwdBpiepCFI4dH7akUDhaSifu+i8h961y5
GoQwKetcL85jeuPSuQ41MgCIYi+mdXWAog82HNAH8QcqeblLPWdpUUOGE6347FLmfbAwROQW
r9/W2eJC1deN6xBdz+mkROAI9QhRYvDp4YjI4mccyxSDxw7qmZEe4DAOl7TTY+96Lln2sY89
tlT2TQyKuJtTaRFK3KUdCufwCFWdA2Q7cmRZsAJLFcWBJR67yhXuSBOimQem4nZtqQhgxZaO
kj1x8TNJ4/TBZqQ4zYysKReOLOcd3rXjutRA5QtYKoVKHQhoOthuih0+GR2Of3Fbl96e6+6/
HJ1ZjeY1UjEwHDqqQCdqDbXQjIyDL+LzZo+egYvmfFOqvkgoxnVatuKFG/npVBIeYLprtPDE
i0mGQ38R5dfyXmdMZ68Vwbj4nciANmL8x4dl/s3P+rufg+GlhzQ0ziP7LnHkxXHdFl8WeeZx
hj4eSsuuk3t8XS4LfR94iyxDzLx9ds77juKcpxqwMt85ocXN6zflJa2cG7L8jRKbbLvIJd9d
EHwD1/iUSbqkGijai8CJvNvfpLf7g3ITNYHipdaZX80UO5ye5LXsyD4a+vAWuLl7v//r4fIv
0wnYLHH263759dXgrOJjHm+ZRxgFEBwDPu/aphaUpPNNnkI9c8rSZrgektp9SjU8S1wo9WtZ
tnh/SJU5GHMuJc9vyJS432WnxYK5BxQqbZp9OaBDP/pj0/yYwmCFkQq4kqwqa3zkoKdTGCJQ
9ywZ81O8uNCz7ZrAdRxQqKi70G6FcQ37JvPI1i8O7X6sKpG6XEWQM5Y32yOv6rSTjAJvUoyx
olWpDJnjFN3K+qVlgZq4FYVvsdWoB83WWw8FSsShlvMtRLPUtcJmR/2yDrTw4Wvnu1Xcq7pM
z3x3tDR36IjPmnMF0R+oeeIeZTTGMvoSMBatIvE9ZOOgxmmZZYPKpFYAqHEUmcRkJM6PCNNs
+1WrKwyfooE9EyMnwq5MHGbvx12ZRY4bW6qLj3FTzx0qNloe/eOfd2+PD7NcxMBJqgvTrGyy
RTEGGTZENKlDt/owc+ChM1eFdfP6+P707fHy4/1qcwF5/XKR77EmSd+ABCnrYn/gig+5dkgs
so60o+MBfpSswTfAxPKlVoTn/jGXllkH07nZd125qqZoTd3l5en+7ap7en66v7xcre7u//v7
892LFFcMUqlZdPwRg5prVvJYCFLuJqrYbgN55TNuJbZqy3xDvgvAwspKeSiNtCFuFaTlD/2l
QpX8VTZL/gOTahi8yuqU+BYka0ziq9F1P8k94XLdZgC0L+r2F/G58kbSscroWDarydCmMpv5
ZaOT3vlJ5p8/Xu7RjtoMaT7O9HWuKVZIGY0+JAGEVO7wDh1EZ/Jr8RnaVlmeqTlxH4iOfF7M
qaMtp7LsYz6nxnNOFk9YvK7iwY7cdhLZ7g9R4uksLpaRB1WxwLO88xgZ5DuricYMmiuHo+Q0
xUAVKXhhd1KPaSTyQjVGDuV5LwLbMvRBcDcYPnq2Bejx7VZXZkxvN6G6fzmk7fX0TI5snKrJ
rNbciNnMm+dC0IWJ3b+1xmd7VIdsn9PdV5gf+5x2Tgkcutkv0oSvR61HBDHQOmW2YVGpURTG
IUVNmEGNE0fPoA/x7FOp1KS1z6zF15NwVqePcCRavld6IKdkj1qyPraabB3AaKUPinmiBdNd
jved8WJJYwicpfwxPf3Yj8PXsRPrlW53QR+SXoAR7Uo/Ck+aiwMO1IF6djgR7QOds1zfxjAE
qDuadHUKHIcQmaNXXLH49vXT/euFh4N+HRZibj1ejv6yiXd2yDC86JPzHV82SLS+PKc1YwFs
y7tM8zSNeNWwxKeO+YfEVa0MCzRYcp2A7nJh1k6fpnEo0mT7aAdPUD1XmxNYl9Ea3yQHYaB/
2ejS0vZts429mQzoCwvLxKK4wEDkpnK9iBHDq6pZwJhRVr0wsmwPUvjaZz58kMgLVR85tNeg
XGp0fkRH+uFfVgd4Xv9Lp6kPgQQ1ThL6dcsE2zpleOHwy6SZo108e5ibeXKKKldo9pRqDzow
86zLEzoQ21d9SiqjMyf6oTkIx0XdQXleN/Pg6SM/fFzkMhabGULVKlYHtgrqxrYmUx6wJCbz
3sF/DZ31qIh90FpLr2ykdte0IA1hdBUA80hBorG4VMbrdBewQDZ4nDHdplVypcvVocUiBcsx
YGR3lV2VMMfSXQDCrt6lbaNnNpATIfuo4VFmWy4GNSZqWZJZ4kh9u6Vi5PstlSWwfC7xQsrk
6TMmghdQGaD9cEQ/G5q5Rv1rsRxkCuRFRoHi0E+sUEh29Kyz0VWKk4A2StC4ImrdVXg0NVLH
ZGVSw2KHnHPjZkBdoVQ8iulsAYoTOlfQV9XbTxXzPvjQUd0lkuuqLMWyPnwtXNL2TmI6xrFD
dyeHYjuU0NBNTZFHndQAQGkIXGgKupVQpfBYSJsbqWyB49Eas84WLU9fU/nSMJeRnS2pZ7ai
PUsANY0NVKjlRTbr24qqwvQQkkIUpSArMm2sI2W378t1Kb+WaTNNTweCCGIz/z24nJddB5et
crxQtpx0Rj7SP3d73hVTRlrKNgtGhE7aZqGUdKZ/PmYkvdvvbi1ldenudr9cGl7VNmS+NWg0
16ucxE71nEYeH9mZiG00KnNFXqb8hZPwaTYfSX17fHi6u7q/vBLRjUSqLK3Rl+acWEFByan2
sPk42hjQ3WQPapydA4O47SVw1mVFrfN2BK1fhiPOkjtC6hAa6HvuoqIiO+dY5gV2nhSpSJCO
fiXNWEFL86MeVFUAQtetyx0KrXS3KTqdoz/sZJUVcz+vb3bKqzXOuTqs8cqWoB5rfqNOIPlx
ZVI9ba7O9Lqo901HIUYRkPM4l+edKV4lDK53qMtFSIKOFdM8bXqc4W4oQ/ntLq3LTDSW1Ewc
K9DFW1dkeFN/rvZdh1GRp1HMB7B5kso7+YBH2+qov3n85/3dN9PTJLKKTsmqVA7TpQFKyKpf
MtOmE27fJFIdCLcw8rXJueuPTkj6t+W5VLG8hk4Zn1fF7gtFz9CxKwk0ZerqhQso77POId+8
zjxFv687Ojn6eWwscf9mrs8F3lh//oir8hwnWGWUJcDMdQ0lZj1dm+v9rsyoTdrMUqdtRzVR
3Sb4JCilsN1N7JDtuj8GbmIBmE/XkUPn5IO2gJ2s51CatsISMVnx1CDX0uNd4TvUzkvi2CUY
jzOmshYY2RqwBJanlRX5TCLwI1CdVesgvffSuWgbO52Leo6m88QLlQk/aDj44QaWhvuSqNtV
DaJUGIVFuK+hkqNZHXWUpLC4LrMVj1KIfCUs8Rx2TXUgZ04fyo/3JfoeFgC6xH5/aDRn/BTX
MQ4YHU1jZDlmjuYQRcJAFNCvoGaeU9kKn8IlGdZi4vuasZM25pubTC8XSNZH4yNOrhnDogJS
WpvOX1sW+ifjA6E7b4qV9nky7nn8rEBYlL3cPV/+ddUfuZcMY7UTZTfHFlBDoRnIk/2VZFEh
w7A2W+wuFC5smnJNDXTBuM2BVf5WQYbEx1KPNarx8AEeOoOhumlVx9vg08PTv57e754/aIv0
4MTyHJapQu37RUKyN/ihR08e06LgKQAksTbGyCJ0Ny19X4dUXNv8g+9DHQoAVX3DAaMprRO5
XGEApDozU6TKMaqUgCs7SpUN8MytL27J7tSZ6WtjicuJLA9PR55D3Z/pe5KRIzuRjVInykI3
lwnbmKNJPzaRo772kxGP1pFGlk0TNx0VnWRk2O2PIBHP6iQdwb6n6Xnfg0p1MIF9Axs5l+jV
deLI164qfQzURnxik/VHP/Bo09+pOjeea3lBNHUFaHft5vbcU3J//qxj4FLDb92WsjfZqfZf
QfeOiGYrsu2u7NKpWc2es9eWt/l5dcg3lhCIM5N2PiFbronvaY/WHFZe5g2mHY3ldhbZ0k48
8JA2Nn+gGPjtTpF8vy/JvaL2YnmVk6nkdneASAk1YKqAm3w1bfO6vIL9+Og4VzEoExs23EPa
N/tQncn3HRUDepCh6bo4Z1lpaf59Nhxp0AuLj8Evag/+jSVY+bjPFoJJ6iGitgOK5xIEKi6s
xUnM48NVXWefOjStkJpMGkcI4UCSzun4Ycq0y5YPfMUxS+lHDnlqOcG6YqfTplrrgHCkbGZQ
t8qywQd/t1JPr3jpdQqqWZpbbmyHGm7TlhKZEqqpU9dFsVPEFxLbFMXajrJZ4VVOE8fVW7Uv
0iAKfbPeXZpGkRNS/kHGlOswVq7oOFncZY8TuH/8efd2Vb68vb/++MZ9jiIe/7xa18P5xtVv
XX/FLTN/N07puAokxcniWd5fvn1DczOR+vIdjc8MCYA6h+8aIqA/Tn6UxyF727RF12Gc9nrw
ACyPxTLdQRfm8io507maJB3Y3L3cPz0/373+mn2Zv/94gf//gNZ7ebvgL0/ePfz1/emPqz9f
Ly/vjy8Pb7+bIqM7rGAGcCf/XVEVmf2UMO37NNvq6lrZDnZbk4/H4uX+8sCr8vA4/jZUirtM
vXB/1389Pn+H/9DL+uSLNv3x8HSRUn1/vYDInRJ+e/qpSb2xqdMDbT814Hka+eq9xgQkMekN
ZcALDOod6KeDgi67NRDkumuYr+7LhyHSMebQL7lHhoD51F3kDFfMS416VEfmOWmZeUw/qzwf
8tRlvrH83NRxFAUUVX7pP5zWNl7U1Y0xtPmx/apfnwXGO6TNu6nj9BkC8zsM4nhkPT49PF6s
zGl+jFz5fk+QV33sJmbLApl0vTShYWgmuu4c16PtP4aOrOLwGIUhdZY0fVLkusYIEGRi79If
m4AOvyzhgZFfj1qwY3Rif+PFqoO7kZ7QfrQkODR7+cSEjw6pd3C63SmzkejUyI2MsQHSMIh9
LbfHl4U8ZCVTIsfGIOUjIzLaSJBJbuYb44iTE5N8HceEDN92sedMH5PdfXt8vRtkmU0h3B+9
0CdkANID6pHzCKPfDL0CexiFdGZRSDqiGLq0C0OPGB91n9SaHxIdPzrqEejQI63DnCZj5u55
/Xz39pfUFlKvP30D+f3vR1yLJzGvn1I0OXwfsxidyDyx6b+UrxafRFmwUn9/haUCrcMtZaEU
igJv2xkZdXl7xVdPdTWqn97uH5/xmcEF48uo65U+87ZdxBamXh14wrXJEOtTrIY/8JEI1Pjt
cn++F4NLLOdjFdBmWitYWZLHCzBRoR9v75dvT//7iHsYoQ2Q/Bito6lk8z8JgyUx9mR7AgNU
TCRV0AXUtaJJrDoRUmCuG1Ij0+SyZlJ3pUOe0itMsLs/WT4BsdDy7RxjVswLQyvmMtdW5S+9
Sx+zyEyn8WKBzOKUBQ5pWqIyqdHelBqeKshBdsFlolFvQTPf72LH1i7pyXNlTxTmeJF9Ucjo
OnM0SWSg9DGDwWYx3jZrQp2eyGyFvQnXGax6tuaN47bDk0dLE/YH2Cw5lmnTlZ4bRDRW9onL
LCO5hXXL1mWnijluu6bRL7Wbu9BsvqeJlbfHKzyxXo9biUlKohnE2zsoDHevD1e/vd29g8x8
en/8fd51qGepXb9y4kRSNgdiaJxO4R1L4vwkiK7JGYI6ZrICVTuxw/F80k4ooYvyjgmvHtRH
3fOoD/959f74CovMO4aTtX5e3p6u1dxHwZh5ea5VsBymh3J6Ve/i2CcNI2d0qimQ/tH9nWYH
xcx39XbjRI9prdEzVzsX/VpB56juaGYypdTwrwu2rrJLGrvPi2Oz9x2q9z1znPCOpsaJY7R6
7MTM7ApHWJSpR464sJHLD6LHonNPqqsSnmiYhbnrLJymCy7R+rQomitA7Q9EHqk5O0SWIUWM
qF529Prj6LOYUPNCO1h1bDcAMF2MDqtXcZjqFRItzrWCabz2V79ZZ5JawwZUBlsVOHjSPwq+
1Vu63BC4/YSaD1ryAnWY3NoUrkJf+II2vtnXhMzu1JuDHOZaYByi47RiAaVM8joM90va5Yt8
7aTklvPH9Q59qysxUO+xBjhxHGP0DB9JvZPgZ+vrxHG12VdkpIhnoTFecw/Wr5ag+m6hkdu+
8mLmUERNiHFpq0kefgVwXhcq9WvuwhKJllP7XP9ucekEScyLRBja2bBYWMUwypJYF4qiLT1y
GOnSWYjFaJxPad9BmbvL6/tfVynsIJ7u714+XV9eH+9ervp5kn3K+BKW90drzWB8wl7XmFD7
NkDHUZZuRtRlxgheZTULXPssrDZ5zxh5kC7Bxso40EN6uyg4oI+tEgPntqOtKOkhDjyPop1z
/cZyoB/9SusTzNidZFzZ5ctCTk6a6N0O8y2mZavndEoR6rr/H/+vcvsM3wZPSt54CS4lhY3p
869hH/mpqSpdOAPpg0UPL5odq/yWeKSdcZGNQcrGQ4WrPy+vQs3RawDSmCWn28+2UbRbbT3t
XhZojd7gnKaNAHwM4+uXupyoukmcyTZxjdtpfQo3WmnVpos3lV5VJOqaatqvQFnVxR1IijAM
fhoVO3mBE9ivSfnOxKM3j6MMZ1rdt/v20LFULyrtsn2/cJO9LapiZ4rM/nJ5fsNQadDXj8+X
71cvj/9jVawPdX0rRDVPu3m9+/4XPkadDa+nItMNtZodNylGbJZuMASBW9ZumgO3qp0PdgDs
bso+2xbtnrpcyFvpcgf+ONclRmXslHeLSM8bkBynMew0ndPgx76uz11RrfFqVM37uu6GeMwm
fb0aoV8ytF5BabOTLgrcH4tWGCfDSiPD1T7Nz7AtzInbKsT7Xvv2DYYtRI8RREWwjgo2XRUN
B8NX/8fYk3Q3jvP4V/y+U/ehZ2zLkuWZNwdqsaWKthIlL3XRS1e5qvI6iTNZXn+ZXz8AKckk
Bab60F0xAHEnCIAEcJncBymfy5TdIKLoYnuP4Wm28Oj8EgNJcayE/WnjW6RdoKtZZMu9jmiW
R7BApibIsJr9Jm+twks13Fb9jilIv9/9eHu+xRtDjW1BWUXZ7mPW2pu8WVBXQYja7+LcHIR9
ftht7R3b5cy1ycOAbiMLF8dOc8sjDVzrO7ZbflBumNbAKLrPsPwsfalDVmPQLHzWYPbp89He
qqAME/K9AI5FWjeYwK9q9dVZMUyI+z6cdS9P97fvs+r28XxvrDVB2GX7iBMFTAynV0xaFGWG
edfn680X9Rn7leRTlHZZA+dhHs9d/YC/VsBy3ha7Los2WjoWpWmA3K3ctUMh4f8Mnw2H3X5/
XMy3c2dVfFwR92InUR9QkiQ+Y3QpwgMn+7yYL+oFP6pGrAkRn6+cZpHFFqK0qfG9M4i367W/
2es0MvaOzlTkdyNGm9lrYILg+e7bj7MxydLpBipjxXGtvd4RjLjNA8H8Ixaa6xIXRhcXNqck
sTHiHcNsJBioN6qO6Mq4i7vAd+d7p9sezBKRN1VN4awsnnWyq8iduor73pLUTMVjEhzE1PeW
xkwBcDPXn/sKBl7yJA1YJzxc1x59GyoI067ZViv6LWDPYPFSzV0YEzsiHEefueuenwLxXY+O
YHVY7Vqz+UnKU/hfYHvqiBNx5Fvy5ZfoVHHSju8e0B/hQUph5qBSfm6mmDqumHYuDwhYy64/
ObQyXCAnS8Mwq2vNikiErpIXbM+3D+fZn2/fv2M+a/POcRuowsZwVouTm6gBBIUwjzD3wnVG
toF0NtRSegEwiuihBZQIQAmKLPvgrRlWBf9t0yyr0fXk3UCEZXWClrIJIs3ZLg6ytDHag7ga
RJYqPcYZuhF1wamhQiAAHT9xumZEkDUjwlZzVZd4iQfbuMGfbZGzqooxUkVMuc1gr8s6TncF
cIooZYVRXFA2SY+hvw7gH/JLaFqTxR9+K3qOfmhq56J4G9c1tFhPaovkwOcwk7FlonOGkYlI
l0hsJwtvsnSX6EOMH/SSnt6KJs3E6MLu2JGL++ft87e/b5/PVORWXABCorA1tcppmx5+eAri
2qLmAJrp7o0IAWYKI0wLP2KJ8saKhBG15BLdCusPbbvAXbgirSwo3O/0xVpWeATVaoobnMtF
JONv6Z0pYO2m1krrdG/FpesVfSbhUoz9uWtJTiEWjjXRJ1Zql7Vx9JvTYmktmVmewOMA0OZ1
xLC9ES5Fw6bWVbW3j1wRl8AvUiuTvDnV9DtMwDmRRWDHKssyKkvafwvRDRzx1o42IA7F9oVr
PP3U94+1UJDT87SwsVozKpWA8bC199CmcuCSC0BhOTYrm8YCJB8kkxMTJqLeGA3KY5Quy9y6
BNC8tiR9SpHP1aAM8ySOG22/sbbsbhYb3WKqwG3spkdPBk3oFpZB5miQXk+GeU3eWY98ucvC
aOrXjUDpiisd3nVMttrO58vVstFTHAhUzkEC2m3JTLGCoNk77vzzXi8ReOlmuTxOgY4qqiKw
icrlKtdh+91uuXKWbKWDh0fUKrMTvfViz8mpoRcNlGqV1hLQchxvs92pD+P63sLKvtlOxyE5
+g6Zf/E68Mb4jp9fKfoA4h9P3xCSa4KRoT2IYkW+uQ8LrXJ/s1p0hyyO6JZxBgqbLUPqQDTN
eTBtSlT5mi+2gVqTKBFeSPUoNlAbElP5rppF84qZRmpTpqBS/V6U0vbucr7OKgoXRN5C34hK
r+rwGBYWh7sd45iVzvZAjJaahJqkrvByR58pvGwLTeAXslMCSsAkKkWSKjeY8OOafrap42LX
JFpw6zSq2YFodJsYuTihIGJJS5v+0/kr3idgcyaBBvBDtkKnIrM4FoZtU7aWUJySom6pNShw
lWapGUFpbQC56qArIC3I9ZkxRnF2kxYmrCmrbrs124324prS7yQyhV8nvSSQ5TgzGxaKVzmT
wqvlwvLwSaCli4GlcpjLXVnUmLhCUbEHGHblXSWP0bS81VuFHgKqT4OElQbgy01sdHEX50Fa
Gytvt62NopIya2Ll+Yz8PWnZrvF8xxgvqFKsFgN6MhZBG6LpJ9SBB5bJUHNqHadams01aIqJ
AAyQ7tyHoOaQFgmposmWFhx0oMYsOwuHtNYqMJ7ssywuyj3NBwQa+of7yUogxNa8bDktDkmS
0xaOMErIEugUww+X28ZsWl4WwEti2+rP26xJiVkqmtQE1OlOB4EMo60MAFWgo8Fmy8paGyMF
3JGZz8W3cQFDUEx6UMUNy06Fja1UsH1BBjDaIYGGMUbFjIeEdcQHykyP5EHTxBGtsahEoC7b
+pCxQlhbQ4PzVXWas6MOq1F0Npd8XYYha3QYcDA5QVpreiOypSVcY4XCrcTc6iIBLoYbMGpr
4jjjcNzERh+uMRe0doAGY2nDro7jAjR+jdWOQPsC4jmrm0/lyaxNhdu/btK9wTSBAfF4utmb
BFgFFbJAIuuWNzmIFnowKxVub0OLZ3tXccdkhhMOf0jT3odZAR5T2EE66Etcl3rEiwEi51Xr
2ZdTBAe4xQ4gRlhkwOqSlrLiipM6q8YHEcJBlpJ30B2REFaqlN5nPblxT6tVEVwAWj1fXi9f
L2SaIeE1Gdgi8gjOq16Cks1G67lstqR7fD3fz1Dt1anHOmW4cSDAryw1l0mY6kZEPQLTRFUU
zuUyi6EGA0kX6mG8S8JIw+hkMi2A+l1RAM8N466ID0O4tdGvUfO2wLG++ltqIzvkoUBRObXc
UAo6LSaWbUgaLU1ND+oOCTCz7KPSkSrIBFvnjblGJ5Rbbos6grwczTa7XVyLrCA4AQ/6eil0
wEELvDBAujBgW7MvI2IaYuW6pC8vr3hhjW9u7vGOgV7Qobc+zuc449aeHnF9JdZQVHGPVrfi
CK/xTgGGsWtsQWUEWdPg2uEgY+sLT2JxwVGFJ4rFwLYQju1yMU+qvoEKJuXVYuEdJ2tdIBxv
Of1iC1MOhfVfaM3BJMeY0uCjYSyJYdQI2o/HmWf+YkFVPiKg6TbPbUmjSgbC3dvHB0abNTV9
h49bkxwY9RW2AtN82JkwWnO4fVshXkQQQNWZXNh9prPw/vblxcamWWhbECAMFcaxKnob2cMj
NflU+S3g3PyvmYw/VNZohf52fsLHTej3xUOezv58e50F2Q3yw45Hs4fb98G14vb+5TL78zx7
PJ+/nb/9NxR61kpKzvdP4nXcA8afvHv8ftGPvZ7OYPISaEavUVGo/6Isdw0tKgHCSbzKLeWx
hm1ZYI7XgN6CRBWSoQ1VqpRH6G9prtseC38zG3cYaHgU1fMN3UTEqTG3VdynNq94Uja2ulnG
2sgWJW8gKovY0G5U7A2r1cw8KmoIDQBjGAb013EBAxB4S3euF9EyTQZKH25/3D3+oAM05lHo
z43vhS5nSO4AT6vOko9IfCR2YFRPonlJRMlt0yTwO4bxXyasURzaGLK+LrPpjq7ub19hrT/M
dvdv51l2+371kszFbgde8nD5pqSEEgVipsGyyE56p6ND6JhNR1jXZmSWmhFvZogaEbJPdmEE
af5p5+QJPIQx0adQFCTPORNabq8PlMzKaZORONeTFGTh2M6I8Zhbe1PPXxx0bN/UpieWJefr
5XQng8ZG5O/EonT5z8Ku4zz1bMHtALf0zK6zqG1IG6FszZ7HBg+s09I1o61k8a5sdNOMAJsC
wbCLw9M69CbrKzyJRKH2cY7sNhkhVTRR2sUZoxUm0Vk0cEYwXxmjL0llOBoO/+x39gnPbEd5
UzMQ3vdpUPdJLNTWlwdWw+AZYyQeshqCGo8beXJv02PTqtF05XJDO4l4KKVAT0B3NFdT/EWM
y9G2IlCchH+X7sKMsJlwUAzgD8dVXVdVzMqbT2KRiqiHMLbCE/kD3SBMWMlvdCvYuM6rn+8v
d19v7yULozdPlWivcQoZxao7hnFKv+YWXBVZ3T5oyWzNLNmLmIDKI6UBJJO8BadBsTJHWYi5
9uCnJC+X0A8ymphE+FyHfGcyJeT6euqR2HE0Zh/+Z0lgh0O0aPMuaLdbvGVZKq3pGZNIg0Lx
ZzFx5+e7p5/nZ5i6q7akz9sg+LdROBmRGqGWDg7itaE+H9lyPQljme8/KAiRjqGN8KIyglYP
UChHqEWGvolNWepNCYBSdko/rsgjComNjICCO+WR6zqevfEgPC2Xa6PmHthFOTMLFCiffigg
hry8oR9ZC96xW86t4UvlopEZgw3BQTghTFTBLA1AuK1KjpcBGgbOZN5lhmFkWG8TUhKa410y
KctvJ7tB/mmDXivQ+dWANrQhmqgMYnvo6pGq+CdFxf+QCINU8Q+kq5G2LiLLYx69yNimiIwk
9kEfSbYwrzC7Vqwe/NVAJh/YHxWydk8/MDLIemWV5luXv8XL0Xs8aN5FZJ/m/en8R0gJWc2p
imGro15qFQ/iSBisLCOIEjTwWHVYDurpexAmAY2rHaQRga4RkOli5c8pN4Jc93atDjWPP4Mg
mFMspsdOgp/kYRdkZXhDgIZ4+r5i3sfAcy2r6cWIX5qigVRRRCBCGYvwHxjcsBxbUGTE8SjR
TV0j0J7McKQw01ZOi8iabU6XDjoGqxkn7zZ1qmaz0EdUovpE6nTpW/zXoTk6Uh0CTu8aMe7p
Nu84Jbsidng2ZrSpIkaxTsMy6UKajyBJGKwtvq2I3YukG/QaFPgWHbX1drQ8CU1IlKQeKItz
s4HDy/2PJjpvqBiP14E+xoVqVc7jnDeptgV6iJGF9/xweX7nr3df/6KYx/hRW3AMIgrKUJtT
JoQckzNPdh0fIZPK/smWGSoX6yC3zN5A9EmYPYrOsbiEjYQ1yEJED/ACA033ylsyNOTL3BcE
rBPX6dpbHsQFNSo7BSqNyQH1hmIXT9/xACk13KIExh3PyLFnVBHmnrOk3PSvaFcLLiTg4u0Z
+Y5uxCqa0wD01ICDAiiTaxlDUoVs4zomaQ81ckELlP5US9aGaUFXBNA1y80q1xUJxXLtKmXE
qf7AV6AzHRIAe7Qhpcf7LqknDVj5Gk7/SHTakq10JPDIPHcCPeSebFjT8sn6ili4WK743Cef
bIriD7kx1tcslfqoBNFSS9kme9U47sZcCJMUbfKSK2SY8suEZqG7Wag+WLKISfa4cd3pfs6S
esg8bOvlTRMtvc1y8mHKncU2cxabDyagpzGeBxsbU5jh/7y/e/zrt4WMF13vAoGHb94e0ceV
eAY3++16xf/7ZGsHaG+gBWSBl8l0bV3G3J6T/hZpuPYDuiPN892PH5opQr2bnK6t4dKySXNd
8qTJSuBySUmLTRohSPD0K3WNKm+ok14jSWIQ04JY1W81/NV/xRymgSKsKKlTI+mZlaUr/VU1
kVzh7ukVI3K8zF7lsF/XSXF+/X53/4q+0MKLePYbzs7r7fOP8+vv9OQIyxxP48LWVRmx29rO
isHCIHrKwhCOpjQARbhRLOgxsBUQ8Eq8Xedh3QYGishFhnCigroJUXdWbpoAAOxj5fkLv8eM
ZSBOHKZEQVHOru8JJrBRihnLUnB7+moc7xMm7nYA7OJipznQIWxMtgsneBFneiOEwK1DSu2m
Hi/XagYyyy6yXIhueQZDmFP3T/3DD0B6K7XQHl6yxlboZzgRUQ+F9uS7nDKGXCmU5h+wB2Yy
wh6q7qSB0JBTe2zC296mM452eH+HYbu1OA78VIDEe+xsfQA4qW8BPGi305Ddojy0NV6bzg8C
qk1IeyTM6D0SwzhoTwAr4Vyu/0SfXbEH5ga4LkXtrg6Wkh+cY5xr9gaJFf6WA+5f/1KUY0vQ
63qMq38tSrrGD+O9v3t+xeC+U6myd6GnZ61HBhgzQn0U1MNFnp7rSPTQPFflOQU4OKNOnwJ9
fb68XL6/zpL3p/PzH/vZj7czKADEs6fkVMWWRBAShUnlK5vzF0hNsJdpC/XR95QEA9bUkFUu
WeG1g4OmqRtBRmiVVmquz6Qu83isSDtlJa4EGQ3tUJQeha9wO8wfKiOLqLtvQGUVxXcHLCzH
Rju+BAJTZ6KVh3y1OhBmN/hgAZbBTaskIU3YPkYclBzDFlCWch9hH3DDNIcyun54fwENT3iC
/n15/kud3es3hMPJlQrQCY9ooUEpYshW/Cs6kSD3V0Q8dR2X9tLTqRZ0bBKdaE2bExSiMArj
9fyXbUeyzZLO66aSibA/IN/8irA4/pIENIhfkhxp7q2SpKFD61YK0T6ke5YceJUWaDyYHARy
dfHL2/PX8/SyDQqN902X+ktX0VEBGmTRCL0eC02OLDylhVjY20IUBq72C4K8aemujhRNTt9c
xHlPwBuL8YelWVBS2mIKw9ia2Tx350cMGTcTyFl1CyKmiBPHiZBKeSTLmAxxfX64vJ4xVwN1
nsj0R8Bopm+j6qeHlx/KN9JbCAh/4+8vr+eHWQnc4efd0++zF9SdvkNDI52YPdxffgCYX0Kz
nOD5cvvt6+WBwt39R36k4J/fbu8x54eBu85PWxzTjtdkDjnMjNMocl4ljo1tHX8ehRz5c7a7
QMGPF3Uh9ig4Jva9hRqUhijOWaHGm1SI4GzDA4MZtlSNBJ8scGDItOSkUKKuyCsWUmeMViII
3yBWDBa6oT+Rua2uXe/iPWolV/3g2IRCcBAFxP9+BR1neKhHGPUkeceisPvEQsqm2VP0BiLz
w14ILhpntaHSRPRkcDIsVu5asU1cEY7jukTJg4HCXmjd+Ju1wyZl8tx19ay2PWK4xLcXCRTh
cHZrttqyVtQzLZ1XiuKauPHWCHpYp742Q/DNNt0KpA7uFUWUCWRZGlb+ueXkN3q18CfahGuO
C3gkUa7ikYgPj8MpNibxw5eWVspVN4TI/Pr1fH9+vjyczaRZQc4WZA5PQCxV7+QAdFJ3LvTh
jIb2SXAojHHJEDHbpXXEnAUtUoA6U0eW01/i6Ny4AkeG7hHj2PQtdNgxNWZvxKEjwkd46J2J
vznySMvVIgBISTZSYtETgsaGn24WRhj3YeWDzOBoVylsvdK3aw8yizewcooUoOfpxfor1awM
gI3rLoZnFWplCKcrAowaJl9E5Hc1gLdUX6fykOkxlnlz42uRuREQMHcMntknLcVwin04T+Cu
wFL1xGcsghNmB0p/FGeNwp5YtNaSGODvjRalQEBoyRhQqzXFYQGx1nPwIGRDjZFAOFoDZMaI
6++NbpZHiMV0G2Ks4fkCjw7LXtvgDt1VjHyPEmXFEr9VuHexj7OyQmW1iUPNPJ6k/spRZi45
rtVgWGnBlsejXlrWhMuVmitDANScNwKw0XNdwDE1tyQuQtxiQeeBECjfLMnxyC3FjhtPbX0e
Vs5SD3KBoBUZiSyPi+7Lwvf1zhasXfv6kdekSDL3F/TsDGgyEPeAXPG5HoxVIhbLhUNdd/XY
ud9nfTQ+8vncnYK9BfeWngGGAhbupGK+3rjU8Euk7/m++UkOssXRukIx8FoWrtwVfSTst95i
bn484FI4XYMSeH8/Eb2w/HQPQrRxBrLIdzxt50rsz/ODeKbY56rRPmkyBgd40nvoWfYf98l4
Rin7rL9G23/xN8r1j5ASevOELJ9P+CxBM+lAcvetb/sMyHtjg+JfhzYoPtagpLDjvBo+pD4C
tNIuVE3Nk3EkSFpDuoJDU6+QxmmnkYHrh6I3oLw9virqyxjEGfN3iaNA4//KlLtzj8p9DghH
Pfjwtz/XOa67WtLM212ttNMDfm+03+5miZcuavSBHmrU4G4cyncZMfOV9rG3XNX6cCHb9PSA
5EhnsfoAau1Sd6OI8IzDD5NXWkjVty5wKDlz7RjzfT3aT1SVTWdciFyZq7d0LJYQ4M3uggo8
gwhf54XAo1driyEIcRuSf0umIgNfSr9T2Drf3h4e3o3EVNvn8/++nR+/vs/4++Prz/PL3f/h
fWYU8T5UuGJ8EUaG29fL839Gdxha/M+3PiruOEAbed0u35b+vH05/5HBh+dvs+xyeZr9BiVi
HPOhxhelRn1Zb+EYtif4/vH+fHn5enk6z15GnjZ+mvKF9/+VPVlz4ziP7/srUvO0DzszvnL4
oR9kibbV1hWJcpy8qDJpf92p6SRdOWpn/v0CICXxAN29VT2VMQBRFA9cBIHJlbX2ETSdO8tf
AUOrCbEzNv98lBzqZnFutbbKN9NA2s+8aucT0E94tVXzhM1tXQZ0c0KFVXdCM5p7Kjdzo+Dd
9nj//f2bIQJ66Ov7WX3/fjzLX54f3+2RXIvFwlr+BLBi6dGqngR1FUQNeem3H0+PXx7f/zWm
zPBIzeZ8puStNDWYLUp9W4PZymbGsrGtbO191KSXkwm/jRA185dbCqv9HQ/6n473bx+vqv7d
B4yTt94WE2+9La4sqzOdXni/tegwVhFBGzaob5cfLixVdI9L64KWlu0xsVD8qjMoOBGVNflF
0hxCcFbk9TivPRwOOgBmoaNLQ4UvPH799s4ukRjWeJRxBzdR8hkMobm5UKJsjuVUrQ1fJc1y
zi5VQi3tkJ7Vdnp5zu9oRLG+hjifz6ZmCRkEmMFR8HtuVgGB3xd2bQyEXAROI0xdSWcAq1kH
8aaaRRUs6GgyMbw/g77SZLPlxLYibFwgZyMhpzNun35uIlDWzbLOVT2xwrH6N3jxZrJ20g4C
41gs+ByfZSXnE5u6ghfPJnOnWqCxs6fTRWDTy918znpUZNzMF1NDPyHA5cz/GglDcm7WEiTA
lQ1YnNtVA9vmfHo144Je9nGR2aXp9iLPLiaXduHQ7MLxdamz1vuvz8d35Rtj5OLuanlpqlz4
21p60W6yXLKKvvaB5dGmsNnVAA7wGZPCDdCNNrBjWcGRx/PzmZkzXXMYaoaXgn0fTqEZIdlP
4zaPz68Wc25HaFTgA10q9ZH/NRSe+/H9+I/lsiFjpR1qLafPD98fn705I1wfxXX2+5mqX/f9
5floJQqBtra1PmZSDtOAhkFXCuq2koa31WpGIjvJyrLiGrI9urfNuuGoLAXtx8s7yMrH0VHb
y/NmapeYBHV3YXJMBTDLJIKGq6puGgBnQ8kqQ03jp72BYbSDUrK8Wrol35TqihVoQeIz+2hV
TS4muZHSapVXM1vW42/Xi0wwTzb27HwV1WYCnsoaoyqbTs/d367uoKG87gDIud1Gc267hui3
3WcNsx2qAJtfevuLLsvyUFZXUBirZXm+sPNzbqvZ5ILbc3dVBELVMFA1wH5TDzR2JOkWz3il
ntMvmvlyfs4shJd/Hp9QbcXbNl+okuQDsyyyNIlqzMgjur0pJ+q1rTA3h+U5K9qQcqirLo9P
P9DQYlcgbJE07+gGchmXrXNLPM8Oy8lFIFRB5tVkwvl2CWF5KCVsdDYEmhAzKwtIIfnkHvtc
dPwtVitWGX4otmKe0CNQndJvsxivId5wJ7VI1Z+iOQ9joN1a8gENiM+qpgnevBgJwrlmkIZC
uq8sMUpfA+PJHnnV13hJf/z0CMu6YGaj6NAV9aepwWurKN4FRg92j5B4ACfrMstIeTYO6REX
ye0lf46k8CtRZyl//VwRpPmB904rNOadS69PEVTx9CpQklJR5KIJZAxT+CptJJbf4NMjKpqm
jNdV4P67ppB5wAWj8RgHEBximerQbHOCFerutjj1/VJs6qhbVTlXvWqdx+MSgB/dOtoJjPqy
gCBj96mZvhSBNzWyGIFRGLlNPkaOKca1vT1rPv56o/CLkXnozK76XnovneK825VFRFfsbRT8
wJifbnZV5HSj3tpmJhKf5fcSUMWwUejmO7ePAE/hqerSvv1uA+G/WwICzA6OnVLEBLxzbC2P
rRBk+BmIjEQMLN9hII+veEGa2P6TcpL4Od7qyGJectsWCfrtMz+eNXr+8vry+MXQKIqkLlMr
xZMGdasUmwFewF6HSFfFPklzI8Nfn3yoyu3iUkWCKN6YZbN0JZFxW7rYY3NjlK20f6ib1Gb3
EdiUbR0L7ho+RzYE+LPOCoz8sLMZ97DAFA7oTeCxRnIJUQd03rRGsMPwLmlZMAM8dL0TWZOx
e+EX3sixEtESMN/AFMdiMXFtpAGrw8rjPctNHKrK0awGvLoFzyB16SXTFtRN4doLZQ/SzVV4
OULpIXW/Z9ZNyoX4rht2v2EqWXj6MD5v2E7s7cQWz9o2l8sZF0aPWDeICGEYp+ztxvXj6xNV
KvEin0Ri6TjwsyvZBJxDqR7YJTlxnPF4QGRZV68CBeLiZBXxlxtTTCfWpas1ZlYp2Po/N128
3gxqEwM16gMN7W7KcpOJocfsu8U6VTwkwiUf1Q1j5snj19f7s//0Y+ccKDx+B62V5I5p+cUg
zEV3g6l81WUUo9sNxiOazFoc5MzKiKAB3SGSsvbBmK8B1kRsJUTokY2IWxCb3A0AIJl3ZriT
BlgNOqi+OQuzcFtZhFtZnGhFFHF9W9lFHvtHgjgnAdznVWKYIPjLpcCsCCuaEOO+jkhhqjEH
gSXKBjAQx7wIGUgwNBTY4pqLezOadyfRRLETaRKcmMzPqvNP5m9mBj6zo49QdxyRUEYyxfvD
1qAc6E2c53XdzJwBBBWVYJx7TNZ9lw157I5EQGxrMpoWkkUbd1h84rotuiYqgI5yG4T75IyE
AkYNzIIRAVqkmf7cUZzMvAVEIBxGfgz0E8OasJ8LjYND408nYdTYMN2xNlOwXbrwlxafRWzv
ORwfUz8KbXQMz7Zf3sN0ToqyYkckBRaNeFVdq5dgoBPiVd7bAN7mD+OENH5JuESBWAWIMOrG
qTloUfCR67aU1nVEAmBGH8qxRZ7HNR+PTKlOND2Io0J9j9NQSLm6Xuey21tuQAXiDsOpqVga
s4P5L9eNzbXXLZZOMABxa0Y4YIXdLLq1KEYYMKkkxSp1HfwZ32MQoC5/GG7M3D98O9p10Rpi
yH74TvI72Hp/JvuEJOsoWA1toVxeXEz4/dUma6vH+LvIhgtaSdn8uY7kn4V0Wh9mXlqP5w08
4bCs/Tq4uSM53JzFSpt4fevTYn45cBDpsQsChSadkPVN3/nq7fjx5QX0EKbjJIsclxKCdgFt
lpD73L4LSUD0AJhLh4D4JZjPObXS5xEq3qZZUguDYexEXZjKjOfs2rYb2C+rdaAWgMJ27uW3
fpXSH28gc1AiVS6220aKnJse2KSgj+1MKoO7Z/aPIancb49vL1dX58vfp7+Z6H5+u8XcciRa
uMs571WyiS65I0aL5MoOv3BwvB/CIfqFd1zaAzBiLiZBzDSImQUxhrPfwSzCX3nBn2o6RJyz
1yFZBt+xnP/08eWJiVgGPG820WL50y5eLuyhA4aHC7C7shiH+ch0Fji7d6k4DzfSRE2cpva0
9G+d8uCZOw49govNNfGBjzvnX3PBU1/y1MvAJ8z5Vswzbwt+7o70rkyvOv6UcEDzZi+i8TI5
CDU291SPj0Um09jup4KDStHWJYOpS1DWo8L+BsLc1mmWca1tIpGZNYQGeC3MtNk9OI0xbWvi
TjWhijZwndD64jSQ9bUnkm2942siIkUr11e99NsdX5+P38++3T/8/fj8dZR8sgZ1C48a1lm0
adx7gj9eH5/f/1anWU/Ht6/+xXpSy3Z0O9G880t+PCxJlIm9yAZpMMhyfavdp1gYhghef9ft
JyKU27Yv98Bnc4hfnn6AwP/9/fHpeAZK1MPfb/Q1Dwr+yhWbUPlGA5apKKIVfBlqoEBYgQ4X
SbMmgcbnbSOVRWEo3XWUqyc/XU2Xxt2nRtZpBUwED7YCCaxqESXUcNQEUicWoH4m2MCqZOOe
iIeVN4V5M8vPrLqF9+Atrb7rzqA0yrpBdSGPZKDWlEukBguTcXNKHw1KVaqk+5ZbGI+09hGe
lQYML939En3CNyLa0d2yuDK8sVTyCjWo+poFDvqmmrZPk3+MQzWTzk9gbfUBdTaRfbLSpZ0l
x78+vn61dhtNgjhIrARmGomqFcRihoXYH/gB1S8w3XH+DAXfAkPalEUoy4FqtS4xe7+XudCi
KVdo0jZ+lzQChiZb/0oLVArA/eQeR3EpTQiLemcIV8ctrdoQHtYELAlgSa1eYSyVPaqfpoPy
nbWrntSYLwKjm8LcOpgCQS+HXOQZLEh/0HrMiUlRC79teP1d0exzv+l9Dv8izyx0aeqVOwYA
rDbE/s2jZl3pR5Po8rrukzxYXUwFDpoa/h8NJNdACvtU1HVZa4fJKFH1alf7GHZgxQ8wjRFa
y+usvGHYlIlmBoNaok/E+fB43QA8/SimwzTMNv1zbAUBXdmia4ObEYVPC9ftTinSd4Fcm8O8
gGVqnAD7v6BhECttDvpPB4yDGaMtCH0/CAp51hlG4X/8UJJye//81b4MX64lOpTaargSx45T
nWgq5VjDHQ7zkltHHgbVibYUCizbAtOXNxYrUOx7QNFrYMw/TWcTW5OoIpA0BmEVyH0VpEVZ
1IKIGJu9uQbRBgIuKXkmqx4DSVjyvjsLPzRvIfvPGcBUAsnPa6XArs5io4lfccFE9KxiO6JI
XLVFLRfsyE6ISrndVIQUXvIYhNzZf7/9eHzGix9v/3P29PF+/OcI/3N8f/jjjz+M9GVa8EjQ
kKQ4CI/l9wk9PJ4ykDvr+OZG4YAnlzd4DBVkfuRF9eRrVQOj6D2k3ME5YEDRMx+hhnA0T75K
PWSB+9xpmRCV/yW6D11UpYNQ5eaLXg87BWsoqEILA/scB0M/bwSX4fyStj/2ihQzGBFM3CpE
AqugBnulZITLTgnKE2JLU4CmCvKtCYsg+G+PwQ6NpwtgRTVPJUpZcLPxu9hLFjZNHFHENXxj
AUbf6NEE7cHS05xlgWgmqM0c+/FgChQRzM7Rg0fdHRDmI9x5F5CgwINJgtnoN/1sauL7ubPa
Fddh/6feH9daQ6573dgZN3W6AEopHuSyKZ+gY1tgipmSrFL0wWSGxctJdaXhjiOa82TsmirX
sJBONc6bxULiYfRPH+htj+CZTZRmTRZZIUAIU5o1sRD2/USTRztMgXzd8lNNNBRErSbZfcUa
92+gdau7g/XGEmcwT0V8K0suCARPbAyG4BeAJC1n3RbqRURUh7CbOqq2PE1vm68dvsMgu5tU
bjHixVX4NDonBZ4WRZ04JOhzp32DlGRKeo3AtjdTpah0Zbo11fSIVC+MbSmEQGTOTI5L1UNe
AwAukiaCSvtN58sFJYFEvZhnpJgzskoDroz645m8GPL49m4ZldkuMYOsSH+k6pSNVVOS4Bo0
akbjGgCJEWRPKwm2m8PvyGIHpaUbccO7tNFlA5X0u1iYwsnWerfikLRsEKTqvKxxCrYiwxqg
3tM7wMuS3ztEQL4kLiiHsKtUYlSJPV5tmybO0Nagfm8luQtsWoQ7oGyXuw3i1ovL6tbr/qpa
h7t+MghHDQ4dPIXxbdiFpgc3krAbd+KWZyhEZJl9LBmYTsEaScqKpoqBGCaGV0zSQFRvE2Eu
LLag/WiAbRKLQ+PvUyZTu0KDiyIa0jvhWkVEdhMB79CERdkVbcb5fAhvPuu3zPvoiCzK0k2B
dtkJmsCLDascoyy7tCFhdGM6IHGTxFJTGLu1DGEw4aXWyMj4aS3VVER1dqu9sFxYH2bLlLhp
ncSwI8I17m+MYIikbGEf9eWnbIMjW62zlnLnD59AmexkbYWD0XrAaL2AKIMPp5VPJU66yeFq
MhpTLg7Gccrj1O4Za0zZ2KIEE37u4ehlZkDpiBB8PYuB4sRuHWjwrazapxUFs4um2arVPvKu
o6HL7/e4CodTlLBxc1zp5L2wIktU44641Qp6Pto15rDgUtG6TMWfAlUt7CySH+HwWdOPDPbM
DQVDm68BJXiAs2/ZtHjPiCNR+UGODx+veLfHOwNBnmlpuqpCNbpeAIUyi63NhrXaweSip83Y
URWYozGc40jcdskWJkHU5Bk3YwV0aBOoEqKh2wW05y1PQTgkrket3e1FlwUK6BFKLxReSge2
qwF6RK6jx24BVemmCpxvgcVCoUUq4JvrqpJW2BrWAVYqgckEGTQFqX767c+3vx6f//x4O75i
2dDfvx2//zi+/ubunnEko9hcyDYWszL3qxgsDTKlzJAgnMgh93L8+u+P95ezByza+/J6pl5s
5CQlYhjZTWSmDbfAMx9uub4NoE+6ynZxWm3NcXIx/kPbyGTBBtAnrU0+MMJYQqPooNP1YE+i
UO93VeVTA9BvAWu1Md1pIg+W+B8t4mTrTi0G2kUbpk8aPjP3gEa1DXvz1n4QqyHQiQQ5gbzm
N+vp7CpvMw+BigML5HpS0d9wX/DYBczYVngt0h9/3eUBeNTKrShiD27bBz0x3ktxN3T/3Vkr
NA7FRr+zoo/3b3hn9+H+/fjlTDw/4E4DHn32v4/v386it7eXh0dCJffv996Oi+OcGZxNoEZd
/9A2gn+zSVVmt9P5hIsP0pSNuE73zGraRiA69/0nrChlDnKkN7+DK3/oYumPTsysFBGvPFhG
QXHuWljF3lQc7HO/fmuJ2xuw+T0Bub1/+xb6AlUjwOEieeR/14Hrx15R9te0wQD231DH81nM
9FYh1P2b8CQRFbPMAQpDk+FWczsFSDmdJOmae0xhQo9ubFOxnwK9lPy50QjSlC4WPhNKOJid
KURDU1h2IsO/4bGo8wS4i88mAWyGso3g2fkFB57PfOpmG029viKwa5pGzDkUtK6RTGPn01kY
Oe3yFTMIus2cMxbtlvNVoEOBrjDLDxDzU3xEbuopW2ms58HVuZkpxVxAHS2urkjV4u6vQ8VU
rdbfg5HwuQPArNzVBlivNf+LENm/M9zvqGhXKfPCOvbXKqhNN3aNPgcx1vByOzNQqO6e5Nhg
IGRZyl0CcyjGfRZqAwcBxiDaH/4fLx4fmjFPuc9g/JD6ao+9AM5nEgQ1euTzKyC44KGnHksE
JwMAOu9EIn7h89c/0TJ22+guSrh9GmVNNGNTJ1kEwQ/WItofKo0Y17grsUXib3xRV1ZKcxsO
XEjMwg0qGmOYT5DMQh8kha+oypuStk4AHlpDPTrQGxvdzW+i2yCN9VFD0B2mRLGy/Q0LZ41H
E75Ocld633u18EVyduf3FmDbQT+o75+/vDydFR9Pfx1f+xyEqiceJyuatIurmj337ftbryi9
beu9lTCsDqMwnOFEGE51Q4QH/JxKKWr0pTjWtGFJ0IEBvuvUFhwIG21D/RJxHYgdc+nQ2gwP
IEkqDEzwrUhfC1VXSRO7QKiPI1l2Cg9Sl2EoSIGJPuIoyoc1QOctDX+eZzwXh2qmjCTXeH9l
e7U8/yf+aXNIG88PgZwXLuHF7Jfo+pfv+YME7vW/SAod+DmlqvDEua2b2zwX6Iki3xX5I/9l
kFW7yjRN065sssP5ZNnFAt1CKYbc6svGI0G1i5vLIa54wKptj5kZ/0Pm4RtVbHx7/PqsEuZQ
TLB1nKbutpjuudrycPr4xirOpfHiIPES/thj3uFWFklU3/70bauMajI18hcoaMdR1MTonSI3
3m5vuP31IU56F7kH9UDGTvV+W6JSUpcNxksmaVR0mdhEceAaaVrgh/lnbjq70l+v96//nr2+
fLw/PpsWYx2lyUVXXRt5KlJZCyxqZkU/jOdAI547uqTPM2MU+6QmjayLuLrt1jUlDTHXkkmS
iSKALYTsWpmaN596FN7DxzM7dazo46s4dS+x96gg2Ngy+NV4/TDOq0O8VRFBtVg7FHhQtEY9
UudMSG1/OFipwNVSNqMH4KaWkRN3vq0LnZJtZzlwHCMarWfD42/DYauL1e2V06URE1IqiSSq
b5wt5VCsAmfsgOXV7vjS7EmWrpTjgKc1rOPDQRvz40lim+BpBU4BOhyBf+pJZJcnxluxwwTa
Dz1vH3chFDNouPA7zI4KYtZWrgjqqVygazEtI5RrGbQrlhp0Lh7O96+RyUj+ZIEN+gFxuEOw
Mcz0Wzv9xqMjBaX8PWzaG02QOkUyNTiqeU43ouW2Zf0EmqIBOeN3chV/Zl4WjJHvP77b3KVW
yOCAyO6sSpwj4nAXoDeU5FW8tX7Q7Zz+6G/EWOEcpnhuyjgFJkrcto6sIBrKxGGeJSsQHsB2
FhejM+vcuvmNwS4F5pB0YmMtAippyQfPxlWbY2xuuV5TJJPBX6q2q63XJ9cm/89KK2wAf5+6
xFBkdgKKOLvrZGR6Vcs6sdNNJQmbW7O+Rlee0ZW8Sq0quJjFCZP+NOr0dFQpMC42S7neNZi9
ygzFG1g/YMjHzKAw41NnnTKNQRIq3UpHZ+9O0g8a50RUpcGlGh02M+phdZqLroBto2J0hmcp
dsdgc/8Hdww3ShnRAQA=

--X1bOJ3K7DJ5YkBrT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
