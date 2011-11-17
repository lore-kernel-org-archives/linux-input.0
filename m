From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Thu, 17 Nov 2011 15:39:15 +0000
Message-ID: <4EC52AA3.8090902@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com> <4EC3F2AD.5080505@edigma.com> <20111116192749.GA26909@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:34534 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab1KQPjS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 10:39:18 -0500
In-Reply-To: <20111116192749.GA26909@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On 11/16/2011 07:27 PM, Dmitry Torokhov wrote:
> Hi Nuno,
>
> On Wed, Nov 16, 2011 at 05:28:13PM +0000, Nuno Santos wrote:
>>      Why? I thought this thing is an input device? Why does an
>> application have to modify a running device? Is this modification
>> local to the application<->device interface or does it also affect
>> all other running applications that use this device? If it is a
>> configuration value to put the device into a different state or
>> similar, then you can use a sysfs attribute. The user can change
>> this with "echo<value>  >/sys/class/input/inputX/<attribute>"
> Any chance you could use some sane quoting style? It is almost
> impossible to dechipher where someone else's mail stops and your reply
> starts.
Yes, sorry.
>
>> I'm already with working examples of ATTRIB in my driver project.
>> The thing is that I have random kernel panics when I try to read
>> from the attribute. This is my attribute code:
>>
>> static ssize_t usbtouchscreen_get_state(struct device *dev, struct
>> device_attribute *attr, char *buf)
>> {
>>      int count=0;
>>      struct usbtouch_usb *usbtouch = dev_get_drvdata(dev);
>>      struct dpx_priv *priv = usbtouch->priv;
>>
>>      printk(KERN_INFO "state length: %d",sizeof(DPX_DEVICE_STATE));
>> // size = 43196 bytes
> So it is probably 39K more than sysfs attribute can handle.
Ok, I found on documentation that buffer size is maximum PAGE_SIZE
>
>>      memcpy(buf,(void*)&priv->context->State,sizeof(DPX_DEVICE_STATE));
> and you are smashing kernel stack here.
Now that i'm copying the proper amount of data I have another problem. 
I'm actually reading this attribute constantly when I open my control 
panel, however it seems that I can only have reading results from second 
to second. Is there anything that limits the amount of times I can push 
attribute data per second? I would definitily need at least 40 readings 
per second in order to have my data visualized in control panel.

Thanks,

Nuno
