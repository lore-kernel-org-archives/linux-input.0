From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: input: ignore System Control application usages
 if not System Controls
Date: Mon, 19 Sep 2016 14:26:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609191402430.22028@cbobk.fhfr.pm>
References: <1473760358-31999-1-git-send-email-benjamin.tissoires@redhat.com> <1473760358-31999-2-git-send-email-benjamin.tissoires@redhat.com> <CAAZ5spCtj6O+d6t7G2x7-m6rj4fSNQsak_QGeuqf4Bf2bqW7Cg@mail.gmail.com> <20160913135759.GG25951@mail.corp.redhat.com>
 <CAAZ5spC9VX7QuMjfZUb-F_-i+ktz3HUpyP-3Ess2APTmyNQ5Dw@mail.gmail.com> <CAAZ5spBHTytyXg6cGhHEBsZM=FWuL_v-BzUQ+J4pHp=OYtdcAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAZ5spBHTytyXg6cGhHEBsZM=FWuL_v-BzUQ+J4pHp=OYtdcAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Hermier <michel.hermier@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 13 Sep 2016, Michel Hermier wrote:

> I'm the original author of the 2011 bug, and I still own one of the 
> Microsoft keyboard with the issue. But not one that has a fix, but one 
> that have the exact same broken report descriptor. When I'll get some 
> time to test the patch, on success I think it would be safe to remove 
> one of the 2 fixup available, since they seems to have reused the exact 
> same descriptor for the whole family.

I'd be interested in the result of this test.

In any case, to get as much testing coverage as possible, I've now applied 
this one (1/2) to hid.git#for-4.9.

Thanks,

-- 
Jiri Kosina
SUSE Labs
