From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] USB: input: gtco.c: fix usb_dev leak
Date: Mon, 27 Jan 2014 14:29:23 +0400
Message-ID: <52E63503.3060804@ispras.ru>
References: <1390087466-9898-1-git-send-email-khoroshilov@ispras.ru> <20140121195957.GB29615@core.coreip.homeip.net> <52E5FD48.7040208@ispras.ru> <20140127065416.GA11945@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140127065416.GA11945@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

On 27.01.2014 10:54, Dmitry Torokhov wrote:
> Hi Alexey,
>
> On Mon, Jan 27, 2014 at 10:31:36AM +0400, Alexey Khoroshilov wrote:
>> On 21.01.2014 23:59, Dmitry Torokhov wrote:
>>> On Sun, Jan 19, 2014 at 03:24:26AM +0400, Alexey Khoroshilov wrote:
>>>> There is usb_get_dev() in gtco_probe(), but there is no usb_put_dev()
>>>> anywhere in the driver.
>>>>
>>>> The patch adds usb_get_dev() to failure handling code of gtco_probe()
>>>> and to gtco_disconnect(().
>>> Hmm, I think gtco should simply not use usb_get_dev() in the first
>>> place.
>>>
>>> Thanks.
>> Dear Dmitry,
>>
>> Could you please clarify why usb_get_dev() not needed here?
>> We store reference to usb_dev in gtco structure, so we should refcount it.
>> What is wrong in this reasoning?
> The lifetime of gtco structure is already directly tied to lifetime of
> usb_dev: when destroying usb_dev driver core will call remove() function
> of currently bound driver (in our case gtco) which will destroy gtco
> memory.
>
> Taking additional reference is not needed here.
>
> Hope this helps.
Thank you, that helps a lot.

By the way, usb_skeleton suggests to use usb_get_dev()/usb_put_dev()
nevertheless.

Greg, may be it makes sense to fix usb_skeleton as well?

--
Alexey
