From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR 	system?
Date: Fri, 09 Apr 2010 10:01:46 -0300
Message-ID: <4BBF253A.8030406@redhat.com>
References: <9e4733910912060952h4aad49dake8e8486acb6566bc@mail.gmail.com>	 <9e4733910912151338n62b30af5i35f8d0963e6591c@mail.gmail.com>	 <4BAB7659.1040408@redhat.com>  <201004090821.10435.james@albanarts.com> <1270810226.3764.34.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270810226.3764.34.camel@palomino.walls.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Walls <awalls@radix.net>
Cc: James Hogan <james@albanarts.com>, Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi James,

Andy Walls wrote:
> On Fri, 2010-04-09 at 08:21 +0100, James Hogan wrote:
>> Hi,
>>
>> On Thursday 25 March 2010 14:42:33 Mauro Carvalho Chehab wrote:
>>> Comments?
>> I haven't seen this mentioned yet, but are there any plans for a sysfs 
>> interface to set up waking from suspend/standby on a particular IR scancode 
>> (for hardware decoders that support masking of comparing of the IR data), kind 
>> of analagous to the rtc framework's wakealarm sysfs file?
> 
> This requires support at the hardware level.  (You can't have CPU code
> running to decode IR pulses when your CPU is "asleep".)

The additions at IR core, if needed [1], shouldn't be hard, but the main changes should
happen at the hardware driver level.  There's no current plans for it, at least from
my side, but, let's see if some hardware driver developers want to implement it on
the corresponding driver.

[1] Basically, a keycode (like KEY_POWER) could be used to wake up the machine. So, by 
associating some scancode to KEY_POWER via ir-core, the driver can program the hardware 
to wake up the machine with the corresponding scancode. I can't see a need for a change at
ir-core to implement such behavior. Of course, some attributes at sysfs can be added
to enable or disable this feature, and to control the associated logic, but we first
need to implement the wakeup feature at the hardware driver, and then adding some logic
at ir-core to add the non-hardware specific code there.

-- 

Cheers,
Mauro
