From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: do not stop the device at the end of probe
Date: Wed, 9 Apr 2014 17:14:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404091713590.14588@pobox.suse.cz>
References: <1397055694-6312-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397055694-6312-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 9 Apr 2014, Benjamin Tissoires wrote:

> Well, this is embarrassing, if the device is stopped at the end of probe,
> we get into big troubles (it even oopses my kernel).
> 
> This was a leftover of an attempt to be smart when sending the patch,
> I deeply apologies.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi Jiri,
> 
> well, first thanks for having integrating hid-rmi in your for 3.16 branch.
> 
> While backporting it to 3.13 so Fedora can get it, I noticed a tiny difference
> (besides formatting) between the version I submitted and the one I asked people
> to test...
> 
> ...facepalm.

Well, I missed that as well when reviewing it. Good catch, now queued on 
top of previous one. Thanks,

-- 
Jiri Kosina
SUSE Labs
