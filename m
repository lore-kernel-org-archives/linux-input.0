From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 6/6] Input: Add ChromeOS EC keyboard driver
Date: Mon, 18 Feb 2013 20:13:42 -0800
Message-ID: <CAPnjgZ3Y88uwrwF7M7-EijA3N8y_jgbcOBeSNtM6T6iG8hW0RQ@mail.gmail.com>
References: <1360988172-15380-1-git-send-email-sjg@chromium.org>
	<1360988172-15380-7-git-send-email-sjg@chromium.org>
	<20130216204954.GA22044@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130216204954.GA22044@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Luigi Semenzato <semenzato@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Mike A. Chan" <mikechan@google.com>, Jun Nakajima <jun.nakajima@intel.com>, Tom Keel <thomas.keel@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Sat, Feb 16, 2013 at 12:49 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Simon,
>
> On Fri, Feb 15, 2013 at 08:16:12PM -0800, Simon Glass wrote:
>> +     for (row = 0; row < ckdev->rows; row++) {
>> +             if (cros_ec_keyb_row_has_ghosting(ckdev, buf, row))
>> +                     return true;
>> +     }
>
> No need for curly braces here. I would not care if not for below.

OK I dont't think I even knew about that rule. Actually, what is that rule?

>
>> +
>> +     return 0;
>> +
>> +fail_register:
>> +     kfree(idev->keycode);
>
> Sorry I did not notice this before, but idev->keycode is devm-managed,
> so you either need to use devm_kfree() or just remove call to kfree()
> and let it clean up automatically (which will happen if binding fails or
> upon removal).
>
> BTW, maybe you should move the whole driver to devm_*? We have
> devm_kzalloc() for ckdev and you can use devm_input_allocate_device().
> Then you can get rid of entire erro handling path and completely remove
> the remove() method as well.

Yes I was thinking about that - might as well do it now.

>
>> +fail_matrix:
>> +     input_free_device(idev);
>> +fail_alloc_dev:
>> +     kfree(ckdev);
>> +     return err;
>> +}
>> +
>
> Thanks.
>
> --
> Dmitry

Regards,
Simon
