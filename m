From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] input: spear-keyboard: Use devm_*() routines
Date: Fri, 9 Nov 2012 08:06:29 +0530
Message-ID: <CAKohpo=PdNoBzpZoHWcHSqh_az2OOGGGegNzCXPxjUDVOHostw@mail.gmail.com>
References: <9f07bb7dbf29978970d901bbe89add0a333cc925.1352381962.git.viresh.kumar@linaro.org>
	<20121108163835.GA8877@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121108163835.GA8877@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com
List-Id: linux-input@vger.kernel.org

On 8 November 2012 22:08, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 08, 2012 at 07:10:47PM +0530, Viresh Kumar wrote:
> It also breaks the error unwinding/removal of the driver as it frees
> input device while IRQ handler is still active.

I have heard of this argument before, probably from you. :)
Just need clarification again. How will we get an interrupt when the controller
is stopped, unless we have a shared irq.

> I will push the patch which implements devm_input_allocate_device() to
> my 'next' branch in a few, please use it because it will make sure input
> device will stick around long enough.

Will surely use that.

>> +     kbd->io_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>
> There is devm_request_and_ioremap() which you can use here.

Should have been done in V1 only.

--
viresh
