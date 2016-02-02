From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 3/3] input: touchscreen: ad7879: add device tree
 support
Date: Tue, 02 Feb 2016 14:35:42 -0800
Message-ID: <52a499dc71c2d75acd258446860eb011@agner.ch>
References: <201601301057.HOqi7vdd%fengguang.wu@intel.com>
 <alpine.DEB.2.02.1601300804310.2052@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1601300804310.2052@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org
List-Id: linux-input@vger.kernel.org

Hi Julia,

On 2016-01-29 23:06, Julia Lawall wrote:
> I haven't checked the entire context, but it look suspicious to have the 
> kfree in the remove function and not in the probe function.
Oh, yes, clearly an error I introduced. Will take a look at that.

> 
> Unrlatedly, do the probe and remove functions really needed to be 
> exported?
They are required in two variants of the driver, -spi and -i2c... Hence
I guess yeah.

--
Stefan

> 
> On Sat, 30 Jan 2016, kbuild test robot wrote:
>>
>> Hi Stefan,
>>
>> [auto build test WARNING on input/next]
>> [also build test WARNING on v4.5-rc1 next-20160129]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Stefan-Agner/input-touchscreen-ad7879-move-header-to-platform_data-directory/20160130-075110
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
>> :::::: branch date: 2 hours ago
>> :::::: commit date: 2 hours ago
>>
>> >> drivers/input/touchscreen/ad7879.c:676:1-6: WARNING: invalid free of devm_ allocated data
>>
>> git remote add linux-review https://github.com/0day-ci/linux
>> git remote update linux-review
>> git checkout 0e522b6d5ce3104accf736302f6de5386b9af789
>> vim +676 drivers/input/touchscreen/ad7879.c
>>
>> b4be468c Michael Hennerich 2009-03-09  660
>> ec51b7f5 Michael Hennerich 2010-01-19  661  err_remove_gpio:
>> 4397c98a Mike Frysinger    2010-06-30  662  	ad7879_gpio_remove(ts);
>> b4be468c Michael Hennerich 2009-03-09  663  err_remove_attr:
>> 4397c98a Mike Frysinger    2010-06-30  664  	sysfs_remove_group(&dev->kobj, &ad7879_attr_group);
>> 4397c98a Mike Frysinger    2010-06-30  665  err_out:
>> 4397c98a Mike Frysinger    2010-06-30  666  	return ERR_PTR(err);
>> b4be468c Michael Hennerich 2009-03-09  667  }
>> 4397c98a Mike Frysinger    2010-06-30  668  EXPORT_SYMBOL(ad7879_probe);
>> b4be468c Michael Hennerich 2009-03-09  669
>> 4397c98a Mike Frysinger    2010-06-30  670  void ad7879_remove(struct ad7879 *ts)
>> b4be468c Michael Hennerich 2009-03-09  671  {
>> 4397c98a Mike Frysinger    2010-06-30  672  	ad7879_gpio_remove(ts);
>> 4397c98a Mike Frysinger    2010-06-30  673  	sysfs_remove_group(&ts->dev->kobj, &ad7879_attr_group);
>> 4397c98a Mike Frysinger    2010-06-30  674  	free_irq(ts->irq, ts);
>> b4be468c Michael Hennerich 2009-03-09  675  	input_unregister_device(ts->input);
>> b4be468c Michael Hennerich 2009-03-09 @676  	kfree(ts);
>> b4be468c Michael Hennerich 2009-03-09  677  }
>> 4397c98a Mike Frysinger    2010-06-30  678  EXPORT_SYMBOL(ad7879_remove);
>> b4be468c Michael Hennerich 2009-03-09  679
>> b4be468c Michael Hennerich 2009-03-09  680  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>> b4be468c Michael Hennerich 2009-03-09  681  MODULE_DESCRIPTION("AD7879(-1) touchscreen Driver");
>> b4be468c Michael Hennerich 2009-03-09  682  MODULE_LICENSE("GPL");
>>
>> :::::: The code at line 676 was first introduced by commit
>> :::::: b4be468cc1e65110d9144751bf7079dad6f142b7 Input: add AD7879 Touchscreen driver
>>
>> :::::: TO: Michael Hennerich <michael.hennerich@analog.com>
>> :::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
