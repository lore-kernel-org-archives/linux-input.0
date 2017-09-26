From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] Input: add support for the Samsung S6SY761
 touchscreen
Date: Tue, 26 Sep 2017 14:53:39 +0900
Message-ID: <20170926055339.GC6393@gangnam>
References: <CGME20170926010324epcas3p3ab00a816cff8082d2f093efa82a1037e@epcas3p3.samsung.com>
        <201709260816.p8Srr1ks%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <201709260816.p8Srr1ks%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Ops, sorry,

this patch must have come from the wrong branch on my PC as this
driver has also been tested as module :/

Sorry,
I will send the patch v4 with this fix.

Andi

On Tue, Sep 26, 2017 at 09:02:41AM +0800, kbuild test robot wrote:
> Hi Andi,
> 
> [auto build test ERROR on input/next]
> [also build test ERROR on v4.14-rc2 next-20170922]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Andi-Shyti/Input-add-support-for-the-Samsung-S6SY761-touchscreen/20170926-080648
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from drivers/input/touchscreen/s6sy761.c:19:0:
> >> drivers/input/touchscreen/s6sy761.c:539:26: error: 'stmfts_id' undeclared here (not in a function)
>     MODULE_DEVICE_TABLE(i2c, stmfts_id);
>                              ^
>    include/linux/module.h:212:21: note: in definition of macro 'MODULE_DEVICE_TABLE'
>     extern const typeof(name) __mod_##type##__##name##_device_table  \
>                         ^~~~
> >> include/linux/module.h:212:27: error: '__mod_i2c__stmfts_id_device_table' aliased to undefined symbol 'stmfts_id'
>     extern const typeof(name) __mod_##type##__##name##_device_table  \
>                               ^
> >> drivers/input/touchscreen/s6sy761.c:539:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
>     MODULE_DEVICE_TABLE(i2c, stmfts_id);
>     ^~~~~~~~~~~~~~~~~~~
> --
>    In file included from drivers/input//touchscreen/s6sy761.c:19:0:
>    drivers/input//touchscreen/s6sy761.c:539:26: error: 'stmfts_id' undeclared here (not in a function)
>     MODULE_DEVICE_TABLE(i2c, stmfts_id);
>                              ^
>    include/linux/module.h:212:21: note: in definition of macro 'MODULE_DEVICE_TABLE'
>     extern const typeof(name) __mod_##type##__##name##_device_table  \
>                         ^~~~
> >> include/linux/module.h:212:27: error: '__mod_i2c__stmfts_id_device_table' aliased to undefined symbol 'stmfts_id'
>     extern const typeof(name) __mod_##type##__##name##_device_table  \
>                               ^
>    drivers/input//touchscreen/s6sy761.c:539:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
>     MODULE_DEVICE_TABLE(i2c, stmfts_id);
>     ^~~~~~~~~~~~~~~~~~~
> 
> vim +/stmfts_id +539 drivers/input/touchscreen/s6sy761.c
> 
>    534	
>    535	static const struct i2c_device_id s6sy761_id[] = {
>    536		{ "s6sy761", 0 },
>    537		{ },
>    538	};
>  > 539	MODULE_DEVICE_TABLE(i2c, stmfts_id);
>    540	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
