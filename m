From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: Put button input devices in correct place in sysfs
Date: Wed, 14 Nov 2007 12:32:52 -0500
Message-ID: <d120d5000711140932w40898cabo527bb1315740635b@mail.gmail.com>
References: <200711062051.59884.arvidjaar@mail.ru>
	 <d120d5000711061247l5102875bg9d9b841086dd77b5@mail.gmail.com>
	 <200711111142.52346.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200711111142.52346.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, David Brownell <david-b@pacbell.net>
List-Id: linux-input@vger.kernel.org

On 11/11/07, Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> On Tuesday 06 November 2007, Dmitry Torokhov wrote:
> > Hi Andrey,
> >
> > On Nov 6, 2007 12:51 PM, Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > > Properly set up parent on input device registered by the button driver.
> > >
> >
> > Seems to be a popular topic today :)
> >
> > >
> > > +       input->cdev.dev = &device->dev;
> >
> > Please don't use cdev, but rather input_dev->dev.parent. cdev is going
> > away soon.
> > I sent a patch a couple of days ago to teh acpi list...
> >
>
> You mean button patch? I could find only video one.

Right, I got confused between the two...

>
> Just in case, here is updated version.
>

Please forward to Len Brown with
Acked-by: Dmitry Torokhov <dtor@mail.ru>

Thanks!

-- 
Dmitry
