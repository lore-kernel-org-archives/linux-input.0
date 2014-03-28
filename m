From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Fri, 28 Mar 2014 09:04:22 -0700
Message-ID: <20140328160421.GA22658@core.coreip.homeip.net>
References: <1395310330-3232-1-git-send-email-hdegoede@redhat.com>
 <20140320172159.GA27400@srcf.ucam.org>
 <20140328075655.GE22093@core.coreip.homeip.net>
 <53352EFB.8000309@redhat.com>
 <20140328081739.GG22093@core.coreip.homeip.net>
 <533532FE.2000304@redhat.com>
 <20140328085207.GN22093@core.coreip.homeip.net>
 <20140328090053.GA10597@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140328090053.GA10597@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 28, 2014 at 09:00:53AM +0000, Matthew Garrett wrote:
> On Fri, Mar 28, 2014 at 01:52:07AM -0700, Dmitry Torokhov wrote:
> > 
> > Are we even certain that they will be consistent in use of these special
> > PNP ID's? Maybe you should really do DMI match...
> 
> The Windows drivers bind on PNP IDs, not DMI.

OK, fair enough.

-- 
Dmitry
