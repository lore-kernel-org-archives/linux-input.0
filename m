From: Matt Keenan <tank.en.mate@gmail.com>
Subject: Re: Fix sudden warps in mousedev
Date: Wed, 28 Mar 2007 21:51:34 +0100
Message-ID: <460AD556.9090408@gmail.com>
References: <20070324001610.724a820a.zaitcev@redhat.com>	 <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com>	 <20070326144206.93805eeb.zaitcev@redhat.com>	 <200703262114.45287.dtor@insightbb.com> <460934D7.9030700@redhat.com>	 <d120d5000703270846y87e4283m4009ff0a9f65dac4@mail.gmail.com>	 <4609409F.2070203@redhat.com> <d120d5000703270919y16ae3e56kb7d2fbd293213939@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703270919y16ae3e56kb7d2fbd293213939@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Peter Osterlund <petero2@telia.com>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On 3/27/07, Chuck Ebbert <cebbert@redhat.com> wrote:
>> Dmitry Torokhov wrote:
>> >>
>> >> And why did the mouse numbers all get rearranged in 2.6.20, e.g.
>> >> mouse1 became mouse2 for many people?
>> >
>> > Input devices are not guaranteed to be stable.
>> >
>>
>> So people with z-axis mice need to redo their X config for each
>> kernel release when the device numbers change? Or should they
>> be using some other configuration?
>>
>> People using this now have X crashes on kernel upgrade because
>> event1 became event2:
>>
>>        Driver      "evdev"
>>        Option      "Device" "/dev/input/event1"
>>
>
> I'd recommend matching on "phys" or individual capabilities bits
> instead of device node. See "man evdev".
>
I wrote a few udev rules to create specific /dev nodes for X with evedv 
(I run with multiple X users / screens / keyboards / mice on one 
machine).  I can forward you the udev rules and helper scripts if you 
want.  This means that you can hardcode the /dev nodes in your xorg.conf 
file and udev will make sure they don't move on you.  I wrote this up in 
the early days of evdev development before the phys stuff was there.

Matt
