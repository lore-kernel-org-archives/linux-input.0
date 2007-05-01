From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Getting touchscreen to work on Fujitsu B6210
Date: Tue, 1 May 2007 11:49:38 -0400
Message-ID: <d120d5000705010849h396fb6a0qf4e2065643f3adcf@mail.gmail.com>
References: <20070221221629.59088fed@localhost>
	 <200704040116.58366.dtor@insightbb.com>
	 <20070405133615.6536eea5@localhost>
	 <200704052227.19831.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704052227.19831.dtor@insightbb.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On 4/5/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
>
> Could ypou please load evbug module or run evtest utility and
> verify that the driver produces reasonable events?
>
> > Do I need an Xorg driver for it?
>
> Mousedev (i.e. /dev/input/{mouseX|mice} will provide crude
> emulation of normal mouse; there is evtouch X driver that
> should work better. You may also try evdev X driver from
> recent releases of x.org; as far as I know they want it to
> supesede evtouch eventually.
>

Did you have any luck with fujitsu_ts module? Is it busted or is it ok for -mm?

-- 
Dmitry
