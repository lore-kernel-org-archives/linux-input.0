From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: input: make sure the wheel high resolution
 multiplier is set
Date: Wed, 24 Apr 2019 18:41:11 +0200
Message-ID: <CAO-hwJK614pzseUsGqH65fCnrm=N7970i4_mqi0m1gdkY=J0ag@mail.gmail.com>
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
 <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com> <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
Sender: stable-owner@vger.kernel.org
To: James Feeney <james@nurealm.net>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 24, 2019 at 5:42 PM James Feeney <james@nurealm.net> wrote:
>
> Hey Benjamin
>
> On 4/24/19 7:30 AM, Benjamin Tissoires wrote:
> > Given that this basically breaks a basic functionality of many
> > Microsoft mice, I went ahead and applied this series to
> > for-5.1/upstream-fixes
>
> Is there some reason that both patches should not be applied immediately, to the 5.0 series?
>
> Or - likely I am uninformed - are the 5.1 patches applied as a set separate from the 5.0 series revisions?

For a patch to be picked up by stable, it first needs to go in Linus'
tree. Currently we are working on 5.1, so any stable patches need to
go in 5.1 first. Then, once they hit Linus' tree, the stable team will
pick them and backport them in the appropriate stable tree.

But distributions can backport them as they wish, so you can make a
request to your distribution to include them ASAP. They are officially
upstream, though yet to be sent to Linus.

Cheers,
Benjamin
