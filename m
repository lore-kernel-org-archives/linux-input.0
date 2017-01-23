From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/4] HID: wacom: fixes for next
Date: Mon, 23 Jan 2017 09:02:40 +0100
Message-ID: <20170123080240.GA8653@mail.corp.redhat.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
 <CANRwn3QHsoURBnpybX4Bn1UAMif13yqo16NEg1JFqfz4GD=3dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANRwn3QHsoURBnpybX4Bn1UAMif13yqo16NEg1JFqfz4GD=3dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Jan 20 2017 or thereabouts, Jason Gerecke wrote:
> Patches 1/3 look reasonable to me, though I've not run into the bugs
> they aim to fix. For those:
> 
> Acked-by: Jason Gerecke <jason.gerecke@wacom.com>
> 
> As for patch 4, I have some additional reservations about hiding the
> message... We can discuss that further in its thread.
> 

Yeah, I am fine dropping patch 4. Thanks for the review/tests Jason!

Cheers,
Benjamin

> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can’t take seven from three,    /
> So you look at the sixty-fours....
> 
> 
> 
> On Fri, Jan 20, 2017 at 7:20 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > Hi,
> >
> > well, these are non critical but nonetheless interesting fixes for
> > Wacom I was working on last week. I was waiting for the current v4.10
> > fix to be sent by Jason before pushing those out.
> >
> > Cheers,
> > Benjamin
> >
> > Benjamin Tissoires (4):
> >   HID: wacom: release the resources before leaving despite devm
> >   HID: wacom: remove warning while disconnecting devices
> >   HID: wacom: do not attempt to switch mode while in probe
> >   HID: wacom: do not shout an error on LED control
> >
> >  drivers/hid/wacom.h     |  1 +
> >  drivers/hid/wacom_sys.c | 42 ++++++++++++++++++++++++++++++------------
> >  2 files changed, 31 insertions(+), 12 deletions(-)
> >
> > --
> > 2.9.3
> >
