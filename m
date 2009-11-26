From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Thu, 26 Nov 2009 13:39:09 -0800
Message-ID: <1F6BE32B-13EE-4FB4-96AD-D4526F435777@gmail.com>
References: <200910200956.33391.jarod@redhat.com> <200910200958.50574.jarod@redhat.com> <4B0A765F.7010204@redhat.com> <4B0A81BF.4090203@redhat.com> <m36391tjj3.fsf@intrepid.localdomain> <20091123173726.GE17813@core.coreip.homeip.net> <m3r5rpq818.fsf@intrepid.localdomain> <20091126052155.GD23244@core.coreip.homeip.net> <m31vjlw54x.fsf@intrepid.localdomain>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <m31vjlw54x.fsf@intrepid.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Jarod Wilson <jarod@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@ubuntu.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Janne Grunau <j@jannau.net>, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Nov 26, 2009, at 9:46 AM, Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>
>> In what way the key interface is unsufficient for delivering button
>> events?
>
> At present: 128 different keys only (RC5: one group).

Where did this limitation come from? We have more than 256 keycodes  
already _defined_ in the input core and we can add more if needed.


> One remote per
> device only.

Why would you want more? One physical device usually corresponds to a  
logical device. If you have 2 remotes create 2 devices.

> The protocol itself doesn't have the above limitations, but has  
> others,
> with are acceptable for key input.
> -- 
> Krzysztof Halasa

-- 
Dmitry
