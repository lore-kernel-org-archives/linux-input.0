From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Fix sudden warps in mousedev
Date: Tue, 27 Mar 2007 12:04:47 -0400
Message-ID: <4609409F.2070203@redhat.com>
References: <20070324001610.724a820a.zaitcev@redhat.com>	 <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com>	 <20070326144206.93805eeb.zaitcev@redhat.com>	 <200703262114.45287.dtor@insightbb.com> <460934D7.9030700@redhat.com> <d120d5000703270846y87e4283m4009ff0a9f65dac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703270846y87e4283m4009ff0a9f65dac4@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Peter Osterlund <petero2@telia.com>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
>>
>> And why did the mouse numbers all get rearranged in 2.6.20, e.g.
>> mouse1 became mouse2 for many people?
> 
> Input devices are not guaranteed to be stable.
> 

So people with z-axis mice need to redo their X config for each
kernel release when the device numbers change? Or should they
be using some other configuration?

People using this now have X crashes on kernel upgrade because
event1 became event2:

        Driver      "evdev"
        Option      "Device" "/dev/input/event1"
