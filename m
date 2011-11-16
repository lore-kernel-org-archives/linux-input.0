From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Wed, 16 Nov 2011 17:28:13 +0000
Message-ID: <4EC3F2AD.5080505@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:52644 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab1KPR2P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 12:28:15 -0500
In-Reply-To: <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

     Why? I thought this thing is an input device? Why does an 
application have to modify a running device? Is this modification local 
to the application<->device interface or does it also affect all other 
running applications that use this device? If it is a configuration 
value to put the device into a different state or similar, then you can 
use a sysfs attribute. The user can change this with "echo <value> 
 >/sys/class/input/inputX/<attribute>"

I'm already with working examples of ATTRIB in my driver project. The 
thing is that I have random kernel panics when I try to read from the 
attribute. This is my attribute code:

static ssize_t usbtouchscreen_get_state(struct device *dev, struct 
device_attribute *attr, char *buf)
{
     int count=0;
     struct usbtouch_usb *usbtouch = dev_get_drvdata(dev);
     struct dpx_priv *priv = usbtouch->priv;

     printk(KERN_INFO "state length: %d",sizeof(DPX_DEVICE_STATE)); // 
size = 43196 bytes

     memcpy(buf,(void*)&priv->context->State,sizeof(DPX_DEVICE_STATE));

     return sizeof(DPX_DEVICE_STATE);
}

static DEVICE_ATTR(state, 0777, usbtouchscreen_get_state, NULL);

Should I make anykind of protection while doing this operation? I have 
read in some answer from you guys, that I should create an attribute for 
every field of the structure I want to bring to userspace, but that will 
make me have tenths of attributes. The problem for me are not the number 
of attributes, but the changes I will need to have in my control panel 
to support that architecture. One attribute with the content of State 
variable would be perfect.

Any ideas?

Thanks,

Nuno

