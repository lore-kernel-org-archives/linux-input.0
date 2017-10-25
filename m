From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers/hid: Convert timers to use timer_setup()
Date: Wed, 25 Oct 2017 23:33:41 +0800
Message-ID: <201710252301.r0P7VSxv%fengguang.wu@intel.com>
References: <1508866222-15063-1-git-send-email-allen.pais@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1508866222-15063-1-git-send-email-allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Allen Pais <allen.pais-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Allen,

[auto build test ERROR on v4.14-rc6]
[cannot apply to hid/for-next next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Allen-Pais/drivers-hid-Convert-timers-to-use-timer_setup/20171025-230118
config: i386-randconfig-x008-201743 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/ioport.h:12:0,
                    from include/linux/device.h:16,
                    from drivers//hid/hid-multitouch.c:41:
   drivers//hid/hid-multitouch.c: In function 'mt_expired_timeout':
>> include/linux/kernel.h:928:51: error: 'struct hid_device' has no member named 'release_timer'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
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
>> drivers//hid/hid-multitouch.c:1251:28: note: in expansion of macro 'from_timer'
     struct hid_device *hdev = from_timer(hdev, t, release_timer);
                               ^~~~~~~~~~
   In file included from include/linux/compiler.h:58:0,
                    from include/linux/ioport.h:12,
                    from include/linux/device.h:16,
                    from drivers//hid/hid-multitouch.c:41:
>> include/linux/compiler-gcc.h:165:2: error: 'struct hid_device' has no member named 'release_timer'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:931:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   include/linux/timer.h:183:2: note: in expansion of macro 'container_of'
     container_of(callback_timer, typeof(*var), timer_fieldname)
     ^~~~~~~~~~~~
>> drivers//hid/hid-multitouch.c:1251:28: note: in expansion of macro 'from_timer'
     struct hid_device *hdev = from_timer(hdev, t, release_timer);
                               ^~~~~~~~~~
--
   In file included from include/linux/ioport.h:12:0,
                    from include/linux/device.h:16,
                    from drivers/hid/hid-multitouch.c:41:
   drivers/hid/hid-multitouch.c: In function 'mt_expired_timeout':
>> include/linux/kernel.h:928:51: error: 'struct hid_device' has no member named 'release_timer'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
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
   drivers/hid/hid-multitouch.c:1251:28: note: in expansion of macro 'from_timer'
     struct hid_device *hdev = from_timer(hdev, t, release_timer);
                               ^~~~~~~~~~
   In file included from include/linux/compiler.h:58:0,
                    from include/linux/ioport.h:12,
                    from include/linux/device.h:16,
                    from drivers/hid/hid-multitouch.c:41:
>> include/linux/compiler-gcc.h:165:2: error: 'struct hid_device' has no member named 'release_timer'
     __builtin_offsetof(a, b)
     ^
   include/linux/stddef.h:16:32: note: in expansion of macro '__compiler_offsetof'
    #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
                                   ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:931:21: note: in expansion of macro 'offsetof'
     ((type *)(__mptr - offsetof(type, member))); })
                        ^~~~~~~~
   include/linux/timer.h:183:2: note: in expansion of macro 'container_of'
     container_of(callback_timer, typeof(*var), timer_fieldname)
     ^~~~~~~~~~~~
   drivers/hid/hid-multitouch.c:1251:28: note: in expansion of macro 'from_timer'
     struct hid_device *hdev = from_timer(hdev, t, release_timer);
                               ^~~~~~~~~~

vim +928 include/linux/kernel.h

^1da177e4 Linus Torvalds 2005-04-16  909  
91f68b735 Wu Fengguang   2009-01-07  910  
e8c97af0c Randy Dunlap   2017-10-13  911  /**
e8c97af0c Randy Dunlap   2017-10-13  912   * swap - swap values of @a and @b
e8c97af0c Randy Dunlap   2017-10-13  913   * @a: first value
e8c97af0c Randy Dunlap   2017-10-13  914   * @b: second value
91f68b735 Wu Fengguang   2009-01-07  915   */
ac7b90049 Peter Zijlstra 2009-02-04  916  #define swap(a, b) \
ac7b90049 Peter Zijlstra 2009-02-04  917  	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
91f68b735 Wu Fengguang   2009-01-07  918  
^1da177e4 Linus Torvalds 2005-04-16  919  /**
^1da177e4 Linus Torvalds 2005-04-16  920   * container_of - cast a member of a structure out to the containing structure
^1da177e4 Linus Torvalds 2005-04-16  921   * @ptr:	the pointer to the member.
^1da177e4 Linus Torvalds 2005-04-16  922   * @type:	the type of the container struct this is embedded in.
^1da177e4 Linus Torvalds 2005-04-16  923   * @member:	the name of the member within the struct.
^1da177e4 Linus Torvalds 2005-04-16  924   *
^1da177e4 Linus Torvalds 2005-04-16  925   */
^1da177e4 Linus Torvalds 2005-04-16  926  #define container_of(ptr, type, member) ({				\
c7acec713 Ian Abbott     2017-07-12  927  	void *__mptr = (void *)(ptr);					\
c7acec713 Ian Abbott     2017-07-12 @928  	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
c7acec713 Ian Abbott     2017-07-12  929  			 !__same_type(*(ptr), void),			\
c7acec713 Ian Abbott     2017-07-12  930  			 "pointer type mismatch in container_of()");	\
c7acec713 Ian Abbott     2017-07-12  931  	((type *)(__mptr - offsetof(type, member))); })
^1da177e4 Linus Torvalds 2005-04-16  932  

:::::: The code at line 928 was first introduced by commit
:::::: c7acec713d14c6ce8a20154f9dfda258d6bcad3b kernel.h: handle pointers to arrays better in container_of()

:::::: TO: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
:::::: CC: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNSr8FkAAy5jb25maWcAlFxbc+O2kn7Pr1BN9uGch2R8G8dbW34AQVBCRBIcApQlv7Ac
WzNxHY89x5ZPkn+/3QAvANjUZlOpVIRu3PvydTfoH3/4ccHeDy/f7g6P93dPT38tvu6f9693
h/3D4svj0/5/FqlalMosRCrNz8CcPz6///nx8fzqcnHx8+nFzyc/vd5fLtb71+f904K/PH95
/PoO3R9fnn/4Edi5KjO5bC8vEmkWj2+L55fD4m1/+KFr315dtudn1395v8cfstSmbriRqmxT
wVUq6pGoGlM1ps1UXTBz/WH/9OX87Cdc1oeeg9V8Bf0y9/P6w93r/e8f/7y6/HhvV/lmN9E+
7L+430O/XPF1KqpWN1WlajNOqQ3ja1MzLqa0omjGH3bmomBVW5dpCzvXbSHL66tjdLa9Pr2k
GbgqKmb+z3ECtmC4Uoi01cs2LVibi3JpVuNal6IUteSt1AzpU0LSLKeNqxshlysTb5nt2hXb
iLbibZbykVrfaFG0W75asjRtWb5UtTSrYjouZ7lMamYEXFzOdtH4K6ZbXjVtDbQtRWN8Jdpc
lnBB8laMHHZRWpimaitR2zFYLbzN2hPqSaJI4Fcma21avmrK9QxfxZaCZnMrkomoS2bFt1Ja
yyQXEYtudCXg6mbIN6w07aqBWaoCLnAFa6Y47OGx3HKaPJnMYUVVt6oysoBjSUGx4IxkuZzj
TAVcut0ey0EbAvUEdW11UU3acna7a5d6bsimqlUiPHImt61gdb6D320hPFmolobBWYCkbkSu
r8/69kGV4YY1qPzHp8ffPn57eXh/2r99/K+mZIVAyRBMi48/Rzot68/tjaq9K0oamadwIKIV
WzefDhTarEBA8KgyBf9pDdPY2dq0pbWQT2jH3r9Dy2CupGlFuYGd4xILaa7Ph8XzGq7YqqiE
a/7wYTSNXVtrhKYsJJw/yzei1iBG2I9oblljVCTsaxA9kbfLW1nRlAQoZzQpv/XtgE/Z3s71
mJk/v70AwrBXb1X+VmO6XdsxBlzhMfr29nhvRRx0sOJR5FiTgw4qbVC+rj/84/nlef/P4Rr0
Dav8Deqd3siKk7ODkoPMF58b0QhifichoAmq3rXMgK/xrHS2YmVq7cMwXKMF2EpiINaAq46u
wyqjJcAKQXJyT0/nW8G8GH8VrtHUQvSqAHq1eHv/7e2vt8P+26gKg1MBtbOKT/gbIOmVuqEp
IssEOH5ceZaBX9HrKR9aTjBiyE8PUshlbc0vTeYrXzewJVUFk2XYpmVBMYF1B5sLp7rz78Sj
WxtK3A6yAGjhYIadiQnssK5YrUW3pWFYf9V23ExTAoTARasGxnYXl6rYwvssKTOelvuUDTjh
FH1wztC17XhO3J81nZuJ3AyOHMcDA14afZTYJrViKYeJjrMB7mlZ+mtD8hUKHQwuuZdL8/ht
//pGiaaRfN2qUoDseUOVql3doikurLQMJw+N4O2lSiUnTtz1kql/PrYtGAKAEvglbU+sDi7O
IeSq+Wju3v61OMCaF3fPD4u3w93hbXF3f//y/nx4fP4aLd6iF85VUxonO4H42XsZyaQlSnSK
askFGBxgNSQTejxAvGa64po3C02cLNiFFmge7OMAprZwgD6IDjhsn6gJ552OA0vJ8/GGPIpD
t2LJE4sLAlrGSggUPD88NgK+YBmC5GHHjgYib++QPBQ7n+IJXgIhEBZUAAIvzzzQJNddBDJp
sZcwNucKR8jALMrMXJ/+4rfjpQOo9+nDnqpalmbdapaJeIzzwAs0EFA5qAM4OXX6RQHKBK0H
MDQlxhYAKdssb7TnCPiyVk2lfdkDx8Upe5fk647d53YIc6RR5swS3FI9R8hk3ZIUnoExAS95
I1Mb34x3ZvwO5LV2c1Uy1cfodRrCjpCagSzf2hB17FeBlzZHx0zFRnJxjAMGiZU0Wraos2BW
15xU2XwfewGeViq+HkjOMYzDrQRfVwpkDM2YUTW9WsRH4L7AqBCzOoFDnDoRBXAhGYYcVS04
WPCU6F2HsSCKDRybBdy1JwH2NytgNOfIPLhcpz0UHsUiPYIzgRhjzJHio2DLqKJxAUNSJ8+H
EAwRgL02zF6UPMB1MRtGstSJguc1PmArIRCQpUr9IMtpvUxPvayK6wh2mYvKxqY2oxH1qbiu
1rDEnBlco3f2VTb+GGz7CEpxLmK1BaBoCbrgJXA0BKsI7NoRQ0Qy0RHIC+p2QbAEaNv53HHS
NTDrXUG0tNESxvZEq7wBNAR7pa3+wJpA6GmFFZGrF9Ba+xz/bstC+uFo4MlFnoGvm9G06HJo
F49LyRryaDLYjZc+sT/B9nn3Wikf02m5LFmeeZpmj9U2jCtGnJZR2gsi005wol65mH/oz6Qi
N8LSjYStdAPQphQFywZq5PwVl+3nRtbr2F8lrK4BxZND2hxQSlojpyAwYzvgW+9qTk8uJoCp
y45W+9cvL6/f7p7v9wvxn/0zgDwGcI8jzAO0OiKpmcG7tAwSYcftprDZGWKFm8L1bi0KdAoQ
5BswTVivKauSsyRQxLxJaP3LFRV7Yn842nop+tg5HA2o6CYRqLU1OGtFSy/cthGF9UTtBvB3
JrkN5Gh1qFUm8wjr+nelHIenkX0L6qATZn+ZvzZFBbFPImjT06WySJqdzya7wZ6A2qDT44iz
59YGga7kEu+qKcMeETDDG0d4CaAe8LtLO/gDSbAWiNZgcXHwv45zb661FoYkgPehO7hWCJ7a
jPIZgT0bsw6WdaXUOiJiMhp+G7lsVEMEiRouAUOrLkwm0r1g/IzMdr23nzIA9uoSKgTKBcyx
A8yCoaz1QrbUEK2xFktwAGXqUv/dxbSsijfKc2p3wBfjLEtb3YD2CeYwVUQr5BYkYCRru4bY
o4O9g3bT1CVEI3AG0nessX0iLmbF6hTBvwWCRnDTwRFqEGL+3gTV3bmkTRGLoz3mUZHic4Uw
ykUimUsmhTfnhMkFNLyosG4QH7hrdWnQGVqqmpmUuqx46xItfWKVWLwWHE1lC3bCBLhlpt32
XAJ6q/JmKcvA5nrNc4YAOOxhov7aC4kwYUik4WXIA6JRxsgy4oC7bXJGe8ApN6iIIq2sWWF2
Bg4NYE8sK+7UpWVx0pLVGCnE5muaupgxJiXmyERXGMEaRaxBKu0usBIcPcdIB1KTgwVDW4oI
q/YFc7AalmJ907SGNK3cRQxiixlSymKFva7Cy1fVrq84mDwQnXFaWNuKSihqBo4hskoQ2pfg
L+C4b0DVvUWqPEU81xWezicExruEqR/DYkJkdFRZdsT32ZVucKv2smlIhzzKBh8s7/Pu9c32
/8Xc4wsqAT7YfwOOxHidPC2eJ8XdndR0PGOYh9WoBo8jAtmuRMTV5qff7t72D4t/OfD3/fXl
y+OTy+Z5dkFtujUc24dl6yFLAKOd0ek8pvOoK4Ha4e0UDDBWsbyYFfaEmN9XQhsvaESU16ce
SHYKQwV0nSrZBF4O3r3xPEDSJZaGcfIkZVQyAiN5zbWE0/zcCD9518f4iV6SjblMpu3gL8Wy
libIyffEW9AIOvvTc4ACKmNiJBmw8SK15WXrPWi7iWw3CSWXbh7E8JmOV6jB66uKTSWpuns9
POJzioX56/veDxIYoB8bwEOIhEmEIBxjED2WIw+tWhAgkxy9SdDZSPf0owAzQRIMq2VAGAWJ
8aNTFTpVmu6KyepU6vUEkPddZQn70E1C9obYHRalbZX6+Gk0MAwYS0FPNopyWhzdiV7OHAHY
qnruwMflNjOX1tHXrC4YPb7I5PGF7fTm8oru64n1bH+U0uIzRtOh4kHbRkI3NDCuJqgW+v73
Pdbl/aBWKpcELJXyy25dawquD5cwpfAsqIXBzy6d2zEQS+3Ltt6gXhDtaDAOeQM9HZd5ZOhu
8usPD/u7BzDr+yHVCOcxvymPuN4lYdjZE5JwZYO6hwU7psvT8RcIb+nevVSAs5qSyOwPTzGY
URj11IVXe7X+wHUGg6JuSh/Zutc7M0ScaY42BK625p1aNltnHFnmKXHn+obuOmkf8/DOgL6+
3O/f3l5eFwcwoLbA9mV/d3h/tcZ0OH10Dy2d3588d8kEg9hLuJR3RML6UU/HJx2BpUeOorLO
gxQ+pCeAzgpK9JYA0TLpl2GQXWwNADl8lTTmaoPx+m6zE6LXzMGMUpo00j83zH8+MxLySk/2
yIpxPUSFYxT4rC0SGSmBbZvWz4MJ6pSfn53SiLF7kIT5cMCgZQoAePblIcQdMli9U0FQEOPi
lNZG4YIKuFY7iIM3UkNktAzBC1wwQ5sYZAa7tiMbG1gGbaA8wKYYphuT1ZtiQBbHhz5SHo5Z
o/IgxACJUiZK2xYXV5fkjMWnIwSj6ScySCuKLeXlL+3L0JETwhcjm0JKeqCBfJxOpx976gVN
Xc9sbP3LTPsV3c7rRivaEBQ23BIzKKG4kSW+XuEzC+nI5zTcLUTOZsZdCpWK5fb0CLXNaa0r
+A7gzex5byTj5y1dbLPEmbPDIshML/Rjswagi4mOmLQaa2Xdk1FXLf/ks+SnES0YvoJoDMx8
Sdo1ZEDHZZls9VQ3RWg6QQHChi5pdXkRN6tN2IJwt2gKG5ZnAMXzXbhuawa4yQvtOeLusQfm
cEQueGA7cCCNcAqtOZVX6uj2foPH2j0FrP20kYMKsaaeEmwKpxCGubEm62gKDhTK3lbCDMl6
v00UTY7PlWrDA6RXSGKU0r7d9RIwzuLrwg+ZbVPB/QMUoqjMJKXWt29UDgaV1buZCoXlooxt
19/a4/CibWoTszqRpEjVN4YeUQAoNq5knNRqLUprrjGxRrsEK0yh/Dq85FWpvr08Px5eXoM3
SH5m2fp5dRPiWLt4sWR8126KGScwSzAK9C2hH3fKK6pk5TaPe83k1j1KGSJDDnIPWh44jr5x
KvAED2yQDDl7OmbNrDHJgnqIPVs9ORUQPEnb5FLhMzHwrZTcO8pFUCDuGi8vaCixKXSVA4Y5
pzz8SMTEmj9qTzk7PuqZ7XiU5ZSGFks4sizTwlyf/JmcuH+ifRKJOGhtwdbWuyr+4iADxXdU
Rryut0B7nmxNYf/itoDr9BJrMkcRznv4h28iG3E9rPVo335RBSsbFr5rGFbkaFRx3nUOR2ut
r3L9vFhkHA4f6vmGwmXCRZGEGC5o7gadVBL7dOLST+m5j2mk5oCm/YHD7G8HEN2reRyeiqas
fFTGLsGa4ouoOM3nS72rHRidNK1bM/2kaMwYgTElHbNDwArT5Z6VKBq/iDZiak0pYx//22y+
e5Sa1tcXJ//tvSOkihTzuW1XizSryj4mp0sxuWClRSOUwNQKBojeoXMykL0N68a3lVKBeN4m
DW2ebs8zsHTkiEX/ich4Sd33G3BC1Vwute9nBZeKdTsZtF+I9LXtuYQG3Imoa3TitobrzAw+
BgsCSywlWwoWpNdzC3OPfNrJw9fA8FZmDvZZtAchvMJvPeq6qeJMm43wQUswyip6+zGyugFm
vZyGgBPT7TfXl57SFKamU9H2mKbPLLwhdRHKjcgozNSVPAN1v21PT04ob3Xbnn06iVjPQ9Zo
FHqYaxgmjstXNb6AJodai62g4D6vmV5FFWo0IxLRFVxzja7otPNEXnUH4ZeVY8qP9f3tiw3o
fxY6MrjevLGI1kuVDpfukU9GugvfaVr3ZGeTahUqucvawtAzOEal+D4iT82Rh3JWSJyD7OWx
W8WQQXv5Y/+6AER493X/bf98sDk0xiu5ePmOlYkgj9ZVFkkc476Hw6Arz7E26RdPx4/lvHtC
x5Z6KevxQSeSciGqkBlbwnQdtOKr0ynvDVuLKHHot3YfcJ2OtxpQl35sECREqmL20w8gqSpc
hXs4MnS++ezgtFdtPVLm5H7FF3/1sNvKrZ6U5VwZGr/b7Gq12KXyv9O0Ld3jK7cQNIQw1Pi9
q1dh6p+3LMn0mBurO/ewF4ajmXYz0IYLuWqxadUGLLtMxfCF5NxEgvdfxkS7YfH2EmYA0O3i
1saYoJaFjRuYWUVtGYu50jDX3m/QxdvcHiB5ApZhbj+yKuLL5Y02CqRLgzpn8VeEMcexcrLl
dT66qZY1S6frC6jzVzSfy3S75CgBau7Db5D/KJx3uwA8w2Q5ae9to1RhUOwELYkvPvg4wD+e
QpiVimkAHxr8JgtfRtkqoCpzT0ZGfWGVmDxz69vDl1Y+e3gulne5mnlDOLIIWf46JyCOAb89
jp6YpZXJpkF5hSUfVdViSVf3+pOH/w+L05pEBDbJD/eHXs3bcWgKkQH8I4C37rHYrGtAzlSN
YVowBOIxRG/0YWFPCTEF27VJzkoKOyEPos0bDNV179XwLXf2uv/3+/75/q/F2/3dU5DmsPm1
WnifFvYt7VJt8ANNTKaZGXL8ndJARHMQZ70soQ8ssLf3ZQAdD5Cd8Mo1yOPf74K3Yj/Z+Ptd
VJkCFCcvkeQHGoLW/kX88cEtyGuMnEtDDscbfjpBcvSnMUMftk4u6u/ulNghxTLsy5e9L7Hs
LR5eH/8TlMyBzZ1RKGZdm62wpWIThxeuLFdZxzOb+bPnU4JKrKnPNUKOX8LE1nJrNblQaTwz
qLdIATy47G8tS/pJf8gqOfWqLeTRhYznqi5cgQqWMReLdSdV2s9twz8yAtioXNZN2V/I2+93
r/sHD8+SywgeHYUk+ycp8LUCq1wM51+1fHjah5Yl/Ga0b7HCkrM0+EMnAbEQZRPYR/Tp+AGk
Hvm4aqo8fBdhV5K8v/UbXPwDXPNif7j/+Z9eYpcHh4zOe6kwlKUDZUsuCvfzCEsqazHzialj
UHlFBW6OyErPC2MTLihscROEbf26wlacKeprP9bW8b55mZyd5MJ9NjK3dIGIOGnmj6fQdDHM
TjwXI3DEIi430gVl4V93sJjKNMFXGiub5p8ZjZnovFBrcmH/GkV3RMHKpNrMjFTVEwGpmCbf
Ddh5ooffHXwLHhB5jS7KDd76TKltuYEQms4leMwyIRPpHkcYPMUUHGB2Iag6xwfXKytnVuvS
/dvj1+cbMC8L7Mhf4H/0+/fvL6+w9i6+hvbfX94Oi/uX58Pry9MTRNujLxhYxPPD95fH50Og
sSAkaf8dQXAzffsA6mZuSVSZfacyBPsw09sfj4f73+nlBJPoG/hXGr4yZO6le5rsZdXdHxnq
3iqPuTlNF3w0x8wKMXCnyAMj/m636hRg7gw3Uj/BgD4+z2XworcU5tOnk1MKQBZpWya+FmEa
PDzxgkt6E8gaWYnuoH+6v3t9WPz2+vjw1X/YucPKqT+4bWgVXQZ3xFpyRb/wcXRDiWxHchW3
cXc13E4q1aTBpv9txGY/qfezZR1DZ7DqbWu2rc3NkksaxgNJEOUSQr3jbDOmcpy1KfD9clgT
7al8VTAq4OnpBa6z5Q5HuT9vcPf98QEfMTotmKCyvqfR8tMv2+kx8Uq32y21FuxxeXVkMdh1
Kcqz6aD11lK8B/sWf+x0lvTrFn/u798Pd7897e1fblvYKu7hbfFxIb69P91FyAbfhBcGP3YY
h4Qf+N7CS1o6Js1rWU3+pAxKgf9O1/FiM7HDjlpI/+EDThZmZrtM53n8l4m6N4tSBWWAUgxm
q9wf/nh5/RfCaCIpCUB/Lahl4aNffxP4G+ScUfK2zfwPofGX/UtmUZNuEhD9XPJdRHB/jUYE
q2/XYjdp8DhHC1mSy4dW/KtWmKAvgud5OFRlAIrmTGuZhZPYLtVqZ3UZwoSiiv6OCPC4r5vo
kNtQRlYb/wOAWqbLYAMbiM3bq5Oz07lXt5zeYZ77fyAj58GTEVlRT8WYYWFWFd/2swowMRKo
iz37X8aupLlxHFn/FR27I+ZNi9RGHeYAcZFQ5maCkmhfGG6X+7VjqssdZdeb+vkPCXDJBJOq
ObhKzEyAIEgAiVw+bLB4KkoutbU8FTne78s4juGBNmuO1uZp98MkyeuO1nNtykoC9gKuOBPh
UC9+JTfwK6KQa3GUQ/agKgAnDL0b/f6ESRrgaP1PsqtE7Jxb5xF/YoR1eSPnYh+cKN+XzBjf
Lno1Hfgzjlw9KaIaeAaD6KM7MpX53dwgz8pU0WEElPao0Dg3FIi2mQ6bNmdztE44GKvCMSpV
YiB4sKLcYH6HyWHGcyWp+2dk2WHOKeLArQA2Rj20NKv/cE98vyZLv9Zbj4xJbkGVJWBHs84R
OvUuPl7eKVrRSWSViMbEgPLp+d8vH3p9/fz6BvlQH2/Pb1/QkiScgQjXbSS0lqDSObuWblLF
ejerQg1oUKL5p79ZfO3a+fnl/16fXziVNruTildZtqVg3bKH8j6uT3R4PeiPrgV7ZxI1LP0U
NXR0GU4puC7vmDH2Gz0ItA6F2B+hL7TGcKWEQ0jF2+N1ME5o1Siy3RFNjE8wC9jakS6raU04
Ez4KXJWGrLoFPMdWBaRQpCEkRALeyYxHHsTSOGIRz+BhqkkPfBL5Yyv1rxVV0U/tfNvCaUca
EhtWj7jsXtDww91uOSkERHe7M+HP3VImEv5nQS6An7XM6ypjcWesFbPF1CcB/m/68B0R2urW
2LNu4o+AYJypGx3UN4zed2hu6N727iJg8NyoMG2m9aki6abp4YNXpa4BEDf+eHqmOSBQ4CRX
nsepFaaHw9LfeA2u7awOtDanAzSftihWERB9Z0wykt0TW/r0pZo7s80MQONhimXhQbjFiIAN
QrAJG9yAO1CNH1BE4mgmDRIA1tgqzGhGE2MN0XRJ7aQ0HGoO6tAaMr98f/l4e/v4czqVj4WN
FZzchcyD+rqqKf8UykNNXgIiTkoPDFsNbrdhqWgG0MYKnEU1E7xmy4eZv1xxn2HHT5iGXk4k
N0+rLtUlnRBaRTb3mirq04oozD/TA64ScHYxRElPgXQkRNVXLd1RGhKFvTMkVT5MhCTSUMPk
CEqxR/Qto2J7xnyVFTN+6r4gfNVxWgB2s1YxAf14Bpatlw9jQBfpgGfaIj+zK9BYu3VjEd1t
ZPZK8fQ2NhVBpIDFELEDemhQFQkuEGMQgG7jtlDy0HedQxk08lEDsnsPzgjWs8CFabAIDB6h
wdlejp9BhoG5zWU3qRg05zHqvkruJNZG7bUzNXREmZfU1NDRj+XMEAM9dc9iCgpJkfL09ax9
yTB1VVZtwUQy9vKELFX6Uu8tjrJmo3uBm+NR2hEg5cutBcjuNIHYp3BSQp2iNJxMl/nL07dF
8vryBaCm/vrr+9fXZ2MMWvyiy/zazaFo8oSasliChYC2M4nKCaGV/uTxy3yzXkMVMy3X/NWK
1mRIk37tyBKjaZrWQfw9hdggZLi32ygz9fFLpum6evpeLG16+46uSvc9NmVXCX2Plgz1zN18
lVyrfOPcxRLdDi6V0PvP2c2QVhJ5Xnqtz3k+k/AQAc7vTHzxEZKY4tTdFutRAftobLZ4MFlP
I6PzfzjbixFC/fW5Iy8K1+96tvhlpzgt8eaKkPX6VJ9QSKC+cZ2VdJrtaW0GCTa8k8HkiAJe
Cmf0qewdE1lZy4RBeB0blOi9cCEiGmszCMt8HtxDz9WVGETRYwxV2qCZoQvG6jmBNuliKrnl
Wpg4wgu2t46bbBMYg7kzBjqjGeo1mdUIBsWxihnIOligu7J6mcuKmb28elAoqZYVGSCfy/MN
NRVLgffUgSDXKy0xI9trOs47GhnjHS3LiHOkK4xByMGxYU5riACLN6GvD5gmc9Aio7Fu+nFO
HjtHwrCHmLkDr4kUenS7uFGgaHW5Wmx3ZjULn1CjjigS/BsM5HVNkp01EVJUagLkpYk2dJ9l
6WZlHXF04SU9HhvnwUtMngVROUca3fVpOnkZRdISu62+zogGDA1yKjA+ZKeSzpLqtBkCVFPx
wLTZjba1mGP01Jg5Qkvdmz1VD3cp+Bl8LKjnlIRXi5CMViMB1vym2FGxYRkdVzRBsNtvp033
/GA9peZF91A9PS/JRTdTZPp1imM8BOmVUyuhFqbO+w6+h2zCOkSf/KzVxEPKh3D0QglvU9ct
lzN7ir4k2CmU3s5ntSxXfsMnRj/OBSz0tUQi3G/5/Ihe5OxkBk4EQj2HW1v3TbHUATWxK3R1
iBafX9/Bc/h58fvL89P395eFmTr05vvt28I4n2yRLy/PHy+f8bw0dPXhNriSavgs+J4/10th
VIFx9K4Oowt/BwAJhWHYxjXvAu+cAj/7DirVcBvu/JLFziZ2eGbNItoeiCaslgecWlTHuJ4U
sOTJu2GFkql6n72+P0+VeBXneg2FNAa1Si9LH8c7Rxt/o7dlJQndHYmuxolZxnY2XTDOWfZA
J0x5yFqh8Kk+J62FFMSmCVBJsgg5rGy9886cTjekXdMQE4AM1X7lqzUbtqEX2bRQAMQCAZqg
K5C9n9psVps2S45sZvZJr+kp8beIMlJ7vQUWMyjEUqX+frlcsYEwwPKRjbV/P7XmbDYM43Dy
rAHZoZtW7Jdol33Kwu1qg+yJkfK2gY97DuaY3cYjztPO1XYABZANCQeDeXk6oy0ZmLtsvI+e
GcR+HaD2wTqvu7iNw3LFRJYpZ3wP90CRSlSvCH26NNpr/a3pmkTV+p7pNRv5EINGsXgfwqr6
D8DQ9QThE1/qSN6wL7Lj22SaWxKZaLbBbsN9elZgvwobtEQO1KZZb5kWyahug/2pjBVrgD7s
vKUzKCzNcawioh6DSqv0YMIa1tT65cfT+0J+ff/49v0vg0LdRb9+fHv6+g49uABAK1gSnl//
hp94vq8h/JDz/6MJp5tBrO/ty8fLt6dFUh7F4o/Xb3/9ByLhPr/95+uXt6fPC3t8F3IBQtSB
gD1ZiZ3lFqGIbuoHov7jhtzArhvUYcjB3LdQfv14+bIAxRNUb7sj7fepKpQJQ77oqXpKHSs6
QTTfHDOEqC/mNrPyb38PEFbq4+njZZGNqXi/hIXKfnW319C+obr+yeEQq7YiwKpxeKIu5SY1
SJD8SqyZIjn3G7minDGgajH+YCoL9BphjLdo8NGWX16etNrx/vKyiN6ezYdprFS/vX5+gb9/
fvz4gJCmxZ8vX/7+7fXrH2+Lt68L0NCM9R8DzUVx2+hNl0nLJ/dqrZtRUaLWH6jxbYCT1Eyl
ufxsr5lHFu5+LB2iVZeQAXf4UAAKbVUV+HwCJKVbFc+0yuRezjXKoFnrZbXmrA4mlc5qdsPn
r7vw+c/Xv7VUP4P+9vv3//3j9QfdgJoHnkXVGVTi6YkRvYqaRdv1co6uV4FTD2I5fWCyW0B0
s9FOkn+h2FX0OO/TFQHXifd89hqWI4DSLSrHotMXK5LkUDh4YhMhppOmFekpeetzSsugjT5S
p6zz1E6wfs8Vcbj1WTV2kEilt2lW04pFFu3WNG5xYNVSNrxySt7irfvWlUzSmK0eNDH/9gbI
KGtcJDAR2DBfF9C3U/qprFfbLdeaT8aMPIeAabYyoecvl1zZUvfTzeeQdeDtOHAjJOB7zNsx
9GZKz1WwW3sbtjFR6C/1x9Dy0A0TsTy+TutXl+sdMz8pKTMCvT0ydId7K649Kg33y3jL5RuN
H0mm9WSu8EWKwA+bm592HQbbcLn05gZNP00A4nDvOp7MEAaOOMP5oZWQkcn3Q/0AUvSqOzx3
VHiB1gWb8dZOc6MhAY5TqUDCma1N27tGW0DLX7Se9u9/LD6e/n75xyKM/kcrkr9OJzyFIbpO
laXVU1qhHDd8X56FnO8rIqr+QGUTu8xDDTuzSY/p32CQn7FXGpG0OB7ngoWMgIJQBqEe8ulm
2XRf3eu5785rV5BX271oWmUSWsbcA0nzL/ORaAVCzdK1mqT/m9wMWEZZ43FArUxVstWmxdV6
WselzdANFpg5VskpcMgb38qgYRP7LqX7DFbXVo/BxowJp6JTqYRD0tL7pmmmVO6pRcgDdVqm
CJlbChnuSP0dAVYjZY5ptj4CdP5fLwFYKuAUgbzhTP1rg+A7ehG7gZpARxGuOZl0UrKKjeeo
rh/sWU9Ms/dus/c/bfZ+ptmjgaITwg3nDNNErHuCSSXuM8y+GRnu187DAMHdlNrp7sK9eUOd
dcMjEVBtU2pB67jnjFeI7cxcgk2LO/PXPgHAp+uh4b6lKiQYinbi0s3wiWqYxUdhVgi9fGrN
j3ez9DJTk4IrwfaP1lU0/cYqUta+I0DmikxUdXnvLljnRJ3CaHI3S3bj7HgZJgKQTgm1xGDf
dsI5Kz2DYwAHO8OmQp0mmWzddr28mIl7fsbP2U1Jty43K2/vuXNH7JxyOBD1V3Y8xlE7OaeZ
EYXFHZJ+iwwyxWdfgJGFUBhdtYIjR8mDnw1WtHv2sOEd7VGWzkrjvkhZut8ugF9hF1dPhMBN
h1qW026QM7i4lvkoS4hHZs/5GyUUuJXD2h1AqqZ7AEt8yDarMNCTBqcaG5F7882Ac8l9gPtU
DOvXUO19HLFAVuaDCFf7zQ93tEML9ru1Q85ViXORDO0a7by9u6hNIqls52Zm2ZrV7bLAqqu0
lPVX3JjPZvWqQkX23QvrCHZ559QdBkCNzARvLHgxPv1jFJiHeZmxjmT8FrnzYrgnG3bc5EzP
YrLXbmhUT2Xnu45pItP09kR/Lg6HnJnZ0TqFcjCIxHG88Fb79eKX5PXby1X//Yr2CTjMI4a4
R64ZHavNC4WCqDIR6o4uAI/M2NDogYQiBCTbrDir+FBz+08bi9b5MfpSksYbzfeuXs+IH9xe
6xGFN0w9cbkhn2VHrsR1tmJAPpjUoyfG/fLHD6aqjiO5Vbm/m8xayVWpN9/YleIwOtNIF6At
E2TWZlI+TDyfVnJ4UyYwlYGxcvJPsMBJkZhzTRnOw+iIJkWEdD6NQIDmX+I8Kqp2FVIf2aWo
9IzJD6aH8sR7blB9IhJlHWO0JEsw0HfwmbKt0Ft7zIlrb4WND1gy1Zq51BWSI5dVKsNiJpWG
FK5jHo3IugFqNdO8TDxOsrpG5lweVC9wf9YbTCn4qqtwrl54iQU36WChc1VU+JQOc93mhyDA
K68dL1HsHP2rpwA2PnGs/1AVIrKfSL8zW6/JhcUwAMi7Humb8mB2uMVHhDADUyYW0XtF9Knn
WImr5bHA6cn2uj1dCQ4S1ICXTgM1R/18WsS5Mjln4HFIEgh8Y9+b7pjQATI75FyaDSoTios8
ZzOvOzzFqboRX9yLadWDFwqbFg605tzluRMFMFYXsTgKWIAGXUapj67UOY/c46R7mglbu103
4Kg7FtrYd9JyuUbHj3DawE/qbgRWSHw8/V0aJ1e4McfHmshBCJFreeBKVPsJYxiXnjvUeqmz
uGLwNsRyskViUkVMLfHmkjTYUvS3ziaryiNyoesLd0xo0gUF2cmGyOur2LmcVLCmzcHPFfgb
1mb6KZsrojeLl/hnHZ5pCZEXaChnabNu49whUG+1ITl2AU3b9GLjRAhE4zJmtsppo65ciY5q
e+dmwRam8gynY1semf4siQSFWpI5gYHiemtGwqlGuMdkSI6bvFNBsPHca10TPYVcPQbBupnJ
enOqL2AYou80D/3g03Y5pbRXWLLNwcoPhNv4a81GJZJYpLmLktLfMxd6geYPWUBCkKCbFxm/
kucXGUmyATVgXZETyjUtWNyhVwWRKnaYjEOyPhW8C86kUhs8CAZ8ZHqje8dYobebK2JzvE+7
hXDcfBrK7Hd4nx7dsdfEecubMO6xR1Rf8N2oNZoUjBCkFaHYQZomH7J1b7KKM0ExU7L/YrYH
dKo65uLMiVAeW1MWw8OIs9V2uV7OfF8VJPHzceBISolMr3H89hSLxTEPPYFl5NzJOEToJzqg
OXIw0X/oXakkJBdtFkbgZqJnFfb0mx4OyLuBt/3zhmZsAC+WqM20gVpWZ2YbSqxOlsYlJUdX
4ETXsL0vlBt+SWQ6nzh52q7en81s6kw66STK8iGLZ8Kg4UuYCZUNASIhZ28mz+yHWsenc42m
Gfcai2IxwAjT64SgUKb1f/FtXeRPVNarfHSUR0tprxtvBmN9EJgDYcd9/ZAXpVbKOZNGFKFn
jOIEz4Hm0kmMUHcJhepp1YEqUplFdzKuDkqkBzQYSphB7kGG4ZwtQ9YHgWOa+gra7NzwVJM4
SJZvzISnqGIWGwTEurKYdJJgxo1J28rTA0GLVFebTjfcM40jiIkA8GwQnngq4WQzoM+lOJuj
d3CGXr+tdah1sFw1lKb70ripnBZpcrCzZM7Jrl+AWTqdB+t3pPQWep8pIuHeQetetcyFe4dx
PtEbsq4qbiYpg1WwDuiNDHG7o8REAhQnIcmwTPULdhpkgwSbq3iYuWcK1vvaW3pe6JZNm3qm
UKdBuwV6src8zhU0OiJt+KDYMWTQvty7WAx9kc7c4h6V6Zdgu6C7FcHq29+Xszfr1cUtojfz
3rLhdoJgztFfjwwVvfdF66EKjkqjFTVSb3P1ONWDwK+Os4f82e7SmvN+v8l4Q3SZSj5wqSx5
ukrZrSyEPpu0x8Fwixh6mx9Syp3eadbEJAbUMj4KxWZvdUACgUePzhjJnGMEuHpR2QV4Kgai
/iN2m77xkLPj7Rr3DiNr33q7gFuCerEwCh28G8RpY3xuEWbkIcOw2/F5PjCyg2Q4UbbfYqt1
T1fVfocXGEQPWLr+hncbt/d6zp7lHNOtvxRTeg7TRDB5e2bKTOcwN3qJLFS7gI1v6yWqPJI2
KoTvKHU+KLOjodEKUxG3gSLVeuhmy564Z/i5v/OdvjvE6Z3MJzVVmR61Z95YDQJxqYrcDwIO
AdEMmtD39sxrehTn6qy4ng2bwF95yxnVs5e6E2lGN5k9517PhdfrjF4GQifF2cz64nr52HiN
8yFCV7tYcUCX5Yno1SaZQsYVmIenr+WSblnk0+HJT3sff9LXlEL/DIAcV9YtDeKjiyDT0z+t
Chm9ca368qYz8LS5m1HoNW97h8wf9rrHIsFVAJnP0++YE1frVeox6XG9RR8li0kDyKVFSiYk
XJixu1dh1kG6I0pClMCeAkF8cOxYGM0zM3U8nBOG7cC19GSK/zLUFcqYko0JlQT9AzU6HPkH
NfZs1EuyIu8Hi86fn+hKVYqF9MdinXI03jmFA4FqbELoKfTRByrtp5FMvccDfS7caBDIYnzU
dnaFA+KaCcG5bU+l76GnkoaTp48jKewgZDuxEm4YKSdk9Tj+DhWNj8AsxZt8sAgLH4wFHh8i
4ShFjxF1LWNxs1WJ85xMyvd1br9hyBw3PfjT9bCb9cyG6fqaiWYB3vovL+/vi8O3t6fPv8NJ
VZPcSAtLI/31cokGNKY6bwpzKJrN2FsziwjC+exURzZq4ZOs1bmlCYpSRTMGgwuxcHTpQn9/
/5gNap4g6BjCHKyeZSYJHAdGYZ4sB3AkCSiOJdvTKO8ItILlZELvdJuOY5p7fn/59gVeDg/E
1hWDUAh9I75jjcin4sERIOz44iSG92Rn7KMunINDtCXv4geTAILr7Gl6IeXsbYhdbjZBMHaO
w9lznPruEDH0e61s4uxQxPC97ZJtXtThnlbbgEtZHOTSO/6ertWEMMxHEXOe90GsDsV27W3Z
KjQvWHucYjiI2I+IaVeaBSt/xVYLrBWXkItqbXarDdf1WifnqGXl+R7DyOMrOUBsYBRlnIPT
iauts13zvVqkUSLV6RZ+x1hRXVzFlcWhGGXOOf9iAVR7zb+WzG/r4hyeNOXmq72m6+WK/+wa
+IRvtx5MGS3r+R5FROl5NDtp4B1C3uKLZpHZGUJPIArOlMQV9zS99xFpwSkJo8Qq4kuy4YcD
OywOlWALHhOfW+dHfoVdfITcUmCfkXeGw4yzgl/mBzGjqImZk1oGKSWj+CrziEUBGqTqDGu6
4y2Mc49tpGXNKP6ulE9Pjh/YV1FVkj1TbxCBrKU0xVCv46PBcVBFdWCrNswDH4gwCgHUKDaO
jB1ylZG+YDiPpzg/nQXDiQ577k2LLA4Lrv31uToUx0okDf9Jqs2SBfYbJGAxPc98RE0p+EE8
SJQKZGbcjXawmVMF0bbYXlvjQRiHOLQHs2RJ1FrEOtZ4s4IYJ5FfBZ1YEffuoC84K+Uo0pnq
mAosCI/+1vR2kIOu6B4VZk0VVjEOiUBE2PWVgDBJdT4sEQRlFmyXXPQGFhOR2gXrLX8XEe2C
3W7uDoa7/1n9laf1VxoIQfiwa26zpp69y1lrB7IJJe/KxaKHs97He9yCjaXAKl3kcSvDPFh5
Ad+s8CEI6+zo/T9jX9Ydt820+Vf6fFfJRSZcmmz2zMkFm0s3LW4m0It0w6PYHUfnlSWPLM+b
/PtBAVywFNi+cKKup4h9qQIKVa5jwyklre5jxGTQnKEgHPiINxl1axiMw9rKI4Omzsosabx1
/PXNNga2AI8lo7Dd1zEbozf5DnHVkgNuBi3zZRm1lpzNtTK+Nc4F0zD9bCkNmtTNUu+bJi1u
5ViUBRuOF7xD9sf6IbNW6I7mnuttblVJO7RTMezkUebgK1B/jpQXrybDwgBmwq/rRqrvHJwx
IYFjuT5W+Criuqg/H5kpK3M4XynaNV7uiv+wFbqoLuGx7CnBzXsU1jq7oEaPSm53G9UxjrJK
Z7XhORLrLAjJS4OLY1mG+d8d+IJbwM+FdTBQeKDi+8Hlp6ptLrbY4Egpv+1dGB5npj2hrtBl
Jn7k3VRtQwpqnQ9V4vqbyL9Zcn5L8DOLAd+i4/pDYWlQwP3KjhW0spWVl4HLUj9VXL4O/BRn
WiXQfe7tacRL2HHKT7QDOARRD/6MMoL1DZNZxnllY2to0y41y4eY4IHejPYrG3s2mVfYwYd7
MBcsLLug6BsmXSXrQPNvr7P9zNTnycXkfqFd+N8F9VSXBgoHSfimdCszxuc5zmVBCBAc64WM
GIy7rDL5Njf5uqpH7ZVlHlKUiptlFSNLqwehruffljMIrfLbxTh2OdMQ/CXxh1yiMLgt/tCW
hIGzsTypkRgfMhp63u0164HrpLckwKYsdl3Rn/LAIo92zaES8q8nvaIYjjCUqGmCNmoHfVOL
IGLasQeT7V3UIcsAc6k9iVtt7At0V8WuXNDh2NS/OKyIVDnnGk94L5tNuPXBPI8WRmEZHG29
YCqrCW43tk/F1tG3527KWj/hqeJoHeDL6lBbtlegXpgFvG+9WM+XH2ruskzxPy1BtCjpcOiJ
4inT0lPz23NBYIHrd1SNOjv2SskkI8AWOq7gPpSpHNF4OpwmLUQA4rCBXuiHLUocqjH6y9LK
xONAV1osaYXjPovVVymCnFSuszXT67L9sYT3qUOH21VomKmeGyldr7bFpfXYDGjVi7Pha3Ek
OX+8MDxG3hObo5j1i+A6jrcoavMkbEqHPhug1RFpvCSPgo39mKA9V/Mg079lmFEijYcPta6h
cXcP9vtNarGXFtxC9ROz0FokzmSZqoCFPo4JabHHJmicXkp/YTEqeKCgozmAYt9RHS0pgO5R
X+MCuYifSJXsrx0aXWu4uGqSYVnr466LzVp3Jw9WWjFekWnLGcJgZLA3LefbSAkNcFcVa+NJ
CyfaqshBYnEDJ8AKO+LiUO74Wt6MIoQYje6lg2NHnV8OJzJQPJ2iXggMNHyHFmCgCDf8Uu7w
+PaZu4wsfm9Wus8etcCIw22Ng//si8hZezqR/VePqyKAhEZeskGtSwRDG3fKtcpATYqWGLkw
IQChKhHbBGl4AIswM1J1LKnxQZdg3HGLZcgDIsctac3qirs8gsttR5ucC4fS6ivOkdLXJAgi
OZ8JKbFlcUKz6ug6dy6SYl5F/MRDXBj//fj2+OkdQlTr1/yUKmLRyRb/dct2GCq7fxFeWqxE
NlGPNf3DC0K18ZiCVQvvVanNRWDdPDQWTzUQAgy/xhJvIInNj9h0T6i9Yh/gNDtVslkm+30n
CMIh1vXt6fHZNC8fKsSd+CfyzjsAkac6LZ6ILIO2g4evWcq9HArHswif8OmotyCHcriLwq7B
ZCZGIo1s66gkrjhJkYDhHSqabcVPKrBVU+aqOx6Vh/yxxtCODY2iyiYWNKPsQrM6tcRylRlj
0masHU/WaGFKqxHLmxi5c843WTrqRRG2V8tMZUss3VoVqbV9m4slzrtggsALiEchEcTo9eU3
SIRR+IDl/hwQpxxDUkyn8G0PYhQWXA8cWKDZywKVfAcOVZmXiNLw1FP9YJnnA0ySpLY425w4
3LAgG0u8gYGJjcJd1qWxJVTQwDXsMx9ovL81xgbWW2xFfgkvlnAGAws817yVzPACoCU3OdnO
twR3Lb6XDTCbNGww38qD/WILB0TRKfYF0+Ut0WnGkQWnAq6Pn9QMPOBMTwvkMi/4o881bAnk
gKxXli021trWZjg1REMYvsFk1bYq4AI1LTWtBOhMvyyGkDK2T8WLLmFPAKc2kjgNsOwtRRBI
kWukc0yTQ9rsNTJXRZtc4j6cmfRUp7Jh7kTi4c2ZvCJ2u6kaM24YsBoccZXin+4zLd6gwXGS
HYzIZNU1jFTaVqpEfepipdSdvw1x0Rkim8OrKWyRaup79cCsOuOObNok2vjhP9rrtpokGoWJ
qoMd40wD40hOz06ES0Vj1Vr5rh9+wUmNsulPxAUvqGwk7pNDBgYO0J/S6VmyVxuNEwqin7AK
qsmmxHYaiUzf0u3AZahglDqT5SEZrY+nhupgLZ/dAQFJXkp2XgUYPelQM4UEpNm2AhuCyz1S
Mer7D60a80DHLNHoDDa1kbIyKRvVWIr1OkjlSFpsCS/vlZecI0UElRJGl6wYprmqfAsOzs55
6zZMrtwrDsKAyk3AWPs1KhmupGKq0Q6MVbMHZeTqiJ5MMGQIrQbectSUmG4t14sPmnLf7Apq
Etsklis7KbQQP2Cu+eC/fMVSZvS/IX7Ap9eX97fX52fQbQxrVJ544So+rydi6CPEi06s0k0Q
YrSerKPI05uJYZGLGhDxiRGpjuw4TfMArIEVuoMwCLxor/XEan7Mjr1S4h0Cbqe3gf4RI4fo
s6oB3IYXtQFO6juhgaTZQYi4FuCDH3EoxlNOVCVvHun/fn+/fl39CSHexKerX76yvn7+d3X9
+uf18+fr59XvA9dvTOIFR/a/6qknMIP02KcSnmak2Nfcb6a6Emog9qJfY7H5PdNTUp3Ra+gu
vmcqbIErJ8Cb7T3HNhayKjsZQ3Gh8o1masvHUxIjcQk4cokNAlab7g6NxSxGUaX4VwOaEF7H
WZ/98359e2E6C4N+F/P78fPjt3fbvE6LBp5KHD0tVSNYnETsS9W4gBe62TU0Pz489A1Rw94C
SmOwuT1hYgOHi/pefQUh5kILgSuEATyvXPP+N6vHXDNpaBvjVlj59mYc0lFcSf7xHKb0Jlqu
fBQaUxuIQ+Ac68gSjzV0h4gICyzUN1jwsIvahSQ4C7Q6MmZYBTfo3XT4wpaQ6vE7jIRkXuyN
pwfcLTnXvvSs4otwWm51ZAOg4SGBE48UxPPyXiXPTumUCo1zWaOf9bkyUHVXYwpumbwAldXG
6cuy1ZMEJc121g14I8arFWez2hadb4btHo8Zy/gY3srAdPKIbTaORdlkHJRJAmWRQ3BJ1H8r
Y7kMPnxk0riUSLSH+/pj1fb7j2LwTUNpDJY4jCltBLF/yqMdXqYyC72Lo7e3sexLKOrvSXGB
eeDu5mepTJzjk0ISaKZARZz8/ARRqObSQgIgq81Jtq1y68J+mrNMSFAtGdMzxUr4jHUBxPO9
G3UJJc0BLNMCD305s5iBO2ds0Jim8nyBWMeP769vprxHW1ba10//QcpK294NoqgfBe5R3G4j
H8LlKF4UVGYYYFbs7iTH5CvqhHblVNinF62PZj7FmQp8x/6SzuaHgLszIOkHsHgOOaFjasB0
x50GXiWt5xMHDyM5MpGi3luOvCaWixtYzv1GlkWRZWRiSmnX3Z+KDPP8NjJpjgWnDJjmptky
TMnGdd3UZXy3XAu2TjMt3HavPXLtM/BWdzOxMjsXZHfs8HfdU8Md664gGXfSjl3dsHGvuIZp
cu30gF8uqcFbh48geOTgvU4bOZbtgielxbPgtNnTlEzlz7ycSSSrrl9f3/5dfX389o1J3DwL
RGjhX0JMJPuGJmrE9+YFvErREJMCBBuGrVbc9By3inUbp8LdhT2XnML/HPSmUm4ZRBQWcId0
ViEvJZxS3teX0U2/0sJZ/eB6G53K1pxjqxFZtyWyGs+Jp0sUBBpNlaNbtkD+NnQZ3AYvdlu+
cbVbDBUvaIRbyIkSolv0CPmuezE650zcMFlHxo4Eah8v6fWfb48vn5V1VQyA6VmoNmoEHWaG
deyktd62YqA7Rmqc7mFKjLjxTeJt4F+0xAaqGtl1QMCuxWyFhbVVWE21ReJF6hgVMzJPbzRT
Vzw06oNxTheBv+w5ms8dDDQwEv0Q1w89pfj6L6ZB62/X2EOVAY02vtk6XRLQwGIGPRiVLV7a
DE0IBowRFn1hxj35WcxMjkK9izl5K9tuCLL5oFOMcptJ+Ihut+s/pGh8y10qTpSMTHY0skjr
YiizXbWxzs9WfTkw0Iq+AE9taswKrXPSxPfsdSMNeCcryylgJUjci9VjO4cbrtH5ada5Snw/
ivBrM1GHgjRkYfm/dLG7VoMPi5f2ZLdcTEWnH4CzUsCzC7dFRsrub/99Gs4xDYWDfSJUXf5s
u7loyQ1YSrz11uK1UGGKcLVKZnLP+DHAzKNLEnIlyPPj/1NdELDvxBED9xWMjIqJgWgXTBMA
JXewp/YqRyS3uwKAS490F8vyv8IhBwpUPw0tgPpOXoYii2W58rmPPxVSefD1TeXBXvrLHBvZ
bbECRFbAxYEoU03q+SViH5/wu1eB8jBbmFTPUXJsW/ngRKbq7q1b8IIIuDLjB0ksThOmasBB
DO5GUBhNG58PlpYwMI6Yr7oBH78bqBBd20xryH7psenIEic02q6DGPtcdBnaojJLhIbwlBnk
4I0y3cNyLbM9k4pP2DY8soCpm5kk2amh4A8Ql6YD8kJSu4+eGm1OA9RrKx08pB+xKoxwSvsj
Gyusk3T3LnprwCtPB2klLufM9NE2Wu9woMNpgKgyktHAkB8zpj7GR9VX9ZgbvBzcOOvlHh+Y
8LVbYcL33ZFlNM+uYtmrwNhpowG22STdRXawPvIXpIVSmQCfb46PDYyhBEgZRw6Q+GTtZ6Sr
OtWcVR3v1X6ZEqKJHwb4OjvypBnNEsq9Zl3cdRhgsqBUK/4yA8uLDb61G6Cx5mUO2SefDHjB
xpbqxsf2PYkjiLBUSbXz10grDjLtxuxjPkKh0bztGlk7RuNIZHDQwPHRVukoW+Ww4mthF/hP
Jj6lOmm4dRDHGcJ67fGdqamYsiqsqwk81/HRl7MSw9pVNjIFwTbUmaGCJ/zS0a8CBDYgxHMD
CHMaoHD4eHZbb+1gAN1cXAvguw5eDsqqjZtlyxyu9eMQDTYnc2wsRVpvAjRVkmy0oN4Gz10E
AW+WWVznJk8eV25wEKv7Ui2YSJKRKkGqwZ1x47UAm9PF3GN6aTFDgBFPSeghTceE9BAbhil4
RSbKzceIiAcryrqvYGg/FMEd0y1xj6tTA25cJvHmN3kiL0fv8iaWwN8ExCzd+GxNFN1MmiQH
y3H3yLIvAzciqFnXzOE5BGm2PZPFYpTsIVR+XKY6IhixQ3EIXd9mzDm09q6Ks6ViMoZW9pw4
0cF1+lmPgTD1YYD6Px1xuNOFWYJ+q53tafCHZI00A5tKnet56JQoizpj+/ViM4gtCNs2FI4t
ngFN2Ea8NKWAw3ORpZoDnmdL1VvbzFAlnnCppQUHMm259wjXAoROiBSWI+4WKyyHQvxyR+bZ
LnUtt+neeEj3MiQM/a0FwAYEBwK0uzj0EwXBO7tKWt+5sU3QxPaWeUolq3PP3VX2ODPzjpWo
jtOmnq1CTHWaYWz/Y1QfT2yzOPgr1Q2RRF/u87JClUYJ9rFCRujOwOhLvVZWW7TGW3x6VVv8
qENiCDx/SajjHGtkCgkAmUHCUBcdVwCtPfxWY+SpaSIOtApCUUdpE2NC2WxEmhaAzQYpGQOY
fo9MJAC2Diq68muELbbutYOFpflJZTHEkaRPD5fP2EbUJ3neWiJpj1ydH3je4lpceUzjRKVj
vsZvloRx0O8iFy3fsG4uDRjG4jmbAF90/fUak65Brw1lv6PTItOSNVPP0cHNsMAPUedgI8sx
SbcOLkMC5Fmf3wiehzJ0F7d4eP+cx7VZbnKgeAMyYLHjGO7/g6aXIC2K2JROsmeVuRt/eapl
TATUDuQxHs+9zROePWexXhVJ1psKVXVGbLuk7Qimnb9F12gmqwbh5cLDnFvsDSZWSslmUZBh
cn4Y4upTmrhelEY3dFniOpgcxN3gecgo58AGU0dZw0aYPlLUsXIlL9PxnZQhvndzS0f9AEzw
oUoCZPbSqnWxVZXT0Z2YI8ubKmNZL44oYMCa5lTEfdIeB8nbBMMojLEynajrobbjMwNEcjDT
PEdMjXJTHNhaAc8GIDsap6MjUiCwCFmNlyTWchMFqCcblSdU3VJKYOhtDvny94wlO+RIHfiR
v0m/wFXDeAplM1mfJgS8tDCOFBDt/85x0ZMXI6zmQAAr7o6VBN5PD0+4QOmP7/uK/OHozIZO
OAIN1jgjCCEtwUEnBNVqiVmE4YFRv29OEKeoBU8sGZaLzJjHRce2h9hiP4x9Am/khbfYn/5k
uJEqyyaJqeVp4fidvVQIo1xPBAar4F41DZbhuSZYM/1swYXZ4fAVUt40O+Vd9nFp7IC7mEId
EtwRibeQrIjsBZ49UsrW54bk+mMIhcHIXcAfj3F3pzHMU4nx+GvnsgIT+K/YI/qBwUydz7Sx
gkpYWPFJaCsQPJ2dIfRCEWmT+eZweFeJLTLgUa8hpNhJJg6vL0+fvq/I0/PTp9eX1e7x03++
PT++XCXDYvmFACRBwB5fJbVJAXGL5NRNVFkSIcTQ2udmG7uuSPeoZTtklhaNnrSSyshg+74o
M9mQDWjideMUKR0vtMqk5zqgFsvFXVLFSLJAVn/1ompJYeGecIzMBrZGnsusASQvY+WGROLe
Q0COpFLmnoK3FsNIwYTaaFc/nt+f/vrx8un9iQ0qW3zDKk/16NFA4dZeKk26l5apxN+oh/8j
1cMvJNuKT6A2CDxsb+Nfx9SLNg5SLuFOLS+zixIkaIYOpRL8BwDWRMHWUQVKTk+3wcatzlhY
C54gv9nVMhG3vWq06nzyrI8Srdzqo0/eLvzW+YIQ5StnSGI4sdeexUgI/u50YgjM5EIki9BH
knctPuA4XNaYAgQQHNUr9/oSEavICNlrcihCJj3zRppTZUpm38akSHyVxpJpy1TNXd59xgdv
Mwd471EMc4FAVLu3eXuDUqDNorL0uws9/xRjctAYjYKr3kFUumb/rYFqBHaGcUvMpGq0OGEA
3TElpMTvUADmFi3oAcOMaqNtNIIxehyu2YMNru8PDJtNaF03BByF2hCbb+Z1arQ2xrewTsBO
LyfUC4ykwLEimtIWU7I5SkNxDCDTxrNmOansAZ5Mxfg9JV9NdFTCFKND5asuo0fLR5Klx7xq
j+73tOA7JoN1q+K5msafKk6J8UBMgQdjAv0T5QUlpwoTYKPWd5Fj65GuDmjoRvonJEuMl40y
XKw3oe5tlgNV4Bj7IicuNxG5u4/YLMA3T5GGxTd1vLsEjmN/hsk/plVrrYr2XgBoikfsWN9a
hXW2Xkmw0Ynwg5EhybLCXcfz0ReXVYw6qm1J6DqBsmoII22bq2fEBa1cjsHAWy++oG9ti4xk
I2N8Fq031s8KxFpdAoIQu9aRMoy0jpntzM3Sb9FjAwn2kMQY1RRVJoTouwlD2LIvnyWN9mPm
XBiR+KjtLwwInbU5ZqVvz6XrbXwk0bLyA30xmA37jXZJ/CDa2lceWqFaBF9E1SczXA6cXkmY
RN1ZswzhMSyExL3elKovEV77KnAdm0QFoGq1I6iwG1krymH77GTw2rqb68dfMw2r9IDYXhSP
LIHhYFQvrWREOHm1lTObXd3a3oTPHCJm+akpaayaXM4s4DvoKLxRkWOFGv7MzHB6ww9vJnak
sKPEs8EzBM0qCnEDApUL9K9bbGngo1KHxFLHmgd6CRO61/L3o85nIqPOhKQ86mGLSesKkIoE
nqXbuUpzo2GEjvMzTNhtvcLiqbNOw7Dzd2kAxjVTrVWLqhm1igaSO2eu9fwU0ylAjWlntoKU
W18WzxUo9DZujGGw72/QAcARSy9x293l7p+2SBSxNVopFvfllMHedxNiSYPaEahygAJG4Xp7
o7k5F2reo/IouoMG2Qb3oF7cSlvTfHRM1n80TLEmkLBB/zb8JSscWrgRlCfa2qrGlKAb0wVY
PLzsmgY1I6apuoTlx4dMM8mU0FMUOTf6kfNESwmgsqPEc67wj5F3iybPpKWYkGFqPWNgZ+CG
ljgRChuXsReLAEyeL78cUrHAwTtslMftmG0SctT1MTlIY1KM1w0sWkjeQx2na0yawK2hTE6+
lYQmMkuY+RJUkkj0e1GDY5LMkK+FDIV9nmhiNSMoYYW7ZIyvoNgIlUWHhhPo+jqbvphTKfjI
ttBDlP7hhKcDnhZxIK7vsWAQ4gKvRZGKCW13uxTFLpX8zdyoyeB2E7dt4vHF+Qs1zVUfP5Df
vz1++xsuegwvJPFeanT2AzzJydlyEhocnCNVqn1dpfKDWCBp/jGAVJ+KVHXDBlRSYLo3R85N
d0fUNBTvm0DI8py1jhpCAk4d91S6/zntY6YR7QwCd3G5b4/kDzeUIXIuKHgBaaTD2VR2rMB+
QJyzok9lBzlATVlrHC+SS0IZ4+9Hqgqn9iQrc3jMp8J3FRn8FZr0fIdC+Q680Mr3qwbYnCBw
VNkkf7CtSYbLJk57NqpSprh0leobCnBKJxfjoERdXz69fr6+rV7fVn9fn7+xv8C1nXTdA98I
H40bR369OtJJUYrH1PMV8IDUl7anTL7dok6rgauL00yvnqBxLamlnZ4uG6isu42JEift6pf4
x+en11Xy2r69frp+//769is47/rr6cuPt0e40ZItKyCtujmeshg70+Q12KqmbCONzbT2gE5Z
nRFi+By7rM+6rtE6WOBN1XYZIRODmdfQCkZ9P799/f2JMazS658/vnx5evmiV45/fuYpL5VR
exQ70cm5z8Hf2DC4m92HLKEELePEKnzBpjGmTs/c8xwxkyqbc19mJzb7uWt97s0EXzfVCvSn
XRnXd312ilHnv8B92mfavD1V570aknemslmWWCzqgGlfxfgrCACPaalmFOtLQrWP957jqMSk
6Loj6T9margaPieSuAP3bYcUdfIFLB8vpf7VrkkO2NLMayl8TbO5pBaihXBM4/qQPn3/9vz4
76p9fLk+f9dHGGfty1Nqy0MwkKJq1cO1GSvquinZYts6m+1DggX4mXk/pAVTyZyNU2VO4OiN
N+Qlorb3Zbp11ihHycD9Otj4GMj+GxOIcdefThfXyR1/Xatyv5kVCTP/EONSMsodxbFt4Ay8
XPwoP7qO27nkol4JGGzEWfvULTNLrFC5H3j8vktPKFPgttgdNh803KwDa50JUcZG8fJ+ffvr
8dN1tXt7+vzlqu0cIlA7yzWuL5tIvsvlO+ex2vH9Oo0TvZYwsBYjJ/GJBLE/DkUL9q1pewHl
c5/1uyhwTn6f4yEV+NLPtqaW1v4a1dxEnWEj6pn8Hap22ACyPY/9KyL8YlFwFFvH06pLG3Io
drE4Wd6EGw0tepq3a9cx99g4PW0C+fxMAVQNjrd6l7R7/MIE4ENBCvafXYXfCvGGvZAcf6cn
ilrfpx3u1oP3HQ/JYmkacCo2uYbnYyl/e/x6Xf3546+/wMmmHi0ml8S+UaThAo5E3vVJlcJj
MIVWN7TI7xVSqr76Y5Rd09D+lJGlLR3SZ//yoiw7tg+qGcO/pr1npYoNoICo9ruyoFqmgHVM
imuLS1aClXK/u0ejWTA+ck/wnAFAcwbAlnPbNUyKz9g0ofDzWDP1rc3gviHDz4mh3kzlK/Y1
m41M/MceNI2lbGT7TmjtLGcSCEtdvcMBdjbr2UCw5VjFYFmQYTsLdFmc3GludeEb9sEgTRMt
N1qUvC3YuDWtnpTR9/foBByxxoV+43s0Xqq28pTysN+s33KmYxZwS1obA+d+l3WespPJ1GGo
zgib1Fq1YrYOsQ7BA2Tw0UeoFWQdYHG6BMMCJoT1ywWsXrv4RgSazh7b4RnQtLDOK96hYYi4
qWb+A+mPKqhO0q+TZsB2wzNzyONJTqArTpYSF5u1ozEXkeVSmWFlFjmB5TkdH+3giQnPaVKR
lIIJHckWgm7mmGp2g2+hjWJ673qRPvI4EU9e4VJHMIToogZptJEtk9TMpt/jN7ADerOCBH/D
A0h8sj0dBrTAFQ8Y/4V9+GcNW3cL7KyLoXf3nb4O+mlu6fhT06RN42r8J8qEDuy8F1Y5JqAJ
q1mllTo8OhlfoayNwxSOCndcne9EjBWlGzmlLy8IcX/RCjSSsVN8aPjBCkamkOSYq2krOhbM
vh1Tyi50HTj6vBwdjVhaWdzcqhtJBpJyU2VaStWOtT16Gwl7UtfEKTlkmTa+j01/526dC0rV
yzrSrUuoUKYsDUfYeqleGPPG26BnzNPEgWk3ij5zIYGYlDEhw+mlipTr3HG8tUflcJUcqIgX
+ftcviDkdHryA+ejEuED6Gz/2nroDd+I+rK/CiDStPHWlUo77ffe2vfitUo2/anyuoZZ6FeO
XhShM1pKwtQ3P9zme/kAbKgvG613ufreC5DDJfID7Apubni8fWfccJgr9dloyTLlOWOtxd/e
zCGuzBfLZt6dz9hwLXkjE+7h5AZPW0XbtdufS4tbk5mTxEzdxTbjmUU3NZGKkrZRJN8+adAG
hTCbU6now43hYpEG0wg8BdaHoe/gW4nGhV1USyxtFAS2YoKiZXGBPHONF2HLlTHs9qWhanlR
MZfxFHjORg0gMKO7NHQd3ABJyr9LLkmNqR9MlCU0lgNrg4rTaArBAMEZmjSJm72yJcNv8Cpy
vDB9osYNKyQeuxAtMSXlkXqexWlEc6yVsS+c7xepeeVzUPxZFensM492Wb2nBwUVoWunfI6Q
pNlykMy8zIinRd+unyCOI3xgvP0A/nhNM9WknVOT5Mgj1qPVFBzdEZflOGpdLia0wM+BOE5Q
rYxDR6bZllrLZeVdUetV2GW0afsce8sIsPAqryaUHAr2Syc2HYmLTiPymz6N1nqubFjJaff8
TkAlst7cN9zFu3rSM1Lthc7gkinXa5qVWWIJziJgbDJz5EGJLy6GT7UrVGtxTs5R36wAHZqS
ZpLnVPG7V6IHQgo0jHytFVnufJDpud3dozH/GHJM4PwxUZM5x6VmzsYzvO/4dZslpQJCsOjf
aDFIFYyei/qAnpeIqtQQEkGJSgf0MtHcg3JiluqEujk1emmgqjA5rUXiyknVHIm91FV8z5+d
WYpdFfAWqcmpWh62WLK1SB8bEA+7QDuspriJp8C6Ao93ACgTU9EIxICx3Q4eWZaN7DJZIhpj
rM3qiseM1qg0Bm/6GhXiiybGQB/IveW4VGZZVlZlTvbvNk+W4iqqzJQsLJpMPK75nUBiWzvb
rmDCnl7jDvSj1D6CuiZJYnsd2dpo78HhokTPEqw47AmCW7zSFoWbc9AsKyG+K3qiyDmOdVse
tWW3kyUFvkJ0WVbHRLWBmIjaKqyWoIo7+qG5h0wsRaCFOaHZKkVsPv84fmBLiG2dpYfuSOgU
2Gr6UKYvlfkIQkTfWk5QxDqKhzflWFFUjSyTAfFSsPmmkh6yrhmafkp7pNn3tYf7lMkT+top
HCH0h+POGEACSVjFm2r4ZRMYSn6KPfloR4UxBgwCmTbt8L4a2LXIv3PoSSwLHudSlvkgkeaQ
FD2cZJfZcByv4oYiD0ThHkalMWn60B9i0h8SNQuVTXn2x7+ra7ZgJllfZ+fRsmlsrerp+6fr
M7xDf/3xnbfd6zcwvPiuttvoYQHk8oJoZU3v6xjeMlZF3chiO6883RuE/nxgy0lppAPQruQL
LqHDiNDgXPbQCERYUeEUbQ/OZhlhaEmlF3GPboCcReMp3Gfe/Ls4N7qdjywIJorGl1MSScLN
xXGgo6xj6wLDQmOQ4GyA9eJxegcXYKyBestdwcRIKXQ6YXLwYj7GkBlzR85jeFdcjp7rHFpj
JHKH0G54wQE/9EwgZ/3KEjMB7oTLc7FGaJC2UxiOtxhIGbnuIkcXxWEYbDcLfXS29NHhHC8m
DQ0Lb/otyQJM9FkNRO51vhIHudOIFJevq+T58TsaLZKvAAm25PPFQo+AzuuVav1Nq0nXrNkG
8b9XvAlp08Fp/Ofrt+vL5++r15cVSUix+vPH+2pX3vGo7CRdfX38dwzR9vj8/XX153X1cr1+
vn7+P6wsVyWlw/X52+qv17fV19e36+rp5a9XdRUa+PTmHsjmjQjKBaqlJszgqcU0zmNcQpT5
ciZL4FuqzFWQ1FPPjmWU/R1jFzIyD0nTTnakpWPy6zUZ+3CsWnJoKI7GZXxMYxxr6mxUBBD0
Lu6q2FahQSXuWRsmt5swq1kT7ELP4nKAT2j1teg0+ouvj2BKN3i+MAZ+lSb4s3UOgl4k1Fr5
o6K1v67ln/HpmHb4RR7fEM8Jdsg4QJ62ezJKP3htERbEj5+/XN9/T388Pv/Gdpkrmw2fr6u3
6//98fR2FXu0YBnlj9U7n1XXl8c/n6+ftY0bUjeWd07V7Agn+gkek8tujiYELPzuWLMRkoF8
nxO9++d0QVIomhS9VuMb5KGAEJrayBupIqY5BmgxUhVMd06jcPFIBarp0DSIeCMaB2d82BGy
8cxpy+qmOgWaklLlKctynFUF6i99wLxQrXycHunxYhbiRDLsAphvXkUTmMsNhPigFi/nHDe3
snEiJ/ebBH0yJ5i4nyRtw0/5oYWeYE7Tos/KGDfU5NWFg8OU9VcZY/ZIvO4FYf877bXhUxrF
ZyOWCb6nYtfpPrXkkjbnuGMtpu2Cqlm4kIpIRsUunBcXMBTW8ysInBVYrNiA4Z59hJ+o8gwe
eBNdcNtEvu4cYVDuvMC97GziA2GyOPvDD9QrLhlbhw5+uM2bkenlPWt8iBWRof6exLSLGyKO
FqfR3/797/enT4/Pq/LxXywiN5c45GCrddMKYTjJipPa2CKe1u6oKRRcjlQNLDl3nO4z8zUG
L9Trf7mN2jMU5t/V48vnFf332/W3BJue9L7NWAuBHGNtHrb4WY+7+KJR8pjQ2KHB8SyLdWcu
KqoEkClVSuGuI0ey+a3kEATtuSPZR7ZqqP5EBjJJow3qpHnER0PfOWmmgSkxcifSqN5F0k0I
hIE7xh2+6sKX+vgROmeV/E7S3+Hrn9GnIB2bsQtgJD2om8JEtEahnjm477mFdJkCRPMKT73J
mUoeE8tSpvLRLW4gMHMN0cIXC5PD/+WARQCddyRVKbTIq14nStFb1NxtL/cZluw2uJOJKuHe
S0mqDEZOPu60kJlAPZID+vifQ+mhCLum1Ko1yOma1xeo3WCS25q9XlFcrp9b8JLVljcCVVYR
WiTYKSecm8BBw1wOfuzAjQEwWj86gZuvFgHbdbA51LCdHs6wftb7zLxIhIt1ZGHiKSwEFuN4
HFPXUx3lCzrxQ82pgFKwpAp92d3vTA10KjdjcDCib2QLF+GWiFUcF89+baUSAVM9LauBqnvx
AmggaWUA7zXYu8gJDfQsyjYIJg/NSIJBgDrGnlEfSTD0kJSiAHUcPKKKAcRce9VwQKbbLvUn
nlB+d8+po/8OGtOjPph1Pw0T0WiyNE5cb00cNVKAyPaM6cYckv18KCMv9cRzda29qB9YogSI
4WS+VFcZaBLD22RbcWiZBFv3olfYfFo/kgeHYPpMCP4xit5QD1VDRUqSRzCZfkdTL9zqTV0Q
381L392ao2CANIM3bVXhByx/Pj+9/OcX91cuIHX73Wow5/kBQU0xe4LVL/Pdxa/GurQDkdHa
zZPLKfUjeChn76u6SDbRDq8IfXv68kURLOVjYH0Uj6fDtKjUSxUFbdi6fGhwSUZhPGRM4Nll
6HmNwoiaKCscSYu9ZFRY0DVtBMdTeSSe7NO3dzgN+L56F201d259ff/r6fkdXo3yl5arX6BJ
3x/fvlzff8VblKtRpNAMVdWqxJUtbLvC18Z1YXFsliQZeGYtyoJiel/G1hgmRzVw00CSTr4d
4NB8jTIlCXQkpY4m8KJl/h4IEGAgjNzIRLRtHkiHhAkh9zhxtA78n7f3T87/zIUBFgbTBpWE
ANUOZIBUn0Q8XN6njLB6Gt9uKcIBsBY1zSGDHNM7Joa2axRFYQK0ey65WN1p1IWn2y8oCiKk
jOwLcsrIEu92wUNGfLW+ArlEsvHtSE/JYCuL0k1P5xqesOF7RGPDyoybNZ7BZt2fU4pioeYK
Z0AO91UUhPhuNPJA7KMtujFIHIM/Gexjm8uYmWN0GGN83ZEg8TcWVyEDT0FK10NdKaoccoyo
EbkwemCSeZAaD+l1DghXtBhiBSIEqNYulUMbq3S8I3cffe/OJM8eO3TACAEvIboDkLHNJ3+V
GkCY+Lx1Yqyf8sq3BY2bkmXzBVXTJIYgwsrDPvSQTsoq3/E26KgBzzdmXHTQIW8sCdD2FuFN
YUFdmMgzGRlrnI7UA+hrpLk53bKSbLFxA9PUDZEG3G7Uo6i5ZdesxW/0WogHflBm6DqyFAdr
BzYhPFeNSj59k7SbLeZ8shNek/u4Tgf3j1OPwknZTyz2KWFKHOoTRymWZTyxDt0mnjGi2ufH
dyaoftUy1z5Pqoag3ehFSG8xuvIiV6YHaKvB6h5BzJKqKG/sHJs1ugvwAPKLY1pTpxQ6NqZH
h936EkLv3A2NseGyjii+BwCCxhaWGYItkiSpQm+NlHr3cR1hI7Nrg8RBmh6638GKJtTSxQm0
YM4/sjzc1x+rKXDw68tvIHHfGM45ZX8tr6ezk3Pja1KfbPIX/3J0Z2bOhI2vngVMVuXk+vKd
qWyLE0GylwI1R84grWLEm5FwCFDFu2NuWvyQ+zqB98tyoIYzp8oJx8cLckszH0GDBwLsCFw+
t2E/+qTIVUILNdpnddF9VIGUCcMoEMte+YHAVMukkYVLnm5SSJbz85E9g+qMYsIq/6o7yuI/
kKo8VJ24wpO0XkRxwHpfeO4Yh+Hp6Y21t9mXg38P5bJ2pg0P9PVcGbgDn0KoidPAUNTtkRpp
VpWqWUrk8WU+5gZrsBr79Pb6/fWv99Xh32/Xt99Oqy8/rt/fJYO42cTuvs26EzpCBAQ+p1tr
QFga77UH4ANyicLJOEkyapPUyQycoqHutBh0SBUL+7hk2i33UmD5hBxJX8atZoLOgy2zL/rY
4tBzYihRA6whWHPDhCrZhQRQux2VzP/y44eCkiNShBHh8Zrw4wvYvZq+y++KEo9kQxMmiTh6
1ed+arlyjn97gKBIXVYy3R2pIKCyRW5FirkO80IxuHAxawf+luJyAJD0uas4PUEgtoX4Vhr3
YCPQxqnBDodadwAMwRTmZpEBoZ3ncQLnE7hRMsJvyaU/1iTOs/FSwZIjfxF1M59DQ+8yiAVW
Kt6EpqjTadxihc2yrMVanI9020gQoL27eYGUDoexv6tkcw4YAoJl3iqy+KNl4oE1NY07o9NE
0CdxEyQ18nA1tKPDcFcadwAPeIOMsFJ8nk1StcqGIZzdJQfKA0z5Ob50CS72X8dxvP5k9fkr
+PhLnVNW4zNY8JzYkrCUFVqtAas6swZtZQY9mFl2FZMu8Dl/adyl5YTBQZ/tmga7S5v8PWkd
Wl0qfViIUjbxHe3iAhMlxrQ+yg54uPlIv6+OkmouUupke44hDgvY+CeTp495RJ6Mg0qj6Qp1
VJBjl4OH8LZr/H53pNQW3XPgW2QacjnWBYV88AvL8tJDtJtpG8Tu+StxZioXdLwI1k0UTIa2
QMNIJIeuqbIpW2UFE1hD+haM+9Cvh7hIs7fG+eMBKlus5UeUNTCVREhOBg+fYJeBuJlJyjuw
RGUi0t1RGm+H+JQBxpLL2lj2uCju/QAbJbbk9evX15dV8vz66T/C98x/X9/+M0tu8xeIi1ag
HkiKzQXpO9O3swSSIvDlMMUq5CqiqIqhPt4lliRNso2D5wqYdvQoo4R7vEnwkDUSY325yWJ7
/i6zXPDLBZmlSCyujyWmU4I/gj+cSVvUYOdiCLui28nrjzcstBpLlHRsMYi8wFcGXXaiCHXH
5utInbdVHtWsLfDFn01EfnXF9qEbDBU94g0wcVBLTJasGhgI6oC2YuvvrpFDlo2Sd3WQLJPa
RFLDwHqji/tKfDevWiIpm2VZwbrqKN3lCIvY68v17enTioOr9vHLlV9urcikboj7kevX1/fr
t7fXT4iinMHLpuH2Q3B/+/r9C3oQ0FaE7Sls0PR7bgrHCOaJZ5OsfiH/fn+/fl01bGn4++nb
r6vvcG/6FyvobMUkXJ1+fX79wsjkVVbhObR7e338/On1K4Y9/a/qgtE//nh8Zp/o30g7TH0p
etLF+KyC2GNoL7fVGEB0bKPh52r/yvJ4eZUbdAw1ykOjcjOyvqnTrIprye5IZmK6HowYsMe0
MIBlKmHLMg5PMThUBUz6PiaEaeDmKcdQCcS0bK6xKXyNM+MC8sHYINk/7xC8c3hzgaQo2Hns
0A8xakw0clxaT44jP5D1+96BPAmT/nob2hOFJzO+GkBhRrgRAz77JZ5ojR2ozRx6ELQB6Wi0
3fiYhdHAQKogUG06BmC09VwqGeNJxv0fl4XY9Ebv9gr5tKmA05JjnituwCdan+xU8h13BcdA
lTxcZYO0gaQl/swJ+o3BymPJEJgbE4sns5Dz/2fsyXobx5H+K0Y/7QLbM5J8xH7oB1qHrbGu
6HCcvBiexNsxpuMEiYOd/n79V0Xq4FF0DzCDtKtKFMWjLharjGQzLXhoUbCYx8fjj+P768vx
oq1IFuyS8WRqzTzW4emqRcuUufJRGvz2VI/tMvXdqXPFQxAwb04fYAVsbEk9F4BeHjjUSheY
hebhLAPSYSu5RXn/9mOJOW12VbDQfuolKgWQrly02fl/bFzHlatTgQaihmeym4lSVkoAtBJc
LVCtvgXA2Uxtaz5RKoSmGPPlGqU7WjglxjlGLeW28yeOQ1Yl2/kzT+Ullc/GjkPPZVVvQPO1
qB+AW7KpefmCnQ8gGfH+ytPp++ly+IExKcBSL4rsZliAb8VL4Ca1mss+uPFm1CpBxELSmPnv
ufJ7cjPTmrqZ0XlhELWgxpMjxlorczLgGhAL+dgbf6sRXG3VWVvpRSEvrGjfd2FmXCs+zLZh
khfo0q3B1rXUF1/HwP4tCvLuxrJXk9r3JjdkHCNitJBABNkKl7Gd63h2HDopryDJko+AGWv1
bdluMbN8SuoXY48MW0HMRM0qnIbZ/sG9MicZa7DsDu1yjfExZ+7Sj3Zoi0HToSeVQ4aiCrzr
uWMlC2QLduaVe7VbrjevnCl1pNviZ24182ZG09XNwnKFT6DnM0vFyKEApW0sMdNy4k+mE/Jz
28qDKVNTBfPCgwBfFVqzLX4bzVxnrxS8HGqptvBWgX/7AYq9IVnnY5VlCOzz8YVfghEHdzIj
qxMGwn7dyiTFsvarOVkkKWa3OoPfPthqHHKtoqs73TqAdQ+fOFc8PXXnivBM6+BQc0a1clMo
KmoyAg1NKjdp1fdACDthNlVF997+nUrvgUDqOb6WdGoqlEqmAI6qtXfTOEXearh2zFv3z+f5
ItlfQSurQGwdhACjpdbUUQq0BFOlnBL+nqu/J56r/p5oIgogVF45QEwXHkacqvftWrjtCTlT
EwKcifbwzJuU1vshyMlnZNwHPil7suD3jawE4e+Zq/1WR+pGE95j9Sqbj4fBZGwn7Mm5ln6/
yGsLcTrzxvIFAxANU7m0FP6ee2p9X7+Y3FgSKSJu4VEjIhiNyJgvYihh0z19vrz8bO13KYUI
rkNhTwdNmioHvjpOGK20E9egFcaKwQkivFh8PD/+HFU/z5fn48fp/zDcOwiq34sk6Za88IFx
P8zh8vr+e3D6uLyf/vxsa7T0g78QsX0ihOf58HH8msCDx6dR8vr6NvoXtPjv0X/7N35Ib1QZ
awRqiKkudhvv+8/314/H17cjoHQWG8SVO9MqtwmgLYyuw9qUP8R6ZNEBMJ3KajJVzKOVOzN+
q1yohWmWhsRTV/dlDpYKvcaKZuxYi6m2TEw0wHZxZfA3jsJ4ryto6JmBrldjkb9AiI/j4cfl
WRJwHfT9MioPl+MofT2fLurEROFkIueeFYCJstvGjla0r4WZ8WHrz5fT0+nyk1gBqTd2JW4T
rGs1BeYaVSDHntawz0iUxoEWij7Q1ZVHal7rulEZRhXfaPaVgvLMVR7DJrvg9YuX4+Hj8/34
cjxfRp8wnsYynziK/OAg1ViPtdUYE6sxJlbjJt3NSG0k2+ISnPElqLhWJITWVru0kiqdBRWl
WyMB9l4NvZehg6dF3AE5fX++SDM/bFY8rmUJzRFZ8AdMrs3jwBIQBQ7lwGJFUC20O40ctiCZ
wnLt3igsAX7Lk+KnY8+dK2sEQaQkBcRYjecEyMyynBA1I+3+VeGxApYacxwl6qVXkqrEWzgu
rZurRB5lZXGUK0cSy46XpLLwuYLOoP9HxcBykYMIixKsEUkh6LqkFwdP6nKqCn/gH8BkyAj7
vKhhUqVWC3it56iwKnbdieoDqTfjMelsqv1qPFEP4zjohprZ7hNqGLqpaqByEFkgFDCTqRxY
3lRTd+4pWQ+2fpZYvngbpmAPqbmNt8nMnZs8KD18Px8vwptIsNjNfCFflOC/ZQVv4ywWcqRt
6yNM2Uq5oSGBLQJNplDdY2w1duVjf2ldIXVY52mIyfLGyuikqT+eemTO8JZN8VfRwrHr5zU0
ITv7SJzUn87lcHQNoZfD0NGaIi7m6fPH5fT24/i3pkFxC6wxb8/F58cfp7NtXmW7LvOTOJPH
0KQRnul9mdddyUP+ju523ujr6ONyOD+BhXQ+6p1bl+2BpLAdLfPBc1OVTVHTNmaNJ/1JnhcS
WhU7eB2KeoeiTr69XkDEngbfeac5VLA1dN/RdDInXascI9sOYAy48l5FgNi8w04vElK50TsG
w3hRL4OnxcLVNrnQud+PH6gzkMJxWTgzJ6XzVizTQvPSU/xaZDkeeHnhUGwKjA5X1sDEb315
t1Br+oEigQ1OOqar6UxmLuK30byA0qcaiBzfGDtYS+MsQ0lHgsBo6k49nTiW9JuF58woLvdQ
MJD/ksXcAtSXdkDplgZXhM6Y/8rk0dV4MZ72ttj769+nF9SX8VLH0wk35iO5SpI4wHC7uA73
W4s3v4wsyWOq3WJqOx6Ah+bGcq2PL29oUaordthScbrnmYVyP2+0ioRyxHuYUrGhabJbODNN
IKeF49CGHkdRrvsauIisE/DfnsQSs1pJIgk/93FAnSUjpoizVZFnK+XxfZ3niQrB43KNBi/h
6ldct2loSTUjCpAPPwQzVEEi8GSd+IFv0reORPltCI6qZB/VZLAZYHm6hbHaUFJUlQnR83cM
8CvhbEDD0xjMp2qD9V1iANQM3HF5i4nCJCUFa4Ji1lK222flN1eSHAWmOaNHFXZ8WOPJbV3m
SaLVjeY4Vq9vFuQKE/hlWIJkvUIQpzv6DESgMQN0fHuNoPDd+c5yd4ZTpGFliTsU+CKuaqzR
SJ/JC5oq96NiRQdltRR1ai1Fz/EYpnIFX8dt5oArNHjB51oT4apk+2VB8odITrgAP/YR24Ra
RCKCQX3YauneFPxdicwyxOAias0iyRDrKLjx+n5Uff75wcOHBobXFdVSMmQt/XS/yTPGs361
qGHPrO8xMm7vzbOU5/YiO6lQYTNWKh82F0/IRe09wHcBt9iI3o9wd5/l1QRTuV59R0u3c71/
Qjf1ptfaw5Ah6DJ5YCenDfK1tMgISIreHVsc3/GyIZeJL8J1ZSZ3LpnExep1kwV4UpT0UWrs
/PT+enpSVK4sKHNLfumAUcZvd+G/E5u1+sP0CSOwypsSiznnIA4tFTkkMjKBxcD8eKRRTdcj
0He88CBXMXXxJ6pMcyU6vb/wUo1U5FRA3ZDpq4fCsKRMYt/tJRm17rIfLBl5XoSJaffxMsLE
fXKA2oCQWMHd3o9WvbgcPkiCdzekKGdLnq+SUK7k3rfQovBsiZcw5Xd2jBRkvyDPqfzqTRjF
sHtVeYQwDH0uQCRhcdyKsIHq4/f3w+i/3bz0pxHtdP0AvYxzKdks8kE2hPs7LM4gknYMYxfu
am+vDlsL2u9YXVN2HuDH+0htAwGwuSssQuwnJqoK/Qa47r2CmeitTOytTK60EmZ+eV+0Fq32
iBWn3fb5YxkoDBJ/2ys2Vvt0yQdV8nmFMUwXYORv6oG8bLuqerQYjHCFPRxR94akNsVskK9T
Rsx8gTRulO+u6/Hw5XKLliekiVCesyd05k+h2wFTttHuXtBPKlx4lFepLo1+djC6syYZnwLO
LVf6WJjEZZOB7MyAjsc90x0W1LZFIrCsglmQeFUWJ+IrJfblGd/GQThc2nCoBNQeVSnEN19t
g+cjirM/Ql8vyyMJBovss+1WtHnUrS0gbV5KtYJxDCwSwbFsYmFUMuYZu7fgLTs7qvpy1IOM
ESDybIRjeKCy1AYz2+hgLftEWw+TKsd0sMNtk9fSHTf+Ey8s89h07iGLtKhontS9JQQZlNE3
aAVeY1y3UVrvt4qXSoAoJzZvwa+lyWJNnUeVyomjBqtdSQC/kbNL51swiNi9tmQHKLCeIMZC
2vvAUhhHogXhHppeT//w+KyUJ686bistSiHVcJdY1ndLsQaek6+04HqNphtU4+F8iTtjjwUu
qOMepMEVKg9WDzNblXBkr8THB1/BMPk92AZcnhviPK7yxWzm6Gw7T+KQ6uND3Cb+7jSPINrr
v7Okry8S5NXvEat/z2rt7ZKjDmhsTGUbGUyr43y1weY4yC4zOLq8Mwao+Dh+Pr2CDkQMDhen
6ls4aKNHVcnIbdpGD8lANGXlncKBeO8dy5PEtRoNxpFggCdBGVIX+zdhmcmDrrl26rRQ+8wB
v5BsgsYuAdbNCnjO0jJRLXav3+TvVir/o6kzwPNEmglMixamEiYvMTeqRs4CY8ZbkDarAzqK
9JXViRDO7FWFsQOhe6TiaQcUf6OtKUCIukeVRt5Cr2o/S/0jOUDjyUuNRn/Gh22vrIbbhlVr
tT8dTAhAzjioU0mFSrBdspUAS14Ue6yGZzM4NVJeV+7aK2U6lIh+0ZCvtq/QnuQhiemiEz1F
8mDxYA8ElAY9dOKB7NtDVVNGbI+f8KooS3438yE0Z2wfpkuwg2W/5TAlJVulIcj1VlBhA+OO
arsz9kYaZ7DsyCWbp9oKWhca4DbbTYwWATiz7YLSaFNA8EIu3pS51/OKCzTWu1fh4t6w/ptP
Kc/ooJ9BtXiYrx5Nu4o6uglJp1L5wpNi9AJvBhIvp5UB4GpbVTQaIyogwoNIWfUmLwh3udGK
gNkMBy14GBRHsNw3Mt+lpGsi9Rt+dKlGv305fbzO59PFV1dKbYkEfh6EXJxNxrT3WiG6GVMn
LSrJjRJ3oeDmU+qoUiPxrjxOnStqJDf2x2f0GZdGRB0TaySeOsgSZmzFTK70iw4M0ojo4y+N
iAozVkgW45mliws5+kl7xvbBi8nC9sFyoAliQP/EBbifWx5wvaljHSJA2qaFVX4c6w92L6Nj
xmQKyj6S8WP6K4zZ7BC2FdrhZ3R7NzR4QYPdsfWDqZx1CsFUbXKTx/N9ScAaFZYyH3k/y/Q3
I8IPQfhTJ+QDAdi7TZmbbfplzurY0ux9GSeJ5XSkI1qx8JckZUhWQe3wsY+FbQKqC3HWxOSR
sDwkSmnIDlM35UaUbZAQTR3NOxNrc3w/H3+Mng+Pf53O3wfbBas1hXjuGSVsVel36t/eT+fL
XyIc4OX48d3MAse9CJsun9ygyKNkxLLFSbgNk14w3PRaPdeeCYpJr8+iM7ttPYARkxywXSnJ
Tup16TfewDj7ejm9HEdgyT/+9cH7/Sjg71LXBzcNL0JlcYSGGfeko2sECEEX8Fkt61wtPm2q
une1tijQwlLx5DfX8fpPquoyLoCF4Cm7bMiUIQuEk79ScrA0WcNraN2nyzwhFRFegO0uk11J
4psUvQ2ax/vDWicFYSV8cGhmpaxW6znrODEWeUZmuRTfXORdpUBtkKMcT5XuQrbh95jppOa8
ijWqRHLqPgnY5zIXY//N+dulqETlLf1L0RwOk265pMeX1/efo+D45+f378qO4IMa7mos463m
im5rlgEek+lRHIg/C2OAmcpk16EK32d56+i1UmChXPPVZY71Bm1ZMQSNcB5V+te3YBibJFJr
Vql4LFRovrjD8nA8WnVWCVF7/Adkpd/w5fmrr2lNPWAsjVqIUqVqt2THS1z9tVXCqENrnuWn
XSRpmCawSM0h6DDWrmI0BBai0WpPCuSW0v37Ur0tTVzWjbluB7DWpkhnAOzLkhKmL7GHuw02
SHFt4tbxag0NXh8d/onoSI2S/M7gJDSSP86/FEfQOJPqgfZxXYtMnsJTiPt1hNeFPt8Ef18f
zt/VxCZ5VKO12BS/uMbMyuCf0Ankfo0hDTWr6GV9dwvMEVhkkFPWVYFpwtCMzZVjCAW837Kk
Cb+5KhI3XN7U35xehmCVXtPJK8C6JFPRdq+1eFos4DAL9saEaIsFe7UJw0I7MhDRhngHrGer
o399vJ3OeC/s4z+jl8/L8e8j/ON4efztt9+kOhIte6tBmtbhLjS4V5d2SYcP5FoP7+4EDrZ8
fodH29blxU+HOD9X3K5b4gAIAaAJyG/jT+PAXhmt9jFrD7pyFUkYFvoHtn3YsyLuWXdldACW
LtYZNATDsDz74WjbIDqjaoKSbwmXBUfK7+WqAAwbJqkMwwCWTwlKbU4nE2o5qGDT1nGA/4eq
ovoYxpYva5lcbDstadfPSh9YfrYWizowWmN+Cd+TgZmg6lwiH5TfkDoDXzCAlNzr0pzI70CR
h2GbNimOeO1ZCYOcHCYExr3jDJ6rts1nytJueEucD7Ub5rZV0UpDOdMoxXkqKEjopaQnBXu5
zusiEWKhDrtYSNpwaqdiH5Ylv1RAnAt3SqZ6cix/RsTiRJfvClKoWIbmptKkbIPFn28b207i
VPxWAR9+O02E+82CVj6i19hJ4gRGL/Pv6cS2eIgs7U/JepOFb9Rk4kWcqLRhVyUr1jRNZ3BF
HRuwI/d3cb3Gml2V/h6BTrkKBwR+XgYaCZ5+8aWNlNyS0Bvx2wdFK9JmgyeQTRLlfSJjQ8gH
aJg9lxeKd8eLCeYIuqJOAZJ1KXtNxvB55pZnffy4CNYwTOEmICOheYlYZFugsqh95hgE0iEg
w3wDN7fykWUNqrzBfrh5BqrGvsfSh2JcJs0mpMBQ+7kOd0FDxs6KzwCjN0MjNCmUqlscuQFs
LacM5FBu9UcacBnXSmgfBzZNHGigEhTqNQ+CM0YUMbZuUpF4ov/8SNb2WNO5JtSHFM2dMnTD
VJ8YbsdkvKA8BvPhfSZbbEzF8MY+ecw4KNurQLlvgL+vmSDNEixSYZXGD5xNyk9zsjsGG7Il
BAs2ayyZfTnFdXMH41f3ccW58V2o+MJwvfh1S0O0gindWzWB+4gaRR8LWZnct24jy8NFjct1
r56+DwhCNFJhSEHewBITdqamWuD5d9KopT3bjJW15USJzxsm1bfwccxkgQuNVx7eO7u5M1gE
Og6G06Vx7WL1aGyWZ3hWKHW5xeLryImWKEI6fLmnEK8mvryn4K+XRrKVknIXh5PMVhPhLkJW
Mi27cMHs51ywq1Jc4GBPxKqPRrQJil95rwOzNJYdJ7r/MC2v6dW4tFoRrx5Wi8TNyGntQZ+y
Uw1U7TsMXVK8a6sGY8M6jCGWquPj5zve6DIct5vwXj0iBe4MsgjPjgGFPJsMihye7EVvA08F
GrQNlDPgmIQ+WMM0hCW/DqrcgBXxnVjAo+J3MzgnMAk0F6V4CE9HufNnnecbqucdZUS9sj3v
JFvuzkJ3EXnbqKdDK1NTV/iFjgwGoeGlRop7oX6qxUwNoisorsNWhXqAAXo7jxMUkfu0xMAo
WJ83k+ZBKIQxTdl9DizL/J4Mb+goWAF7L5U/xUDxLcp3qO7eMEnXWjVkmqLjDNc73z9iD/Tq
aZOcBUVMCaye5J6lUmxlH85LgDAHYcbQeKOQrLpP0xCXtbYtJJImiGXGr7wYNNA0ZBWahoUP
llKw++Y6ErdNGb/miDYDxWoBjT6slkIRT4Cq4tWvnu64ct/El9PL4ev5+xe1pY6Mz1e1ZmSO
EILOm870TukkU0vySIP2rtBILYTfvnw8H+DF2ieI61pFnsQ+KbWABE9tWgp1imDxlSyWo1dl
6LAlFL2FdBB3HaW2nCSENCI6jZVO9u3L4e3t8P7y+v6ll1S4YdG6l+PpeJknVVkSsJ288wWo
kI5tOP/vyxn57z/fLq+jx9f34+j1ffR8/PEm57MSxMAdV0zO36CAPRMOM0ACTdJlsvHjYi1b
tjrGfKjlSCbQJC1lTWKAkYT9+YTRdWtPmK33m6IwqQFotoDxTER3KmbAAvOjQ58ApixjK6JP
Ldx8mRrzrlLvg7ji8rvzcKpUq8j15mmTGAi0Qkig+fqC/zXAKNxvm7AJDQz/oxgnXZ8Fhthl
3Wg39TrMfKPFKk6Dbkuwz8szJm54PFyOT6Pw/IhbBHS00f9Ol+cR+/h4fTxxVHC4HIyt4vup
OUgEzF8z+M9zgFHdq/Uvuy6Ft/GWmPA1A/24v4y65KndXl6f5Aj57hVL80P92pxpn5jXUL6A
2cKS8o4Y8wJeYx/wneoV7zZCeH9Xqhc/RV6ww8ez7WNSZn7NmgLuxHfr79ymKvvtcnUcPy7m
y0p/7BGDx8HikiWNpKEwRgm1RwBZu04gV9DrVgzJ4qxrJQ0mBIygi2H5hAn+NTlOGsBWJsEz
hxhPQIB4ts884MeeYy5rUDsooNAxDPDUNccUwGMDWK9Kd2HScnWjF3ant2e1/EcnmqhFClC6
0oKEn87NXiM8iy2rhGXNMja3Gyt9cwZB5N9FMbEOOsSQ2lXvOxZ0T5KYSojWU2B4jJYaVsJN
yVar+sqMB6H5YRHN2zdr9sAoDl6xpGIeWfdGISBHvuOpBC8NTYUEhF4RZjXVCYHZV1Xo4Yvs
valDRjwPdilOz5XHBIFt/Du0+MY+igqzA53UpLv9yEcW66Bj3Q+58Za5WvO2p6Rj6wf02mSj
5eH89Poyyj5f/r+xK9htG4ahv9JP2IAuw46W5SxqbcuV5DbNxViBtcilA7Lt0L+fSMkOKdPA
riSdyLJNUeTj08vPy0w0yshFl9ffQ6ezFJVpp5CVe5Q12dWv7hx1cv6YmkjrHihWwjsTQuMg
28R2/CRSmipOGVSoVqPZNPQ5ePwvYyd2AZZWYuSN+y6AIAijPjwJv8q3wynF9yEoh1G12caP
ipsdv3z6NtUNZEAMAPRyC/vVYLiv/dcFb7ho09sNHJqvGIH9vnkFOofz23siGkIEYVHISUh4
mvFyBQKiNFUtHjXmg2ScTTFTdP9IQrdcNzCnineaPh4sOFNnPUCdtKl64bxXZfrK5RT4fvUF
teeXy4/Lx83l198/53ca/8TNqd6xHZwywTVwWC2nVFpKDFe9VH7CsVM000xc4oPr6+F52jvb
FVsCatI2/Ya2b8I0BkObD2YV8DZAKSfVi9Z6OCLXWFZHmlWbYvJKzgWMPSxq2IM0tIbvaeJe
uY6fNhN93nGLdTAW/yeME7+KR3kQ3kkp6KyJ30ejniXaTWZwK1xauafCpxcWaqMgGrUS/juK
Cb68NWod5dYk/jseeQyKCTDpBOakwGeQDm2djcTBJTQKmTRhpHFlot1CRJrazLgcm4uie8u5
MyrN6yK5a9JoxKXiL/ugBXMUS/bHE4jp3CQJlBrEychqJMLZOCcym5hqJ6/LWV85GeFzVYfD
2EmVxmzhoweuy1uZVH23kpUo1Xkepu8nM4gK7Ldbi1lQMn/XQiKelcbpQuRtbaI7Q7/nKpaf
9+A3KBdPEkH1bmL+BOueHYviAFDQAy+l3UJmRgM8NNyKh7YmogUh4QzwG8d5cB4ocVzLaT3q
9gSsMURgnaY7N63pLLmH+RjhLOkGwziZhRFF/V6Tp2mNBoxIXBgdL+cA1K8VeyA8EDlR/rvF
G3uYisqQhRIhMboZLK0elQCCuEJ2zdTHt7VAgWXEguQ4/gGYlAbsvOcBAA==

--GvXjxJ+pjyke8COw--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
