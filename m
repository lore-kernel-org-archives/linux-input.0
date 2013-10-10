From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Q: weird hidraw behaviour
Date: Thu, 10 Oct 2013 11:41:06 +0200
Message-ID: <CANq1E4QrtTCv5NQ-zmuSk4Nmb1r9U-K_SGz7m0pPgxXcL9FqNQ@mail.gmail.com>
References: <20130924085606.GI28875@intel.com>
	<CANq1E4TxGS4NSc3BOon2+zVwkvY2LQTmQowHxOJnypf860+-jw@mail.gmail.com>
	<20131010093939.GH3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40013 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab3JJJlH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 05:41:07 -0400
Received: by mail-ie0-f180.google.com with SMTP id e14so626087iej.11
        for <linux-input@vger.kernel.org>; Thu, 10 Oct 2013 02:41:06 -0700 (PDT)
In-Reply-To: <20131010093939.GH3521@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Manoj Chourasia <mchourasia@nvidia.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Thu, Oct 10, 2013 at 11:39 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Oct 10, 2013 at 11:26:45AM +0200, David Herrmann wrote:
>> I don't know whether it's intentional, but it is hardcoded this way
>> now. Logic is, ->close() is called on hidraw_disconnect() that is,
>> when hidraw is unloaded on a device. It no longer depends on
>> user-space processes.
>>
>> Any reason to change it back? It's no bug, so if no-one cares I'd
>> leave it as it is now. Otherwise, we can try to change it again.
>
> Well, if you open the device and close it from userspace, the device stays
> opened forever. I'm not sure if that's the intention.
>
> I think that fix for this was already merged.

Indeed, fixed upstream in:
http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-3.12/upstream-fixes&id=0f5a24c6602063e014ee48892ebf56093241106e

Thanks
David
