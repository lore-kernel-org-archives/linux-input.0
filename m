From: Slawomir Stepien <sst@poczta.fm>
Subject: Re: [PATCH] Input: gpio-keys - use module_platform_driver macro
Date: Thu, 27 Oct 2016 21:11:43 +0200
Message-ID: <20161027191143.GA1630@x220.localdomain>
References: <20161027141554.GA31977@x220.localdomain>
 <20161027164830.GB36933@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027164830.GB36933@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ldewangan@nvidia.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Oct 27, 2016 09:48, Dmitry Torokhov wrote:
> Hi Slawomir,

Hi Dmitry,

> > -late_initcall(gpio_keys_init);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Because of this we can't switch to module_platform_driver(). The
> late_initcall was requirement of one of platforms because of the probe
> ordering issues. It may be resolved now with deferred probing, but you'd
> need to confirm with all the users.

I was unaware of that. Let me look in to that more deeply. At the moment I do
not have the knowledge what will be to correct solution for that.

> > -module_exit(gpio_keys_exit);
> > +module_platform_driver(gpio_keys_device_driver);
> >  
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> 
> Thanks.

Thank you.

-- 
Slawomir Stepien
