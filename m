From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Tue, 19 Apr 2016 11:22:35 +0300
Message-ID: <20160419082235.GP4247@mwanda>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
 <cover.1460985538.git.mdl@60hz.org>
 <341e0bb72d58c1c7d72ad5352f4bb364d939c0a8.1460985538.git.mdl@60hz.org>
 <20160418165456.GG4298@mwanda>
 <CADemMPN5wPjDzrLnsWgBHKZt3JNN-tYeJ8B+waFVsizZJdi2tA@mail.gmail.com>
 <20160418203600.GH4298@mwanda>
 <CADemMPNu2KuQgwyzLjr+L5ngbLxbOTpM0sKF2TLeZBvpvJjZKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <CADemMPNu2KuQgwyzLjr+L5ngbLxbOTpM0sKF2TLeZBvpvJjZKQ@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Laws <mdl@60hz.org>
Cc: devel@linuxdriverproject.org, haiyangz@microsoft.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 19, 2016 at 07:00:42AM +0900, Mark Laws wrote:
> On Tue, Apr 19, 2016 at 5:36 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Tue, Apr 19, 2016 at 02:24:47AM +0900, Mark Laws wrote:
> >> Sorry, I don't understand--which part are you suggesting we remove?
> >
> > The call to i8042_controller_check() or move it to the probe function or
> > something.  Why must we have the hardware to load the module?
> 
> We don't. That's the point of the patch. Do you mean that since our
> intent is to load the module regardless of whether or not the hardware
> is there, the check should be (re)moved simply to clarify the code?

Yeah.  Just remove the call to i8042_controller_check().  Wouldn't
everyone be happy with that situation?

Your patch makes life slightly more complicated for people who want to
use the original hardware if the load the module but the hardware isn't
detected.

regards,
dan carpenter
