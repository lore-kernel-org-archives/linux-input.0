From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI / button: Add KEY_LID_OPEN/KEY_LID_CLOSE for
 new usage model
Date: Thu, 21 Jul 2016 13:33:22 -0700
Message-ID: <20160721203322.GB9841@dtor-ws>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
 <1b96ee1e5b5ebbed0096adde410a9fd0b7930848.1468915808.git.lv.zheng@intel.com>
 <6943722.0LO9QHJXWg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6943722.0LO9QHJXWg@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 21, 2016 at 03:35:36PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 19, 2016 04:11:02 PM Lv Zheng wrote:
> > There are many AML tables reporting wrong initial lid state, and some of
> > them never report lid open state. As a proxy layer acting between, ACPI
> > button driver is not able to handle all such cases, but need to re-define
> > the usage model of the ACPI lid. That is:
> > 1. It's initial state is not reliable;
> > 2. There may not be an open event;
> > 3. Userspace should only take action against the close event which is
> >    reliable, always sent after a real lid close.
> > 
> > OTOH, using an input switch event for the lid device on such platforms can
> > cause the loss of the close event, but the platforms purposely want to use
> > these close events to trigger power saving actions.
> > 
> > So we need to introduce a new ABI, which is input key events based, not
> > input switch events based.
> > 
> > This patch adds a set of new input key events so that the new userspace
> > programs can use them to handle this usage model correctly. And in the
> > meanwhile, the old input switch event is kept so that no old programs will
> > be broken by the ABI change.
> > 
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > Cc: Bastien Nocera: <hadess@hadess.net>
> > Cc: linux-input@vger.kernel.org
> 
> Dmitry, any objections here?

Yes I have (see the other email).

Thanks.

-- 
Dmitry
