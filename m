From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Mon, 20 Jun 2011 12:03:35 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F38227BCFE@AUSP01VMBX24.collaborationhost.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl>
 <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net>
 <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:49857 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab1FTREC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2011 13:04:02 -0400
In-Reply-To: <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Jander <david@protonic.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Saturday, June 18, 2011 6:18 AM, Grant Likely wrote:
> On Sat, Jun 18, 2011 at 4:17 AM, Dmitry Torokhov wrote:
>> On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote:
>>> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
>>>> Use a threaded interrupt handler in order to permit the handler to use
>>>> a GPIO driver that causes things like I2C transactions being done inside
>>>> the handler context.
>>>> Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
>>>> all needed GPIO drivers have been loaded if the drivers are built into the
>>>> kernel.
>>>
>>> ...which is a horrid hack, but until device dependencies can be
>>> described, it isn't one that can be solved easily.
>>>
>>
>> I really do not want to apply this... Currently the order of
>> initialization does not matter since nothing actually happens until
>> corresponding device appears on the bus. Does the OF code creates
>> devices before all resources are ready?
>
> It's not an OF problem.  The problem is that all the platform_devices
> typically get registered all at once at machine_init time (on arm),
> and if the gpio expander isn't a platform_device, (like an i2c gpio
> expander which would end up being a child of a platform_device), then
> it won't be ready.  The real problem is that we have no mechanism for
> holding off or deferring a driver probe if it depends on an
> asynchronous resource.

To avoid the registration order issue, isn't the proper fix to use a "setup"
method in the gpio expander driver?  The gpio-pca953x.c driver has this and
I use it to hook the gpio_keys driver to those gpios.  The registration order
ends up being:

i2c-gpio as a platform_device in the machine init code
pca9539 as part of the i2c_board_info for the i2c-gpio device
gpio-keys as a platform_device via the .setup callback of pca9539

Regards,
Hartley