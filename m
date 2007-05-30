From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] gpio_mouse driver
Date: Wed, 30 May 2007 08:30:14 -0400
Message-ID: <d120d5000705300530ie4ce2eatfec117a4e950da2d@mail.gmail.com>
References: <1180444046354-git-send-email-hcegtvedt@norway.atmel.com>
	 <d120d5000705290836o49bc207bqb3d9dfebc34ac752@mail.gmail.com>
	 <1180506198.32245.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180506198.32245.59.camel@localhost.localdomain>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/30/07, Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com> wrote:
> On Tue, 2007-05-29 at 11:36 -0400, Dmitry Torokhov wrote:
> > Hi,
> >
> > On 5/29/07, Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com> wrote:
> > > This patch adds support for simulating a mouse using GPIO lines.
> > >
> > > The driver needs a platform_data struct to be defined and registered with the
> > > appropriate platform_device.
> > >
> > > The driver has been tested on AT32AP7000 microprocessor using the ATSTK1000
> > > development board.
> > >
> >
> > It looks sane although I would recommend switching to input-polldev
> > when implementing a polled input device.
>
> Oh, I was not aware about this, it seems like just the thing I need.
>
> Could it be scheduled for after the official kernel has this included?
> AFAICT it will be released with 2.6.22?

Because merge window for 2.6.22 is closed the driver will only be
merged in the mainline when 2.6.23 window opens. For now it will stay
in my tree (and because Andrew pulls form me it will also show up in
-mm). Because of that I would like to get the driver in shape from the
beginning - my tree obviously does have these changes.

Thank you.

-- 
Dmitry
