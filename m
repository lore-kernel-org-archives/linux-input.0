From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] HID: input: make sure the wheel high resolution
 multiplier is set
Date: Sat, 15 Jun 2019 07:50:19 +0200
Message-ID: <20190615055019.GC23883@kroah.com>
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
 <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com>
 <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
 <CAO-hwJK614pzseUsGqH65fCnrm=N7970i4_mqi0m1gdkY=J0ag@mail.gmail.com>
 <b6410e5d-b165-7a9b-2ef5-eb44c8de7753@nurealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6410e5d-b165-7a9b-2ef5-eb44c8de7753@nurealm.net>
Sender: stable-owner@vger.kernel.org
To: James Feeney <james@nurealm.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Sasha Levin <sashal@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 14, 2019 at 04:09:35PM -0600, James Feeney wrote:
> Hey Everyone
> 
> On 4/24/19 10:41 AM, Benjamin Tissoires wrote:
> >>> For a patch to be picked up by stable, it first needs to go in Linus'
> >>> tree. Currently we are working on 5.1, so any stable patches need to
> >>> go in 5.1 first. Then, once they hit Linus' tree, the stable team will
> >>> pick them and backport them in the appropriate stable tree.
> 
> Hmm - so, I just booted linux 5.1.9, and this patch set is *still* missing from the kernel.
> 
> Is there anything that we can do about this?

What is the git commit id of the patch in Linus's tree?

As I said before, it can not be backported until it shows up there
first.

thanks,

greg k-h
