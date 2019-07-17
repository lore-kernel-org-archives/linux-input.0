From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] input: touchscreen mc13xxx: Add mc34708 support
Date: Wed, 17 Jul 2019 11:53:38 +0300
Message-ID: <20190717085338.GA581@penguin>
References: <20190716221929.3782-1-lukma@denx.de>
 <20190716221929.3782-4-lukma@denx.de>
 <20190717033655.GC621@penguin>
 <20190717101704.2ff4d877@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190717101704.2ff4d877@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Lukasz,

On Wed, Jul 17, 2019 at 10:17:04AM +0200, Lukasz Majewski wrote:
> Hi Dmitry,
> 
> > On Wed, Jul 17, 2019 at 12:19:29AM +0200, Lukasz Majewski wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > The mc34708 has a different bit to enable pen detection. This
> > > adds the driver data and devtype necessary to probe the device
> > > and to distinguish between the mc13783 and the mc34708.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > 
> > > ---
> > > Changes for v3:
> > > - Replace forward declaration of mc13xxx_driver_data with
> > >   structure definition
> > > - Rename mc13xxx_driver_data with mc13xxx_chip
> > > - Move static struct mc13xxx_chip mc13783_chip and mc34708_chip
> > >   closer to ID table
> > > - Do not check mc13xxx device type  
> > 
> > You do not even need to define or store the type. Once it is dropped
> > please feel free to add
> 
> Ok. I will remove the type definition.
> 
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > and merge with the other 2 patches.
> > 
> 
> Ok. I will squash those three patches into a single one, add your
> Acked-by and wait for Lee to pull this single patch to his MFD tree.

Sorry, it looks like there is misunderstanding. I did not ask to squash
together the 3 patches, I meant that they can all go together through
the same tree (MFD). That is what I meant by them being merged together.

Sorry for being unclear.

Thanks.

-- 
Dmitry
