From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] USB: add API for interface driver to vote for
 autosuspend
Date: Sat, 10 Jun 2017 19:50:45 +0800
Message-ID: <201706101918.GVjap9Ca%fengguang.wu@intel.com>
References: <20170608215828.130455-2-yueyao.zhu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:8518 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbdFJLvP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Jun 2017 07:51:15 -0400
Content-Disposition: inline
In-Reply-To: <20170608215828.130455-2-yueyao.zhu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yueyao Zhu <yueyao.zhu@gmail.com>
Cc: kbuild-all@01.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, Badhri Jagan Sridharan <badhri@google.com>, Dmitry Torokhov <dtor@google.com>, Yueyao Zhu <yueyao@google.com>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yueyao,

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v4.12-rc4 next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yueyao-Zhu/USB-add-API-for-interface-driver-to-vote-for-autosuspend/20170610-172143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   arch/x86/include/asm/uaccess_32.h:1: warning: no structured comments found
   include/linux/init.h:1: warning: no structured comments found
   include/linux/mod_devicetable.h:686: warning: Excess struct/union/enum/typedef member 'ver_major' description in 'fsl_mc_device_id'
   include/linux/mod_devicetable.h:686: warning: Excess struct/union/enum/typedef member 'ver_minor' description in 'fsl_mc_device_id'
   kernel/sched/core.c:2088: warning: No description found for parameter 'rf'
   kernel/sched/core.c:2088: warning: Excess function parameter 'cookie' description in 'try_to_wake_up_local'
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   include/linux/device.h:969: warning: No description found for parameter 'dma_ops'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/iio/iio.h:597: warning: No description found for parameter 'trig_readonly'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'indio_dev'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'trig'
   include/linux/device.h:970: warning: No description found for parameter 'dma_ops'
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'enabled'
   include/linux/usb/gadget.h:408: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:408: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:408: warning: No description found for parameter 'quirk_zlp_not_supp'
>> include/linux/usb.h:263: warning: No description found for parameter 'autosuspend'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_handler'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_preinstall'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_postinstall'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'irq_uninstall'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:524: warning: No description found for parameter 'fops'
   include/drm/drm_color_mgmt.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_plane_helper.c:403: warning: No description found for parameter 'ctx'
   drivers/gpu/drm/drm_plane_helper.c:404: warning: No description found for parameter 'ctx'
   drivers/gpu/drm/i915/intel_lpe_audio.c:355: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:355: warning: No description found for parameter 'link_rate'
   drivers/gpu/drm/i915/intel_lpe_audio.c:356: warning: No description found for parameter 'dp_output'
   drivers/gpu/drm/i915/intel_lpe_audio.c:356: warning: No description found for parameter 'link_rate'
   Documentation/core-api/assoc_array.rst:13: WARNING: Enumerated list ends without a blank line; unexpected unindent.
   Documentation/doc-guide/sphinx.rst:126: ERROR: Unknown target name: "sphinx c domain".
   kernel/sched/fair.c:7650: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1200: ERROR: Unexpected indentation.
   kernel/time/timer.c:1202: ERROR: Unexpected indentation.
   kernel/time/timer.c:1203: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:122: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:125: ERROR: Unexpected indentation.
   include/linux/wait.h:127: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:990: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:322: WARNING: Inline literal start-string without end-string.
   include/linux/iio/iio.h:219: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:226: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/iio/industrialio-core.c:638: ERROR: Unknown target name: "iio_val".
   drivers/iio/industrialio-core.c:645: ERROR: Unknown target name: "iio_val".
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1898: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/pci/pci.c:3456: ERROR: Unexpected indentation.
   include/linux/regulator/driver.h:271: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   include/linux/spi/spi.h:370: ERROR: Unexpected indentation.
   drivers/gpu/drm/drm_scdc_helper.c:203: ERROR: Unexpected indentation.
   drivers/gpu/drm/drm_scdc_helper.c:204: WARNING: Block quote ends without a blank line; unexpected unindent.
   drivers/gpu/drm/drm_ioctl.c:690: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/gpu/todo.rst:111: ERROR: Unknown target name: "drm_fb".
   sound/soc/soc-core.c:2670: ERROR: Unknown target name: "snd_soc_daifmt".
   sound/core/jack.c:312: ERROR: Unknown target name: "snd_jack_btn".
   Documentation/userspace-api/unshare.rst:108: WARNING: Inline emphasis start-string without end-string.
   Documentation/usb/typec.rst:: WARNING: document isn't included in any toctree
   Documentation/usb/usb3-debug-port.rst:: WARNING: document isn't included in any toctree
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 69: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 82: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 96: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 109: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 122: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 133: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 164: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "/home/kbuild/.config/fontconfig/fonts.conf", line 193: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 43: Having multiple values in <test> isn't supported and may not work as expected
   Fontconfig warning: "~/.fonts.conf", line 56: Having multiple values in <test> isn't supported and may not work as expected

vim +/autosuspend +263 include/linux/usb.h

^1da177e Linus Torvalds       2005-04-16  247  	enum usb_interface_condition condition;		/* state of binding */
7e61559f Alan Stern           2007-11-06  248  	unsigned sysfs_files_created:1;	/* the sysfs attributes exist */
3b23dd6f Alan Stern           2008-12-05  249  	unsigned ep_devs_created:1;	/* endpoint "devices" exist */
352d0263 Alan Stern           2008-10-29  250  	unsigned unregistering:1;	/* unregistration is in progress */
645daaab Alan Stern           2006-08-30  251  	unsigned needs_remote_wakeup:1;	/* driver requires remote wakeup */
55151d7d Alan Stern           2008-08-12  252  	unsigned needs_altsetting0:1;	/* switch to altsetting 0 is pending */
78d9a487 Alan Stern           2008-06-23  253  	unsigned needs_binding:1;	/* needs delayed unbind/rebind */
04a723ea Sarah Sharp          2010-01-06  254  	unsigned resetting_device:1;	/* true: bandwidth alloc after reset */
4ad2ddce Stefan Koch          2015-08-25  255  	unsigned authorized:1;		/* used for interface authorization */
cb66a852 Yueyao Zhu           2017-06-08  256  	unsigned autosuspend:1;		/* interface allows autosuspend */
4d064c08 Alan Stern           2006-07-01  257  
^1da177e Linus Torvalds       2005-04-16  258  	struct device dev;		/* interface specific device info */
969ab2ee Greg Kroah-Hartman   2008-01-30  259  	struct device *usb_dev;
ccf5b801 Alan Stern           2009-06-29  260  	atomic_t pm_usage_cnt;		/* usage counter for autosuspend */
dc023dce Inaky Perez-Gonzalez 2008-11-13  261  	struct work_struct reset_ws;	/* for resets in atomic context */
^1da177e Linus Torvalds       2005-04-16  262  };
^1da177e Linus Torvalds       2005-04-16 @263  #define	to_usb_interface(d) container_of(d, struct usb_interface, dev)
^1da177e Linus Torvalds       2005-04-16  264  
^1da177e Linus Torvalds       2005-04-16  265  static inline void *usb_get_intfdata(struct usb_interface *intf)
^1da177e Linus Torvalds       2005-04-16  266  {
^1da177e Linus Torvalds       2005-04-16  267  	return dev_get_drvdata(&intf->dev);
^1da177e Linus Torvalds       2005-04-16  268  }
^1da177e Linus Torvalds       2005-04-16  269  
^1da177e Linus Torvalds       2005-04-16  270  static inline void usb_set_intfdata(struct usb_interface *intf, void *data)
^1da177e Linus Torvalds       2005-04-16  271  {

:::::: The code at line 263 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICH/TO1kAAy5jb25maWcAjFxZc+M4kn6fX8Ho2YfuiO2q8lEeT2z4AQJBCWOSYBOgJPuF
oZZZVYqyJa+Omap/v5kAKV4J9U7EzJSRiTuPLxNJ/f1vfw/Y6bh7Wx0369Xr68/ga7Wt9qtj
9RJ82bxW/xOEKkiVCUQozQdgjjfb04+Pm5v7u+D2w9X1h0+/79fXwWO131avAd9tv2y+nqD7
Zrf929+Bnas0ktPy7nYiTbA5BNvdMThUx7/V7cv7u/Lm+uFn5+/2D5lqkxfcSJWWoeAqFHlL
VIXJClNGKk+Yefilev1yc/07LuuXhoPlfAb9Ivfnwy+r/frbxx/3dx/XdpUHu4nypfri/j73
ixV/DEVW6iLLVG7aKbVh/NHkjIsxLUmK9g87c5KwrMzTsISd6zKR6cP9JTpbPlzd0QxcJRkz
fzlOj603XCpEWOppGSasjEU6NbN2rVORilzyUmqG9DFhthByOjPD3bGncsbmosx4GYW8peYL
LZJyyWdTFoYli6cql2aWjMflLJaTnBkBdxSzp8H4M6ZLnhVlDrQlRWN8JspYpnAX8lm0HHZR
WpgiKzOR2zFYLjr7sofRkEQygb8imWtT8lmRPnr4MjYVNJtbkZyIPGVWUjOltZzEYsCiC50J
uCUPecFSU84KmCVL4K5msGaKwx4eiy2niSejOaxU6lJlRiZwLCHoEJyRTKc+zlBMiqndHotB
8HuaCJpZxuz5qZxqX/ciy9VEdMiRXJaC5fET/F0monPv2dQw2DcI4FzE+uG6aT9rKNymBk3+
+Lr58+Pb7uX0Wh0+/leRskSgFAimxccPA1WV+R/lQuWd65gUMg5h86IUSzef7umpmYEw4LFE
Cv6nNExjZ2uqptbwvaJ5Or1DSzNirh5FWsJ2dJJ1jZM0pUjncCC48kSah5vznngOt2wVUsJN
//JLawjrttIITdlDuAIWz0WuQZJ6/bqEkhVGEZ2t6D+CIIq4nD7LbKAUNWUClGuaFD93DUCX
snz29VA+wm1L6K/pvKfugrrbGTLgsi7Rl8+Xe6vL5FviKEEoWRGDRiptUAIffvl1u9tWv3Vu
RD/pucw4Oba7fxB/lT+VzIDfmJF80YylYSxIWqEFGEjfNVs1ZAU4ZVgHiEbcSDGoRHA4/Xn4
eThWb60Un808aIzVWcIDAEnP1KIj49ACDpaDHXF60zMkOmO5FsjUtnF0nloV0AcMluGzUA1N
T5clZIbRnefgHUJ0DjFDm/vEY2LFVs/n7QEMPQyOB9YmNfoiEZ1qycJ/FdoQfIlCM4draY7Y
bN6q/YE65dkzegypQsm7gp4qpEjfTVsySZmB5wXjp+1Oc93lcegqKz6a1eF7cIQlBavtS3A4
ro6HYLVe707b42b7tV2bkfzRuUPOVZEad5fnqfCu7Xm25NF0OS8CPd418D6VQOsOB3+CBYbD
oKycdszd7nrQHw2zxlHIc8HRAY3FMdrTRKXEHMjicI+Y8ol1Ld3hcyEsi4Vz5BzWkwCaSq9p
HZeP7h8+DS0AvToHBEgldPLWXQKf5qrING0/ZoI/ZkqCx4fbNyqnl+hGRm9gx6KPCsEVvcH4
Eezc3HqyPCS2wfkZSKAZQNG2cDvloreRARviMWI0loLnkimgeD1wGYUMrzqwH/XZxCA9XGQW
Udk7GvTJuM4eYUkxM7imluqErru+BAy5BGua02cIQCoBYStrM0IzPelIX+QAWAfIZ6ymrbuB
nvopoYlZDlf96BHDKd2lfwB0X8BMZVR4lhwVRixJisiU7yDkNGVxFJJEu3sPzVpaD22SRZdP
fwaelKQwSft2Fs4lbL0elD5zlAjr5D2rgjknLM9lX26a7WDcEIpwKJUwZHn2OJ27uvrUQxnW
mtYxc1btv+z2b6vtugrEv6stmG8GhpyjAQc305pZz+A1gkcibKmcJxbIk1uaJ65/aS28T1Kb
ODKnBVLHjEIlOi4m3WXpWE28/csI7C/a5DIHAKToy4XbMxBKIkYoAfnKSHIbYXk0SEUyHjit
7tUox9GxI01LmSbSyW53/f8qkgzAx0TQMlkHPrTXxvlsxgPiX1AYtNGcC619axMR7E3ixUC4
0+sxwE54weiXwGWWE71gQ4gvwVNgOgAWZwakx2Gk5lpzYUgCWHS6g2vFcCii7DKc5aDFLtyy
zpR6HBAxIwF/GzktVEGgNAi5LG6q8SeRCIBQvwbaRLwM8e0TwHeEitbE23TSYAm5mGpwTqFL
79TnXrJsuA9cKrQ6fRvQZgtQF8Gcyx7QErmE62zJ2s44dIFgjKDdFHkKcNCArHdzXUPbQpyy
pRIDN3Yhr7cXFslQaOxpteI+OmN3q6VmkQA0nGFqZzhCLbPufG02YcBR93NhrIcWqsKTF4Ew
q3TBRhMaEzvQgqPlKkGlzejwpgBSsriYyrRnOzvNPt0EDntyqFKCAxQbQJ8+kUZRfR644HQI
oAYccJFFzGjAMuaGY1d+w+eOUZoZ2AwnA1EOEe1QUAj871HkFAM/Uaer+nedqLCIwTqgnRIx
CuRYnLSjWLs/ztyNU6MDBrEEs0pag36v+/4tquypyf2YuCcD7bSwNjpMx9zopLBGgbrgGO4T
sBZ/XLA87KxXQfwAgKnO/N2MCMymtnuSAOEZRIOtP4iiCy7GLnqOu7b3SiMh5FEWR7O4yXnk
Cxr3+ZibdAiF6s922IC9Np1O3by5lzTs7gSo5nFZOa7mv/+5OlQvwXcHmN73uy+b115sex4G
ucvGr/eSAs4M1G7FuZ2ZQDHu5A4RLmvETw9XHRzoZJrYeyPtNpiMwbkVvfTWBCM+optNycJE
GShkkSJTP4dS062sOvolGtl3kUsjfJ27xH7vfm6XGYWeM08WAw7U7j8KUaDFh03YrI2fJV80
DG3kAQf23MfV9q6z/W5dHQ67fXD8+e7yGV+q1fG0rw7dx6Rn1LfQkxMExEC2Yz47Egw8LLgz
tH9+Lsw4NayYp6VZp6DFkfRZDIDXIOohIEDvPGJpwCzgI8OlGK7Ow8tc0stwOQC4KePsemlB
hifYnT0BHoDQCJzGtKAz0GB+JkoZl7pvleD2/o6Okj5fIBhNxyFIS5IlpVJ39gGw5QTLCcF7
IiU90Jl8mU4fbUO9pamPno09/sPTfk+387zQik7gJNbSC09MkyxkymcAfjwLqck3vvg1Zp5x
p0KFYrq8ukAtY9pFJPwpl0vvec8l4zclnc23RM/ZcQhcPL3QDHk1ozbonpdlqwiYcaqfC/VM
Rubhc5clvhrQesNn4ErAFKScSmghA9o5y2QzdrroJKKQDArQb6ix7t3tsFnN+y2JTGVSJBYR
RBDBxE/9ddsohJs40T1ACkvB8AVBoYgBHVJwBUYEG+9MVCf5Xjfb++29yTcUloQEO6gQK/Ix
wQLFREDsTo1VJNy1t6Ypg0DORuHkZYcJBb1S+zqrwV2f9y9EkpkRxG7a5yoGbMtyOiNac3ml
DQ8hk7RNs5fWlxPn0zrpnbfddnPc7R10aWftBHZwxmDAF55DsAIrADc+Aezz2F0vwSgQ8Qnt
juQ9jR5xwlygP4jk0pesBpAAUgda5j8X7d8P3J+kDViq8PljkPprpMVRbntPGHXj3S0VC80T
ncXgJG96XdpWxL2eA3Us13QetiX/5QhX1LpsZYECnC/Mw6cf/JP7z2CfA3QVAWCA1lKkjCg0
sJGyn2ztQvM2CRC2awRkjOIVNxgCX+EK8XBezcW+zaISlhY2xm8hynlFjkacQt25P1ppTbfr
10latMNB2GNkx8K6fItIJn3c22uuB+0O6AqFpOYQvnW796OtGhW50oF0IO7npeE9Z8ZOZC3T
7SCvyv0ZzNkT6H8Y5qXxlkvNZQ5GUmEw2ntI15SONG/YNi52T5xh/nD76Z933XewcThP2dlu
LcxjDxnyWLDUulA6W+GB6c+ZUnRm9XlS0PbgWY9T2w0Wr+M6W3nSZEF9cQ2ci8jzfrrKPoIN
bUlm/CbN+vtyIhWWeeR5kQ3vtWdBNaBuDBEXD3cdgUhMTttFu94LmXEcFA7DH+i48AOwBh0y
uEwZHSE8l1efPlEW97m8/vypd0TP5U2fdTAKPcwDDDMMX2Y5vk7T72ZiKXxFFkzPbEKTMqug
TZKDKQMbkaNlvaoN67l7LjAZaZ9oL/W3uU3ofz3oXr+SzENNP0HxJLTR9sQn52A+ZfRUxhAj
Eo9fXUlwdrwxuzNlMGXZ5Eey3X+qfQD4YvW1equ2Rxs1M57JYPeOVZi9yLlORdH2x/MKE/WA
V1N2EET76n9P1Xb9MzisV68DSGNRay7+IHvKl9dqyOytjbAHgOZHn/nw9SqLRTgafHI6NJsO
fs24DKrj+sNvPajFx5sJq8Pm63ax2lcBkvkO/qFP7++7PSyjPmNoF9uX991mexwMB5cTWm95
KXFIJYFcuWX9ztDt4InyUQBJkoo9RUggubT+p8J8/vyJjv4yjl7Qb3WedDQZHaH4Ua1Px9Wf
r5WtGQ4s4D0ego+BeDu9rkZiOAEfmhjMA5MT1WTNc5lRXtAlP1XRM9h1J2y+NGgiPTkJjEA9
tqRW9Zth1VydIJPKOZvu+RJS9u8NRADhfvNv96jblhxu1nVzoMYaW7gH25mIM19kJOYmyTx5
YrB+acgwQe0LeOzwkcyTBaAAV/RCskYL8F8s9CwCHfPCVpNQ59hZK75Vh7mcezdjGcQ89yTo
HANm5ephwI5D8OypjwFE1aa86CxeU+YFxgWmlZzM9Ha5sNymqaDrhKfMFe2GcIRRROQ20Ti9
WCHo3W9i6ONWEbEM98yB1djn2mvAbnUhenuprmm0gmRzWFNLgNtKnjARTC5EpDxWGlOhCGKG
59Medc5o/8GvycUIAWeYBIezoW0ntJTynzd8eTfqZqofq0Mgt4fj/vRmayUO38ByvwTH/Wp7
wKEC8EVV8AJ73bzjPxtVY6/Har8KomzKwEjt3/6DBv9l95/t6271Erh644ZXbo/VawC6bW/N
KWdD01xGRPNcZURrO9Bsdzh6iXy1f6Gm8fLv3s+Zcn1cHasgaf3/r1zp5LehpcH1nYdrz5rP
POhlGdvnEC+RRUWjgCrzPp7K8Fw0qbmWtfR1bv3s3rREQNSLGrHNl+VPGAefqxD/2UWMSyPl
9v10HE/Yeto0K8ZiOYObsJIhP6oAu/ThE9Z2/v/00rL2nppZIkhN4CDAqzUIJ6WbxtCZKjBV
vpooID36aLgqwLRopwewpD2XLJGlK0v2vCEsLoUm6dxnCDJ+/4+bux/lNPMUbaWa+4mwoqmL
ufw5QsPhvx4YC/EQH77HOTm55qR4eKo+dUZnvnWW0ISZHkPODDSGmDPLxmKMbfUXWTtbc9wH
piYL1q+79fchQWwtGoMoBmvIMSQAUIJfSmBgY48QkEGSYb3UcQezVcHxWxWsXl42iEBWr27U
w4fu8vBuBhXpZ9rCgyYxlVmyuafq0VIxOqYhm6Nj3B7TWjBbJJ5kipmJPGF04NXUpVP5Gz3p
fqDjDNduu1kfAr153ax322CyWn9/f11teyEM9CNGm3BABcPhJnvwN+vdW3B4r9abLwD+WDJh
PXQ8yJk45316PW6+nLZrvJ/GrL2cbXxrGKPQQjDaaiIxV7r0RNQzg4AC4t4bb/dHkWQehIjk
xNzd/NPzxgNknfjiDjZZfv706fLSMUz2PZUB2ciSJTc3n5f47MJCz9MjMiYeI+PKbowHKiYi
lKxJI40uaLpfvX9DQSEUO+y/7To8wrPgV3Z62ezAnZ8fvn/zf0IJg5SgfoTxtVzRfvVWBX+e
vnwBTxKOPUlEKy6WrcTWc8U8pDbXZrGnDPOtHqStipQqIS9AodQMwuRYGgOhO0TLknXKt5A+
+pYSG88VHTPeQwWFHoef2Gah30sf82B79u3nAT9sDeLVT3SxY43B2cAo0i5JZZa+5ELOSQ6k
Tlk4JUI+O73NzoTVK0770xpi8/O9+p37VlLEmfT65mJBX2KSeIRdJNqbWEsFRHQipGdyVZBy
IuHenoh7FSHjTfwLcXrR+RLRkkZ3moNpAentNyT86vbu/uq+prR6aPD7HKY9IWDCiEjNRdkJ
g/CLzHw9pRxLAz1ZpmIZSp35vpQoPPbCpuN9AHS+2cMqqHvGblLBrfWHrYO09X532H05BjOQ
k/3v8+DrqYLQgbAqLrJFYzfM2nfD/+mgJrqXzmkqT6jQt4X7M4jHxJl3vNMzaNbvm61FIwNF
5LZR7077ntNqxo8fdc5LeX/9uVMjB61ibojWSRyeW9sLNImIy0zSpgvCBIsaS578BUNiCroM
4cxhEvqTJJHUDKBxnpBFxhNFZ+SkSpLC61ry6m13rDDko6QJ8x8GY2Y+7vj+dvg6vAwNjL9q
+wlXoLYQfmzef2vByCBsPKMVvePDgTYfkuWgvT2uIl1Kf1IA1lB6jglJzx4vk1lBHSaW2ytY
Gi8+sLlz+uw9yp0tqEc1BsoyBaOXsGWZ5t06QZlhba3PdFuUa0vdcxX7QqsoGd8huqbuN3ej
zJXPdyHQz5asvL5PE4xCaBfR4wIHREs/QNLyUaXMcvhnRLzOPc9SCR87bqI2gjJ0ORvbHLZ9
2e82L102wEW58tQShMyTCveG0drQ7e5pzcxGK7KZpR566zwjtFeMXKOuECMS+46I0DFqUlfh
WOlE6EndNtld2Kvv1TAUcVzmE9q2hTycMF8VpJrG4jwFkbD7ul91Em69jFaEjwVOsjv+IHQF
WRCtdr6C6RxK/a0d43R4J5ZoRIHNPfcrT9WKrRBGDp9/hBFEyvOn0ctuh8N+quHJ0FygSUcr
vR8lRuxC7z8KZeismKVwQ58L5q0jfVt6XgoiLGXz0BQAHMBGA7ITvdX62yDQ0KNqAKfsh+r0
srMPRO2Vt7YD/JdvekvjMxmHuaBvAkvLfS8g+OkmHe2639C4TC292Mr9H0iJZwB8abJS5r5j
o5nSeHyk9XeB31br7/0PuO0vz8j8jyhmU92B2LbX+36zPX63EcbLWwVuvwXB7YK1skI/tb/B
0RSIPPzjXH0LuobFECOO2/qyd2/vcH2/26/N4d7X3w92wrVr31PA2z3YYNEMra3ubRtsB/7G
T5YLDiGm5xPS+hm8sD/CIsjaelcCjaM9XH26vu2a81xmJdNJ6f0IF4vq7QxM06a/SEFHMA2R
TJTno1JXzbVILz5vRWS+XODjmnY7G3/fqYX7HSSQqgTzV7SsD5jcsao0pkK49vOqXt34oFD/
ryrK6x0p+4MPgj02VUIeCIzQCfSh/9bUG8p9JdJIdQLQF+LmsPrz9PXrsG4Sz9oW0WufhR78
uo3/ymCLWqU+V+CGyZX9FHX4yy0DLjX5F9yC90Wk3iR44hhOa3zPDeXCDO4jrkL7DJPjmtPo
tc6q1DwQiA5q9XqEC8PXxShYNnWB60IBZ3sYdj/oYqLY/vgItd2G7BvJbgzPbqQ+58ZLJzob
vH7WT/YgdEEMoevp3dm52Wr7tWfcED8UGYwy/vqvMwUSwZ+k7lctSKbFH2RauiOkKWgOqLai
X9t69GHZpiNidIo1E6PiK69tdmQnbvjTVX91jDjDoxAZ9dMheIytGge/HupUweG/g7fTsfpR
wT/+r5GrWXIThsGv0ifobJpOp1cgJOsNa6ghf3th2k4Oe+pMunvYt68kGwxGUnpMJMDYsiQs
fR+263yeN+yE9QkoI80ekcxA7Rk4nbwSItNPTdbxLtTrUuaouAxXH/XkkW6Ax6XKQ4bjswqm
7M5Y4DGEPW7LaisjkuihYIYjcIk3tXEews2kk6PAdacMbe+dnTZ4ozrLxtzTaDWPPCCltWUv
XLlBmE/GZFpIL8OHFlpgiX0mEB8hfYwWGu+uBN0Am/9Vjf+6jbxSRMTzI3h8bXsEqqfeyfF7
mO++dK524DieSrmf2TcfszpDPjXC0gVSRXLt24MtIg1MCuwepTuXNY+8zsABwBIWzIUElOZw
9EH8TNhoUCjg6zRRCV2cfgwe6p8i3cOF/i5RiFfgFo8TEGdxsbLecpHdCZLw7vr3LbFd6o0i
bo1WKuWQiijN44IgUlu2u5yAr6Lc+7dvX3VHQ2N5LM9iz5gfLKTvdhfa4PjtTnp7UOyEQ1ZS
IKYdvu2Q5LnppCMSkh8ktApJHULIFy3FybtKKPMZwYQygo3I6ASpjjjPlJtaz6bCd6xH/5Y9
NzzieZJr7Tazkg3+1hLOQ95mFu4M+SLyRHlodjSVSNjhFW3dW4m3iDT05PZIQI3WtyWWswIi
lj0gmczr1kM6BNosjyRQeJmofNKh1cpF66ijOV7eWj0bxgJ2n6ZcVb6tDhII2VcVYJfK1DNY
hBK8r6k9M2vfXZqyfzh/f4gpZSqDOV7xMm+uke5zLiWc3noho4dN26KjQDgcGDWU7THq2KQf
dpzSELOmQ5zmy0WTKbtzJEEbOFeVdYOMRChHjODOfitE4eaA1KPoXZeD8RWe6+/32+vbB3cc
sy8vwjlZWRyc6S7ghsqW6hXEyKDq8gcZRIiTOci64OsBYzyRb1A2nSX8KQs1KRftIEKjDmLO
lr3QyfrFV8km4LBUOqdlxXNemVP1OIM8ha9j8yLTUeXGZu7CRBv/MfT66/bz9vHp9ucdovd1
ckY38h51zhYwa1tshcUXZ6iRQKUqrSDdGjvwGueGobVE6MLQuJ6IxL8Z2g7iSiCCvaYycwKt
whV9UZiONyGQrnicKl7XrR42ho/SKDYdZLySdM2XsEDC9yVVJqerJJBRwcP6iXs1MJp6fACD
RY+5EjXtrL/oudD5BXnOFVGfF0+skba4alP8pP8LHfoc60jxkVh+Z3mHretGLJWgArU6SAqY
0wovvtnwH0fEQyuyDAYkpSRMsYOpVbbYtJAZyxgsxrueQiYI/wFzsUHX/V4AAA==

--k1lZvvs/B4yU6o8G--
