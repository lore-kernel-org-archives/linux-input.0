From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Mon, 23 Feb 2015 17:44:33 -0500
Message-ID: <20150223224433.GB28675@mail.corp.redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
 <54E45A82.7090706@gmail.com>
 <20150218200417.GC5928@mail.corp.redhat.com>
 <54E5CEE9.1050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E5CEE9.1050909@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On Feb 19 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 02/18/2015 10:04 PM, Benjamin Tissoires wrote:
> >On Feb 18 2015 or thereabouts, Nikolai Kondrashov wrote:
[snipped]
> >
> >OK, will respin the patches for your out of the tree driver.
> 
> Thanks a lot, Benjamin!
> 

OK, so after a little bit of struggle, I think we need to work both
upstream and on the out of the tree driver. Most of the current patches
in the out of the tree driver can be included right now and there is no
need to make hundreds of tests for these.

If you don't mind, I'll post them tomorrow with the follow up of the
patches I know will not break the tablets. Then, we can sync on the
digimend tree and ask users to test the "abstract buttons events"
reporting mode. It will help me and will also speed up the process of
having everything included sooner.

How does that sound?

Cheers,
Benjamin
