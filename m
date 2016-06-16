From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 3/4] i2c: i801: add support of Host Notify
Date: Thu, 16 Jun 2016 14:55:14 +0200
Message-ID: <20160616125514.GD24234@mail.corp.redhat.com>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
 <20160615081247.GQ24234@mail.corp.redhat.com>
 <20160616060942.GA1403@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160616060942.GA1403@tetsubishi>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jun 16 2016 or thereabouts, Wolfram Sang wrote:
> > > - removed the .resume hook as upstream changed suspend/resume hooks and there
> > >   is no need in the end to re-enable host notify on resume (tested on Lenovo
> > >   t440 and t450).
> > 
> > Actually, this hook seemed to be required on the Lenovo T440 (Haswell)
> > but not on the T450 (Broadwell) laptop I have now here.
> > 
> > Wolfram, I can resend the whole series or a follow-up patch to re-enable
> > after resume Host Notify. How do you prefer I deal with that?
> 
> That depends a little how we want to handle patch 4. I am going to apply
> patches 1+2 today to my tree. Then you can just resend patch 3 which I
> hope will get some review soon, but I will pick it up for 4.8 later
> nonetheless. If it is not causing too much dependency hassle, I'd prefer
> that patch 4 goes via Dmitry's input tree.
> 

Works for me. Thanks for picking up the core changes. As soon as this
gets merged, the input part (patch 4), which is independent of patch 3
(i2c-i801) can be carried over through the input tree. So as long as
you don't need to have a new feature without users for a short period
of time, that's fine by me :)

Cheers,
Benjamin
