From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 6/6] Input: Add ChromeOS EC keyboard driver
Date: Mon, 18 Feb 2013 23:20:43 -0800
Message-ID: <1361258443.5920.7.camel@joe-AO722>
References: <1360988172-15380-1-git-send-email-sjg@chromium.org>
	 <1360988172-15380-7-git-send-email-sjg@chromium.org>
	 <20130216204954.GA22044@core.coreip.homeip.net>
	 <CAPnjgZ3Y88uwrwF7M7-EijA3N8y_jgbcOBeSNtM6T6iG8hW0RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPnjgZ3Y88uwrwF7M7-EijA3N8y_jgbcOBeSNtM6T6iG8hW0RQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Luigi Semenzato <semenzato@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Mike A. Chan" <mikechan@google.com>, Jun Nakajima <jun.nakajima@intel.com>, Tom Keel <thomas.keel@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2013-02-18 at 20:13 -0800, Simon Glass wrote:
> On Sat, Feb 16, 2013 at 12:49 PM, Dmitry Torokhov
> > On Fri, Feb 15, 2013 at 08:16:12PM -0800, Simon Glass wrote:
> >> +     for (row = 0; row < ckdev->rows; row++) {
> >> +             if (cros_ec_keyb_row_has_ghosting(ckdev, buf, row))
> >> +                     return true;
> >> +     }
> >
> > No need for curly braces here. I would not care if not for below.
> 
> OK I dont't think I even knew about that rule. Actually, what is that rule?

There is no rule, uses with and without braces
exist in about similar numbers in the kernel.

Both are used ~2000 times.

Newer uses more commonly have braces and I think
using braces is a better style.


