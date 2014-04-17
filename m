From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH v4 4/9] input: misc: Add driver for
 AXP20x Power Enable Key
Date: Thu, 17 Apr 2014 14:07:59 +0200
Message-ID: <CAOQ7t2Z0ESCsPc6K-i9hKCT0YACEzKvzemw+2YHMarZMdSYzsA@mail.gmail.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
	<1397209093-10077-5-git-send-email-carlo@caione.org>
	<20140413081701.GB7267@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140413081701.GB7267@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, boris.brezillon@free-electrons.com, linux-sunxi@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Sun, Apr 13, 2014 at 10:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

<cut>

>> +static ssize_t axp20x_show_ext_attr(struct device *dev, struct device_attribute *attr,
>> +                                 char *buf)
>> +{
>> +     struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
>> +     struct axp20x_pek_ext_attr *axp20x_ea = get_axp_ext_attr(attr);
>> +     unsigned int val;
>> +     int ret, i;
>> +
>> +     ret = regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
>> +     if (ret != 0)
>> +             return ret;
>> +
>> +     val &= axp20x_ea->mask;
>> +     val >>= ffs(axp20x_ea->mask) - 1;
>> +
>> +     for (i = 0; i < 4; i++)
>> +             if (val == axp20x_ea->p_time[i].idx)
>> +                     val = axp20x_ea->p_time[i].time;
>> +
>> +     return sprintf(buf, "%ums\n", val);
>
> Please do not print ums and instead document the units in sysfs ABI
> docs.

Ok, I'll fix it.

<cut>

>> +     if (device_create_file(&pdev->dev, &axp20x_dev_attr_startup.attr) ||
>> +         device_create_file(&pdev->dev, &axp20x_dev_attr_shutdown.attr))
>> +             return -ENODEV;
>
> I think you still want to use attribute group here. You also need to
> clean up the attributes when unbinding device. Also, why returning
> -ENODEV instead of the proper error code?

I'll fix the error code and I'll add the clean up code.
I'm still a bit puzzled about the attribute group for the platform
devices. IIRC for the platform devices the default attribute group is
still a bit an issue [1]

[1] http://www.spinics.net/lists/hotplug/msg05775.html

Thanks for the review,

-- 
Carlo Caione
