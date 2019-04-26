From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Date: Thu, 25 Apr 2019 22:34:39 -0700
Message-ID: <20190426053439.GB31266@innovation.ch>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
 <20190422123426.2d0b4bdf@archlinux>
 <20190424104718.GA31301@innovation.ch>
 <20190424201317.2a472120@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424201317.2a472120@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


  Hi Jonathan,

On Wed, Apr 24, 2019 at 08:13:17PM +0100, Jonathan Cameron wrote:
> On Wed, 24 Apr 2019 03:47:18 -0700
> "Life is hard, and then you die" <ronald@innovation.ch> wrote:
> 
> >   Hi Jonathan,
> > 
> > On Mon, Apr 22, 2019 at 12:34:26PM +0100, Jonathan Cameron wrote:
> > > On Sun, 21 Apr 2019 20:12:49 -0700
> > > Ronald Tschalär <ronald@innovation.ch> wrote:
> > >   
> > > > The iBridge device provides access to several devices, including:
> > > > - the Touch Bar
> > > > - the iSight webcam
> > > > - the light sensor
> > > > - the fingerprint sensor
> > > > 
> > > > This driver provides the core support for managing the iBridge device
> > > > and the access to the underlying devices. In particular, since the
> > > > functionality for the touch bar and light sensor is exposed via USB HID
> > > > interfaces, and the same HID device is used for multiple functions, this
> > > > driver provides a multiplexing layer that allows multiple HID drivers to
> > > > be registered for a given HID device. This allows the touch bar and ALS
> > > > driver to be separated out into their own modules.
> > > > 
> > > > Signed-off-by: Ronald Tschalär <ronald@innovation.ch  
> > > Hi Ronald,
> > > 
> > > I've only taken a fairly superficial look at this.  A few global
> > > things to note though.  
> > 
> > Thanks for this review.
[snip]

I've applied all your feedback in my tree, but it now looks like this
module is going to be redone differently. I'll try to keep all your
comments in mind during the rewrite, though, so they're not wasted.


  Cheers,

  Ronald
