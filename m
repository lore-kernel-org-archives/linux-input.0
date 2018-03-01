From: Arkadiusz Hiler <arkadiusz.hiler@intel.com>
Subject: Re: rmi4 defunct on T460p [was: [git pull] Input updates for
 v4.15-rc8]
Date: Thu, 1 Mar 2018 15:29:59 +0200
Message-ID: <20180301132959.GB27356@ahiler-desk1.ger.corp.intel.com>
References: <20180119174205.iq76oggc2h7neymf@dtor-ws>
 <b41e15f7-845a-6873-ddd1-0829b39319a4@suse.cz>
 <20180209013916.GA42766@dtor-ws>
 <6eb210d1-5b1b-d7ad-6188-e632fde2c6f7@suse.cz>
 <CAJ+F1CLFE=02hBY8paC83c-GjcPBM3YekAeYwxaporw8QczLFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLFE=02hBY8paC83c-GjcPBM3YekAeYwxaporw8QczLFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 01, 2018 at 02:22:10PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Feb 13, 2018 at 9:22 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> > On 02/09/2018, 02:39 AM, Dmitry Torokhov wrote:
> >> On Thu, Feb 08, 2018 at 11:04:22AM +0100, Jiri Slaby wrote:
> >>> On 01/19/2018, 06:42 PM, Dmitry Torokhov wrote:
> >>>> Please pull from:
> >>>>
> >>>>     git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> >>>>
> >>>> to receive updates for the input subsystem. You will get:
> >>>>
> >>> ...
> >>>> - touchpad on Lenovo T640p is switched over to SMbus/RMI
> >>> ...
> >>>
> >>>> 王振杰 (1):
> >>>>       Input: synaptics - Lenovo Thinkpad T460p devices should use RMI
> >>>
> >>> Hi,
> >>>
> >>> one of openSUSE users with T460p reports that the touchpad is defunct
> >>> after resume in 4.15. psmouse.synaptics_intertouch=0 works around the
> >>> problem.
> >>>
> >>> The problem is:
> >>>  kernel: rmi4_smbus 8-002c: failed to get SMBus version number!
> >>>  kernel: rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read
> >>> current IRQ mask.
> >>>  kernel: rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
> >>>  kernel: rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
> >>>  kernel: rmi4_physical rmi4-00: Failed to suspend functions: -16
> >>>  kernel: rmi4_smbus 8-002c: Failed to resume device: -16
> >>>  kernel: rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03
> >>> TX register (-16).
> >>>
> >>> The downstream bug is at:
> >>> https://bugzilla.suse.com/show_bug.cgi?id=1079862
> >>>
> >>> Any ideas?
> >>
> >> Hmm, maybe the seuence between psmouse and rmi/smbus is not quite right
> >> on resume on that box. Can you ask the reporter to:
> >>
> >> echo 1 > /sys/power/pm_print_times
> >> suspend/resume
> >
> > He uploaded it here:
> > https://bugzilla.suse.com/attachment.cgi?id=759933
> >
> 
> Same problem (with f27 and upstream kernel), is there anything else we
> can do to help? Should we open a bug on http://bugzilla.kernel.org ?
> 
> thanks

There are already two reverts on this mailing list that fix the problem.

https://patchwork.kernel.org/patch/10239877/
and
https://patchwork.kernel.org/patch/10228565/

Since the regression made it to the stable kernel and this is not moving
I think it's appropiate to cc Greg here.

- Arek
