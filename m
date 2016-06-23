From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 3/4] i2c: i801: add support of Host Notify
Date: Thu, 23 Jun 2016 15:57:07 -0700
Message-ID: <20160623225707.GR32561@dtor-ws>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
 <20160615081247.GQ24234@mail.corp.redhat.com>
 <20160616060942.GA1403@tetsubishi>
 <20160623205552.GO32561@dtor-ws>
 <20160623214654.GA3707@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160623214654.GA3707@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 23, 2016 at 11:46:55PM +0200, Wolfram Sang wrote:
> On Thu, Jun 23, 2016 at 01:55:52PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jun 16, 2016 at 08:09:42AM +0200, Wolfram Sang wrote:
> > > > > - removed the .resume hook as upstream changed suspend/resume hooks and there
> > > > >   is no need in the end to re-enable host notify on resume (tested on Lenovo
> > > > >   t440 and t450).
> > > > 
> > > > Actually, this hook seemed to be required on the Lenovo T440 (Haswell)
> > > > but not on the T450 (Broadwell) laptop I have now here.
> > > > 
> > > > Wolfram, I can resend the whole series or a follow-up patch to re-enable
> > > > after resume Host Notify. How do you prefer I deal with that?
> > > 
> > > That depends a little how we want to handle patch 4. I am going to apply
> > > patches 1+2 today to my tree. Then you can just resend patch 3 which I
> > > hope will get some review soon, but I will pick it up for 4.8 later
> > > nonetheless. If it is not causing too much dependency hassle, I'd prefer
> > > that patch 4 goes via Dmitry's input tree.
> > 
> > Any chance I could get a stable branch with these 2 patches based on 4.6
> > so that I can pull it and merge the #4? This way we do not need to wait
> > for 2 releases to merge everything...
> 
> Sure.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/host-notify

Thanks!

-- 
Dmitry
